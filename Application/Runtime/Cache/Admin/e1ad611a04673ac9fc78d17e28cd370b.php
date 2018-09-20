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
		<strong class="icon-reorder"> 留言列表</strong><a href="" style="float:right; display:none;">添加字段</a>
	</div>
	<!--搜索-->
	<form action="" method="get" id="serachs">
	<div class="padding border-bottom">
		<ul class="search" style="padding-left:10px;">
			<li>搜索：</li>
			<li>
				<select name="type" class="input" style="line-height:17px;">
					<option value="">性别</option>
					<option value="1"<?php if(($get['sex']) == "1"): ?>selected<?php endif; ?>>男</option>
					<option value="0"<?php if(($get['sex']) == "0"): ?>selected<?php endif; ?>>女</option>
				</select>
			</li>
			<li>
				<select name="status" class="input" style="line-height:17px;">
					<option value="">反馈状态</option>
					<option value="1"<?php if(($get['back']) == "1"): ?>selected<?php endif; ?>>已反馈</option>
					<option value="0"<?php if(($get['back']) == "0"): ?>selected<?php endif; ?>>待反馈</option>
				</select>
			</li>
			<li>
				<select name="age" class="input" style="line-height:17px;">
					<option value="">年龄范围</option>
					<option value="1"<?php if(($get['age']) == "1"): ?>selected<?php endif; ?>>35岁以下</option>
					<option value="2"<?php if(($get['age']) == "2"): ?>selected<?php endif; ?>>35-40岁</option>
					<option value="3"<?php if(($get['age']) == "3"): ?>selected<?php endif; ?>>41-45岁</option>
					<option value="4"<?php if(($get['age']) == "4"): ?>selected<?php endif; ?>>45岁以上</option>
				</select>
			</li>
			<li>
				<select name="type" class="input" style="line-height:17px;">
					<option value="">人群</option>
					<option value="1"<?php if(($get['type']) == "1"): ?>selected<?php endif; ?>>异性</option>
					<option value="2"<?php if(($get['type']) == "2"): ?>selected<?php endif; ?>>单身</option>
					<option value="3"<?php if(($get['type']) == "3"): ?>selected<?php endif; ?>>同性</option>
				</select>
			</li>
			<li>
				<select name="status" class="input" style="line-height:17px;">
					<option value="">生育</option>
					<option value="1"<?php if(($get['status']) == "1"): ?>selected<?php endif; ?>>未育</option>
					<option value="2"<?php if(($get['status']) == "2"): ?>selected<?php endif; ?>>一胎</option>
					<option value="3"<?php if(($get['status']) == "3"): ?>selected<?php endif; ?>>二胎</option>
				</select>
			</li>
			<li>
				<select name="source" class="input" style="line-height:17px;">
					<option value="">来源</option>
					<option value="1"<?php if(($get['source']) == "1"): ?>selected<?php endif; ?>>pc</option>
					<option value="2"<?php if(($get['source']) == "2"): ?>selected<?php endif; ?>>移动</option>
					<option value="3"<?php if(($get['source']) == "2"): ?>selected<?php endif; ?>>答疑会</option>
					<option value="4"<?php if(($get['source']) == "4"): ?>selected<?php endif; ?>>今日头条</option>
					<option value="5"<?php if(($get['source']) == "5"): ?>selected<?php endif; ?>>腾讯新闻</option>
					<option value="6"<?php if(($get['source']) == "6"): ?>selected<?php endif; ?>>UC头条</option>
					<option value="7"<?php if(($get['source']) == "7"): ?>selected<?php endif; ?>>美柚</option>
				</select>
			</li>
			<li>
				<select name="will" class="input" style="line-height:17px;">
					<option value="">意向</option>
					<option value="1"<?php if(($get['will']) == "1"): ?>selected<?php endif; ?>>冻卵</option>
					<option value="2"<?php if(($get['will']) == "2"): ?>selected<?php endif; ?>>性别选择</option>
					<option value="3"<?php if(($get['will']) == "3"): ?>selected<?php endif; ?>>代孕</option>
				</select>
			</li>
			<li>
				<select name="isone" class="input" style="line-height:17px;">
					<option value="">一对一</option>
					<option value="1"<?php if(($get['isone']) == "1"): ?>selected<?php endif; ?>>是</option>
					<option value="0"<?php if(($get['isone']) == "0"): ?>selected<?php endif; ?>>否</option>
				</select>
			</li>
			<li>
			<button href="javascript:void(0)" type="submit" class="button border-main icon-search"> 搜索</button>
			<button href="javascript:void(0)" type="reset" id="resets" class="button border-main icon-search"> 重置</button></li>
			<li>
				<font color="red">注意：客服反馈用户后，请及时点击确认按钮</font>
			</li>
		</ul>
	</div>
	</form>
	<!--数据统计 留言来源 按月份-->
	<?php if(($_SESSION['user_info']['user_id']) == "1"): ?><div class="padding border-bottom">
		<form action="<?php echo U('messexport');?>" method="post" id="messexport">
			<ul class="search" style="padding-left:10px;">
				<li>导出：</li>
				<li>
					<script src="/Public/js/laydate/laydate.js"></script>
					<span class="float-left">日期范围：</span>	
					<input type="text" class="input float-left" style="width: 110px;" id="demo5" name="exstart" value="<?php echo ($get["exstart"]); ?>" placeholder="请输入日期" onclick="laydate"/>
					<span class="float-left">&nbsp;-&nbsp;</span>	
					<input type="text" class="input float-left" style="width: 110px;" id="demo6" name="exend" value="<?php echo ($get["exend"]); ?>" placeholder="请输入日期" onclick="laydate"/>
					<script>
					;!function(){laydate.skin('blue');laydate({elem: '#demo5',istoday:true})}();
					;!function(){laydate.skin('blue');laydate({elem: '#demo6',istoday:true})}();
					</script>
				</li>
				<li>
					<select name="source" class="input" style="line-height:17px;">
						<option value="">来源</option>
						<!--<option value="1"<?php if(($get['source']) == "1"): ?>selected<?php endif; ?>>pc</option>
						<option value="2"<?php if(($get['source']) == "2"): ?>selected<?php endif; ?>>移动</option>
						<option value="3"<?php if(($get['source']) == "2"): ?>selected<?php endif; ?>>答疑会</option>-->
						<option value="4"<?php if(($get['source']) == "4"): ?>selected<?php endif; ?>>今日头条</option>
						<option value="5"<?php if(($get['source']) == "5"): ?>selected<?php endif; ?>>腾讯新闻</option>
						<option value="6"<?php if(($get['source']) == "6"): ?>selected<?php endif; ?>>UC头条</option>
						<option value="7"<?php if(($get['source']) == "7"): ?>selected<?php endif; ?>>美柚</option>
						<option value="7"<?php if(($get['source']) == "15"): ?>selected<?php endif; ?>>梦美主站·公益宣传专题</option>
					</select>
				</li>
				<li>
					<button href="javascript:void(0)" id="export" type="button" class="button border-main icon-edit"> 导出</button>
				</li>
				<li>
					<font color="red">注意：如果不选择筛选条件，则导出全部数据</font>
				</li>
				<li>
					<a href="<?php echo U('getcount');?>" class="button border-main icon-edit"> 访问量统计</a>
				</li>
			</ul>
		</form>
		<script type="text/javascript">
			$("#export").click(function(){
				var e = $("#demo5").val();
				var f = $("#demo6").val();
				if(!e && !f){
					$("#messexport").submit();
				}else if((e && !f) || (!e && f)){
					errors("时间范围不能为空");
				}else if(e && f){
					if(e > f){
						errors("开始时间不能大于结束时间");
					}else{
						$("#messexport").submit();
					}
				}
			});
		</script>
	</div><?php endif; ?>
	<!--数据统计 留言来源 按月份end-->
	<form method="post" action="" id="listform">
		<table class="table table-hover text-center">
		<tr>
			<th width="1%"></th>
			<th width="3%">序号</th>
			<th width="5%">姓名</th>
			<th width="3%">性别</th>
			<th width="5%">年龄范围</th>
			<th width="7%">电话</th>
			<th width="8%">微信</th>
			<th width="4%">人群</th>
			<th width="4%">生育</th>
			<th width="5%">意向</th>
			<th width="6%">留言时间</th>
			<th width="5%">一对一</th>
			<th width="5%">来源</th>
			<th width="5%">处理状态</th>
			<th width="15%">操作</th>
		</tr>
		<?php if(is_array($info)): $i = 0; $__LIST__ = $info;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><tr>
			<td width="1%"><input type="checkbox" name="id[]" value="<?php echo ($v["id"]); ?>"/></td>
			<td><?php echo ($i); ?></td>
			<td><?php echo ($v["name"]); ?></td>
			<td>
				<?php if($v['info'] == 1): echo ($v['sex'] == 1 ? '男' : '女'); ?>
				<?php else: ?>
					<?php if($v['sex'] != 2): echo ($v['sex'] == 1 ? '男' : '女'); ?>
					<?php else: ?>
					未知<?php endif; endif; ?>
			</td>
			<td>
				<?php if($v['info'] == 1): if($v['age'] == 1): ?>35岁以下	
					<?php elseif($v['age'] == 2): ?>
					35-40岁
					<?php elseif($v['age'] == 3): ?>
					41-45岁
					<?php else: ?>
					45以上<?php endif; ?>
				<?php else: ?>
				未知<?php endif; ?>
			</td>
			<td><?php echo ($v["mobile"]); ?></td>
			<td><?php echo ($v["wechat"]); ?></td>
			<td>
				<?php if($v['info'] == 1): if($v['type'] == 1): ?>异性	
					<?php elseif($v['type'] == 2): ?>
					单身
					<?php else: ?>
					同性<?php endif; ?>
				<?php else: ?>
				未知<?php endif; ?>
			</td>
			<td>
				<?php if($v['info'] == 1): if($v['status'] == 1): ?>未育	
					<?php elseif($v['status'] == 2): ?>
					一胎
					<?php else: ?>
					二胎<?php endif; ?>
				<?php else: ?>
				未知<?php endif; ?>
			</td>
			<td>
				<?php if($v['info'] == 1): if($v['will'] == 1): ?>冻卵	
					<?php elseif($v['will'] == 2): ?>
					性别选择
					<?php else: ?>
					代孕<?php endif; ?>
				<?php else: ?>
				未知<?php endif; ?>
			</td>
			<td><?php echo ($v["ctime"]); ?></td>
			</td>
			<td>
				<?php if($v['info'] == 1): echo ($v['isone'] == 1 ? '是' : '否'); ?>
				<?php else: ?>
				未知<?php endif; ?>
			</td>
			<td>
				<?php switch($v["source"]): case "1": ?>pc<?php break;?>
					<?php case "2": ?>移动<?php break;?>
					<?php case "3": ?>答疑会<?php break;?>
					<?php case "4": ?>今日头条<?php break;?>
					<?php case "5": ?>UC头条<?php break;?>
					<?php case "6": ?>腾讯新闻<?php break;?>
					<?php case "7": ?>美柚<?php break;?>
					<?php case "15": ?>梦美主站·公益宣传专题<?php break; endswitch;?>
			</td>
			<td><?php echo ($v['back'] == 1 ? '是' : '否'); ?></td>
			<td>
				<div class="button-group">
					<?php if($v['back'] == 0): ?><a class="button border-main icon-edit" href="<?php echo U('messedit',['id'=>$v['id']]);?>"> 确认</a><?php endif; ?>
					<?php if($third['auth_check'] == 1): ?><a class="button border-main icon-edit" href="<?php echo U('messshow',['id'=>$v['id']]);?>"> 查看</a><?php endif; ?>
					<?php if($third['auth_delete'] == 1): ?><a class="button border-red icon-trash-o" href="<?php echo U('messdel',['id'=>$v['id']]);?>"> 删除</a><?php endif; ?>
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
					onclick="message(0)"> 删除</a>
				</div>
			</td>
        </tr><?php endif; ?>
		<tr>
			<td colspan="15">
				<div class="pagelist-admin">
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
		$("#listform").attr("action","<?php echo U('messdel');?>");
		warning(function(){
			$("#listform").submit();			
		});
	}
	else{
		errors("请选择的内容!");
		return false;
	}
}
</script>
</body>
</html>