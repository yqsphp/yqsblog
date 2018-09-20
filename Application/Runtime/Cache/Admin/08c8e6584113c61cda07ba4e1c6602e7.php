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
.groups{display:inline-block}
#backupsize{display:inline; position:relative; top:2px;};
</style>
<body>
<div class="panel admin-panel">
  <div class="panel-head"><strong class="icon-reorder"> 数据备份列表</strong></div>
    <form id="myform" action="<?php echo U('Backups/export',array('submit'=>1));?>" method="post">
  <div class="padding border-bottom">
  	<div class="button-group groups">
	    <a type="button" class="button border-main" onclick="exports()">
	    	<span class="icon-plus-square-o"></span> 开始备份</a>
	    <a type="button" class="button border-main" href="<?php echo U('Backups/optimize');?>">
	    	<span class="icon-refresh"></span> 优化表</a>
	    <a type="button" class="button border-main" href="<?php echo ('Backups/repair');?>">
	    	<span class="icon-wrench"></span> 修复表</a>
    </div>
    <div class="groups trous">
       分卷大小：<input type="nummer" id="backupsize" class="input" 
       style="width:100px" value="10" name="sizelimit" max="50" size="50" placeholder="请输入备份大小(M)" />  最大50M   
    </div> 
    <div class="groups">
    	&ensp; <font color="red">注意：InnoDb引擎默认存在存储空间，不是碎片</font>
    </div>
  </div>
  <table class="table table-hover text-center">
    <tr>
      <th width="5%"><input type="checkbox" checked id="allcheck"/></th>
      <th width="10%">数据表名</th>
      <th width="10%">表注释</th>
      <th width="10%">数据条数</th>
      <th width="5%">大小</th>
      <th width="5%">空间碎片</th>
      <th width="5%">存储引擎</th>
      <th width="12%">更新时间</th>
      <th width="12%">创建时间</th>
      <th width="15%">操作</th>
    </tr>
    <?php if(is_array($tables)): $i = 0; $__LIST__ = $tables;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr>
      <td>
      	<input type="checkbox" name="backup_tables[<?php echo ($v["name"]); ?>]" checked value="-1" />
      </td>
      <td><?php echo ($v["name"]); ?></td>
      <td><?php echo ($v["comment"]); ?></td>
      <td><?php echo ($v["rows"]); ?></td>
      <td><?php echo (format_bytes($v["data_length"])); ?></td>
      <td><font <?php if($v['data_free'] != 0): ?>color="red"<?php endif; ?>><?php echo (format_bytes($v["data_free"])); ?></font></td>
      <td><?php echo ($v["engine"]); ?></td>
      <td><?php echo ($v["update_time"]); ?></td>
      <td><?php echo ($v["create_time"]); ?></td>
      <td><div class="button-group"> 
      	<a class="button border-main" href="<?php echo U('Backups/optimize',['table'=>$v['name']]);?>">
      		<span class="icon-refresh"></span> 优化表</a> 
      	<a class="button border-main" href="<?php echo U('Backups/repair',['table'=>$v['name']]);?>">
      		<span class="icon-wrench"></span> 修复表</a> 
    </tr>
    <?php if($v['vols_length'] > 1): if(is_array($v['vols'])): $i = 0; $__LIST__ = $v['vols'];if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$vo): $mod = ($i % 2 );++$i;?><tr class="juanchild" style="display:none">
	      <td>卷<?php echo ($vo["vol"]); ?></td>
	      <td><?php echo ($vo["file"]); ?></td>
	      <td><?php echo ($v["date_str"]); ?></td>
	      <td><?php echo ($vo["size"]); ?></td>
	      <td></td>
	      <td></td>
	    </tr><?php endforeach; endif; else: echo "" ;endif; endif; endforeach; endif; else: echo "" ;endif; ?>
  </table>
  	<input type="hidden" name="backup_name" value="<?php echo ($backup_name); ?>"/>
  </form>
</div>
<script type="text/javascript">
$(function(){
	$("#disp").toggle(function(){
		$(this).children().addClass("icon-minus").removeClass("icon-plus");
		$(".juanchild").show();		
	},function(){
		$(this).children().addClass("icon-plus").removeClass("icon-minus");
		$(".juanchild").hide();
	});
	$("#allcheck").click(function(){
		this.checked=this.checked==true ? false : true;
		$("input[type='checkbox']").each(function(){
			if(this.checked){
				this.checked=false;
			}else{
				this.checked=true;
			}
		});
	});
});
function del(file){
	function dels(){
		location.href="<?php echo ('Backups/del_backups');?>/backup/"+file;
	}
	warning(dels);
}
function restore(file){
	function imports(){
		location.href="<?php echo ('Backups/import');?>/backup/"+file;
	}
	warning(imports,'确定');
}
function exports(){
	$("input[type='checkbox']").each(function(){
		if(!this.checked) $(this).removeAttr("checked");
	});
	$("#myform").submit();
}
</script>
</body>
</html>