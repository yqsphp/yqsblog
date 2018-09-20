<?php
namespace Admin\Controller;

use Admin\Common\AdminBaseController;
use Admin\Common\Log;

class IndexController extends AdminBaseController {
	public function _initialize() {
		parent::_initialize ();
	}
	public function index() {
		$this->display ();
	}
	/**
	 * 网站基本信息
	 */
	public function info() {
		// 网站信息配置文件路径
		$file = CONF_PATH . 'info.php';
		// 网站信息默认配置
		$default = [ 
				'website' 		=> C ( 'website' ), // 网站地址
				'webtitle' 		=> C ( 'webtitle' ), // 网站标题
				'waptitle' 		=> C ( 'waptitle' ), // 微网站标题
				'address' 		=> C ( 'address' ), // 地址
				'QQ' 			=> C ( 'QQ' ), // QQ
				'mobile' 		=> C ( 'mobile' ), // 手机
				'email' 		=> C ( 'email' ), // 邮箱
				'contact' 		=> C ( 'contact' ), // 联系人
				'copyright' 	=> C ( 'copyright' ), // 网站底部信息
				'description' 	=> C ( 'description' ), // 网站描述
				'number' 		=> C ( 'number' ), // 备案号
				'keywords' 		=> C ( 'keywords' ), // 关键字
				'logo' 			=> C ( 'logo' )  // logo
		];

		// $a=file_get_contents($file);
		// dump(var_export($a,true));die;
		// dump($a);
		$this->assign ( 'conf', $default );
		if (IS_POST) {
			// 获取页面提交配置数据
			$config = $_POST;
			// logo地址
			$logo 	= fileuploadOne ( $_FILES ['logo'] );
			$config ['logo'] = $logo ? $logo : C ( 'logo' );
			// 合并配置
			$conf 	= array_merge ( $default, $config );
			$info 	= "<?php \r\n return " . var_export ( $conf, true ) . "; \r\n ?>";
			$res 	= file_put_contents ( $file, $info );
			self::jump ( $res, 'Index/conf' );
		} else {
			$this->display ();
		}
	}
	/**
	 * 网站运行配置信息等
	 */
	public function conf() {
		$disk_space = @disk_free_space ( "." ) / pow ( 1024, 2 );
		$server = array (
				'version' => C ( 'NOW_VERSION' ), // NOW_VERSION.'[<a href="http://bbs.phonegap100.com/forum.php?mod=forumdisplay&fid=62" target="_blank">查看最新版本</a>]',
				'os' => PHP_OS,
				'software' => $_SERVER ['SERVER_SOFTWARE'],
				'upload_filesize' => ini_get ( 'upload_max_filesize' ), // 最大上传容量
				'wait_time' => ini_get ( 'max_execution_time' ) . '秒',
				'ip' => $_SERVER ['SERVER_NAME'] . ' [ ' . gethostbyname ( $_SERVER ['SERVER_NAME'] ) . ' ]',
				'space' => round ( $disk_space < 1024 ? $disk_space : $disk_space / 1024, 2 ) . ($disk_space < 1024 ? 'M' : 'G') 
		);
		$this->assign ( 'server', $server );
		$this->display ();
	}
	/**
	 * 清楚所有数据缓存
	 */
	public function clearCache() {
		$dir = I('get.dir');
		if($dir){
			
			$dir = RUNTIME_PATH.strtr($dir,'_','/');
			$res = is_dir($dir) ? clear($dir) : unlink($dir);
			
			self::jump($res, 'index/clearCache');
		}else{
			$file = $this->getCache(RUNTIME_PATH);
			$file['lite'] = $file[0];
			unset($file[0]);
			$this->assign('info',$file);
			$this->display();
		}
	}
	/**
	 * 列出所有缓存目录文件
	 */
	private function getCache($dir = ''){
		$result = [];
		$temp 	= [];
		$list = scandir($dir);
		foreach($list as $file){
			if ($file != '.' && $file != '..') {
				$fullpath = $dir  .'/'. $file;
				if(is_dir($fullpath)){
					$result[$file] = $this->getCache($fullpath);
				}else{
					$temp[] = $file;
				}
			}
		}
		if($temp) {
			foreach($temp as $f) {
				$result[] = $f;
			}
		}
		return $result;
		//return rmdir ( $dir ) ? true : false;
	}
	/**
	 * 修改密码
	 */
	public function userpass() {
		// 获取登陆人的id
		$id = session ( 'user_info.user_id' );
		$admin = D ( 'Admin' );
		$info = $admin->find ( $id );
		// 检测旧密码是否正确
		/*
		 * if(IS_AJAX){
		 * $oldpass=I('post.oldpass');
		 * $newpass=I('post.newpass');
		 * if($info['pass']===$oldpass){
		 * $data=array('id'=>$id,'pass'=>$newpass);
		 * if($admin->save($data)){
		 * $this->ajaxReturn(1);
		 * }else{
		 * $this->ajaxReturn(2);
		 * }
		 * }else{
		 * $this->ajaxReturn(0);
		 * }
		 */
		if (IS_POST) {
			$oldpass = I ( 'post.oldpass' );
			$newpass = I ( 'post.newpass' );
			
			if ($info ['pass'] === md5 ( base64_encode ( $oldpass ) )) {
				$data = [ 
						'id' => $id,
						'pass' => md5 ( base64_encode ( $newpass ) ) 
				];
				// 写入日志
				$logid = Log::update ( 'admin', $id, 2 );
				$res = $admin->save ( $data );
				Log::write ( 'admin', $id, 2, $logid );
				self::jump ( $res, 'Index/conf' );
			} else {
				$this->error ( '旧密码错误', U ( 'Index/userpass' ), 2 );
			}
		} else {
			$this->assign ( 'admin', $info );
			$this->display ();
		}
	}
	// 友情链接
	public function firendsurl() {
		$link = D ( 'link' );
		$count = $link->where ( 'isdel = 0' )->count ();
		$page = new \Think\Page ( $count, 10 );
		$info = $link->where ( 'isdel = 0' )->limit ( mypage ( $page ) )->order ( 'id desc' )->select ();
		
		$this->assign ( 'info', $info );
		$this->assign ( 'page', $page->show () );
		$this->display ();
	}
	/**
	 * 编辑友情链接
	 * 
	 * @param int $status
	 *        	1.添加，2.编辑
	 */
	public function firendedit($status) {
		$id = I ( 'request.id' );
		$post = I ( 'post.' );
		$link = D ( 'link' );
		if (IS_POST) {
			// 图片上传
			if ($_FILES ['img'] ['error'] != 4) {
				$path = fileuploadOne ( $_FILES ['img'] );
			}
			if ($path)
				$post ['img'] = $path;
			$post ['isshow'] = isset ( $post ['isshow'] ) ? $post ['isshow'] : 0;
			if ($post ['type'] == 1) {
				if ($link->create ( $post )) {
					$res = $link->add ();
					Log::write ( 'link', $res, 1 );
				}
			} else {
				$logid = Log::update ( 'link', $id, 2 );
				$res = $link->save ( $post );
				log::write ( 'link', $id, 2, $logid );
			}
			self::jump ( $res, 'index/firendsurl' );
		} else {
			if ($status == 2) {
				$info = $link->find ( $id );
				$this->assign ( 'info', $info );
			}
			$this->assign ( 'status', $status );
			$this->display ();
		}
	}
	/**
	 * 删除友情 软删除
	 */
	public function firenddel() {
		$id = I ( 'request.id' );
		$ids = $id;
		if (is_array ( $id )) {
			$id = implode ( ',', $id );
		}
		$link = D ( 'link' );
		$res = $link->where ( 'id in (' . $id . ')' )->save ( [ 
				'isdel' => 1 
		] );
		log::write ( 'link', $ids, 3 );
		$rest = recover_delete ( 'link', '友情链接表', $id );
		self::jump ( $rest, 'index/firendsurl' );
	}
}