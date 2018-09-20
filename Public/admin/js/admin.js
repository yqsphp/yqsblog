$(function(){
	$(".comlun h2").click(function(){
		$(this).parent().siblings('.comlun').children('.child').slideUp(400);
		//$(this).next().slideToggle(200);	
		$(this).siblings('.child').slideDown(400);
		$(this).addClass("on").parent().siblings('.comlun').children("h2").removeClass("on"); 
	})
	$(".comlun ul li a").click(function(){
		var that = $(this);
		var id	 = that.attr("id");
		$("#a_leader_txt").text(that.text());
		$(".comlun ul li a").removeClass("on");
		that.addClass("on");
		$(".navigate li").removeClass("active");
		var flag = true;
		$(".navigate li").each(function(i,o){
			if($(o).attr("id") == id){
				$(o).addClass("active").siblings().removeClass("active");
				flag = false;
			}
		});
		if(flag){
			var li = ' <li id="'+that.attr("id")+'" class="active"><a href="'+that.attr('href')+'" target="right">'+that.text()+'</a> <span class="nav-close icon-trash-o"></span></li>';
			$(".navigate").append(li);
		}
	});
	$(".comlun .child").eq(0).show();
	$(".comlun h2").eq(0).addClass("on");
	
	$(".navigate").on("click","li",function(){
		var href = $(this).children("a").attr("href");
		$(this).addClass("active").siblings().removeClass("active");
		console.log(href);
	});
	$(".navigate").on("click",".nav-close",function(){
		$(this).parent().remove();
		return;
	});
});
function hrefurl(url){
	return location.href=url;
}