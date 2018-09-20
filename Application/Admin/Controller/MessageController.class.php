<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
use Think\Page;
use Admin\Common\Log;
/**
 * 客户留言操作
 * @author yqs
 *
 */
class MessageController extends AdminBaseController{
	private static $message;
    public function _initialize(){
        parent::_initialize();
        self::$message = D('message');
    }
    /**
     * 客户留言列表
     */
    public function index(){
    	$get 	   = self::$get;
    	$where 	   = 'isdel = 0 ';
    	$parameter = $get;
    	$get	   = self::get_fillter($get);
    	if(!empty($get)){
    		foreach($get as $key => $val){
    			$where .= ' and '.$key.'='.$val;
    		}
    		$this->assign('get',$get); //查询数据回显
    	}
    	
    	$count = self::$message->where($where)->count();
    	$page  = new Page($count,10,$parameter);
    	$info  = self::$message->where($where)->order('ctime desc')->limit(mypage($page))->select();
    	
    	$this->assign('info',$info);
    	$this->assign('page',$page->show());
    	$this->display();
    }
    /**
     * 查看留言信息
     * @param int $id 主键id
     */
    public function messshow($id){
    	$info = self::$message->find($id);
    	$this->assign('info',$info);
    	$this->display();
    }
    /**
     * 管理员修改反馈信息
     */
    public function messedit(){
    	$get = [
    		'id' 	   => I('get.id'),
    		'backtime' => date('Y-m-d H:i:s'),
    		'back' 	   => 1
    	];
    	Log::update('message', $get['id'], 2);
    	$res = self::$message->save($get);
    	
    	Log::write('message', $get['id'], 2);
    	self::jump($res, 'message/index');
    }
    /**
     * 留言删除操作，软删
     */
    public function messdel(){
    	$id  = I('request.id');
    	$ids = $id;
    	if(is_array($id)){
    		$id  = implode(',', $id);
    	}
    	$res = self::$message->where('id in ('.$id.')')->save(['isdel'=>1]);
    	
    	//将回收的数据对应表名，主键id，添加到回收表中
    	Log::write('message', $ids, 3);
    	$rest = recover_delete('message', '客户留言表', $ids);
    	self::jump($rest, 'message/index');
    }
    /**
     * 留言导出execl
     */
    public function messexport(){
    	$start  = I('post.exstart');
    	$end    = I('post.exend');
    	$source = I('post.source');
    	if(!empty($start) && !empty($end)){
    		$where = 'isdel = 0 and date_format(ctime,"%Y%m") >= "'.str_replace('-', '', $start).'" and date_format(ctime,"%Y%m") <= "'.str_replace('-', '', $end).'"';
    		if($source) $where .= 'source = '.$source;
    	}elseif($source){
    		$where = 'isdel = 0 and source = '.$source;	
    	}else{
    		$where = 'isdel = 0 and source in(4,5,6,7)';
	    	//暂时 ，导出 来源为 今日头条，腾讯新闻，uc，美柚留言数据
    	}
    	$output = self::$message->field('name,mobile,wechat,source,ctime')->where($where)->order('ctime desc')->select();
    	
    	//数据空时不导出
    	if(empty($output)){
    		self::jump(false, 'message/index','','没有数据可导出！');
    	}
    	
    	$data   = ['姓名','电话','微信','来源','留言时间'];
    	$name	= '';
    	foreach($output as &$val){
    		switch ($val['source']){
    			case 4: $name = $val['source'] = '今日头条'; break;
    			case 5: $name = $val['source'] = '腾讯新闻'; break;
    			case 6: $name = $val['source'] = 'UC头条';break;
    			case 7: $name = $val['source'] = '美柚';break;
    			default: break;
    		}
    	}
    	array_unshift($output,$data);
    	//标题
    	$title  = ($start == $end ? $start : $start.'_'.$end) .'用户留言来源'.($source ? '_'.$name.'_' : '').'统计表';
    	export_excel($output,$title,$title);
    }
    /**
     * 显示统计数据
     */
    public function getcount() {
		$sum = $this->runtime ();
		$arr = [ 
				'baidu' 	=> '百度',
				'fenghuang' => '凤凰',
				'meiyou' 	=> '美柚',
				'sina' 		=> '新浪',
				'tencent' 	=> '腾讯新闻',
				'toutiao' 	=> '今日头条',
				'uc' 		=> 'UC新闻',
				'wangyi' 	=> '网易',
				'weixin' 	=> '微信',
    			'yidian'	=> '一点咨询',
    			'fuyi'		=> '新浪扶翼'
    		
    	];
		$date = [];
		//各平台总访问量
		$znum = [];
		foreach($sum as $key=>&$val){
			$date[] = $key;
			$curr   = 0;
			foreach($val as $k=>$v){
				$curr 	  += $v;
				$znum[$k] += $v;
			}
			array_unshift($val,$curr);
		}
		array_multisort($date,SORT_DESC,$sum,SORT_DESC);
		
		foreach($znum as &$v){
			$z += $v;
		}
		array_unshift($znum, $z);
		$data = [
				'title' => $arr,
				'num'	=> $sum,
				'znum'	=> $znum
		];
    	$this->assign($data);
    	$this->display();
    }
    
    public function hits_export(){
    	$sum   = $this->runtime ();
    	$data  = [];
    	$pdata = [];	
    	$date  = [];
    	foreach($sum as $key=>$val){
    		$currnum			= 0;
    		foreach($val as $k=>$v){
    			$currnum  += $v;
    		}
    		$date[] = $key;
    		$data['time']			= $key;	
    		$data['baidu'] 			= $val['baidu'] ? $val['baidu'] : '0';
    		$data['fenghuang'] 		= $val['fenghuang'] ? $val['fenghuang'] : '0';
    		$data['meiyou'] 		= $val['meiyou'] ? $val['meiyou'] : '0';
    		$data['sina'] 			= $val['sina'] ? $val['sina'] : '0';
    		$data['tencent'] 		= $val['tencent'] ? $val['tencent'] : '0';
    		$data['toutiao'] 		= $val['toutiao'] ? $val['toutiao'] : '0';
    		$data['uc'] 			= $val['uc'] ? $val['uc'] : '0';
    		$data['wangyi'] 		= $val['wangyi'] ? $val['wangyi'] : '0';
    		$data['weixin'] 		= $val['weixin'] ? $val['weixin'] : '0';
    		$data['yidian'] 		= $val['yidian'] ? $val['yidian'] : '0';
    		$data['fuyi'] 			= $val['fuyi'] ? $val['fuyi'] : '0';
    		$data['hits'] 			= $currnum;
    		array_push($pdata, $data);
    		
    	}
    	array_multisort($date,SORT_DESC,$pdata,SORT_DESC);
    	$arr = [
    			'time' 		=> '时间',
    			'baidu' 	=> '百度',
    			'fenghuang' => '凤凰',
    			'meiyou' 	=> '美柚',
    			'sina' 		=> '新浪',
    			'tencent' 	=> '腾讯新闻',
    			'toutiao' 	=> '今日头条',
    			'uc' 		=> 'UC新闻',
    			'wangyi' 	=> '网易',
    			'weixin' 	=> '微信',
    			'yidian'	=> '一点咨询',
    			'fuyi'		=> '新浪扶翼',
    			'hits'		=> '当日总访问量'
    	];
    	array_unshift($pdata, $arr);
    	
    	export_excel($pdata,'新闻稿访问量统计','新闻稿访问量统计');
    }
    
	/**
	 * 统计各平台每日访问量
	 * @param string $dir 路径
	 * @return Ambigous <multitype:multitype: , number>
	 */
	private function runtime($dir = './Public/From'){
		static $tit = [];
		static $sum = [];
		$open = opendir($dir);
		while (($file = readdir($open)) !== false){
			if($file != '.' && $file != '..'){
				$path = $dir.'/'.$file;
				if(is_dir($path)){
					$tit[$file] = [];
					$this->runtime($path);
				}else{
					$res = array_filter(explode(PHP_EOL, file_get_contents($path)));
					foreach($tit as $key => $val){
						if(strpos($path, $key) !== false){
							$sum[pathinfo($file)['filename']][$key] = count($res);
						}
					}
				}
			}
		}
		return $sum;
	}
}