<?php
namespace Admin\Common;
use Think\Controller;
use Think\Auth;
use Admin\Model\AdminModel;

class AdminBaseController extends Controller{
	public static $this;
	public static $get;
    /**
     * 初始化方法
     */
    public function _initialize(){
    	$get	 	= I('get.');
    	$auth_id	= $get['auth_id']; //二级菜单id
    	
    	//不管是编辑，添加，删除等操作后跳转必须检测二级菜单是否存在
    	//if(empty($auth_id)) session('auth_id',$auth_id);    	if(empty($auth_id)){
			$auth_id = session('auth_id');    		
    	}else{
    		session('auth_id',$auth_id);
    	}
    	self::$this = $this;
    	self::$get	= $get;
        //$name=MODULE_NAME.'/'.CONTROLLER_NAME.'/'.ACTION_NAME;
        $id = session('user_info.user_id'); //获取用户登录id
        if(!$id){
        	echo "<script>parent.location.reload();location.href='".U('login/index')."'</script>";
            exit;
        }
        ///dump($auth->getGroups($id)); exit;
        //$res=$auth->check($name, $id);
        $res=true;
        if(!$res){
            $this->redirect('/404');
            die();
        }else{
        	$cache = S('admin_nav');
        	if($cache){
        		$nav   = $cache;
        	}else{
	        	$auth  = new Auth();
	            $admin = new AdminModel();
	            $group = $auth->getGroups($id);
	            //存储用户组id
	            session('user_group',$group[0]['group_id']);
	            $nav   = $admin->cache('admin_nav',1800)->nav($group[0]);
        	}
        	//三级操作5种情况   1.添加，2.编辑，3.查看，4.还原，5.删除
        	$auth_third = ['auth_add'=>null,'auth_edit'=>null,'auth_check'=>null,'auth_recover'=>null,'auth_delete'=>null];
        	foreach($nav['third'] as $val){
        		if($auth_id == $val['pid'] && !empty($val['condition'])){
        			switch (intval($val['condition'])){
        				case 1: $auth_third['auth_add']     = 1; break;
        				case 2: $auth_third['auth_edit']    = 1; break;
        				case 3: $auth_third['auth_check']   = 1; break;
        				case 4: $auth_third['auth_recover'] = 1; break;
        				case 5: $auth_third['auth_delete']  = 1; break;
        			}
        		}
        	}
            $this->assign('menufirst',$nav['nav']);
            $this->assign('menusecond',$nav['second']);
            $this->assign('third',$auth_third);
        }
        
    }
    /**
     * 查询条件过滤
     * @param array $get 条件数组
     * @return 过滤后的数组
     */
    public static function get_fillter($get = []){
    	unset($get['p']); //首先去除分页p
    	//删除auth_id 防止其他方法错误
    	unset($get['auth_id']);
    	$get = array_filter($get,function($med){
    		if($med !== '') return true;
    	});
    	return $get;
    }
    /**
     * 操作完成跳转
     * @param int $res 获取结果
     * @param string $url 跳转地址
     * @param array $method 额外参数
     * @param string $message 提示信息
     */
    public static function jump($res,$url,$method = [],$message = ''){
    	$param = ['auth_id'=>session('auth_id')];
    	if($method){
    		foreach($method as $key => $val){
    			$param[$key] = $val;
    		}
    	}
    	$message = $message?$message : '操作失败';
    	
    	$res !== false ? self::$this->success('操作成功',U($url,$param),1) : self::$this->error($message,U($url,$param),1);
    }
}