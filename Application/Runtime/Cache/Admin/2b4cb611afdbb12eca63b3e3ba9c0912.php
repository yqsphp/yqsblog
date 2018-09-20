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
		<strong class="icon-reorder"> 操作日志列表</strong><a href="" style="float:right; display:none;">添加字段</a>
	</div>
	<form action="" method="get" id="serachs">
		<div class="padding border-bottom">
			<ul class="search" style="padding-left:10px;">
				<li>搜索：
					<input type="hidden" name="p" value="<?php echo ($get['p'] != 1 ? 1 : $get['p']); ?>" />
				</li>
				<li>
					<select name="uid" class="input" style="line-height:18px;">
						<option value="">请选择管理员</option>
						<?php if(is_array($user)): $i = 0; $__LIST__ = $user;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><option value="<?php echo ($v["id"]); ?>" <?php if($get['uid'] == $v['id']): ?>selected<?php endif; ?>><?php echo ($v["name"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
					</select>
				</li>
				<li>
					<script src="/Public/js/laydate/laydate.js"></script>
					<span class="float-left">起止时间：</span>	
					<input type="text" class="input float-left" style="width: 110px; line-height:18px;" id="demo1" name="start" value="<?php echo ($get["start"]); ?>" placeholder="请输入日期" onclick="laydate"/>
					<span class="float-left">&nbsp;-&nbsp;</span>	
					<input type="text" class="input float-left" style="width: 110px; line-height:18px;" id="demo2" name="end" value="<?php echo ($get["end"]); ?>" placeholder="请输入日期" onclick="laydate"/>
					<script>
					;!function(){laydate.skin('blue');laydate({elem: '#demo1',istoday:true})}();
					;!function(){laydate.skin('blue');laydate({elem: '#demo2',istoday:true})}();
					</script>
				</li>
				<li>
					<span class="float-left">操作类型：</span>
					<select name="type" class="input float-left" style="line-height:18px; width: 60px;">
						<option value="">类型</option>
						<option value="1" <?php if($get['type'] == 1): ?>selected<?php endif; ?>>添加</option>
						<option value="2" <?php if($get['type'] == 2): ?>selected<?php endif; ?>>编辑</option>
						<option value="3" <?php if($get['type'] == 3): ?>selected<?php endif; ?>>删除</option>
						<option value="4" <?php if($get['type'] == 4): ?>selected<?php endif; ?>>还原</option>
					</select>
				</li>
				<li>
					<span class="float-left">操作表：</span>
					<select name="tables" class="input float-left" style="line-height:18px; width: 130px;">
						<option value="">全部表</option>
						<?php if(is_array($tables)): $i = 0; $__LIST__ = $tables;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><option value="<?php echo (substr($v["name"],8)); ?>" <?php if($get['tables'] == substr($v['name'],8)): ?>selected<?php endif; ?>><?php echo ($v["comment"]); ?></option><?php endforeach; endif; else: echo "" ;endif; ?>
					</select>
				</li>
				<li>
					<a href="javascript:void(0)" class="button border-main icon-search" onclick="changesearch()"> 搜索</a>
				</li>
				<li><input type="reset" id="resets"  class="button border-main icon-search"  value="重置"/></li>
			</ul>
		</div>
	</form>
	<form method="post" action="" id="listform">
		<table class="table table-hover text-center">
		<tr>
			<th></th>
			<th>序号</th>
			<th>操作管理员</th>
			<th>管理员IP</th>
			<th>操作表名</th>
			<th>日志记录</th>
			<th>操作类型</th>
			<th>操作时间</th>
			<th width="30%">操作</th>
		</tr>
		<?php if(is_array($info)): $i = 0; $__LIST__ = $info;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr>
			<td width="1%"><input type="checkbox" name="id[]" value="<?php echo ($v["id"]); ?>"/></td>
			<td><?php echo ($i); ?></td>
			<td><?php echo ($v["uname"]); ?></td>
			<td><?php echo ($v["ip"]); ?></td>
			<td><?php echo ($v["tcomment"]); ?></td>	
			<td><?php echo ($v["log"]); ?></td>	
			<td>
				<?php echo ($v['type'] == 1 ? '添加' : ($v['type'] == 2 ? '编辑' : ($v['type'] == 3 ? '删除' : '还原'))); ?>
			</td>	
			<td>
				<?php echo ($v["ctime"]); ?>
			</td>	
			<td>
				<div class="button-group">
					<?php if($third['auth_check'] == 1): ?><a class="button border-main edit" href="javascript:void(0)" id="<?php echo ($v["id"]); ?>" type="<?php echo ($v["type"]); ?>" table="<?php echo ($v["tcomment"]); ?>(<?php echo ($v["tables"]); ?>)">
						<span class="icon-edit"></span> 查看</a><?php endif; ?>
					<?php if($third['auth_delete'] == 1): ?><a class="button border-red delete" href="javascript:void(0)" id="<?php echo ($v["id"]); ?>">
						<span class="icon-trash-o"></span> 删除</a><?php endif; ?>
				</div>
			</td>
		</tr><?php endforeach; endif; else: echo "" ;endif; ?>
		<?php if($third['auth_delete'] == 1): ?><tr>
	        <td>
	        	<input type="checkbox" class="checkall"/>
            </td>
	        <td colspan="11" style="text-align:left;padding-left:20px;">
				<div class="button-group">
					<a class="button border-red icon-trash-o" href="javascript:void(0)" 
					onclick="artSelect()"> 删除</a>
				</div>
			</td>
		</tr><?php endif; ?>
		<tr>
			<td colspan="9">
				<div class="pagelist">
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
//批量删除或提交 0：删除
function artSelect(){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){
		var url="";
		function sumit(){
			url='artdel/status/'+status;
			$("#listform").attr('action','<?php echo U('log/logdel');?>');
			$("#listform").submit();
		}
		warning(sumit);
				
	}
	else{
		errors("请选择内容!");
		return false;
	}
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
			location.href="/Log/logdel/id/"+id;
		}
		warning(jumps);
	});
	//编辑
	$(".edit").click(function(){
		id    = $(this).attr('id');
		table = $(this).attr("table");
		type  = $(this).attr("type");
		location.href="/Log/logshow/id/"+id+"/table/"+table+"/type/"+type;
	});
		//重置
	$("#resets").click(function(){
		$(".input").removeAttr("value");
		$(".input").find("option").removeAttr("selected");
	});
});
</script>
</body>
</html>