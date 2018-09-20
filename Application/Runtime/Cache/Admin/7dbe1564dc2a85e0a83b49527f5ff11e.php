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
body{font-size:14px;color:#333;background:#fff;font-family:"Microsoft YaHei","simsun","Helvetica Neue", Arial, Helvetica, sans-serif;}
	a:hover{text-decoration: none;}
	.admin-panel{border:1px solid #ccc}
	.cursor{cursor: pointer; color: deepskyblue;}
	.currhide{display: none;}
</style>
<!--<script type="text/javascript">
$(function(){
	$(".cursor").toggle(function(){
		var that = $(this);
		that.removeClass("icon-plus-square-o").addClass("icon-minus-square-o");
		var id   = that.attr("id");
		console.log(id,1);
		current(id,1);
	},function(){
		var that = $(this);
		that.removeClass("icon-minus-square-o").addClass("icon-plus-square-o");
		var id   = that.attr("id");
		current(id,0);
	});
});
//显示隐藏结构 status:1显示，0,隐藏
function current(id,status){
	$("tr.code").each(function(i,o){
		if($(o).attr("pid") == id){
			console.log($(o).attr("pid"));
			if(status == 1){
				$(o).show();				
			}else{
				$(o).hide();
			}
		}
	});
}
</script>-->
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong class="icon-reorder"> 权限列表</strong></div>
  <?php if($third['auth_add'] == 1): ?><div class="padding border-bottom">
    <button class="button border-main" onclick="ruleadd()">
    	<span class="icon-plus-square-o"></span> 添加权限</button>
  </div><?php endif; ?>
  <table class="table table-hover text-center" id="tree_table">
    <thead>
    <tr>
      <th width="5%">权限ID</th>
      <th width="10%" style="text-align: left;">名称</th>
      <th width="10%">权限</th>
      <th width="5%">权限等级</th>
      <th width="5%">显示状态</th>
      <th width="20%">操作</th>
    </tr>
   </thead>
    <?php if(is_array($tree)): $i = 0; $__LIST__ = $tree;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr data-tt-id="<?php echo ($v["id"]); ?>" data-tt-parent-id="<?php echo ($v["pid"]); ?>" class="code <?php if($v['_level'] == 3 || $v['_level'] == 2): ?>currhide<?php endif; ?>" id="<?php echo ($v["id"]); ?>" pid="<?php echo ($v["pid"]); ?>">
      <td style="vertical-align: middle;"><?php echo ($v["id"]); ?></td>
      <td style="text-align: left;vertical-align: middle;">
      <!--	<?php if($v['_level'] != 1): ?>&emsp;<?php endif; ?>
      	<?php if($v['_level'] != 3): ?><i class="icon icon-plus-square-o cursor" id="<?php echo ($v["id"]); ?>"></i><?php endif; ?>-->
      	<?php echo ($v["_name"]); ?>
      </td>
      <td style="vertical-align: middle;"><?php echo ($v["name"]); ?></td>
      <td style="vertical-align: middle;"><?php echo ($v["_level"]); ?></td>
      <td style="vertical-align: middle;">
      	<font color="#00CC99">
      	<?php if($v['status'] == 1): ?><span class="icon icon-unlock"></span>
      	<?php else: ?>
      		<span class="icon icon-lock"></span><?php endif; ?>
      	</font>
      </td>
      <td>
      	<div class="button-group"> 
      		<?php if($third['auth_add'] == 1): ?><a class="button border-main" href="javascript:void(0)"
      			 onclick="ruleedit('',<?php echo ($v["id"]); ?>)">
      			<span class="icon-plus-square-o"></span> 添加子菜单</a><?php endif; ?>
      		<?php if($third['auth_edit'] == 1): ?><a class="button border-main" href="javascript:void(0)"
      			 onclick="ruleedit(<?php echo ($v["id"]); ?>,<?php echo ($v["pid"]); ?>,'<?php echo ($v["title"]); ?>','<?php echo ($v["name"]); ?>',<?php echo ($v["status"]); ?>,<?php echo ($v["condition"]); ?>)">
      			<span class="icon-edit"></span> 修改</a><?php endif; ?>
			<?php if($third['auth_delete'] == 1): ?><a class="button border-red" href="javascript:void(0)" 
  				onclick="del(<?php echo ($v["id"]); ?>)">
				<span class="icon-trash-o"></span> 删除</a><?php endif; ?>
      	</div>
      </td>
    </tr><?php endforeach; endif; else: echo "" ;endif; ?>
  </table>
</div>
<!--弹出层添加编辑权限-->
<div class="modal fade" id="ruleedit" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		 <div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
				</button>
				<h4 class="modal-title" id="myModalLabel">
					添加权限
				</h4>
			</div>
			<div class="modal-body">
				<form id="formeidt" action="<?php echo U('Rule/ruleedit');?>" method="post">
					<input type="hidden" name="pid" class="pid">
					<input type="hidden" name="id" class="id">
					<input type="hidden" name="type" value="1" class="type">
					<table class="table table-hover text-center" style="border: 1px solid #ccc;">
						<tr id="menuss" style="display: none;">
							<td width="20%">上级菜单：</td>
							<td>
								<div class="field">
						          <select name="pid" class="input w50 group" style="width: 35%;">
						          	<option value="">请选择用户组</option>
						          	<?php if(is_array($tree)): $i = 0; $__LIST__ = $tree;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i; if($vo['_level'] != 3): ?><option value="<?php echo ($vo["id"]); ?>">
						          			<?php echo ($vo["_name"]); ?>
						          		</option><?php endif; endforeach; endif; else: echo "" ;endif; ?>
						          </select> 
						          &nbsp;<font color="red" style="float: left; line-height: 42px;">不选默认为顶级菜单</font>
        					</div>
							</td>
						</tr>
						<tr>
							<td width="20%">权限名：</td>
							<td>
								<input class="form-control title" type="text" name="title">
							</td>
						</tr>
						<tr>
							<td>权限：</td>
							<td>
								<input class="form-control name" type="text" name="name" > 
								<font color="red">模型/控制器/方法 如 Admin/Rule/index</font>
							</td>
						</tr>
						<tr>
							<td>三级操作：</td>
							<td align="left">
								<label class="radio-inline"><input class="condition" type="radio" name="condition" value="1"> 添加</label>
								<label class="radio-inline"><input class="condition" type="radio" name="condition" value="2"> 编辑</label>
								<label class="radio-inline"><input class="condition" type="radio" name="condition" value="3"> 查看</label>
								<label class="radio-inline"><input class="condition" type="radio" name="condition" value="4"> 还原</label>
								<label class="radio-inline"><input class="condition" type="radio" name="condition" value="5"> 删除</label>
								<div><font color="red">三级菜单操作时选择</font></div>
							</td>
						</tr>
						<tr>
							<td>启用：</td>
							<td align="left" style="height:20px;">
								<input type="checkbox" class="statustype" name="status">启用
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
							<button class="button border-main submitdata icon-plus-square-o" type="submit">
      			 添加</button> 
							</td>
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
<!--弹出层添加编辑权限over-->
<link rel="stylesheet" type="text/css" href="/Public/css/jquery.treetable.css"/>
<script src="/Public/js/jquery.treetable.js"></script>
<script type="text/javascript">
$(function(){
	$("#tree_table").treetable({indent:20, column:1, clickableNodeNames:true,expandable:true,});
});

function del(id){
	function del4(){
		location.href="/Rule/ruledel/id/"+id;
	}
	warning(del4);
}
function catedit(status,id){
	location.href="/Rule/catedit/status/"+status+"/id/"+id;
}
function ruleedit(id,pid,title,name,status,condition){
	$(".pid").val(pid);
	$("#menuss").remove();
	var check=$(".statustype");
	if(!id){//添加
		$(".form-control").val('');
		check.attr('checked','checked');
		$(".submitdata").removeClass('icon-edit').addClass('icon-plus-square-o').html(' 添加');
		$(".type").val(1);
	}else{//编辑
		$(".id").val(id);
		if(status==1){
			check.attr('checked','checked');
		}
		$(".condition").each(function(){
			if($(this).val() == condition){
				$(this).attr("checked",true);
			}
		});
		$(".type").val(2);
		$(".submitdata").removeClass('icon-plus-square-o').addClass('icon-edit').html(' 修改');
		$(".title").val(title);
		$(".name").val(name);
	}
	$("#ruleedit").modal('show');
}
function ruleadd(){
	$(".pid").remove();
	$("#menuss").show();
	$("#ruleedit").modal('show');
}
</script>
</body>
</html>