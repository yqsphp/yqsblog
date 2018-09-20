<?php
namespace Admin\Common;
/**
 * 回收站公共类
 * @author yqs
 */
class Recover{
	/**
	 * 回收数据
	 * @param string $table 回收表名
	 * @param int|array $id 回收表的id
	 * @return int|boolean
	 */
	public static function delete($table,$id){
		$recover = D('recover');
		//将回收的数据对应表名，主键id，添加到回收表中
		if(is_array($id)){
			foreach ($id as $val){
				$data[] = ['name'=>$table,'reid'=>$val];
			}
		}else{
			$data[] = ['name'=>$table,'reid'=>$id];
		}
		$res = $recover->addAll($data);
		return $res;
	}
}