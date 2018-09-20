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
		<strong class="icon-reorder"> 附件列表</strong><a href="" style="float:right; display:none;">添加字段</a>
	</div>
	<!--搜索-->
	<form action="" method="get" id="serachs">
		<div class="padding border-bottom">
			<ul class="search" style="padding-left:10px;">
				<li><a class="button border-main icon-plus-square-o" href="<?php echo U('attedit',['status'=>1]);?>"> 添加视频附件</a></li>
				<!--<li>搜索：</li>
				<li>
					<select name="ext" class="input">
						<option value="">格式选择</option>
						<option value="1"<?php if(($get['ext']) == "1"): ?>selected<?php endif; ?>>图片</option>
						<option value="0"<?php if(($get['ext']) == "0"): ?>selected<?php endif; ?>>非图片</option>
					</select>
				</li>
				<li>
				<button href="javascript:void(0)" type="submit" class="button border-main icon-search"> 搜索</button>
				<button href="javascript:void(0)" type="reset" id="resets" class="button border-main icon-search"> 重置</button></li>-->
			</ul>
		</div>
	</form>
	<form method="post" action="" id="listform">
		<table class="table table-hover text-center">
		<tr>
			<th width="1%"></th>
			<th width="3%">序号</th>
			<th width="5%">附件名</th>
			<th width="5%">缩略图</th>
			<th width="7%">格式</th>
			<th width="8%">创建时间</th>
			<th width="10%">操作</th>
		</tr>
		<?php if(is_array($info)): $i = 0; $__LIST__ = $info;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr>
			<td width="1%"><input type="checkbox" name="id[]" value="<?php echo ($v["id"]); ?>"/></td>
			<td><?php echo ($i); ?></td>
			<td><?php echo ($v["name"]); ?></td>
			<td>
				<?php if($v['show'] == 1): ?><img src="/Public/<?php echo ($v["path"]); ?>" width="100" height="60"/>
				<?php elseif($v['path_thumb']): ?>
				<img src="/Public/<?php echo ($v["path_thumb"]); ?>" width="100" height="60"/>
				<?php else: ?>
				该文件暂不支持预览<?php endif; ?>
			</td>
			<td><?php echo ($v["ext"]); ?></td>
			<td><?php echo ($v["ctime"]); ?><td>
				<div class="button-group">
					<!-- <a class="button border-main icon-edit" href="<?php echo U('admin/message/messshow/id/'.$v['id']);?>"> 查看</a> -->
					<?php if($third['auth_delete'] == 1): ?><a class="button border-red icon-trash-o delete" href="javascript:" id="<?php echo ($v["id"]); ?>"> 删除</a><?php endif; ?>
				</div>
			</td>
		</tr><?php endforeach; endif; else: echo "" ;endif; ?>
		<?php if($third['auth_delete'] == 1): ?><tr>
	        <td>
	        	<input type="checkbox" class="checkall"/>
            </td>
	        <td colspan="15" style="text-align:left;padding-left:20px;">
				<div class="button-group">
					<!-- <a class="button border-main icon-edit" href="javascript:void(0)" 
						onclick="artSelect(1)"> 查看</a> -->
					<a class="button border-red icon-trash-o" href="javascript:void(0)" 
					onclick="message()"> 删除</a>
				</div>
			</td>
        </tr><?php endif; ?>
		<tr>
			<td colspan="15">
				<div class="pagelist">
					<?php echo ($page); ?>
				</div>
			</td>
		</tr>
		</table>
	</form>
</div>
<script type="text/javascript">
$(function(){
	//全选
	$(".checkall").click(function(){ 
	  $("input[name='id[]']").each(function(){
		  if (this.checked) {
			  this.checked = false;
		  }
		  else {
			  this.checked = true;
		  }
	  });
	});
	//重置
	$("#resets").click(function(){
		$(".input").val("");
		$(".input").find("option").removeAttr("selected");
	});
	//删除
	$(".delete").click(function(){
		var id = $(this).attr("id");
		function jump(){
			location.href="/Attachment/attdel/id/"+id;
		}
		warning(jump);
	});
});
//批量删除
function message(){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){
		$("#listform").attr('action','/Attachment/attdel');
		$("#listform").submit();		
	}
	else{
		errors("请选择的内容!");
		return false;
	}
}
</script>
</body>
</html>