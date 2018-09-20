<?php if (!defined('THINK_PATH')) exit();?><!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <meta name="renderer" content="webkit">
    <title>后台管理中心</title>  
    <link rel="stylesheet" href="/Public/admin/css/pintuer.css">
    <link rel="stylesheet" href="/Public/admin/css/admin.css">
    <script src="/Public/js/jquery-1.8.3.min.js"></script>  
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

	<script type="text/javascript">
	$(function(){
		$("#clear").click(function(){
			$.ajax({
				type:"post",
				url:"<?php echo U('Index/clearCache');?>",
				sendBefore:loading(),
				success:function(data){
					console.log(data);
					if(data){
						success('缓存清除成功');
					}else{
						errors('缓存清除失败');
					}
				}
			});
		});
		$("#logout").click(function(){
			function logouts(){
				location.href="<?php echo U('Login/logout');?>";
			}
			warning(logouts);
		});
		/*$("#site").click(function(){
			location.href="<?php echo U('sitemap/index');?>";
		});*/
	});
	</script>
	</head>
<body style="background-color:#f2f9fd;">
<div class="header-1 bg-main">
  <div class="logo margin-big-left fadein-top">
    <h1>
    	<img src="/Public/admin/images/y.jpg" class="radius-circle rotate-hover" height="50" />
    	后台管理中心
    </h1>
  </div>
  <div class="head-l">
	  	<a class="button button-little bg-green" href="<?php echo C('website');?>" target="_blank">
	  		<span class="icon-home"></span> 前台首页
	  	</a> &nbsp;&nbsp;
	  	<?php if($_SESSION['user_info']['user_id']== 1): ?><a id="clear" class="button button-little bg-blue" href="javascript:void(0)">
  			<span class="icon-wrench"></span> 清除缓存
  		</a> &nbsp;&nbsp;<?php endif; ?>
		<a id="logout" class="button button-little bg-red" href="javascript:void(0)">
			<span class="icon-power-off"></span> 退出登录
		</a> &nbsp;&nbsp;
		<a id="site" class="button button-little bg-green" href="<?php echo U('sitemap/index');?>" target="_blank">
			<span class="icon-map-marker"></span> 网站地图
		</a> 
  </div>
	<span class="login-person">欢迎：<?php echo ($_SESSION['user_info']['user_name']); ?></span>
</div>
<!--头部菜单-->
<ul class="navigate">
	<li id="0" class="active"><a href="<?php echo U('Index/conf');?>" target="right">后台首页</a></li>
</ul>
<!--头部菜单 end-->

<!--左侧菜单-->
<div class="leftnav">
  <div class="leftnav-title"><strong><span class="icon-list"></span>菜单列表</strong></div>
  <?php if(is_array($menufirst)): $i = 0; $__LIST__ = $menufirst;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><div class="comlun">
	  <h2><span class="icon-user"></span><?php if($v['_level'] == 1): echo ($v["title"]); endif; ?></h2>
	  <ul class="child">
	  	<?php if(is_array($menusecond)): $i = 0; $__LIST__ = $menusecond;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if($vo['pid'] == $v['id']): ?><li>
	  			<a href="<?php echo U($vo['name'],['auth_id'=>$vo['id']]);?>" id="<?php echo ($vo["id"]); ?>" target="right">
	  			<span class="icon-caret-right"></span><?php echo ($vo["title"]); ?></a>
	  		</li><?php endif; endforeach; endif; else: echo "" ;endif; ?>
	  </ul>
  </div><?php endforeach; endif; else: echo "" ;endif; ?>
<!--左侧菜单 end-->

<!--右侧内容-->
<div class="admin">
  <iframe scrolling="auto" rameborder="0" src="<?php echo U('Index/conf');?>" name="right" width="100%" height="100%"></iframe>
</div>
<!--右侧内容 end-->
</body>
<script src="/Public/admin/js/admin.js"></script>
</html>