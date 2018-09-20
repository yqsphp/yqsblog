<?php
header("Content-type:text/html;charset=utf-8");
/**
 * 微信接入调试 配置失败可能原因
 * 1.文件的编码格式问题，一般转为utf-8 无bom
 * 2.是否成功返回echostr
 */

//echo $_GET['echostr'];exit; //微信接入调试 不敢保证一定对 放在入口文件index.php 开头
// 开启调试模试，修改后即时生效
define('APP_DEBUG', true);
// 网站当前路径
define('APP_NAME', 'Application');
// 设置缓存路径
define('RUNTIME_PATH', APP_NAME . '/Runtime/');
// 设置项目路径
define('APP_PATH', './Application/');
// 定义ThinkPHP目录
define('TP_PATH', './ThinkPHP');
// 生成lite.php文件，提高运行效率
//define('BUILD_LITE_FILE',false);
// if(is_file(RUNTIME_PATH . 'lite.php')){
// 	require RUNTIME_PATH . 'lite.php';
// }else{
// 	require TP_PATH . '/ThinkPHP.php';
// }
require TP_PATH . '/ThinkPHP.php';