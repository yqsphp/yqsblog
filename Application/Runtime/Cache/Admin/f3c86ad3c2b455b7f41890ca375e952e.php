<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>后台管理中心</title>  
    <link rel="stylesheet" href="/Public/css/bootstrap.min.css" />
    <link rel="stylesheet" href="/Public/css/bootstrap-switch.css">
    <link rel="stylesheet" href="/Public/admin/css/pintuer.css">
    <link rel="stylesheet" href="/Public/css/page.css">
    <link rel="stylesheet" href="/Public/admin/css/admin.css">
    <!--<script src="/Public/js/jquery-1.8.3.min.js"></script> -->
    <script src="/Public/js/jquery-1.10.2.min.js"></script> 
	<script src="/Public/js/bootstrap.min.js"></script>
	<script src="/Public/js/bootstrap-switch.js"></script>
    <link rel="stylesheet" href="/Public/admin/css/sweetalert.css">
<!--alert弹窗主题-->
<!--<link rel="stylesheet" href="/Public/admin/css/themes/twitter/twitter.css">-->
<!--<link href="/Public/admin/css/themes/google/google.css" rel="stylesheet"/>-->
<!--<link href="/Public/admin/css/themes/facebook/facebook.css" rel="stylesheet"/>-->
<script src="/Public/admin/js/sweetalert.min.js"></script> 
<script>
function success(title){
	swal({
		title:title,	//标题
		type:'success', 
		timer:2000,
	});
}
function errors(title){
	swal({
		title:title,	//标题
		type:'error', 
		timer:2000,
	});
}
//fun : 函数
function warning(fun,title){
	if(!title) title='确定删除吗?';
	swal({
	  title: title,
	  type: "warning",
	  showCancelButton: true,
	  cancelButtonText:'取消',
	  confirmButtonText: "确定",
	  //closeOnConfirm: true
	},function(isconfirm){
		if(isconfirm){
			fun();
		}
	})
}
//加载弹窗
function loading(){
	swal({
		title: "请稍后...",
		type: "",
		imageUrl:"/Public/admin/images/ajaxload.gif",
		showConfirmButton:false
	})
}
</script>

</head>
<style>
	.admin-panel {
		width: 45%;
		float: left;
		margin-right: 20px;
		height: 300px
	}
	
	.admin-panel p {
		height: 20px;
		margin-left: 20px;
		margin-top: 5px
	}
</style>

<body>
	<div class="panel admin-panel">
		<div class="panel-head"><strong><span class="icon-pencil-square-o"></span> 版权信息</strong></div>
		<p>版权：
			<?php echo C( 'copyright');?>
		</p>
		<p>地址：
			<?php echo C( 'address');?>
		</p>
		<p>邮箱：
			<?php echo C( 'email');?>
		</p>
		<p>电话：
			<?php echo C( 'phone');?>
		</p>
	</div>
	<div class="panel admin-panel">
		<div class="panel-head"><strong><span class="icon-pencil-square-o"></span> 配置信息</strong></div>
		<p>网站版本：
			<?php echo ($server["version"]); ?>
		</p>
		<p>操作系统：
			<?php echo ($server["os"]); ?>
		</p>
		<p>运行环境：
			<?php echo ($server["software"]); ?>
		</p>
		<p>网站域名：
			<?php echo ($server["ip"]); ?>
		</p>
		<p>文件上传限制：
			<?php echo ($server["upload_filesize"]); ?>
		</p>
		<p>执行时间限制：
			<?php echo ($server["wait_time"]); ?>
		</p>
		<p>剩余空间：
			<?php echo ($server["space"]); ?>
		</p>
	</div>
	<div class="panel admin-panel">
		<div class="panel-head"><strong><span class="icon-pencil-square-o"></span> 待办</strong></div>
	</div>
	<div class="panel admin-panel">
		<div class="panel-head"><strong><span class="icon-pencil-square-o"></span> 最新消息</strong></div>
	</div>
</body>

</html>