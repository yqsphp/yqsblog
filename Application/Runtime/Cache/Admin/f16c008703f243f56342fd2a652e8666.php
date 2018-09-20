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
<!--从微信服务器获取的图片需添加如下头-->
<meta name="referrer" content="no-referrer" />
<!---->
<style type="text/css">
	.media-title{background: rgba(0,0,0,.4); color: white; width: 100%;}
	.delete{background: rgba(0,0,0,.4); text-align:right; color: white; cursor: pointer; width: 100%;}
	.img-width{width: 100%; max-height: 200px;}
</style>
<body>
<div class="panel admin-panel">
	<div class="panel-head">
		<strong class="icon-reorder"> 素材详情</strong>
	</div>
	<div class="panel-body">
		<?php if(is_array($info)): $i = 0; $__LIST__ = $info;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><div class="col-sm-3">
			<!--<div class="delete padding-small" data-href="<?php echo U('source_del',['type'=>1,'wechat_id'=>$wechat_id,'id'=>$v['id'],'media_id'=>$v['media_id']]);?>">
				<i class="icon-trash-o"></i>
			</div>-->
			<?php if(empty($v['url'])): ?><img class="img-thumbnail img-width" src="<?php echo ($v["thumb_url"]); ?>"/>	
			<?php else: ?>
			<a href="<?php echo ($v["url"]); ?>" target="_blank"><img class="img-thumbnail img-width" src="<?php echo ($v["thumb_url"]); ?>"/></a><?php endif; ?>
			<div class="padding media-title">
				<?php echo ($v["title"]); ?>
			</div>
		</div><?php endforeach; endif; else: echo "" ;endif; ?>
	</div>
	<a class="button border-main icon-backward" href="javascript:" onclick="history.back()"> 返回</a>
</div>
<script type="text/javascript">
$(function(){
	//删除
	$(".delete").click(function(e){
		var href = $(this).attr("data-href");
		function jump(){
			location.href=href;
		}
		warning(jump);
	});
});
</script>
</body>
</html>