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
<body>
<div class="panel admin-panel">
	<div class="panel-head">
		<strong class="icon-reorder"> 缓存列表</strong>
	</div>
	<table class="table table-hover text-center">
		<tr>
			<?php if(is_array($info)): $i = 0; $__LIST__ = $info;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i; switch($key): case "Cache": ?><th width="10%">编译缓存（<?php echo ($key); ?>）</th><?php break;?>
					<?php case "Logs": ?><th width="10%">日志缓存（<?php echo ($key); ?>）</th><?php break;?>
					<?php case "Data": ?><th width="10%">数据缓存（<?php echo ($key); ?>）</th><?php break;?>
					<?php case "lite": ?><th width="10%">配置缓存（<?php echo ($key); ?>）</th><?php break;?>
					<?php case "Temp": ?><th width="30%">临时缓存（<?php echo ($key); ?>）</th><?php break;?>
					<?php case "Html": ?><th width="30%">静态缓存（<?php echo ($key); ?>）</th><?php break; endswitch; endforeach; endif; else: echo "" ;endif; ?>
		</tr>
		<tr>
			<?php if(is_array($info)): $i = 0; $__LIST__ = $info;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><td class="border-right">
				<span class="hidden"><?php echo ($k = $key); ?></span>
				<?php if($v == 'lite.php'): ?><span class="float-left"><?php echo ($v); ?></span> 
					<a class="button border-red delete float-right" href="<?php echo U('clearCache',['dir'=>$v]);?>">
						<span class="icon-trash-o"></span> 删除
					</a>
				<?php elseif($key == 'Temp'): ?>
					<?php if(is_array($v)): $i = 0; $__LIST__ = $v;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><p>
							<span class="float-left"><?php echo ($vo); ?></span> 
							<a class="button border-red delete float-right" href="<?php echo U('clearCache',['dir'=>$k.'_'.$vo]);?>">
								<span class="icon-trash-o"></span> 删除
							</a>
							<div class="clear border-bottom"></div>
						</p><?php endforeach; endif; else: echo "" ;endif; ?>
				<?php else: ?>
					<?php if(is_array($v)): $i = 0; $__LIST__ = $v;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><p>
							<span class="float-left"><?php echo ($key); ?></span> 
							<a class="button border-red delete float-right" href="<?php echo U('clearCache',['dir'=>$k.'_'.$key]);?>">
								<span class="icon-trash-o"></span> 删除</a>
							<div class="clear border-bottom"></div>
						</p><?php endforeach; endif; else: echo "" ;endif; endif; ?>
			</td><?php endforeach; endif; else: echo "" ;endif; ?>
		</tr>
		<tr>
			<?php if(is_array($info)): $i = 0; $__LIST__ = $info;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><td>
				<a class="button border-red delete" href="<?php echo U('clearCache',['dir'=>$key]);?>">
					<span class="icon-trash-o"></span> 全部删除</a>
			</td><?php endforeach; endif; else: echo "" ;endif; ?>
		</tr>
	</table>
</div>
</body>
</html>