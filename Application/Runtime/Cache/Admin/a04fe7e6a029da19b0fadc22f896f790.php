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
		<strong class="icon-reorder"> 内容列表</strong><a href="" style="float:right; display:none;">添加字段</a>
	</div>
	<form action="" method="get" id="serachs">
		<div class="padding border-bottom">
			<ul class="search" style="padding-left:10px;">
				<?php if($third['auth_add'] == 1): ?><li><a class="button border-main icon-plus-square-o" href="<?php echo U('Article/artedit',array('status'=>1));?>"> 添加内容</a></li><?php endif; ?>
				<li>搜索：</li>
				<li>
				<select name="catid" class="input" style="line-height:17px;">
					<option value="">请选择分类</option>
					<?php if(is_array($cat)): $i = 0; $__LIST__ = $cat;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><option value="<?php echo ($vo["id"]); ?>" <?php if(($get['catid']) == $vo['id']): ?>selected<?php endif; ?>><?php echo ($vo["_name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
				</select>
				</li>
				<li>
				<select name="portshow" class="input" style="line-height:17px;">
					<option value="">显示终端</option>
					<option value="电脑端" <?php if(($get['portshow']) == "电脑端"): ?>selected<?php endif; ?>>电脑端</option>
					<option value="移动端" <?php if(($get['portshow']) == "移动端"): ?>selected<?php endif; ?>>移动端</option>
					<option value="微信端" <?php if(($get['portshow']) == "微信端"): ?>selected<?php endif; ?>>微信端</option>
					<option value="APP端" <?php if(($get['portshow']) == "APP端"): ?>selected<?php endif; ?>>APP端</option>
					<option value="小程序端" <?php if(($get['portshow']) == "小程序端"): ?>selected<?php endif; ?>>小程序端</option>
					</volist>
				</select>
				</li>
				<li>
				<select name="porttype" class="input" style="line-height:17px;">
					<option value="">显示方式</option>
					<option value="置顶" <?php if(($get['porttype']) == "置顶"): ?>selected<?php endif; ?>>置顶</option>
					<option value="推荐" <?php if(($get['porttype']) == "推荐"): ?>selected<?php endif; ?>>推荐</option>
					</volist>
				</select>
				</li>
				<li>
				<select name="status" class="input" style="line-height:17px;">
					<option value="">状态</option>
					<option value="2" <?php if(($get['status']) == "2"): ?>selected<?php endif; ?>>草稿</option>
					<option value="3" <?php if(($get['status']) == "3"): ?>selected<?php endif; ?>>撤回</option>
					</volist>
				</select>
				</li>
				<li>
				<input type="text" placeholder="请输入搜索关键字" name="name" class="input" 
					style="width:250px; line-height:17px;display:inline-block" value="<?php if(!empty($get['name'])): echo ($get['name']); endif; ?>"/>
				<a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()"> 搜索</a>
				</li>
				<li><input type="reset" id="resets" class="button border-main icon-search"  value="重置"/></li>
			</ul>
		</div>
	</form>
	<form method="post" action="<?php echo U('artdel');?>" id="listform">
		<table class="table table-hover text-center">
		<tr>
			<th width="1%"></th>
			<th width="5%">序号</th>
			<th width="5%">排序</th>
			<th width="10%">图片</th>
			<th width="15%">标题</th>
			<th>状态</th>
			<th width="5%">分类名称</th>
			<th width="5%">置顶</th>
			<th width="5%">推荐</th>
			<th width="10%">创建时间</th>
			<th width="5%">编辑人</th>
			<th width="25%">操作</th>
		</tr>
		<?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr>
			<td width="1%"><input type="checkbox" name="id[]" value="<?php echo ($v["id"]); ?>"/></td>
			<td><?php echo ($i); ?></td>
			<td>
				<input type="text" id="<?php echo ($v["id"]); ?>" name="sort" value="<?php echo ($v["order"]); ?>" onblur="setTop(5,<?php echo ($v["id"]); ?>,this.value)" style="width:50px; text-align:center; border:1px solid #ddd; padding:7px 0;"/>
			</td>
			<td width="10%">
				<img src="<?php if($v['image'] != ''): ?>/Public/<?php echo ($v["image"]); else: echo C('DEFAULT_IMG'); endif; ?>" alt="" width="70" height="50"/>
			</td>
			<td>
				<a title="<?php echo ($v["name"]); ?>"><?php if(strlen($v['name']) < 18): echo ($v["name"]); else: echo (mb_substr($v["name"],0,18,'utf-8')); ?>...<?php endif; ?></a>
			</td>
			<td>
				<font color="#00CC99">
					<?php if($v['status'] == 2): ?>草稿
					<?php elseif($v['status'] == 3): ?>
						<font color="red">撤回</font>
					<?php else: ?>
						未发布<?php endif; ?>
				</font>
			</td>
			<td><?php echo ($v["cname"]); ?></td>
			<td>
				<select onchange="setTop(1,<?php echo ($v["id"]); ?>,this.value)">
					<option value="1" <?php if(($v['settop']) == "1"): ?>selected<?php endif; ?>>是</option>
					<option value="0" <?php if(($v['settop']) == "0"): ?>selected<?php endif; ?>>否</option>
				</select>
			</td>
			<td>
				<select onchange="setTop(2,<?php echo ($v["id"]); ?>,this.value)">
					<option value="1" <?php if(($v['recommend']) == "1"): ?>selected<?php endif; ?>>是</option>
					<option value="0" <?php if(($v['recommend']) == "0"): ?>selected<?php endif; ?>>否</option>
				</select>
			</td>
			<td><?php echo ($v["ctime"]); ?></td>
			<td><?php echo ($v["editor"]); ?></td>
			<td>
				<div class="button-group">
					<a class="button border-main" href="javascript:void(0)" onclick="oneSubmit(<?php echo ($v["id"]); ?>)">
						<span class="icon-mail-forward"></span> 提交</a>
					<?php if($third['auth_edit'] == 1): ?><a class="button border-main edit" href="javascript:void(0)" id="<?php echo ($v["id"]); ?>">
						<span class="icon-edit"></span> 修改</a><?php endif; ?>
					<?php if($third['auth_delete'] == 1): ?><a class="button border-red delete" href="javascript:void(0)" id="<?php echo ($v["id"]); ?>">
						<span class="icon-trash-o"></span> 删除</a><?php endif; ?>
				</div>
			</td>
		</tr><?php endforeach; endif; else: echo "" ;endif; ?>
		<tr>
	        <td>
	        	<input type="checkbox" class="checkall"/>
            </td>
	        <td colspan="11" style="text-align:left;padding-left:20px;">
				<div class="button-group">
					<a class="button border-main icon-mail-forward" href="javascript:void(0)" 
						onclick="artSelect(1)"> 提交</a>
					<?php if($third['auth_delete'] == 1): ?><a class="button border-red icon-trash-o" href="javascript:void(0)" 
					onclick="artSelect(0)"> 删除</a><?php endif; ?>
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="11">
				<div class="pagelist-admin">
					<?php echo ($page); ?>
				</div>
			</td>
		</tr>
		</table>
	</form>
</div>
<script type="text/javascript">
//搜索
function changesearch(){	
	$('#serachs').submit();
}
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
	//删除
	$(".delete").click(function(){
		id=$(this).attr('id');
		function jumps(){
			location.href="/Article/artdel/id/"+id;
		}
		warning(jumps);
		/*if(confirm("确定删除吗？")){
			id=$(this).attr('id');
			location.href="/Article/artdel/id/"+id;
		}*/
	});
	//编辑
	$(".edit").click(function(){
		id=$(this).attr('id');
		location.href="/Article/artedit/status/2/id/"+id;
	});
	//排序设置
	$("input[name='sort']").blur(function(){
		var sort = $(this).val();
		var id   = $(this).attr("id");
		$.ajax({
			type:"post",
			url:"<?php echo U('article/artsort');?>",
			data:{"id":id,"sort":sort},
			success:function(res){
				console.log(res);
			}
		});
	});
	//重置
	$("#resets").click(function(){
		$(".input").val("");
		$(".input").find("option").removeAttr("selected");
	});
});
//单个文章提交
function oneSubmit(id){
	location.href="/Article/artpublish/edit/1/status/0/id/"+id;
}
//批量删除或提交 0：删除，1：提交
function artSelect(status){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){
		var url="";
		if(status==0){
			function sumit(){
				url='artdel/status/'+status;
				$("#listform").attr('action','/Article/'+url);
				$("#listform").submit();
			}
			warning(sumit);
		}else{
			url='artpublish/edit/1/status/0';
			$("#listform").attr('action','/Article/'+url);
			$("#listform").submit();
		}
				
	}
	else{
		errors("请选择内容!");
		return false;
	}
}
/**
 * 多种状态操作
 * @param {Object} flag 1.置顶，2.推荐 ,5.排序 
 * @param {Object} id  主键id
 * @param {Object} status 显示状态
 */
function setTop(flag,id,status){
	//console.log(status);return;
	var data = {id:id};
	if(flag == 1)		data.settop 	= status;
	else if(flag == 2)	data.recommend 	= status;
	else if(flag == 3)	data.pc			= status;
	else if(flag == 4)	data.mobile 	= status;
	else if(flag == 5)	data.order 		= status;
	$.ajax({
		type:"post",
		url:"<?php echo U('settop');?>",
		data:data,
		success:function(res){
			console.log(res);
		}
	});
}
</script>
</body>
</html>