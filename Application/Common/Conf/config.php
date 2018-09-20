<?php
return array(
	//'配置项'=>'配置值'
	
	//默认允许模块
	'MODULE_ALLOW_LIST' => ['Admin','Home'],
	'DEFAULT_MODULE' 	=> 'Home',  //默认模块
	// 加载扩展配置文件
	'LOAD_EXT_CONFIG' 	=> 'database,info,routes,plug',
	//url设置
	'URL_MODEL'       	=>  2,
	/*定义模版标签*/
	'TMPL_L_DELIM'    	=> '<{', // 模板引擎普通标签开始标记
	'TMPL_R_DELIM'    	=> '}>', // 模板引擎普通标签结束标记
	'DEFAULT_IMG_MIN' 	=> __ROOT__.'/Public/image/default_min.jpg',
	'DEFAULT_IMG'     	=> __ROOT__.'/Public/image/default.jpg',
	/* 文件上传配置 */
	'ROOTPATH'        	=> __ROOT__.'Public/',
	'SAVEPATH'        	=> 'upload/',
	'SAVENAME'        	=> time() . mt_rand(100, 999), // 这样设置后多文件上传有bug，成功上传的文件只是第一个
	'SUBNAME'         	=> ['date','Ymd'],
	// 显示页面Trace信息
	//'SHOW_PAGE_TRACE' =>true,
	//模板替换规则
	/* 'TMPL_PARSE_STRING' => [
		'__SPECIAL__' => '/'	
	], */
);