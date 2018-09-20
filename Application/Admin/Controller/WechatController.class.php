<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
class WechatController extends AdminBaseController{
	private static $wechat;
	private static $account;
	public function _initialize(){
		parent::_initialize();
		self::$wechat  = M('wechatMenu');
		self::$account = M('wechatAccount');
	}
    public function index(){
    	$get   = self::$get;
    	//一级菜单
    	$pinfo = self::$wechat->where('pid = 0 and isdel = 0 and token = "'.$get['token'].'"')->order('x asc')->select();
    	//二级菜单
    	$cinfo = self::$wechat->where('pid <> 0 and isdel = 0 and token = "'.$get['token'].'"')->order('y asc')->select();
    	$this->assign('pinfo',$pinfo);
    	$this->assign('plength',count($pinfo));
    	$this->assign('cinfo',$cinfo);
    	$this->assign('get',$get);
    	$this->display();
    }
    /**
     * 菜单编辑
     */
    public function menuedit(){
    	$post = I('post.');
    	$post['replytype'] = $post['sendtype'] == 1 ? $post['replytype'] : 0;
    	if(empty($post['id'])){
    		if(self::$wechat->create($post)){
    			$result = self::$wechat->add();
    		}
    		$output = ['code'=>200,'type'=>1,'result'=>$result];
    	}else{
    		$result = self::$wechat->save($post);
	    	$output = ['code'=>200,'type'=>2,'result'=>$result];
    	}
    	
    	$this->ajaxReturn($output);
    }
    public function menudel(){
    	$id = I('post.id');
    	if(empty($id)){
    		$output = ['code'=>403,'message'=>'值不能为空'];
    	}else{
	    	self::$wechat->delete($id);
	    	//删除后查看当前菜单下是否有子集存在一并删除
	    	$result = self::$wechat->field('id')->where("pid = ".$id)->select();
	    	if(!empty($result)){
	    		self::$wechat->where('id in ('.implode(',', $result).')')->delete();
	    	}
    		$output = ['code'=>200,'message'=>'删除成功'];
    	}
    	$this->ajaxReturn($output);
    }
    /**
     * 菜单获取文章信息
     */
    public function article(){
    	//文章信息
    	$art = M('article')->field('id,catid,name')->where('isdel = 0 and status = 1 and mobile = 1')->order('ptime desc')->select();
        //查询类别
        $cat = M('category')->where('isdel = 0 and mobile <> 0 and pc <> 0')->select();
        
        foreach($art as &$val){
        	$val['table'] = 'article';
        }
        foreach($cat as &$val){
        	$val['table'] = 'category';
        }
        ['art'=>$art,'cat'=>$cat];
        $this->ajaxReturn([$art,$cat]);
    }
    
    /**
     * 获取当前主键的信息
     */
    public function get_info(){
    	$id = I('post.id');
    	if(empty($id)) $this->ajaxReturn('');
    	$data = self::$wechat->where('id = '.$id)->find();
    	$this->ajaxReturn($data);
    }
    
    /**
     * 公众号回复
     */
    public function reply(){
    	$this->assign('token',I('token'));
    	$this->display();
    }
}