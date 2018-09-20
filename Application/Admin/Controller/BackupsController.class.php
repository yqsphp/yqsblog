<?php
namespace Admin\Controller;
use Think\Controller;
/**
 * 数据备份和恢复
 * 数据库信息必须为进行了严格的转义数据，不能存在引起sql歧义符号！否则备份不能按每一行保存，导致数据恢复错误!
 */
class BackupsController extends Controller {

    private $backup_path = '';       //备份文件夹相对路径
    private $backup_name = '';       //当前备份文件夹名
    private $offset      = 500;    //每次取数据条数
    private $dump_sql    = '';	//sql语句
    private $sizelimit   = 0; // 默认分卷大小
    public function __construct(){
        parent::__construct();
        $this->backup_path = COMMON_PATH.'Backup/';
        $this->sizelimit   = 50*1024*1024;
        set_time_limit(0);
        $this->mod 		   = M();
    }

    /**
     * 数据恢复列表
     */
    public function index(){
    	$this->assign('backups', $this->get_backups());
    	$this->assign('table_list', true);
    	$this->display();
    }
    /**
     * 数据备份列表显示
     */
    public function backups(){
    	//显示数据表信息
    	$table = $this->mod->cache(true)->query('show table status');
    	$data  = [
    		'backup_name' 	=> $this->set_backups_name(),
    		'tables' 		=> $table,  //显示所有数据表
    		'btype' 		=> I('get.type'),
    		'bname' 		=> I('get.backup_name'),
    		'bsizelimit' 	=> I('get.sizelimit'),
    		'bdosubmit' 	=> I('get.dosubmit')
    	];
    	$this->assign($data);
        $this->display();
    }
	/**
	 * 数据导出
	 * @param string $submit get请求
	 */
    public function export($submit=''){
    	//dump($_POST);exit();
        if (IS_POST || $submit != ''){
            if (isset($_GET['type']) && $_GET['type'] == 'url'){
            	//备份文件大小
                $sizelimit 		   = isset($_GET['sizelimit']) && abs(intval($_GET['sizelimit'])) ?
                						abs(intval($_GET['sizelimit'])) : $this->sizelimit;
                //备份文件名
                $this->backup_name = isset($_GET['backup_name']) && trim($_GET['backup_name']) ?
                						trim($_GET['backup_name']) : $this->set_backups_name();
                
                $vol 			   = $this->get_vol();
                $vol++;
            } else {
            	//备份文件大小
                $sizelimit 		   = isset($_POST['sizelimit']) && abs(intval($_POST['sizelimit'])) ?
                						abs(intval($_POST['sizelimit']))*1024*1024 : $this->sizelimit;
                //备份文件名
                $this->backup_name = isset($_POST['backup_name']) && trim($_POST['backup_name']) ?
                						trim($_POST['backup_name']) : $this->set_backups_name();
                //备份文件表名
                $backup_tables 	   = isset($_POST['backup_tables']) && $_POST['backup_tables'] ?
                						$_POST['backup_tables'] : $this->error('无表可备份');

                if (is_dir($this->backup_path . $this->backup_name)){
                    $this->error('备份名称已经存在');
                }
                if (!file_exists($this->backup_path . $this->backup_name)){
                    mkdir($this->backup_path . $this->backup_name, 0777,true);
                }
                if (!is_file($this->backup_path . $this->backup_name . '/tbl_queue.log')){
                    //写入队列
                    $this->set_queue($backup_tables);
                }
                $vol = 1;
            }
            $tables  = $this->start_queue($vol, $sizelimit);

            if ($tables === false){
                $this->error('加载队列文件错误');
            }
            $this->backups_result($tables, $vol, $sizelimit);
            exit();
        }
    }

    /**
     * 导入备份
     * @param strin $backup 导入文件夹名
     * @param int $vol 分卷标识
     */
    public function import($backup='',$vol=''){
        $backup_name       = isset($backup) && trim($backup) ? trim($backup) : $this->error('请选择备份名称');
        $vol 			   = empty($vol) ? 1 : intval($vol);
        $this->backup_name = $backup_name;
        //获得所有分卷
        $backups 		   = $this->get_vols($this->backup_name);
        $backup 		   = isset($backups[$vol]) && $backups[$vol] ? $backups[$vol] : $this->error('无此文件！');
        //开始导入卷
        if ($this->import_vol($backup['file'])){
            if ($vol < count($backups)){
                $vol++;
                $link = U('Backups/import',array('backup'=>urlencode($this->backup_name),'vol'=>$vol));
                $this->success(sprintf('正在导入数据分卷...第 %d 卷', $vol-1), $link);
            } else{
                $this->success('导入成功！', U('Backups/index'));
            }
        }
    }
    /**
     * 删除备份
     * @param string $backup 备份文件夹名称
     */
    public function del_backups($backup=''){
    	if($backup != ''){
    		$dir=$this->backup_path.$backup;
    		clear($dir) === true?$this->success('删除备份成功',U('Backups/index')) : $this->error('删除备份失败',U('Backups/index'));
    	}
    }

    /**
     * 下载备份文件
     * @param string $file 文件夹名
     */
    public function download($file=''){
    	if($file != ''){
    		$path 	  = $this->backup_path.$file;
    		$downpath = zipActive($path);
    		//import('Org\Net\Http');
    		//Http::download($downpath);
    		download($downpath);
    		unlink($downpath);//下载完成后删除文件
    	}
    }
	/**
	 * 分卷导入操作
	 * @param string $file_name 导入文件名
	 * @return boolean
	 */
    private function import_vol($file_name){
        $sql_file = $this->backup_path . $this->backup_name . '/' . $file_name;
        $sql	  = file_get_contents($sql_file);

        $sql	  = explode("-- ", $sql);
        $ret	  = array_filter($sql,function($data){
        	if(empty($data) || preg_match('/^--*/', $data)){
        		return false;
        	}else{
        		return true;
        	}
        });
        //开启事物
        $flag   = true;
        $this->mod->startTrans();
       	foreach($ret as $key=>$val){
       		$ret[$key] = trim($ret[$key], "\r\n;"); //剔除多余信息
       		if(strlen($ret[$key]) == 0){
       			continue;
       		}
       		$flag	   = $this->mod->execute($ret[$key]);
       		if($flag === false){
       			break;
       		}
       	}
       	if($flag === false){
       		$this->mod->rollback();
       		return false;
       	}else{
       		$this->mod->commit();
        	return true;
       	}
    }

    /**
     * 获得备份文件夹下的sql文件
     * @param string $backup_name 备份文件名
     * @return number string
     */
    private function get_vols($backup_name){
        $vols     = array(); //所有的卷
        $bytes 	  = 0;
        $vol_path = $this->backup_path . $backup_name . '/';
        if (is_dir($vol_path)){
        	$handle = opendir($vol_path);
            if ($handle){
                $vol = array();
                while (($file = readdir($handle)) !== false){
                    $file_info = pathinfo($vol_path . $file);
                    if ($file_info['extension'] == 'sql'){
                        $vol 		 	   = $this->get_head($vol_path . $file);
                        $vol['file'] 	   = $file;
                        $size		 	   = filesize($vol_path . $file);
                        $bytes 	    	  += $size;
                        $vol['size'] 	   = format_bytes($size);
                        $vol['total_size'] = ceil(10 * $bytes / 1024) / 10;
                        $vols[$vol['vol']] = $vol;
                    }
                }
            }
        }
        ksort($vols);
        return $vols;
    }

    /**
     * 获得备份列表
     * @return array
     */
    private function get_backups(){
        $backups = array(); //所有的备份
        if (is_dir($this->backup_path)){
        	$handle = opendir($this->backup_path);
            if ($handle){
                while (($file = readdir($handle)) !== false){
                    if ($file{0} != '.' && filetype($this->backup_path . $file) == 'dir'){
                        $backup['name'] 		= $file;
                        $backup['date'] 		= filemtime($this->backup_path . $file);
                        $backup['date_str'] 	= date('Y-m-d H:i:s', $backup['date']);
                        $backup['vols'] 		= $this->get_vols($file);
                        $backup['vols_length']  = count($backup['vols']);
                        $end_vol 				= end($backup['vols']);
                        $sizes					= $this->get_dir_size($this->backup_path . $file);
                        $backup['total_size'] 	= format_bytes($sizes);
                        $backups[] 				= $backup;
                    }
                }
            }
        }
        ksort($backups);
        return $backups;
    }

    /**
     * 备份结果
     * @param string|array $tables 表名
     * @param int $vol 分卷参数
     * @param int $sizelimit 备份大小
     */
    private function backups_result($tables, $vol, $sizelimit){
        file_put_contents($this->backup_path.$this->backup_name.'/'.
        		$this->backup_name .'_'.$vol.'.sql',$this->dump_sql); //保存备份文件
        if (empty($tables)){
            //备份完毕
            @unlink($this->backup_path.$this->backup_name.'/tbl_queue.log'); //删除队列文件
            $vol != 1 && @unlink($this->backup_path.$this->backup_name.'/vol.log'); //只有一卷时不需删除
            $this->success('备份成功！',U("Backups/index"));
        } else{
            //开始下一卷
            $this->set_vol($vol); //设置分卷记录
            $link = U('Backups/export',array('submit'=>1,'type'=>'url','backup_name'=>$this->backup_name,'sizelimit'=>$sizelimit));
            $this->success(sprintf('准备分卷备份中...第 %d 卷', $vol), $link);
            // $this->ajaxReturn(array('status'=>1, 'url'=>$link, 'info'=>sprintf('分卷备份中...第 %d 卷', $vol)));
        }
    }
	/**
	 * 执行数据备份
	 * @param int $vol 分卷参数
	 * @param double $sizelimit 备份大小
	 * @return boolean|array
	 */
    private function start_queue($vol, $sizelimit){
        $queue_tables = $this->get_queue();
        if (!$queue_tables){
            return false;
        }
        //文件头部信息
        $head  = "-- -----------------------------\r\n";
        $head .= "-- ----Think Mysql Data Transfer \r\n";
        $head .= "-- ----Host     : " . C('DB_HOST') . "\r\n";
        $head .= "-- ----Port     : " . C('DB_PORT') . "\r\n";
        $head .= "-- ----Database : " . C('DB_NAME') . "\r\n";
        $head .= "-- ----Part : #{$this->file['part']}\r\n";
        $head .= "-- ----Date : " . date("Y-m-d H:i:s") . "\r\n";
        $head .= "-- ----Vol : " . $vol . "\r\n";
        $head .= "-- -----------------------------\r\n";
        $head .= "SET FOREIGN_KEY_CHECKS = 0;\r\n";

        $this->dump_sql = $head;
        foreach ($queue_tables as $table => $pos){
            //获取表结构
            if ($pos == '-1'){
                $table_df = $this->get_create_table($table);
                if (strlen($this->dump_sql) + strlen($table_df) > $sizelimit){
                    break;
                } else{
                    $this->dump_sql .= $table_df;
                    $pos = 0;
                }
            }
            //获取表数据
            $post_pos = $this->get_table_data($table, $pos, $sizelimit);
            if ($post_pos == -1){
                unset($queue_tables[$table]); //此表已经完全导出
            } else{
                //此表未完成，放到下一个分卷
                $queue_tables[$table] = $post_pos;
                break;
            }
        }
        $this->set_queue($queue_tables);
        return $queue_tables;
    }

    /**
     * 获取数据表结构语句
     * @param string $table 表名
     * @return string
     */
    private function get_create_table($table){
    	$info   ="-- --------Table structure for $table--------- -- \r\n";
        $info  .='DROP TABLE IF EXISTS `'.$table."`;\r\n";
        $info  .="-- ----------------- -- \r\n";
    	$tables =$this->mod->query('show create table '.$table);
    	$info  .=$tables[0]['create table'].";\r\n";
    	return $info;
    }

    /**
     * 获取数据表数据
     * @param string $table 表名
     * @param int $pos 分卷值
     * @param double $sizelimit 备份大小
     * @return int|string
     */
    private function get_table_data($table, $pos, $sizelimit){
        $post_pos = $pos;
        $total    = $this->mod->query('SELECT COUNT(*) as count FROM '.$table); //数据总数
        $total    = $total[0]['count'];

        if ($total == 0 || $pos >= $total){
            return - 1;
        }
        $cycle_time = ceil(($total - $pos) / $this->offset); //每次取offset条数。获得需要取的次数
        for ($i = 0; $i < $cycle_time; $i++){
            $data 		= $this->mod->query('SELECT * FROM '.$table.' LIMIT ' . ($this->offset * $i + $pos) . ', ' . $this->offset);
            $data_count = count($data);
            $fields 	= array_keys($data[0]);
            //循环将数据写入
            for ($j = 0; $j < $data_count; $j++){
                $record = array_map(function($str){
              		return addslashes($str);
                }, $data[$j]); //过滤非法字符

		        $start_sql  = "-- -------Records of $table ----- -- \r\n";
                $start_sql .= "INSERT INTO $table ( `".implode('`, `', $fields) ."` ) VALUES ('".implode('\',\'', $record) . "');\r\n";
                if (strlen($this->dump_sql) + strlen($start_sql) > $sizelimit - 32){
                    return $post_pos;
                } else{
                    $this->dump_sql .= $start_sql;
                    $post_pos++;
                }
            }
        }
        return - 1;
    }

    /**
     * 获得头文件信息
     * @param string $path 文件路径
     * @return string
     */
    private function get_head($path){
        $fp  = fopen($path, 'rb');
        $str = fread($fp, 230);
        fclose($fp);
        $arr = explode("\r\n", $str);
        foreach ($arr as $val){
            $pos = strpos($val, ':');
            if ($pos > 0){
                $type  = trim(substr($val, 0, $pos), "-\n\r\t ");
                $value = trim(substr($val, $pos + 1), "/\n\r\t ");
                if ($type == 'DATE'){
                    $sql_info['date'] = $value;
                } elseif ($type == 'Vol'){
                    $sql_info['vol']  = $value;
                }
            }
        }
        return $sql_info;
    }

    /**
     * 生成备份文件夹名称
     * @return int
     */
    private function set_backups_name(){
        $backup_path  = $this->backup_path;
        $today 		  = date('Ymd_', time());
        $today_backup = array(); //保存今天已经备份过的
        if (is_dir($backup_path)){
        	$handle = opendir($backup_path);
            if ($handle){
                while (($file = readdir($handle)) !== false){
                    if ($file{0} != '.' && filetype($backup_path . $file) == 'dir'){
                        if (strpos($file, $today) === 0){
                            $no = intval(str_replace($today, '', $file)); //当天的编号
                            if ($no){
                                $today_backup[] = $no;
                            }
                        }
                    }
                }
            }
        }
        if ($today_backup){
            $today .= max($today_backup) + 1;
        } else{
            $today .= '1';
        }
        return $today;
    }

    /**
     * 需要备份的数据表写入队列
     * @param array $tables 数据表组
     * @return number
     */
    private function set_queue($tables){
        return file_put_contents($this->backup_path . $this->backup_name .
        		'/tbl_queue.log', "<?php return " . var_export($tables, true) . ";\n?>");
    }

    /**
     * 获取需要处理的数据表队列
     * @return boolean|resource
     */
    private function get_queue(){
        $tbl_queue_file = $this->backup_path . $this->backup_name . '/tbl_queue.log';
        if (!is_file($tbl_queue_file)){
            return false;
        } else{
            return include ($tbl_queue_file);
        }
    }

    /**
     * 写入分卷记录
     * @return int|boolean
     */
    private function set_vol($vol){
        $log_file = $this->backup_path . $this->backup_name . '/vol.log';
        return file_put_contents($log_file, $vol);
    }

    /**
     * 获取上一次操作分卷记录
     * @return int
     */
    private function get_vol(){
        $log_file = $this->backup_path . $this->backup_name . '/vol.log';
        if (!is_file($log_file)){
            return 0;
        }
        $content = file_get_contents($log_file);
        return is_numeric($content) ? intval($content) : false;
    }
	/**
	 * 读取文件全部大小
	 * @param string $dir 文件路径
	 * @return int|float
	 */
    private function get_dir_size($dir){
        $handle 	= opendir($dir);
        $sizeResult = 0;
        while (false !== ($FolderOrFile = readdir($handle))){
            if ($FolderOrFile != '.' && $FolderOrFile != '..'){
                if (is_dir($dir.'/'.$FolderOrFile)){
                    $sizeResult += $this->get_dir_size($dir.'/'.$FolderOrFile);
                } else{
                    $sizeResult += filesize($dir.'/'.$FolderOrFile);
                }
            }
        }
        closedir($handle);
        return $sizeResult;
    }
    /**
     * 数据表优化
     * @param string $table 数据表
     */
    public function optimize($table=''){
    	if($table == ''){
			$tables = $this->mod->db()->getTables();
			$tables = implode(',', $tables);
    	}else{
    		$tables = $table;
    	}
		$relust 	= $this->mod->query('optimize table '.$tables);
		if($relust){
			$this->success('数据表'.$table.'优化完成！');
		} else {
			$this->error('数据表'.$table.'优化出错请重试！');
		}
    }
    /**
     * 修复表
     * @param  String $table 表名
     */
    public function repair($table=''){
    	if($table == '') {
    		$tables = $this->mod->db()->getTables();
    		$tables = implode(',', $tables);
    		$table  = '';
    	} else {
    		$tables = $table;
    	}
    	$relust 	= $this->mod->query('REPAIR TABLE '.$tables);
    	if($relust){
    		$this->success('数据表'.$table.'修复完成！');
    	} else {
    		$this->error('数据表'.$table.'修复出错请重试！');
    	}
    }
    /**
     * 清空表,请谨慎操作
     * 清空之前请将重要数据备份
     * @param  String $table 表名
     */
    public function truncate($table = ''){
    	if($table == ''){
    		$this->error('请选择一个数据表操作');
    	}
    	$relust = $this->mod->query('truncate table '.$table);
    	if($relust){
    		$this->success('数据表'.$table.'清空完成！');
    	} else {
    		$this->error('数据表'.$table.'清空出错请重试！');
    	}
    }
}