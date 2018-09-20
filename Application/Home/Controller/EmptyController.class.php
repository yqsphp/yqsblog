<?php
namespace Home\Controller;
use Home\Common\BaseController;
class EmptyController extends BaseController{
	/**
	 * 空控制器操作
	 * (non-PHPdoc)
	 * @see \Home\Common\BaseController::_empty()
	 */
	public function _empty(){
		$this->display('Layout/404');
	}
}