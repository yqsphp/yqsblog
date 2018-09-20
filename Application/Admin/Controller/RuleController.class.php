<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
use Admin\Model\AuthRuleModel as Auth;
/**
 * 权限控制类
 * @author yqs
 */
class RuleController extends AdminBaseController{
	private static $auth;
    public function _initialize(){
        parent::_initialize();
    }
    public function index(){

    }
    /**
     * 权限列表显示页
     */
    public function rulelist(){
        //$tree=Auth::rulelist();
        $tree = Auth::rule_list();
        $this->assign('tree',$tree);
        $this->display();
    }
    /**
     * 权限编辑添加
     */
    public function ruleedit(){
        if(IS_POST){
            if($_POST['type'] ==  1){//添加
                $res = Auth::rule_edit($_POST);
            }else{//编辑
                $res = Auth::rule_edit($_POST,2);
            }
            self::jump($res, 'Rule/rulelist');
        }
    }
    /**
     * 权限删除
     * @param string $id 权限id
     */
    public function ruledel($id){
        if(!empty($id)){
            $res = Auth::rule_del($id);
            self::jump($res, 'Rule/rulelist');
        }
    }
    /**
     * 分配权限显示页-编辑-添加
     */
    public function rulegroup(){
       if(IS_POST){
           $res = Auth::rule_group($_POST);
           self::jump($res, 'Rule/grouplist');
       }else{
           $id     = I('request.id');
           $auth   = Auth::rule_group('',$id);
           $first  = array(); //一级级权限
           $second = array(); //二级权限
           $third  = array(); //三级级权限
           foreach($auth['tree'] as $val){
               if($val['_level'] == 1) 
                   $first[]  = $val;
               else if($val['_level'] == 2) 
                   $second[] = $val;
               else 
                   $third[]  = $val;
           }
           //权限id转换成数组
           $auth['ids']['rules'] = explode(',', $auth['ids']['rules']);
           $this->assign('info',$auth['ids']);
           $this->assign('first',$first);
           $this->assign('second',$second);
           $this->assign('third',$third);
           $this->assign('id',$id);
           $this->display();
       }
    }
    /*-------------------------------管理员操作----------------------------------------*/
    /**
     * 管理员列表
     */
    public function adminlist(){
        $admin = Auth::admin_list();
        $group = Auth::group_list();
        $this->assign('admin',$admin);
        $this->assign('group',$group);
        $this->display();
    }
    /**
     * 管理员编辑添加
     */
    public function adminedit(){
        $type = I('request.type');
        $id	  = I('request.id');
        if(IS_POST){
            if($type == 2){//添加
                $res = Auth::admin_edit($_POST, 1);
            }else{//编辑
                $res = Auth::admin_edit($_POST, 2,$id);
            }
            self::jump($res, 'rule/adminlist');
        }
    }
    /**
     * 管理员删除
     */
    public function admindel(){
        $id = I('request.id');
        if($id){
            $res = Auth::admin_del($id);
        }
        self::jump($res, 'rule/adminlist');
    }
    /*---------------------------用户组操作----------------------------------*/
    /**
     * 用户组列表
     */
    public function grouplist(){
        $group = Auth::group_list();
        $this->assign('group',$group);
        $this->display();
    }
    /**
     * 用户组成员管理
     */
    public function groupguanli(){
    	if(IS_AJAX){
    		$groupid = I('request.groupid');
	    	$admin   = Auth::admin_list($groupid);
	    	$this->ajaxReturn($admin);
    	}
    }
    /**
     * 用户组成员管理删除
     */
    public function groupguanlidel(){
    	$id = I('request.id');
    	if($id){
    		$res = Auth::admin_del($id);
    	}
    	self::jump($res, 'rule/grouplist');
    }
    /**
     * 用户组添加与编辑
     */
    public function groupedit(){
        $id   = I('request.id');
        $type = I('request.type');
        if($type == 2){
            $res = Auth::group_edit($_POST, 1);
        }else{
            $res = Auth::group_edit($_POST, 2, $id);
        }
        self::jump($res, 'rule/grouplist');
    }
    /**
     * 用户组删除
     */
    public function groupdel(){
        $id = I('request.id');
        if($id){
            $res = Auth::group_del($id);
        }
        self::jump($res, 'rule/grouplist');
    }
}