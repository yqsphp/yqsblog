$(function(){
	var menuFirst  = $(".custom-menu-view_first"); //一级菜单
	var menuSecond = $(".custom-menu-view__menu__sub"); //二级菜单
	var title      = $(".custom_input_title"); //右侧标题
	var rightObj   = $(".cm-edit-after");  //右侧对象
	var menuFlag   = 0;  //一，二级菜单标识 1.一级 2.二级
	//编辑一级菜单
	menuFirst.click(function(){
		var that = $(this);
		menuReset();
		getCurrentMenu(that);
		//显示右侧内容
		rightObj.show();
		
		that.find(".iBtn").hide(); //隐藏加号
		that.find(".custom-menu-close").show(); //显示删除
		$(document).find(".subbutton__actived").removeClass("subbutton__actived");
		that.parent().addClass("subbutton__actived").siblings().removeClass("subbutton__actived");
		//根据当前id右侧消息显示内容
		var id = that.parent().attr("fid");
		title.attr("fid",id);
		//x轴的位置
		$("#x").val(that.parent().attr("x"));
		$("#y").val(that.parent().attr("y"));
		menuFlag = 1;
	});
	//添加二级菜单
	menuSecond.on("click",".custom-menu-view_second",function(){
		var that  = $(this);
		//获取当前二级菜单对应的一级菜单
		var fcode = that.parent().parent().attr("fid");
		var currX = that.parent().parent().attr("x"); //当前二级菜单对应一级菜单所在x轴（1,2,3）
		var pid   = that.parent().siblings(".custom-menu-view_first").attr("id"); //当前菜单父级id
		console.log("pid:"+pid);
		//判断当前是否一级菜单为空
		if($("#"+fcode).html() == ''){
			errors("请先编辑一级菜单");
			return false;
		}
		var leng  = that.siblings(".custom-second").length; //未添加
		//var currY = leng > 0 ? 
		var child = "<li class='custom-menu-view__menu__sub__add custom-second' id='' pid='"+pid+"' x='"+currX+"' y='"+(leng+1)+"' fid='sub_"+fcode+"_"+(leng+1)+"'>"
					+"<div id='sub_"+fcode+"_"+(leng+1)+"' class='text-ellipsis'>新建子级菜单</div>"
					+"<i class='custom-menu-close glyphicon glyphicon-remove'></i></li>"
		//当前同级的格式大于等于5个去掉加号
		that.before(child);
		var leng  = that.siblings(".custom-second").length;
		if(leng == 5){
			that.remove();
		}
		//e.preventDefault();
	});
	//点击当前二级菜单编辑
	$(".custom-menu-view__menu__sub").on("click",".custom-second",function(e){
		menuReset();
		var that = $(this);
		getCurrentMenu(that);
		var id   = that.attr("fid");
		var pid  = that.parent().siblings(".custom-menu-view_first").attr("id"); //当前菜单父级id
		if(id){
			//显示右侧内容
			rightObj.show();
			$(document).find(".subbutton__actived").removeClass("subbutton__actived");
			that.addClass("subbutton__actived").siblings().removeClass("subbutton__actived");
			console.log("ab:"+id);
			title.attr("fid",id);
			//x轴的位置
			$("#pid").val(pid);
			$("#x").val(that.attr("x"));
			$("#y").val(that.attr("y"));
		}else{
			$("#id").val("");
		}
		menuFlag = 2;
	});
	//删除菜单
	$(".custom-menu-view__menu").on("click",".custom-menu-close",function(e){
		menuReset();
		//删除菜单同时隐藏右侧
		rightObj.hide();
		var that = $(this);
		//判断是否一级菜单
		var second = '<li class="custom-menu-view__menu__sub__add custom-menu-view_second">'
						+'<div class="text-ellipsis">'
						+'<i class="glyphicon glyphicon-plus text-info"></i>'
						+'</div></li>'
		if(that.attr("type") == 1){
			that.siblings(".iBtn").show();  //删除后显示加号
			that.siblings("span").html(""); //清空文本
			that.hide(); //隐藏删除
			that.parent().parent().removeClass("subbutton__actived"); //移除父级选中
			var current = that.parent().siblings(".custom-menu-view__menu__sub");
			var length  = current.find(".custom-second").length;
			//并删除当前一级菜单下的所有子集
			current.find(".custom-second").remove();
			//移除全部子集后增加子集加号
			if(current.find(".custom-menu-view_second").length == 0){
				current.append(second);
			}
		}else{
			var current = that.parent();
			var length  = current.siblings(".custom-menu-view_second").length;
			if(length == 0){
				current.parent().append(second);
			}
			that.parent().remove();
			console.log(1);
		}
		//获取当前菜单的id
		var id = that.parent().attr("id");
		$.ajax({
			type:"post",
			url:"/wechat/menudel",
			data:{"id":id},
			success:function(data){
				console.log(data);
				if(data.code == 200){
					success(data.message);
				}else{
					errors(data.message);
				}
			}
		});
		//删除完成清除菜单id
		that.parent().attr("id","");
	});
	
	/****************************************右侧菜单文本编辑部分******************************************************/
	
	//消息链接选择
	$(".LebelRadio>label").click(function(){
		$("#editContent > div").eq($(this).index()).show().siblings().hide();
	});
	//右侧消息内容的标题失去焦点后将赋值给当前选择的菜单
	title.blur(function(){
		var that = $(this);
		//console.log(menuFlag);
		var leng = that.val().length;
		if(menuFlag == 1){
			if(leng > 5){
				errors("超过指定字数");
				that.focus();
			}
		}else{
			if(leng > 8){
				errors("超过指定字数");
				that.focus();
			}
		}
		$("#"+that.attr("fid")).html(that.val());
	});
	//点击右侧内容为文本是选择图文，文本，图片
	$(".msg-panel__tab li").click(function(){
		var index = $(this).index(), custom_type = $("#custom-type"), reply = $("#replytype");
		reply.val(index+1);
		custom_type.val(index+1);
		$(this).removeClass("on").addClass("active").siblings().addClass("on").removeClass("active");
		$(".editTab-body>div").eq(index).show().siblings().hide();
	});
	//读取数据后判断当前子集的个数是否已经5个了
	$(".custom-menu-view__menu__sub").each(function(i,o){
		var currentMenu = $(o).children(".custom-second").length;
		if(currentMenu >= 5){
			$(o).children().last().remove();
		}else{
			$(o).children().last().show();
		}
	})
	//提交保存
	$("#saveBtns").click(function(){
		//判断是否是选择了图文
		if($(".editTab-body>div:first-child").css("display") == "block" && $("input[name='sendtype']:checked").val() == 1){
			//获取选中的值
			var tree  = $.fn.zTree.getZTreeObj("treeDemo");
			var nodes = tree.getCheckedNodes(true);
			var nleng = nodes.length;
			//默认情况是获取第一个节点的id
			if(nodes != false){
				console.log(nodes);
				var catid = nodes[0].id;
				var table = nodes[0].table;
				
				//节点长度大于等于2时，获取最后一个节点id
				if(nleng >= 2){
					catid = nodes[nleng-1].id;
					table = nodes[nleng-1].table;
				}
				$("#aid").val(catid);
				$("#tablename").val(table);
			}
			
		}
		$.ajax({
			type:"post",
			url:"/wechat/menuedit",
			data:$("#custom-submit").serialize(),
			beforeSend:loading(),
			success:function(data){
				console.log(data);
				if(data.code == 200){
					//如果是添加操作
					if(data.type == 1){
						var first = $(".custom_input_title").attr("fid");
						console.log(first);
						$("#"+first).parent().attr("id",data.result);
					}else{
						console.log(data);
					}
					success('保存成功');
				}
			}
		});
	});
});
//选择当前菜单是都要初始化右侧内容
function menuReset(){
	$(".cm-edit-before").remove();
	$(".custom_input_title").val("");
	//$("input[name='sendtype']").removeAttr("checked");
	$("input[name='sendtype']").eq(0).attr("checked","checked");
	$("#conts").val("");
	$(".msg-panel__tab li").removeClass("active").addClass("on");
	$(".msg-panel__tab li").eq(0).removeClass("on").addClass("active");
	$(".editTab-body>div").hide().eq(0).show();
	
	$(".links").val("");
	
}
//选择当前菜单读取数据
function getCurrentMenu(obj){
	var id = obj.attr("id");
	if(id){
		$("#id").val(id);
		$.ajax({
			type:"post",
			url:"/wechat/get_info",
			data:{"id":id},
			success:function(data){
				console.log(data);
				$("#pid").val(data.pid);
				$(".custom_input_title").val(data.name);
				$("input[name='sendtype']").removeAttr("checked");
				if(data.sendtype == 1){
					$("input[name='sendtype']").eq(0).prop("checked","checked");
					var tab = $(".msg-panel__tab li");
					tab.removeClass("active").addClass("on");
					if(data.type == 1){
						tab.eq(0).removeClass("on").addClass("active");
					}else if(data.type == 2){
						tab.eq(1).removeClass("on").addClass("active");
						console.log(data.text)
						$("#conts").val(data.text);
					}else{
						tab.eq(2).removeClass("on").addClass("active");
					}
					$(".editTab-body>div").eq((data.type-1)).show().siblings().hide();
					
				}else{
					$("input[name='sendtype']").eq(1).prop("checked","checked");
					$(".links").val(data.links);
				}
				$("#replytype").val(data.replytype);
				$("#editContent > div").eq((data.sendtype-1)).show().siblings().hide();
				trees(data);
			}
		});
	}else{
		$("#pid").val(0);
		$("#id").val("");
		console.log('没有id');
		trees();
	}
}


/*树形结构*/
/*var zNodes =[
		{ id:1, pId:0, name:"父节点1", title:"",children:[
			{id:2,pId:0,name:"zijie"},{id:2,pId:0,name:"zijie"}
			]},
		{ id:12, pId:0, name:"父节点12", title:"", children:[
			{id:2,pId:12,name:"zijie"},{id:2,pId:0,name:"zijie"},
			{id:2,pId:12,name:"zijie"},{id:2,pId:0,name:"zijie"}
		]}
	];
*/
//显示树操作
function trees(info){
	//节点树操作
	var setting = {
			check: {
				enable: true,
				chkStyle: "radio"
			},
			data: {
				key: {
					title: "name"
				},
				simpleData: {
					enable: true
				}
			},
			callback: {
				onCheck: onCheck
			}
		};
	$.ajax({
		type:"post",
		url:"/wechat/article",
		async:true,
		success:function(data){
			console.log(data);
			var znode = "[", art=data[0], cat = data[1], artlen = art.length, catlen = cat.length;
			if(info){
				for(var i = 0;i < catlen; i++){
					if(info.aid == cat[i].id && (info.tablename == cat[i].table || info.tablename == 'article')){
						znode += "{id:"+cat[i].id+",pId:"+cat[i].pid+",name:'"+cat[i].name+"',table:'"+cat[i].table+"',checked:true,open:true,children:[";
					}else{
						znode += "{id:"+cat[i].id+",pId:"+cat[i].pid+",name:'"+cat[i].name+"',table:'"+cat[i].table+"',children:[";
					}
					
					//znode+="{id:"+cat[i].id+",pId:"+cat[i].pid+",name:'"+cat[i].name+"',table:'"+cat[i].table+"',children:[";
					for(var j = 0;j < artlen;j++){
						if(art[j].catid == cat[i].id){
							if(info.aid == art[j].id && info.tablename == art[j].table){
								znode += "{id:"+art[j].id+",pId:"+art[j].catid+",name:'"+art[j].name+"',checked:true,open:true,table:'"+art[j].table+"'},";
							}else{
								znode += "{id:"+art[j].id+",pId:"+art[j].catid+",name:'"+art[j].name+"',table:'"+art[j].table+"'},";
							}
						}
					}
					znode += "]},";
				}
			}else{
				for(var i = 0;i < catlen; i++){
					znode += "{id:"+cat[i].id+",pId:"+cat[i].pid+",name:'"+cat[i].name+"',table:'"+cat[i].table+"',children:[";
					for(var j = 0;j < artlen; j++){
						if(art[j].catid == cat[i].id){
							znode += "{id:"+art[j].id+",pId:"+art[j].catid+",name:'"+art[j].name+"',table:'"+art[j].table+"'},";
						}
					}
					znode+="]},";
				}
			}
			znode  = znode.substring(0,znode.length-1);
			znode += "]";
			znode  = eval(znode);
			
			$.fn.zTree.init($("#treeDemo"), setting, znode);
			setTitle();
			count();
		}
	});
}
function onCheck(e, treeId, treeNode) {
	count();
}

function setTitle(node) {
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	var nodes = node ? [node]:zTree.transformToArray(zTree.getNodes());
	for(var i = 0, l = nodes.length; i<l; i++) {
		var n   = nodes[i];
		n.title = "[" + n.id + "] isFirstNode = " + n.isFirstNode + ", isLastNode = " + n.isLastNode;
		zTree.updateNode(n);
	}
}
function count() {
	function isForceHidden(node) {
		if (!node.parentTId) return false;
		var p = node.getParentNode();
		return !!p.isHidden ? true : isForceHidden(p);
	}
	var zTree 	 = $.fn.zTree.getZTreeObj("treeDemo"),
	checkCount 	 = zTree.getCheckedNodes(true).length,
	nocheckCount = zTree.getCheckedNodes(false).length,
	hiddenNodes  = zTree.getNodesByParam("isHidden", true),
	hiddenCount  = hiddenNodes.length;

	for (var i=0, j=hiddenNodes.length; i<j; i++) {
		var n = hiddenNodes[i];
		if (isForceHidden(n)) {
			hiddenCount -= 1;
		} else if (n.isParent) {
			hiddenCount += zTree.transformToArray(n.children).length;
		}
	}
}
/*树形结构 end*/
