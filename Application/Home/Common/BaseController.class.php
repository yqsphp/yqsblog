<?php

namespace Home\Common;

use Think\Controller;

class BaseController extends Controller {
	public static $get;
	protected function _initialize(){
		self::$get = I('get.');
		//语言检查
		$lang=I('get.l');
		cookie('think_language',$lang); //将当前语言存入cookie
		
		$data = [
			'title' => self::$get['title'],
			'index' => self::$get['i'] ? self::$get['i'] : 0, // 一级菜单下标
		];
		$this->assign($data);
	}
	/**
	 * 空操作跳转
	 */
	public function _empty(){
		$this->display('layout/404');
	}
}