<?php
namespace Admin\Controller;
use Think\Controller;
use Admin\Common\Wechat;
/**
 * 微信被动回复
 * @author YQS
 * @date 2018年5月25日
 */
class WechatAppController extends Controller{
	private static $reply;
	public function _initialize(){
		self::$reply = M('wechatReply');
	}
	/**
	 * 用户向公众号回复信息
	 */
	public function get_user_message(){
		$token = I('request.token');
		if($token){
			$account = M('wechatAccount')->field('id')->where('token = "'.$token.'"')->find();
		}else{
			echo '对不起，没有找到相关内容';
		}
		$app   = Wechat::app($account['id']);
		$type  = $app->getRev()->getRevType();
		file_put_contents('/tmp/debug.log', print_r($app->getRevData(),true),FILE_APPEND);
		switch($type){
			case $app::MSGTYPE_TEXT: 		//接收文本操作
				$keyword = $app->getRevContent();
				//这里开始查询关键字表对应发送信息,如果查询无结果
				//关键字完全匹配
				$info = self::$reply->where('keyword = "'.$keyword.'" and token = "'.$token.'"')->find();
				//天气查询
				if(empty($info)){
					$content = self::weather($keyword);
					if($content){
						$app->text($content)->reply();
					}else{
						$app->text('对不起，没有找到相关内容')->reply();
					}
				}else{
					switch ($info['replytype']){
						case 1:  //回复图文
							$news = self::get_article_info($info);
							if(empty($news)){
								$app->text('对不起，没有找到相关内容')->reply();
							}else{
								$app->news($news)->reply();
							}
							break;
						case 2:  //回复文本
							$app->text($info['text'])->reply();
							break;
						case 3:  //回复图片
							break;
						case 4:  //回复音频
							break;
						case 5:  //回复视频
							break;
						default:
							break;
					}
				}
				break;
			case $app::MSGTYPE_EVENT: 		//接收事件(点击菜单)操作
				$data = $app->getRevData(); //获取到的值EventKey设置的是自定义菜单的id
				$info = M('wechatMenu')->where('id = '.$data['EventKey'])->find();
				if($info){
					if($info['replytype'] == 1){
						$news = self::get_article_info($info);
						$app->news($news)->reply();
					}else{
						$app->text($info['text'])->reply();
					}
				}else{
					$app->text('对不起，没有找到相关内容')->reply();
				}
				break;
			case $app::MSGTYPE_LOCATION: 	//地理位置事件操作
				break;
			case $app::MSGTYPE_LINK: 		//接收链接操作
				break;
			case $app::MSGTYPE_VOICE: 		//接收声音操作
				break;
			case $app::MSGTYPE_IMAGE: 		//接收图片操作
				break;
			case $app::EVENT_SUBSCRIBE: 	//关注回复
				$info = self::$reply->where('type = 0')->find();
				if($info['replytype'] == 1){
					$news = self::get_article_info($info);
					$app->news($news)->reply();
				}else{
					$app->text($info['text'])->reply();
				}
				break;
			default:
				echo '对不起，没有找到相关内容';
				break;
		}
	}
	/**
	 * 公众号被动回复信息（图文）
	 * @param array $info 关键字信息
	 * @return array 查询的数据信息根据微信官方规定，最多允许8条数据显示
	 */
	private static function get_article_info($info){
		if($info['tablename'] == 'category'){
			$article = M('article')->where('catid = '.$info['aid'])->limit(8)->order('ptime desc')->select();
			$news 	 = [];
			foreach ($article as $val){
				$first   = getFirstImg($val['content']);
				$temp = [
						'Title'			=> $val['name'],
						'Description'	=> $val['description'],
						'PicUrl'		=> SITE_NAME.(empty($val['image'])?(empty($first) ? C('DEFAULT_IMG') : $first) : '/Public/'.$val['image']),
						'Url' 			=> SITE_NAME.U('article/'.$val['catid'].'/'.$val['id'].'/'.subchar(20))
				];
				array_push($news, $temp);
			}
		}else{
			$article = M('article')->where('id = '.$info['aid'])->find();
			$first   = getFirstImg($article['content']);
			$news = [
					'Title'			=> $article['name'],
					'Description'	=> $article['description'],
					'PicUrl'		=> SITE_NAME.(empty($article['image'])?(empty($first) ? C('DEFAULT_IMG') : $first) : $article['image']),
					'Url' 			=> SITE_NAME.U('article/'.$article['catid'].'/'.$article['id'].'/'.subchar(20))
			];
		}
		return $news;
	}
	public function test(){
		dump($_SERVER);
		$info = self::$reply->where('keyword = "妖精的尾巴" and token = "5ZEhiG0RvUcKru4xMr7V"')->find();
		dump($info);
		$a  = self::get_article_info($info);
		dump($a);
	}
	/**
	 * 天气查询
	 * @param string $keyword 关键字
	 * @return string|bool
	 */
	private static function weather($keyword){
		$weatherUrl = "http://api.map.baidu.com/telematics/v3/weather?".
				"location=".$keyword."&output=json&ak=1a3cde429f38434f1811a75e1a90310c";
		$apistr	 	= file_get_contents($weatherUrl);
		//$apiObj=simplexml_load_file($apistr);
		$apiObj		= json_decode($apistr);
		if($apiObj->error == 0 && $apiObj->status == 'success'){
			$city		= $apiObj->results[0]->currentCity;//读取城市
			$date		= $apiObj->results[0]->weather_data[0]->date;//读取当前日期
			$weather	= $apiObj->results[0]->weather_data[0]->weather;//读取天气状况
			$wind		= $apiObj->results[0]->weather_data[0]->wind;//读取风力
			$temperature= $apiObj->results[0]->weather_data[0]->temperature;//读取温度
			//返回给用户的信息
			$contentStr = '城市：'.$city."\n日期：".$date."\n天气：".$weather."\n风力：".$wind."\n温度：".$temperature;
			return $contentStr;
		}else{
			return false;
		}
	}
	/**
	 * 微信自定义菜单发布
	 */
	public function publish(){
		 
		//获取根据token来获取菜单
		$token	  = I('post.token');
		$id		  = I('post.id');
		$account  = M('wechatAccount')->find($id);
		$wemenu   = M('wechatMenu');
		if(empty($account)){
			$output = ['code'=>403,'message'=>'账户不存在'];
			$this->ajaxReturn($output);
		}    	//查询自定义一级菜单 最多允许3个
		$first	  = $wemenu->where('pid=0 and token="'.$token.'"')->limit(3)->order('x asc')->select();
		//dump($first);exit;
		$menu	  = '{"button":[';
		foreach ($first as $key=>$val){
			$menu	.= '{"name":"'.$val['name'].'",';
			//二级菜单 最多只允许5个
			$second  = $wemenu->where('pid='.$val['id'].' and token="'.$token.'"')->order('y asc')->limit(5)->select();
			//一级菜单
			if(!$second){
				if($val['sendtype'] == 1){//点击事件 click
					$menu .= '"type":"click","key":"'.$val['id'].'"},';
				}else if($val['sendtype'] == 2){//链接跳转事件 views
					$menu .= '"type":"view","url":"'.$val['links'].'"},';
				}
			}else{
				$menu .= '"sub_button":[';
				foreach($second as $v){
					if($v['sendtype'] == 1){
						$menu .= '{"type":"click","name":"'.$v['name'].'","key":"'.$v['id'].'"},';
					}else if($v['sendtype'] == 2){
						$menu .= '{"type":"view","name":"'.$v['name'].'","url":"'.$v['links'].'"},';
					}
				}
				$menu  = trim($menu,',');
				$menu .= ']},';
			}
		}
		$menu   = trim($menu,',');
		$menu  .= ']}';
		//$this->ajaxReturn($menu);
		// 用grant_type=client_credential、appid和appsecert获得access_token
		$result = Wechat::app($id)->createMenu(json_decode($menu,true));
		if($result){
			$output = ['code'=>200,'message'=>'发布成功'];
		}else{
			$output = ['code'=>403,'message'=>'发布失败'];
		}
		$this->ajaxReturn($output);
	}
}