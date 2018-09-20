<?php
namespace Admin\Common;
/**
 * 微信公众号接口基类
 */

class Wechat{
	/**
	 * 微信实例
	 * @param int $id 微信账户表中的主键id
	 * @return object
	 */
	public static function app($id){
		if(empty($id) || is_array($id)) return false;
		$account = S('account_'.$id);
		if(empty($account)){
			$account = M('wechatAccount')->cache('account_'.$id,1800)->find($id); //查看当前微信账户
		}
		//将查询的数据存入缓存
		vendor('Wechat.wechat');
		$options = [
				'token'			 => $account['token'], //填写你设定的key
				//'encodingaeskey' => 'QpseIpCi7EV9OkCHjXGZ2OsqOgqiMbLwvMqaB6kqPc1', //填写加密用的EncodingAESKey
				'appid'			 => $account['appid'], //填写高级调用功能的app id, 请在微信开发模式后台查询
				'appsecret'		 => $account['appsecret'] //填写高级调用功能的密钥];
		];
		$wechat = new \Wechat($options);
		//$wechat->checkAuth();
		//???
		//从服务器获取的access_token时效两个小时，可存缓存，避免每次调用都要重复请求
		$access_token = S('access_token_wechat_'.$id);
		if($access_token){
			$access_token = $wechat->checkAuth();
			S('access_token_wechat_'.$id,$access_token,7200);
		}else{
			$wechat->checkAuth($access_token);
		}
		return $wechat;
	}
	/**
	 * 获取错误信息
	 * @param  int $code 错误码
	 * @return array
	 * [errCode=>错误码，errMsg=>错误信息]
	 */
	public static function getError($code){
		vendor('Wechat.error');
		$errMsg = \Error::getError($code);
		$error  = [
				'errCode' =>$code,
				'errMsg' =>$errMsg
		];
		return $error;
	}
}