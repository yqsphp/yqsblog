<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
use Org\Nx\Page;
use Admin\Common\Log;
/**
 * 微信回复管理管理
 * @author YQS
 * @date 2018年5月25日
 */
class WechatReplyController extends AdminBaseController{
	private static $reply;
	public function _initialize(){
		parent::_initialize();
		self::$reply = M('wechatReply');
	}
	/**
	 * 关键字列表
	 */
	public function index(){
		$get   = self::$get;
		$param = $get;
		$get   = self::get_fillter($get);
		$where = 'isdel = 0 and type = 2';
		if(!empty($get)){
			foreach ($get as $key=>$val){
				$where .= ' and '.$key.'='.'"'.$val.'"';
			}
			$this->assign('get',$get);
		}
		
		$count = self::$reply->where($where)->count();
		$page  = new Page($count,10,$param);
		$info  = self::$reply->where($where)->order('id desc')->limit(mypage($page))->select();
		$this->assign('info',$info);
		$this->assign('page',$page->show());
		$this->display();
	}
	/**
	 * 编辑 针对微信账号管理中
	 * @param int $status
	 */
	public function replyedit(){
		$id   = I('post.id');
		$post = I('post.');
		if(empty($id)){
			if(self::$reply->create($post)){
				$result = self::$reply->add();
			}
			$output = ['type'=>1,'message'=>'保存成功','result'=>$result];
		}else{
			$result = self::$reply->save($post);
			$output = ['type'=>2,'message'=>'更新成功','result'=>$result];
		}
		$this->ajaxReturn($output);
	}
	/**
	 * 未知回复，默认回复 数据显示 针对微信账号管理中
	 * @param int $type 0.关注(默认),1.未知
	 */
	public function reply(){
		$type  = I('post.type');
		$token = I('post.token');
		$data  = self::$reply->where('isdel = 0 and type = '.$type.' and token = "'.$token.'"')->find();
		//$data = self::$reply->_sql();
		$this->ajaxReturn($data);
	}
	/**
	 * 关键字编辑
	 * @param int $status 1.添加，2.编辑
	 */
	public function keyedit($status){
		$id   = I('request.id');
		$post = I('post.');
		if(IS_POST){
			if(empty($post['id'])){
				if(self::$reply->create($post)){
					$res = self::$reply->add();
					Log::write('wechat_reply', $res, 1);
				}
			}else{
				$res = self::$reply->save($post);
				Log::write('wechat_reply', $id, 2);
			}
			self::jump($res, 'wechatReply/index');
		}else{
			if($status == 2){
				$info = self::$reply->find($id);
				$this->assign('info',$info);
			}
			//查询公众号
			$list = M('wechatAccount')->field('name,token')->where('isdel = 0')->select();
			$this->assign('list',$list);
			$this->assign('status',$status);
			$this->display();
		}
	}
	/**
	 * 关键字删除
	 */
	public function keydel(){
		$id  = I('get.id');
		$res = self::$reply->where('id ='.$id)->save(['isdel'=>1]);
		Log::write('wechat_reply', $id, 3);
		self::jump($res, 'wechatReply/index');
		
	}
}