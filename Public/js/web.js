// JavaScript Document
var web_obj={
	slide:function(myself,config){
		var defaults = new Array();
		defaults['relative'] = '.ly_relative';		//相对定位元素
		defaults['absolute'] = '.ly_absolute';		//绝对定位元素
		defaults['leftbtn'] = '.ly_leftbtn';		//左按钮
		defaults['rightbtn'] = '.ly_rightbtn';		//右按钮
		defaults['items'] = 'li';					//滚动元素
		defaults['type'] = 1;						//滚动类型	1.左右切换 2.上下切换
		defaults['seenum'] = 1;						//可视个数
		defaults['slidenum'] = 1;					//滚动个数
		defaults['loop'] = false;					//是否循环
		defaults['auto'] = true;					//自动播放
		defaults['autotime'] = 3000;				//播放时间 ms
		defaults['tab'] = '.ly_tab';				//切换按钮
		defaults['tabcur'] = 'ly_current';				//着色类名
		
		if(config){
			$.each(config,function(name,value){
				defaults[name]=value;
			});
		}	
		var obj = $(myself);
		var relative_obj = obj.find(defaults['relative']);
		var absolute_obj = obj.find(defaults['absolute']);
		var item_obj = obj.find(defaults['items']);
		var leftbtn = obj.find(defaults['leftbtn']);
		var rightbtn=  obj.find(defaults['rightbtn']);
		var type = defaults['type'];
		var seenum = defaults['seenum'];
		var slidenum =  defaults['slidenum'];
		var loop = defaults['loop'];
		var auto = defaults['auto'];
		var autotime = defaults['autotime'];
		var tab = obj.find(defaults['tab']);
		var tabcur = defaults['tabcur'];

		var tabIndex = 0;
		var tabLength = tab.length;	
		var turnLeft = function(){
			if(!absolute_obj.is(":animated")){
				if(type==1){
					var current = parseInt(absolute_obj.css("left"));
					var last = absolute_obj.width()-(absolute_obj.width()%(item_obj.outerWidth(true)*slidenum));
					if(slidenum==1 && loop) last = absolute_obj.width() - item_obj.outerWidth(true)*slidenum;
					if(current!=0){
						absolute_obj.animate({left:'+='+item_obj.outerWidth(true)*slidenum});
					}else if(current==0 && loop){
						absolute_obj.animate({left:-last});
					}
				}else if(type==2){
					var current = parseInt(absolute_obj.css("top"));
					var last = absolute_obj.height()-(absolute_obj.height()%(item_obj.outerHeight(true)*slidenum));
					if(slidenum==1 && loop) last = absolute_obj.height() - item_obj.outerHeight(true)*slidenum;
					if(current!=0){
						absolute_obj.animate({top:'+='+item_obj.outerHeight(true)*slidenum});
					}else if(current==0 && loop){
						absolute_obj.animate({top:-last});
					}
				}
			}
			if(tab.length){
				tabIndex = --tabIndex<0?tabLength-1:tabIndex;
				tab.eq(tabIndex).addClass(tabcur).siblings().removeClass(tabcur);
			}
		}
		var turnRight = function(){
			if(!absolute_obj.is(":animated")){
				if(type==1){
					var current = parseInt(absolute_obj.css("left"))-(slidenum==1?item_obj.outerWidth(true)*seenum:item_obj.outerWidth(true)*slidenum);
					var last = absolute_obj.width()-item_obj.outerWidth(true);
					if(current>=-last){
						absolute_obj.animate({left:'-='+item_obj.outerWidth(true)*slidenum});
					}else{
						if(loop || auto){
							absolute_obj.animate({left:0});
						}	
					}
				}else if(type==2){
					var current = parseInt(absolute_obj.css("top"))-(slidenum==1?item_obj.outerHeight(true)*seenum:item_obj.outerHeight(true)*slidenum);
					var last = absolute_obj.height()-item_obj.outerHeight(true);
					if(current>=-last){
						absolute_obj.animate({top:'-='+item_obj.outerHeight(true)*slidenum});
					}else{
						if(loop){
							absolute_obj.animate({top:0});
						}	
					}
				}
			}
			if(tab.length){
				tabIndex = ++tabIndex<tabLength?tabIndex:0;
				tab.eq(tabIndex).addClass(tabcur).siblings().removeClass(tabcur);
			}
		}
		
		if(type==1){
			relative_obj.css({
				width:item_obj.outerWidth(true)*seenum-parseInt(item_obj.css('margin-left'))-parseInt(item_obj.css('margin-right')),
				height:item_obj.outerHeight(true),
				'overflow':'hidden',
				position:"relative",
				margin:"auto"	
			});
			absolute_obj.css({
				width:item_obj.outerWidth(true)*item_obj.length,
				height:item_obj.outerHeight(true),
				position:"absolute",
				left:0,
				top:0	
			});
		}else if(type==2){
			relative_obj.css({
				width:item_obj.outerWidth(true),
				height:item_obj.outerHeight(true)*seenum-parseInt(item_obj.css('margin-top'))-parseInt(item_obj.css('margin-bottom')),
				'overflow':'hidden',
				position:"relative",
				margin:"auto"
			});
			absolute_obj.css({
				width:item_obj.outerWidth(true),
				height:item_obj.outerHeight(true)*item_obj.length,
				position:"absolute",
				left:0,
				top:0	
			});
		}
		if(auto){
			var func = setInterval(function(){turnRight();},autotime);
			item_obj.hover(
				function(){
					clearInterval(func);	
				},
				function(){
					func = setInterval(function(){turnRight();},autotime);
				}
			);
		}
		tab.click(function(){
			tabIndex = $(this).index();
			absolute_obj.animate({left:-item_obj.outerWidth(true)*seenum*tabIndex});
			$(this).addClass(tabcur).siblings().removeClass(tabcur);
		});
		leftbtn.click(function(){
			turnLeft();
		});
		rightbtn.click(function(){
			turnRight();
		});
	},
}