<?php
namespace Admin\Common;
/**
 * 数据表结构
 * CREATE TABLE `mengmei_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `uid` int(11) NOT NULL COMMENT '操作用户id',
  `uname` varchar(255) NOT NULL COMMENT '操作用户名',
  `ip` varchar(255) NOT NULL COMMENT '操作用户当前ip',
  `tables` varchar(255) NOT NULL COMMENT '操作表名称',
  `tcomment` varchar(255) NOT NULL COMMENT '操作表注释',
  `log` varchar(255) NOT NULL COMMENT '简单的操作日志记录',
  `tid` int(11) NOT NULL COMMENT '操作表中的主键id',
  `type` tinyint(1) NOT NULL COMMENT '操作类型：1.增加，2.编辑，3.删除',
  `ctime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '操作时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='日志操作表';
CREATE TABLE `mengmei_log_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键自增',
  `tfield` varchar(255) NOT NULL COMMENT '字段名称',
  `toldvalue` longtext NOT NULL COMMENT '对应字段插入数据的信息',
  `tnewvalue` longtext NOT NULL COMMENT '对应字段更新后的信息',
  `tcomment` varchar(100) NOT NULL COMMENT '当前对应表名注释',
  `logid` int(11) DEFAULT NULL COMMENT '日志表id',
  `tid` int(11) NOT NULL COMMENT '对应表主键id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='操作日志从表';

 */
/**
 * 后台日志操作记录公共类
 * @author yqs
 */
class Log{
	private static $flag = false; //是否启用日志，默认false;
	/**
	 * 写入日志
	 * @param string $table 操作表名
	 * @param int $id   操作表对应表的id：新增，修改，删除id
	 * @param int $type 操作类型：1.增加，2.修改，3.删除
	 * @param int $logid 日志表id 编辑操作传值
	 */
	public static function write($table,$id,$type,$log_id = null){
		if(self::$flag){
			if(is_array($id)){
				foreach($id as $v){
					self::setlog($table, $v, $type,$log_id);
				}
			}else{
				self::setlog($table, $id, $type,$log_id);
			}
		}
	}
	/**
	 * 写入日志
	 * @param string $table 操作表名
	 * @param int $id   操作表对应表的id：新增，修改，删除id
	 * @param int $type 操作类型：1.增加，2.修改，3.删除
	 * @param int $logid 日志表id 编辑操作传值
	 */
	private static function setlog($table,$id,$type,$log_id = null){
		$info   = session('user_info');  
		$tables = self::get_table($table);  //获取表信息
		$field  = self::get_table_field($table); //获取表字段信息
		$log = M('log');
		$con = M('log_content');
		//写入数据前先判断当前表操作日志类型是否为修改，删除，存在则不添加
		if($log_id == null){
	 		$logs   = $type == 1 ? '操作表‘'.$table.'’新增了一条数据' : 
	 				 ($type == 2 ? '操作表‘'.$table.'’修改了一条数据' : 
	 				 ($type == 3 ? '操作表‘'.$table.'’删除了一条数据' : '操作表‘'.$table.'’还原了一条数据'));
			$data   = [
				'uid' 	   => $info['user_id'],
				'uname'	   => $info['user_name'],
				'log'	   => '管理员【'.$info['user_name'].'】'.$logs, //操作内容
				'ip' 	   => getIp(),    //登陆ip
				'tables'   => $table,    //操作表名
				'tid' 	   => $id, //对应表中的主键id
				'type' 	   => $type, //操作类型，比如删除，添加，修改等
				'tcomment' => $tables['comment'] //表注释
			];
			if($log->create($data)){
				$logid = $log->add();
			}
		}
		
		//获取对应表的一条数据
		$info = M($table)->where('id = '.$id)->find();
		
		if($type == 1){
			//添加操作 删除操作 
			foreach($info as $key => $val){
				$logdata[] = [
					'tfield'	=> $key,
					'toldvalue' => $val,
					'tcomment'  => $field[$key],
					'logid'		=> $logid,
					'tid'		=> $id
				];
			}
			$con->addAll($logdata);
		}elseif($type == 2){
			$table_info = $con->where('tid = '.$id)->group('tfield')->order('id desc')->select();
			if($log_id){
				//更新操作时
				foreach($table_info as $key => $val){
					foreach($info as $k=>$v){
						//比较字段信息更新时修改没有
						if($val['tfield'] == $k && $val['toldvalue'] != $v){
							$logdata[] = [
									'tfield'	=> $k,
									'toldvalue' => $val['toldvalue'],
									'tnewvalue' => $v,
									'tcomment'  => $field[$k],
									'logid'		=> $log_id,
									'tid'		=> $id
							];
						}
					}
				}
				$con->addAll($logdata);
			}
		}
	}
	/**
	 * 修改，删除数据之前操作
	 * @param string $table 当前操作表
	 * @param int|array $id 操作表对应表的id：新增，修改，删除id
	 * @param int $type 操作类型：1.增加，2.修改，3.删除，4.还原
	 * @return int|array 日志主表自增id
	 */
	public static function update($table,$id,$type){
		$tables = self::get_table($table);  //获取表信息
		$field  = self::get_table_field($table); //获取表字段信息
		$info   = session('user_info');
		
		$log = M('log');
		$con = M('log_content');
		//更新之前判断日志表有无数据，没有添加为修改数据
		//$logdata = $log->where('tid = '.$id)->find();
		//if(empty($logdata)){
		$logs   = $type == 2 ? '操作表‘'.$table.'’修改了一条数据' : ($type == 4 ? '操作表‘'.$table.'’还原了一条数据' : '操作表‘'.$table.'’删除了一条数据');
		
		$data   = [
			'uid' 	   => $info['user_id'],
			'uname'	   => $info['user_name'],
			'log'	   => '管理员【'.$info['user_name'].'】'.$logs, //操作内容
			'ip' 	   => getIp(),    //登陆ip
			'tables'   => $table,    //操作表名
			'tid' 	   => $id, //对应表中的主键id
			'type' 	   => $type, //操作类型，比如删除，添加，修改等
			'tcomment' => $tables['comment'] //表注释
		];
		
		if($log->create($data)){
			$logid = $log->add();
		}
		if($type == 3 || $type == 4)
			return $logid;
		//}
		//当前表的主键的数据
		$info = M($table)->where('id = '.$id)->find();
		//日志从表有无数据
		$table_info = $con->where('tid = '.$id)->find();
		if(empty($table_info)){
			foreach($info as $key => $val){
				$logsdata[] = [
					'tfield'	=> $key,
					'toldvalue' => $val,
					'tcomment'  => $field[$key],
					'logid'		=> $logid,
					'tid'		=> $id
				];
			}
			$con->addAll($logsdata);
		}
		return $logid;
	}
	/**
	 * 获取表的结构注释
	 * @param string $table 表名
	 * @return array 表结构数组信息
	 */
	private static function get_table($table){
		return M()->query('show table status where name = "'.C('DB_PREFIX').$table.'"')[0]; //查询表注释
	}
	/**
	 * 获取表字段信息
	 * @param string $table 表名
	 * @return array 表结构组装后数组信息 [字段=>字段注释]
	 */
	private static function get_table_field($table){
		$tableField = M()->query('show full columns from '.C('DB_PREFIX').$table); //查询表字段信息
		foreach($tableField as $key=>$val){
			$info[$val['field']] = $val['comment'];
		}
		unset($info['id']);
		return $info;
	}
}