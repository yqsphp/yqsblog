<?php if (!defined('THINK_PATH')) exit();?><!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="description" content="<?php echo C('description');?>">
		<meta name="keywords" content="<?php echo C('keywords');?>">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
		<title><?php echo C( 'webtitle');?></title>
		<meta name="renderer" content="webkit">
		<meta http-equiv="Cache-Control" content="no-siteapp" />
		<meta name="mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-capable" content="yes">
		<meta name="apple-mobile-web-app-status-bar-style" content="black">
		<meta name="apple-mobile-web-app-title" content="<?php echo C('webtitle');?>" />
		<meta name="msapplication-TileColor" content="#0e90d2">

		<link rel="stylesheet" type="text/css" href="/Public/assets/css/amazeui.min.css" />
		<link rel="stylesheet" type="text/css" href="/Public/css/page.css" />
		<link rel="stylesheet" type="text/css" href="/Public/assets/css/app.css" />
		<!--[if (gte IE 9)|!(IE)]><!-->
		<script src="/Public/assets/js/jquery.min.js"></script>
		<!--<![endif]-->
		<!--[if lte IE 8 ]>
		<script src="http://libs.baidu.com/jquery/1.11.3/jquery.min.js"></script>
		<script src="http://cdn.staticfile.org/modernizr/2.8.3/modernizr.js"></script>
		<script src="/Public/assets/js/amazeui.ie8polyfill.min.js"></script>
		<![endif]-->
		<script src="/Public/assets/js/amazeui.min.js"></script>
	</head>
	<body id="blog">
		<header class="am-g am-g-fixed blog-fixed blog-text-center blog-header">
			<div class="am-u-sm-8 am-u-sm-centered">
				<h2 class="am-hide-sm-only"><?php echo C( 'webtitle');?></h2>
			</div>
		</header>
		<hr>
		<!-- nav start -->
		<nav class="am-g am-g-fixed blog-fixed blog-nav">
			<button class="am-topbar-btn am-topbar-toggle am-btn am-btn-sm am-btn-success am-show-sm-only blog-button" data-am-collapse="{target: '#blog-collapse'}"><span class="am-sr-only">导航切换</span> <span class="am-icon-bars"></span></button>
			<div class="am-collapse am-topbar-collapse" id="blog-collapse">
				<ul class="am-nav am-nav-pills am-topbar-nav">
					<li class="<?php if(($index) == "0"): ?>am-active<?php endif; ?>">
						<a style="cursor: pointer" href="/">主页</a>
					</li>
					<!--<li class="am-dropdown <?php if(($index) == "1"): ?>am-active<?php endif; ?>" data-am-dropdown>
						<a class="am-dropdown-toggle" data-am-dropdown-toggle href="javascript:;">
							首页布局 <span class="am-icon-caret-down"></span>
						</a>
						<ul class="am-dropdown-content">
							<li>
								<a href="<?php echo U('index/i/1');?>">1. blog-index-standard</a>
							</li>
							<li>
								<a href="<?php echo U('index1/i/1');?>">2. blog-index-nosidebar</a>
							</li>
							<li>
								<a href="<?php echo U('index2/i/1');?>">3. blog-index-layout</a>
							</li>
							<li>
								<a href="<?php echo U('index3/i/1');?>">4. blog-index-noslider</a>
							</li>
						</ul>
					</li>-->
					<li class="<?php if(($index) == "1"): ?>am-active<?php endif; ?>">
						<a href="<?php echo U('category/i/1');?>">文章</a>
					</li>
					<li class="<?php if(($index) == "2"): ?>am-active<?php endif; ?>">
						<a href="<?php echo U('img/i/2');?>">精美图库</a>
					</li>
					<!--<li class="<?php if(($index) == "3"): ?>am-active<?php endif; ?>">
						<a href="<?php echo U('article/i/3');?>">二次元</a>
					</li>-->
					<li class="<?php if(($index) == "4"): ?>am-active<?php endif; ?>">
						<a href="<?php echo U('timeline/i/4');?>">存档</a>
					</li>
				</ul>
				<form id="search" class="am-topbar-form am-topbar-right am-form-inline" action="/search.html" method="get" data-am-validator>
					<div class="am-form-group am-input-group">
						<input type="text" class="am-form-field am-input-sm" name="keywords" placeholder="搜索" required>
						<span class="am-input-group-label" onclick="$('#search').submit()"><i class="am-icon-search"></i></span>
					</div>
				</form>
			</div>
		</nav>
		<hr>
		<!-- nav end -->
		<!-- banner start -->
<div class="am-g am-g-fixed blog-fixed am-u-sm-centered blog-article-margin">
	<div data-am-widget="slider" class="am-slider am-slider-b1" data-am-slider='{&quot;controlNav&quot;:false}'>
		<ul class="am-slides">
			<li>
				<img src="/Public/assets/i/b2.jpg">
				<div class="am-slider-desc blog-slider-desc">
					<div class="blog-text-center blog-slider-con">
						<span><a href="" class="blog-color">Article &nbsp;</a></span>
						<h1 class="blog-h-margin"><a href="">总在思考一句积极的话</a></h1>
						<p>那时候刚好下着雨，柏油路面湿冷冷的，还闪烁着青、黄、红颜色的灯火。
						</p>
						<span>2015/10/9</span>
					</div>
				</div>
			</li>
			<li>
				<img src="/Public/assets/i/b3.jpg">
				<div class="am-slider-desc blog-slider-desc">
					<div class="blog-text-center blog-slider-con">
						<span><a href="" class="blog-color">Article &nbsp;</a></span>
						<h1 class="blog-h-margin"><a href="">天气决定心情</a></h1>
						<p>一个好的天气给人的感觉就是神清气爽，阴云密布人的心情总是很差
						</p>
						<span>2015/10/9</span>
					</div>
				</div>
			</li>
			<li>
				<img src="/Public/assets/i/b2.jpg">
				<div class="am-slider-desc blog-slider-desc">
					<div class="blog-text-center blog-slider-con">
						<span><a href="" class="blog-color">Article &nbsp;</a></span>
						<h1 class="blog-h-margin"><a href="">总在思考一句积极的话</a></h1>
						<p>那时候刚好下着雨，柏油路面湿冷冷的，还闪烁着青、黄、红颜色的灯火。
						</p>
						<span>2015/10/9</span>
					</div>
				</div>
			</li>
		</ul>
	</div>
</div>
<!-- banner end -->
<!-- content srart -->
<div class="am-g am-g-fixed blog-fixed">
	<div class="am-u-md-8 am-u-sm-12">
		<?php if(empty($list)): ?>凉菜了
<?php else: ?>
<?php if(is_array($list)): $i = 0; $__LIST__ = $list;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><article class="am-g blog-entry-article">
	<div class="am-u-lg-6 am-u-md-12 am-u-sm-12 blog-entry-img">
		<?php if($v['image']): ?><img src="/Public/<?php echo ($v["image"]); ?>" class="am-u-sm-12">
		<?php else: ?>
		<img src="<?php echo C('DEFAULT_IMG');?>" class="am-u-sm-12"><?php endif; ?>
	</div>
	<div class="am-u-lg-6 am-u-md-12 am-u-sm-12 blog-entry-text">
		<div>
			<a class="blog-color"><?php echo ($v["catname"]); ?> &nbsp;</a>
			<?php echo ($v["editor"]); ?> &nbsp;<?php echo ($v["ptime"]); ?>
		</div>
		<h2 class="blog-line-clamp-1"><a href="<?php echo getArticleUrl($v['catid'],$v['id'],2);?>" title="<?php echo ($v["name"]); ?>"><?php echo ($v["name"]); ?></a></h2>
		<p class="blog-line-clamp-5"><?php echo ($v["description"]); ?></p>
	</div>
</article><?php endforeach; endif; else: echo "" ;endif; ?>
<div class="pagelist">
	<?php echo ($page); ?>
</div><?php endif; ?>
	</div>
	<div class="am-u-md-4 am-u-sm-12 blog-sidebar">
	<div class="blog-sidebar-widget blog-bor am-text-center">
		<h2 class="blog-title"><span>About ME</span></h2>
		<img src="/Public/image/user.jpg" alt="about me" class="blog-entry-img">
		<p><?php echo C( 'webtitle');?></p>
		<p>先感谢各位浏览我的博客，不足地方请多多谅解或者将您发现的问题通过右侧的邮箱联系我，感谢各位对我的支持
		我是一个开发人员，相对的这个网站就是一个技术型的博客网站，将我个人的心得、随笔、相关技术文章、转载一些其他的技术文章发布在这个网站上
		<span class="am-text-warning">如果有需要做网站包括小程序的可以通过邮箱或微信联系我</span>
		</p>
	</div>
	<div class="blog-sidebar-widget blog-bor">
		<h2 class="am-text-center blog-title"><span>Contact ME</span></h2>
		<p>我的邮箱：yqsphp@qq.com</p>
		<p>我的微信：yaoqishan173</p>
	</div>
	<div class="blog-clear-margin blog-sidebar-widget blog-bor am-g">
		<h2 class="am-text-center blog-title"><span>TAG cloud</span></h2>
		<div class="am-u-sm-12 blog-clear-padding">
			<?php if(is_array($cate)): $i = 0; $__LIST__ = $cate;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><a href="<?php echo U('list/'.$v['id']);?>" class="blog-tag"><?php echo ($v["name"]); ?></a><?php endforeach; endif; else: echo "" ;endif; ?>
		</div>
	</div>
	<div class="blog-sidebar-widget blog-bor">
		<h2 class="am-text-center blog-title"><span>置顶推荐</span></h2>
		<ul class="am-list">
			<?php if(is_array($settop)): $i = 0; $__LIST__ = $settop;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><li>
				<div class="am-padding-top-xs am-padding-bottom-xs blog-line-clamp-1"><a href="<?php echo getArticleUrl($v['catid'],$v['id'],2);?>"><?php echo ($v["name"]); ?></a></div>
			</li><?php endforeach; endif; else: echo "" ;endif; ?>
		</ul>
	</div>
	<div class="blog-sidebar-widget blog-bor">
		<h2 class="am-text-center blog-title"><span>阅读排行</span></h2>
		<ul class="am-list">
			<?php if(is_array($order)): $i = 0; $__LIST__ = $order;if( count($__LIST__)==0 ) : echo "" ;else: foreach($__LIST__ as $key=>$v): $mod = ($i % 2 );++$i;?><li>
				<div class="am-padding-top-xs am-padding-bottom-xs blog-line-clamp-1"><a href="<?php echo getArticleUrl($v['catid'],$v['id'],2);?>"><?php echo ($v["name"]); ?></a></div>
			</li><?php endforeach; endif; else: echo "" ;endif; ?>
		</ul>
	</div>
</div>
</div>
<!-- content end -->
		<!-- footer -->
		<footer class="blog-footer">
			<div class="am-g am-g-fixed blog-fixed am-u-sm-centered">
				<div class="am-u-sm-12 am-u-md-4 am-u-lg-4">
					<h3>关于网站</h3>
					<p class="am-text-sm">这是一个使用amazeUI做的博客类前端页面。 支持响应式，多种布局，包括主页、文章页、媒体页、分类页等<br>嗯嗯嗯，不知道说啥了。外面的世界真精彩<br>
					 Amaze UI 使用 MIT 许可证发布，用户可以自由使用、复制、修改、合并、出版发行、散布、再授权及贩售 Amaze UI 及其副本。</p>
				</div>
				<div class="am-u-sm-6 am-u-md-4 am-u-lg-4">
					<h3>联系方式</h3>
					<p>
						QQ：<?php echo C('QQ');?><br />
						email:<?php echo C('email');?>
					</p>
				</div>
				<div class="am-u-sm-6 am-u-md-4 am-u-lg-4">
					<h3>友情链接</h3>
					<p>
						<ul>
							<li><a href="http://jquery.com/">jQuery</a></li>
							<li><a href="http://amazeui.org/">Amaze UI</a></li>
						</ul>
					</p>
				</div>
			</div>
			<div class="blog-text-center"><?php echo C('WEBSITE');?></div>
		</footer>
	</body>
</html>