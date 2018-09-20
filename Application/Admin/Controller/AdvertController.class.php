<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
use Think\Page;
use Admin\Common\Log;
/**
 * 广告位管理类
 * @author yqs
 */
class AdvertController extends AdminBaseController {
	private static $advert;
	public function _initialize(){
		parent::_initialize();
		self::$advert = D('advert');
	}
	/**
	 * 广告位列表
	 */
	public function index(){
		$get      = self::$get; //获取查询信息
		$where    = '';
		$parament = $get;
		$get = self::get_fillter($get);
		if(!empty($get)){
			foreach ($get as $key => $val){
				if($key == 'name'){
					$where .= ' and '.$key.' like "%'.$val.'%"';
				}else{
					$where .= ' and '.$key.'='.$val;
				}
			}
			
			$this->assign('get',$get); //查询数据回显
		}
		$count = self::$advert->where('isdel = 0'.$where)->count();
		$page  = new Page($count,10,$parament);
		$info  = self::$advert->where('isdel = 0'.$where)->limit(mypage($page))->order('id desc')->select();
		$this->assign('get',$get);
		$this->assign('info',$info);
		$this->assign('page',$page->show());
		$this->display();
	}
	/**
	 * 广告位编辑添加 
	 * @param int $status 1.添加  2.编辑
	 */
	public function advert_edit($status){
		$id = I('request.id');
		if(IS_POST){
			$post = I('post.'); //文章id
			if($_FILES['image']['error'] != 4){
				$post['image'] = fileuploadOne($_FILES['image']);
			}
			if(empty($post['id'])){ //添加
				if(empty($post['url'])) $post['url'] = C('BAIDU_PC');
				if(self::$advert->create($post)){
					$res = self::$advert->add();
					Log::write('advert', $res, 1);
				}
			}else{ //编辑
				$post['isshow'] = isset($post['isshow']) ? $post['isshow'] : 0;
				//修改操作前日志判断
				$logid 			= Log::update('advert', $post['id'], 2);
				
				$res   			= self::$advert->save($post);
				
				Log::write('advert', $post['id'], 2, $logid);
			}
			self::jump($res, 'advert/index');
		}else{
			//编辑
			if($status == 2){
				$info = self::$advert->where('id = '.$id)->find();
				$this->assign('id',$id);
				$this->assign('info',$info);
			}
			$this->assign('status',$status);
			$this->display();
		}
	}
	/**
	 * 广告位删除
	 */
	public function advert_del(){
		$id  = I('request.id');
		$ids = $id;
		if(is_array($id)){
			$id = implode(',', $id);
		}
		//修改操作前日志判断
		$res = self::$advert->where('id in ('.$id.')')->save(['isdel'=>1]);
		Log::write('advert', $ids, 3);
		if($res !== false){
			$rest = recover_delete('advert', '广告表', $ids);
			self::jump($rest, 'advert/index');
		}
	}
	public function setup(){
		if(IS_AJAX){
			$post = I('post.');
			$res  = self::$advert->save($post);
			$this->ajaxReturn($res);
		}
	}
}