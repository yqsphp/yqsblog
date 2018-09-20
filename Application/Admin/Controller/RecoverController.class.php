<?php
namespace Admin\Controller;
use Admin\Common\AdminBaseController;
use Think\Page;
use Admin\Common\Log;
/**
 * 回收站管理类
 * @author yqs
 */
class RecoverController extends AdminBaseController {
	private static $recover;
	public function _initialize(){
		parent::_initialize();
		self::$recover = M('recover as re');
	}
	public function index(){
		//搜索查询条件
		$get   		= self::$get;
		$where 		= '';
		$parameter 	= $get;
		$get		= self::get_fillter($get);
		if(!empty($get)){
			$where .= 're.name = "'.$get['name'].'"';
			$this->assign('get',$get); //查询数据回显
		}
		
		//默认查询文章表回收的数据，请通过查询获得其他栏目回收的数据
		$count = self::$recover->where($where)->count();
		$page  = new Page($count,10,$parameter);
		//去重获取被删除表的列表
		$name  = self::$recover->distinct(true)->field('name,notes')->select();
		$reobj = self::$recover;
		foreach ($name as $key => $val){
			$reobj->join(C('DB_PREFIX').$val['name'].' as tp'.$key.' on tp'.$key.'.id = re.reid','left');
		}
		$info = $reobj->field('re.time as rtime,re.id as rid,re.notes,re.name as rname,re.reid')
				->where($where)->limit(mypage($page))->order('re.time desc')->select();
		
		$this->assign('name',$name);
		$this->assign('info',$info);
		$this->assign('page',$page->show());
		$this->display();
	}
	/**
	 * 数据还原操作
	 * 还原时更新回收表对应id，并更新需要还原的表名中的数据
	 */
	public function restore(){
		$id    = I('request.id');
		$table = I('request.table');
		$arid  = I('request.arid');
		if(is_array($id)) $id     = implode(',', $id);
		$res   = self::$recover->where('id in ('.$id.')')->select();
		if($res){
			if(is_array($table)){
				foreach($table as $name => $aid){
					$rest  = M($name)->where('id in ('.implode(',', $aid).')')->save(['isdel'=>0]);
					foreach ($aid as $v){
						Log::update($name, $v, 4);
					}
				}
			}else{
				$rest  = M($table)->where('id = '.$arid)->save(['isdel'=>0]);
				Log::update($table, $arid, 4);
			}
			//还原成功后 删除 回收站
			M('recover')->where('id in ('.$id.')')->delete();
			self::jump($rest, 'Recover/index');
		}else{
			$this->error('还原失败');
		}
	}
	
	/**
	 * 数据删除，彻底从数据库中删除
	 * 删除时同时删除回收表数据 和对应要删除表名中的数据
	 */
	public function del(){
		$table = I('request.table');
		$id    = I('request.id');
		$arid  = I('request.arid'); //真实数据删除
		if(is_array($id)) $id = implode(',', $id);
		$res   = M('recover')->where('id in ('.$id.')')->delete();
		if(is_array($table)){
			foreach($table as $name => $id){
				$rest = M($name)->where('id in ('.implode(',', $id).')')->delete();
			}
		}else{
			$rest  = M($table)->where('id = '.$arid)->delete();
		}
		self::jump($rest, 'Recover/index');
	}
	
	
	
	
}