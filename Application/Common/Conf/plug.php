<?php
/**
 * 插件配置
 */
return array(
    //邮件服务器
	//IMAP地址
	'mail_smtp_server' 		=> 'smtp.qq.com',  //qq Smtp
	//IMAP端口
	'mail_smtp_port'		=> 465,  //465或587
	//IMAP发送类型
	'mail_smpt_type'		=> 'HTML', //HTML TXT
	//IMAP服务的SSL加密方式
	'mail_smpt_secure'		=> 'ssl', // tls / ssl
	//IMAP服务器的用户邮箱
	'mail_smtp_server_user' => 'yqsphp@qq.com',
	//IMAP邮箱地址
	'mail_smtp_user'   		=> 'yqsphp@qq.com',
	//IMAP邮箱密码
	'mail_smtp_server_pass' => 'vpjsqgdkutvdbcec',
    // 滑动验证码
    'GEETEST_ID' 			=> '034b9cc862456adf05398821cefc94eb', // 极验id 仅供测试使用
    'GEETEST_KEY' 			=> 'b7f064b9ae813699de794303f0b0e76f', // 极验key 仅供测试使用
    // 短信验证码(云通信 www.yuntongxun.com 账号：yqsphp@qq.com pass: yqs17373)
    'sms_account'			=> '8a216da85a3c0c39015a5962573f0b36', // 主帐号
    'sms_token' 			=> '0b5b659ae8814d4796c582182fece2a2', // 主帐号Token
    'sms_require' 			=> 'app.cloopen.com', // 请求地址，格式如下，不需要写https://
    'sms_port' 				=> '8883', // 请求端口
    'sms_appid' 			=> '8a216da85a3c0c39015a596257a00b3c', // 应用Id
    'sms_version' 			=> '2013-12-26', // REST版本号
    'sms_tempid' 			=> 1
) // 模版id
;