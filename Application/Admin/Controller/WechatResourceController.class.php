<?php
namespace Admin\Controller;
use Admin\Common\Wechat;
use Admin\Common\AdminBaseController;
use Org\Nx\Page;
/**
 * 微信推送,素材管理
 * @author YQS
 * @date 2018年5月25日
 */
class WechatResourceController extends AdminBaseController{
	private static $source;
	private static $csource;
	private static $app;
	private static $wechat_id;
	public function _initialize(){
		parent::_initialize();
		$cache_id		 = S('wechat_id');
		$wechat_id		 = I('request.wechat_id');
		self::$wechat_id = $wechat_id ? ($wechat_id == $cache_id ? $wechat_id : S('wechat_id',$wechat_id)) : $cache_id;
		self::$app		 = Wechat::app(self::$wechat_id);
		self::$source    = M('wechatResource');
		self::$csource	 = M('wechatResourceList');
		$this->assign('wechat_id',self::$wechat_id);
	}
	/**
	 * 素材列表(主表)
	 */
	public function source_list(){
		$get    = self::$get;
		$param  = $get;
		$get	= self::get_fillter($get);
		$where  = 'isdel = 0';
		if($get){
			foreach($get as $key=>$val){
				$where .= ' and '.$key.'='.'"'.$val.'"';
			}
			$this->assign('get',$get);
		}
		$count  = self::$source->where($where)->count();
		$page   = new Page($count,20,$param);
		$info 	= self::$source->where($where)->limit(mypage($page))->select();
		
		//微信账户
		$user	= M('wechatAccount')->field('id,name')->where('isdel = 0')->select();
		
		foreach($info as &$val){
			foreach($user as $v){
				if($val['wechat_id'] == $v['id']){
					$val['wechat_name'] = $v['name'];
				}
			}
		}
		foreach ($user as $v){
			$wechat_id[] = $v['id'];
		}
		$number = S('number');
		if($number > 5){
			$number = 0;
		}else{
			$number = 5 - $number;
		}
		$this->assign('user',$user);
		$this->assign('wechat_id',implode(',',$wechat_id));
		$this->assign('number',$number);
		$this->assign('info',$info);
		$this->assign('page',$page->show());
		$this->display();
	}
	/**
	 * 素材列表(从表)
	 */
	public function source_child_list(){
		$get    = self::$get;
		$param  = $get;
		$get	= self::get_fillter($get);
		$where  = 'isdel = 0';
		if($get){
			foreach($get as $val){
				$where .= ' and wechat_id = '.$val['wechat_id'];
			}
		}
		$source = self::$source->where($where)->select();
		if($source){
			$count  = self::$csource->where('isdel = 0')->count();
			
			$page   = new Page($count,20,$param);
			//->cache('csource_'.self::$wechat_id.'_'.$param['p'],1800)
			$info 	= self::$csource->where('isdel = 0')->order('ctime desc')->limit(mypage($page))->select();
			
			//微信账户
			$user	= M('wechatAccount')->field('id,name')->select();
			
			foreach($info as &$val){
				foreach($user as $v){
					if($val['wechat_id'] == $v['id']){
						$val['wechat_id'] = $v['name'];
					}
				}
			}
			$this->assign('user',$user);
			$this->assign('info',$info);
			$this->assign('page',$page->show());
		}
		$this->display();
	}
	/**
	 * 查看当前素材下的素材信息
	 * @param int $id 素材id
	 */
	public function source_check(){
		$id		   	= I('request.id');
		$source_id 	= I('request.source_id');
		$where 		= $id ? 'id = '.$id : 'source_id = '.$source_id;
		$info 		= self::$csource->cache('current_source_'.$source_id)->where($where)->select();
		$this->assign('info',$info);
		$this->display();
	}
	
	/**
	 * 素材编辑(从表)：说明：主表数据是通过微信服务器获取插入
	 * @param $status 1.添加，2.编辑
	 */
	public function source_edit($status){
		$id   = I('request.id');
		$post = I('post.');
		if(IS_POST){
			$post['content'] = html_entity_decode($post['content']);
			$post['ctime']   = date('Y-m-d H:i:s');
			if(empty($id)){
				if(self::$csource->create($post))
					$result = self::$csource->add();
			}else{
				$result = self::$csource->save($post);
				//同步微信服务器暂时放着
			}
			self::jump($result, 'source_child_list',['wechat_id'=>self::$wechat_id]);
		}else{
			if($status == 2){
				$info = self::$csource->find($id);
				$this->assign('info',$info);
				$this->assign('wechat_id',self::$wechat_id);
			}
			$this->assign('status',$status);
			$this->display();
		}
	}
	
	/**
	 * 素材删除，同时微信公众号素材删除
	 */
	public function source_del(){
		$id  	   	= I('request.id');
		$media_id  	= I('request.media_id');
		$type 		= I('request.type'); //存在则为从表
		//删除微信公众号的素材
		$result		= self::$app->delForeverMedia($media_id);
		if($result){
			if($type){
				$source = self::$csource->find($id);
				self::$csource->delete($id);
				//更新主素材子集个数
				self::$source->where('id = '.$source['source_id'])->setDec('sourse_num');
			}else{
				$res = self::$source->delete($id);
				//删除成功同时删除从表数据
				self::$csource->where('source_id = '.$id)->delete();
			}
		}
		self::jump($result, 'source_list',['wechat_id'=>self::$wechat_id]);
	}
	/**
	 * 消息推送
	 */
	public function source_send(){
		$id		  = I('request.id');
		$media_id = I('request.media_id');
		//查看当天推送时间
		//缓存当天推送状态
		$cache	  = S('current_status');
		//如果当天推送了 则禁止推送
		if($cache){
			self::jump(false, 'source_list',['wechat_id'=>self::$wechat_id],'当天已推送过，请于第二天在推送');
		}else{
			$endtime  = mktime(23,59,59,date('m'),date('d'),date('Y')); //当天最后时刻
			S('current_status',1,$endtime-time());
			//测试
			$result   = self::send_source_preview(self::$wechat_id,$media_id);
			if($result){
				self::$source->where('id = '.$id)->setInc('send_num',1);
				self::$source->where('id = '.$id)->save(['stime'=>date('Y-m-d H:i:s')]);
			}
			self::jump($result, 'source_list',['wechat_id'=>self::$wechat_id]);
		}
	}
	/**
	 * 上传图文素材，更新数据
	 */
	public function source_upload_news(){
		$id 	= I('request.id');
		$id 	= implode(',', $id);
		$info 	= self::$csource->where('id in ('.$id.')')->select();
		if($info){
			foreach($info as $val){
				$data[] = [
					'title'              => $val['title'],
			 		'thumb_media_id'     => $val['thumb_media_id'],
			 		'author'             => $val['author'],
					'digest'      		 => $val['digest'],
					'show_cover_pic'     => $val['show_cover_pic'],
			 		'content'            => $val['content'],
			 		'content_source_url' => $val['content_source_url'],
			 		'need_open_comment'	 => $val['need_open_comment']
				];
			}
			$media_id = self::set_source($data);
			//dump(Wechat::getError(self::$app->errCode)); exit;
			if(!$media_id) return 1;
			//上传成功后添加到主表
			$pdata = [
				'wechat_id'  => self::$wechat_id,
				'media_id'   => $media_id,
				'ctime'		 => date('Y-m-d H:i:s'),
				'utime'		 => date('Y-m-d H:i:s'),
				'sourse_num' =>	count($info)
			];
			$source_id = self::$source->add($pdata);
			//更新从表
			$cdata 	   = ['media_id'=>$media_id,'source_id'=>$source_id,'utime'=>date('Y-m-d H:i:s'),'up'=>1];
			$res	   = self::$csource->where('id in ('.$id.')')->save($cdata);
			self::jump($res, 'source_child_list',['wechat_id'=>self::$wechat_id]);
		}
	}
	/**
	 * 图片上传
	 * return ['media_id'=>'素材id','url'=>'素材地址'];
	 */
	public function source_upload(){
		$post 	= I('post.');
		$attach = M('attachment');
		$path 	= fileuploadOne($_FILES['file']);
		$post['path']  = $path ? $path : '';
		$post['size']  = $post['size'] / 1024;
		$post['ctime'] = date('Y-m-d');
		$post['ext']   = substr($post['name'],strrpos($post['name'],'.')+1,strlen($post['name']));
		if($attach->create($post)){
			$result = $attach->add();
		}
		//上传到微信服务器
		$result = self::set_source_media('Public/'.$path);
		$result['path'] = $path;
		$this->ajaxReturn($result);
	}
	/**
	 * 从公众号中获取永久素材
	 */
	public function get_source(){
		$wechat_id 	= I('request.wechat_id');
		if(empty($wechat_id)){
			$output = ['code'=>404,'message'=>'无法获取公众号信息'];
			$this->ajaxReturn($output);
		}
		//请求次数 超过5次第二天才能继续执行
		//防止多次刷新导致请求微信服务器超过限制
		$number  = S('number') ? S('number') : 0;
		$endtime = mktime(23,59,59,date('m'),date('d'),date('Y')); //当天最后时刻
		if($number == 5){
		 //存储第二天时间
			$date 	= date('Y-m-d',strtotime('+1 day'));
			$output = ['code'=>404,'message'=>'您刷新太平凡了，超过了请求限制，请于'.$date.'后在进行操作-_-'];
			$this->ajaxReturn($output);
		}else{
			S('number',++$number,$endtime-time());
		}
		//微信账户请求的是数组
		if(is_array($wechat_id)){
			foreach ($wechat_id as $id){
				self::$app = Wechat::app($id);
				$this->get_source_1($id);
			}
		}else{
			$this->get_source_1($wechat_id);
		}
		//当数据库中存在重复数据是更新操作
		$output = ['code'=>200,'message'=>'刷新成功','number'=>(5-$number)];
		$this->ajaxReturn($output);
	}
	
	/**
	 * 从微信公众号获取永久图文素材
	 * 存入数据库
	 * 当天最大刷新次数为5次，请谨慎操作
	 * @param int $wechat_id 微信账户id
	 */
	public function get_source_1($wechat_id){
		$source 	= self::$app->getForeverCount(); //获取所有素材个数
		$num  		= ceil($source['news_count']/20); //循环次数  总的图文素材数/每次获取个数
		
		for($i = 0; $i < $num; $i++){
			$result = self::$app->getForeverList('news',$i*20,20);
			//如果获取数据为0终止循环
			if($result == false || $result['item_count'] == 0) break;
			foreach($result['item'] as $val){
				$pdata = [
					'wechat_id'  => $wechat_id,
					'media_id'   => $val['media_id'],
					'ctime'		 => date('Y-m-d H:i:s'),
					'utime'		 => date('Y-m-d H:i:s',$val['update_time']),
					'sourse_num' =>	count($val['content']['news_item'])
				];
				$add_id	= self::$source->add($pdata,[],true);
				foreach($val['content']['news_item'] as $v){
					$cdata[] = [
						'media_id'				=> $val['media_id'],
						'title'					=> $v['title'],
						'author'				=> $v['author'],
						'digest'				=> $v['digest'],
						'content'				=> $v['content'],
						'content_source_url'	=> $v['content_source_url'],
						'show_cover_pic'		=> $v['show_cover_pic'],
						'url'					=> $v['url'],
						'thumb_url'				=> $v['thumb_url'],
						'thumb_media_id'		=> $v['thumb_media_id'],
						'need_open_comment'		=> $v['need_open_comment'],
						'only_fans_can_comment'	=> $v['only_fans_can_comment'],
						'source_id'				=> $add_id,
						'up'					=> 1,
						'ctime'					=> date('Y-m-d H:i:s',$val['content']['create_time']),
						'utime'					=> date('Y-m-d H:i:s',$val['content']['update_time'])
					];
				}
			}
			$add = self::$csource->addAll($cdata,[],true);
		}
		
	}
	/**
	 * 获取当前media_id下的所有图文素材
	 * @param string $media_id 媒体id
	 */
	public function get_curr_source(){
		$wechat_id = I('request.id');
		$media_id = 'VlnuIP8JKdzFH8NZOGn_NzWG0zjA119tykZBhclTf7s';
		$result = self::$app->getForeverMedia($media_id);
		dump($result);
	}
	
	/**
	 * 第一步，上传永久素材，可以在公众平台官网素材管理模块中看到
	 * 第二步，上传图文之新增永久图文素材
	 * 第三步， 预览接口(非必须步骤，但建议保留)
	 * 第四步， 向用户推送
	 */
	/**
	 * 第一步，上传永久素材，可以在公众平台官网素材管理模块中看到
	 * @param string $path 图片地址
	 * 上传成功微信返回结果 ['media_id'=>'素材id','url'=>'素材地址'];
	 */
	private static function set_source_media($path){
		//通过后台上传文件获取文件地址后上传素材到微信服务器
		//模拟
		$data 	 = ['media'=>'@'.$path];
		$result  = self::$app->uploadForeverMedia($data, 'thumb');
		//dump($result);
		//dump(Wechat::getError(self::$app->errCode));
		return $result;
	}
	/**
	 * 第二步，上传图文之新增永久图文素材
	 * @param array $data 上传信息 多图文素材
	 * [
	 *		"title"               => '',
	 *		"thumb_media_id"      => 'VlnuIP8JKdzFH8NZOGn_NzX_qam9kJblGVVRDEHyiHM', //图文消息的封面图片素材id（必须是永久mediaID）
	 *		"author"              => '测试编辑1',           //作者
	 *		"digest"              => '这是测试的摘要1',            //图文消息的摘要，仅有单图文消息才有摘要，多图文此处为空
	 *		"show_cover_pic"      => 1,            //是否显示封面，0为false，即不显示，1为true，即显示
	 *		"content"             => "",            //图文消息的具体内容，支持HTML标签，必须少于2万字符，小于1M，且此处会去除JS
	 *		"content_source_url"  => "http://www.地址",     //图文消息的原文地址，即点击“阅读原文”后的URL
	 *		"need_open_comment"	  => 1,
	 * ], 多个数组
	 * 上传成功微信返回结果 新增图文素材的media_id
	 * @return $result 
	 */
	private static function set_source($data){
		$data   = ['articles' => $data];
		$result = self::$app->uploadForeverArticles($data);
		return $result ? $result['media_id'] : false;
		dump(Wechat::getError(self::$app->errCode));
	}
	/**
	 * 第三步， 预览接口(非必须步骤，但建议保留)
	 * 执行后会向“touser”发送预览素材
	 * 为了防止开发者模式下，每月发送4条消息的限制，从而导致不满意消息的效果现象
	 * 但预览次数每日限制100条，请谨慎操作
	 * @param int $id 微信账户id
	 * @param array $data 推送数据
	 * $data = [
				'touser'  => 'ocanwvquBmKIvElB1KJpcNAEg-QM',
				'mpnews'  => ['media_id'=>'VlnuIP8JKdzFH8NZOGn_NzWG0zjA119tykZBhclTf7s'],
				'msgtype' => 'mpnews'
		];
	 */
	public static function send_source_preview($wechat_id,$media_id){
		//$wechat_id 	= I('request.wechat_id');
		//$media_id	= I('request.media_id');
		$data	= [
				'touser'  => 'ocanwvquBmKIvElB1KJpcNAEg-QM',
				'mpnews'  => ['media_id'=>$media_id],
				'msgtype' => 'mpnews'
		];
		$result = self::$app->previewMassMessage($data);
		return $result;
	}
	/**
	 * 第四步 主动推送信息
	 * （认证后的订阅号，服务号可用）
	 */
	public static function send_news(){
		$wechat_id 	= I('request.wechat_id');
		$media_id	= I('request.media_id');
		$data = [		//是否群发给所有用户.True不用分组id，False需填写分组id     //群发的分组id
				'filter'  => ['is_to_all'=>true, 'tag_id'=>'2'],
				'mpnews'  => ['media_id'=>$media_id],
				'msgtype' => 'mpnews'
		];
		$result = self::$app->sendGroupMassMessage($data);
		dump(Wechat::getError(self::$app->errCode));
	}
	
	/**
	 * AJAX
	 * 删除永久素材
	 * @param int $wechat_id 微信账户主键id
	 * @param int $id 附件表 素材主键id
	 */
	public function del_source_meida(){
		$wechat_id 	= I('request.wechat_id');
		$id 		= I('request.id');
		$media_id   = I('request.media_id');
		//dump(I('post.'));die;
		//$info 		= M('attachment')->find($id);
		$result 	= self::$app->delForeverMedia($media_id);
		if($result){
			//$res 	= M('attachment')->delete($id);
			$output = ['code'=>200,'message'=>'删除成功']; 
		}else{
			$output = ['code'=>403,'message'=>'删除失败']; 
		}
		$this->ajaxReturn($output);
	}
	/**
	 * 高级 删除已经发送出去的信息
	 * @param int $wechat_id 微信账户主键id
	 * @param int $id 素材主键id
	 */
	public function del_source_news(){
		/* $id 		= I('request.id');
		$info 		= self::$source->find($id); */
		$msg_id = '';//群发后获得的群发id ？？？测试号群发后没有返回msg_id这个参数？？不明所以
		$result =self::$app->deleteMassMessage($msg_id);
		/* if($result){
			$res = self::$source->delete($id);
		}
		self::jump($res, 'wechatResource/source_list'); */
	}
}