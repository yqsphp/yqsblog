<?php
return array(
	//'配置项'=>'配置值'
	/*权限规则*/
	'AUTH_CONFIG' => array(
		'AUTH_ON' 			=> true, // 认证开关
		'AUTH_TYPE' 		=> 1, // 认证方式，1为时时认证；2为登录认证。
		'AUTH_GROUP' 		=> 'myblog_auth_group', // 用户组数据表名
		'AUTH_GROUP_ACCESS' => 'myblog_auth_access', // 用户组明细表
		'AUTH_RULE' 		=> 'myblog_auth_rule', // 权限规则表
		'AUTH_USER' 		=> 'myblog_admin'   // 用户信息表
	), 
	//子域名部署	
	'APP_SUB_DOMAIN_DEPLOY' => 1,
	'APP_SUB_DOMAIN_RULES'  => array(
		'www'	=> 'Home/index',
		'admin' => 'Admin',
	),
	//路由
	'URL_ROUTER_ON'         =>  true,   // 是否开启URL路由
	'URL_ROUTE_RULES'       =>  array(  // 默认路由规则
		'api/:token' 	=> 'admin/wechatApp/get_user_message',
		'/^list\/([\d+]+?)$/'	=> 'category?cid=:1',	//文章列表
		//home
		'/^article\/([\d+]+?)\/([\d+]+?)\/([\d+]+?)\/([\w+]+?)$/' 	=> 'article?i=:1&cid=:2&id=:3', //home 文章详情
		
		
	), 
	'URL_MAP_RULES'         =>  array(), // URL映射定义规则
	//静态缓存
	'HTML_CACHE_ON'			=> false,
	'HTML_CACHE_TIME'   	=> 10000,   // 全局静态缓存有效期（秒）
	'HTML_FILE_SUFFIX'  	=> '.html', // 设置静态缓存文件后缀
	'HTML_CACHE_RULES'  	=> array(  // 定义静态缓存规则
		// 定义格式1 数组方式
		'login:'   				=> array('{:module}/{:controller}/{:action}'), //登陆
		//'index:'	=> array('{:module}/{:controller}/{:action}'),	
		'static:case_search'   	=> array('{:module}/{:controller}/{:action}_{name|md5}',1800),//搜索
		'index:index'			=> array('{:module}/{:controller}/{:action}',3600), //首页
		'static:'   			=> array('{:module}/{:controller}/{:action}_{cid}_{id}',3600),
	)
);