<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
use Org\Nx\Page;
/**
 * 微信账户管理
 * @author YQS
 * @date 2018年5月25日
 */
class WechatAccountController extends AdminBaseController{
	private static $account;
	public function _initialize(){
		parent::_initialize();
		self::$account = M('wechatAccount');
	}
	/**
	 * 公众号列表
	 */
	public function index(){
		$count = self::$account->count();
		$page  = new Page($count,10);
		$info  = self::$account->where('isdel = 0')->order('id desc')->limit(mypage($page))->select();
		$this->assign('info',$info);
		$this->assign('page',$page->show());
		$this->display();
	}
	
	/**
	 * 公众号编辑
	 * @param int $status 状态 1.添加，2.编辑
	 */
	public function accountedit($status){
		$id   = I('request.id');
		$post = I('post.');
		if(IS_POST){
			if(empty($id)){
				if(self::$account->create($post)){
					$result = self::$account->add();
				}
			}else{
				$result = self::$account->save($post);
			}
			self::jump($result, 'wechatAccount/index');
		}else{
			if($status == 2){
				$info = self::$account->find($id);
				$this->assign('info',$info);
			}
			$this->assign('status',$status);
			$this->display();
		}
	}
	
	/**
	 * 公众号删除(软删)
	 */
	public function accountdel(){
		$id 	= I('request.id');
		$result = self::$account->where('id = '.$id)->save('isdel = 1');
		self::jump($result, 'wechatAccount/index');
	}
}