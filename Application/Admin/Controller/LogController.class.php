<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
use Think\Page;
/**
 * 日志操作
 * @author yqs
 *
 */
class LogController extends AdminBaseController{
    private static $log;
	public function _initialize(){
    	parent::_initialize();
    	self::$log = D('log');
    }
    /**
     * 用户日志操作列表
     */
    public function index(){
    	//查询条件
    	$get   	= self::$get;
    	$method = $get;
    	$where 	= '1 = 1 ';
    	$get	= self::get_fillter($get);
		if(!empty($get)){
			foreach ($get as $key => $val){
				if($key == 'start'){
					$where .= ' and ctime >= "'.$val.'"';
				}elseif($key == 'end'){
					$where .= ' and ctime <= "'.$val.'"';
				}else{
					$where .= ' and '.$key.' = "'.$val.'"';
				}
			}
		}
    	$table = M()->query('show table STATUS');
    	//获取管理员
    	$user  = D('admin')->field('id,name')->where('status = 1')->select();
    	$count = self::$log->where($where)->count();
    	$page  = new Page($count,10,$method);
    	$info  = self::$log->where($where)->limit(mypage($page))->order('ctime desc')->select();
        $this->assign('info',$info);
        $this->assign('page',$page->show());
        $this->assign('user',$user);
        $this->assign('tables',$table);
        $this->assign('get',$get);
        $this->display();
    }
    /**
     * 查看日志详细信息
     */
    public function logshow(){
    	$id    = I('request.id');
    	$table = I('request.table'); //操作表名
    	$type  = I('request.type');  //操作类型
    	$log   = D('log_content');
    	$where = 'logid = '.$id;
    	if($type != 1){
    		$where .= ' and tnewvalue <> ""';
    	}
    	$count = $log->where($where)->count();
    	$page  = new Page($count,10);
    	$info  = $log->where($where)->limit(mypage($page))->select();
    	//将值过长的简化
    	foreach($info as &$val){
    		if(strlen(strip_tags($val['toldvalue'])) > 20){
    			$val['toldvalue'] = mb_substr($val['toldvalue'],0,20,'utf-8').'...';
    		}
    		if(strlen(strip_tags($val['tnewvalue'])) > 20){
    			$val['tnewvalue'] = mb_substr($val['tnewvalue'],0,20,'utf-8').'...';
    		}
    	}
    	
    	$this->assign('info',$info);
    	$this->assign('page',$page->show());
    	$this->assign('table',$table);
    	$this->assign('type',$type);
    	$this->assign('jump',$_SERVER['HTTP_REFERER']);
    	$this->display();
    }
    /**
     * 日志删除
     */
    public function logdel(){
    	$id  = I('request.id');
    	if(is_array($id)) $id = implode(',', $id);
    	
    	$res = self::$log->where('id in ('.$id.')')->delete();
    	self::jump($res, 'log/index');
    }
}