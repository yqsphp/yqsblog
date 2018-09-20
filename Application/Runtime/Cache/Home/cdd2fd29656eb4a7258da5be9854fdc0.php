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
		<!-- content srart -->
<div class="am-g am-g-fixed blog-fixed blog-content">
  <figure data-am-widget="figure" class="am am-figure am-figure-default "   data-am-figure="{  pureview: 'true' }">
      <div id="container">          
          <div><img src="/Public/assets/images/01.jpg"><h3>Agfa</h3></div>
          <div><img src="/Public/assets/images/02.jpg"><h3>Auto</h3></div>
          <div><img src="/Public/assets/images/03.jpg"><h3>Bald eagle</h3></div>
          <div><img src="/Public/assets/images/04.jpg"><h3>Black swan</h3></div>
          <div><img src="/Public/assets/images/05.jpg"><h3>Book shelf</h3></div>
          <div><img src="/Public/assets/images/06.jpg"><h3>Camera</h3></div>
          <div><img src="/Public/assets/images/07.jpg"><h3>Camera</h3></div>
          <div><img src="/Public/assets/images/25.jpg"><h3>Vintage camera</h3></div>
          <div><img src="/Public/assets/images/09.jpg"><h3>Coffee</h3></div>
          <div><img src="/Public/assets/images/10.jpg"><h3>Cookies</h3></div>
          <div><img src="/Public/assets/images/11.jpg"><h3>Cubes</h3></div>
          <div><img src="/Public/assets/images/12.jpg"><h3>DJ</h3></div>
          <div><img src="/Public/assets/images/13.jpg"><h3>Doors</h3></div>
          <div><img src="/Public/assets/images/14.jpg"><h3>Matchbox</h3></div>
          <div><img src="/Public/assets/images/15.jpg"><h3>Freiburg</h3></div>
          <div><img src="/Public/assets/images/16.jpg"><h3>Henna</h3></div>
          <div><img src="/Public/assets/images/17.jpg"><h3>Home office</h3></div>
          <div><img src="/Public/assets/images/18.jpg"><h3>iPad</h3></div>
          <div><img src="/Public/assets/images/19.jpg"><h3>Keyboard</h3></div>
          <div><img src="/Public/assets/images/20.jpg"><h3>Lynx</h3></div>
          <div><img src="/Public/assets/images/21.jpg"><h3>Mac</h3></div>
          <div><img src="/Public/assets/images/22.jpg"><h3>Notebook</h3></div>
          <div><img src="/Public/assets/images/23.jpg"><h3>Thoughts</h3></div>
          <div><img src="/Public/assets/images/24.jpg"><h3>Office</h3></div>
          <div><img src="/Public/assets/images/25.jpg"><h3>Children</h3></div>
          <div><img src="/Public/assets/images/26.jpg"><h3>Portrait</h3></div>
          <div><img src="/Public/assets/images/27.jpg"><h3>Startup</h3></div>
          <div><img src="/Public/assets/images/28.jpg"><h3>Sun</h3></div>
          <div><img src="/Public/assets/images/29.jpg"><h3>The Eiffel Tower</h3></div>
          <div><img src="/Public/assets/images/30.jpg"><h3>Water drops</h3></div>
          
    </div> 
  </figure>

</div>
<!-- content end -->
<script src="/Public/assets/js/pinto.min.js"></script>
<script src="/Public/assets/js/img.js"></script>

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