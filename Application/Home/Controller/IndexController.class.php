<?php
namespace Home\Controller;
use Home\Common\BaseController;
use Org\Nx\Page;
class IndexController extends BaseController{
	private static $article;
	private static $category;
	private static $where;
	protected function _initialize(){
		parent::_initialize();
		self::$article  = M('article');
		self::$category = M('category');
		self::$where 	= [
			'isdel' => 0,
			'status' => 1,
		];
	}
	/**
	 * 首页
	 */
    public function index(){
    	$this->comment();
    	$this->display();
    }
    public function index1(){
    	$this->display();
    }
    public function index2(){
    	$this->display();
    }
    public function index3(){
    	$this->display();
    }
    public function article1(){
    	$this->display();
    }
    /**
     * 文章详情
     */
    public function article(){
    	$where 	= self::$where;
    	//浏览次数+1
    	self::$article->where('id = '.self::$get['id'])->setInc('hits');
    	//查询当前文章
    	$info = self::$article->find(self::$get['id']);
    	//上一篇
    	$where['id'] = ['LT',self::$get['id']];
    	$pre  = self::$article->field('catid,id,name')->where($where)->order('id desc')->find();
    	//下一篇
    	$where['id'] = ['GT',self::$get['id']];
    	$next = self::$article->field('catid,id,name')->where($where)->order('id')->find();
    	$this->comment();
    	$data = [
    		'pre' 	=> $pre,
    		'next'	=> $next,
    		'info'	=> $info,
    	];
    	$this->assign($data);
    	$this->display();
    }
    /**
     * 文章分类列表
     */
    public function category(){
    	$cache = S('cate') ? S('cate') : [];
    	foreach ($cache as $val){
    		if($val['pid'] == self::$get['cid']){
    			$method .= $val['id'].',';
    		}
    	}
    	$method = trim($method, ',');
    	$method = $method == '' ? ['pid'=>self::$get['cid']] : ['pid'=>$method];
    	$this->comment($method);
    	$this->display();
    }
    /**
     * 查询
     */
    public function search(){
    	$method = $method == '' ? ['keywords'=>self::$get['keywords']] : ['keywords'=>''];
    	$this->comment($method);
    	$this->display('category');
    }
    /**
     * 图片欣赏
     */
    public function img(){
    	$this->display();
    }
    /**
     * 存档
     */
    public function timeline(){
    	$line  = self::$article->field('id,name,ptime,editor,catid,date_format(ptime,"%Y%m") time')->order('ptime desc')->select();
    	//按月份分类
    	$doc   = [];
    	$cache = S('cate') ? S('cate') : [];
    	foreach ($line as $val){
    		foreach($cache as $v){
    			if($v['id'] == $val['catid']){
    				$val['catename'] = $v['name'];
    			}
    		}
    		$doc[$val['time']][] = $val;
    	}
    	//dump($doc);
    	$this->assign('doc',$doc);
    	$this->display();
    }
    /**
     * 文章列表，类别，阅读排行
     * @param mixed $method 额外条件
     */
    private function comment($method = null){
    	$where = self::$where;
    	if(is_array($method)){
    		if(isset($method['pid']))
    			$where['catid'] = ['in',$method['pid']];
    		elseif(isset($method['keywords']))
    			$where['name'] = ['like','"%'.$method['keywords'].'%"'];
    	}elseif(is_string($method)){
    		
    	}
    	$count = self::$article->where($where)->count();
    	$page  = new Page($count,10,$where);
    	$list  = self::$article->where($where)->order('ptime desc')->limit(mypageone($page))->select();
    	//类别
    	$cate  = self::$category->cache('cate', 7200)->where('isdel = 0')->select();
    	foreach($list as &$art){
    		foreach($cate as $vo){
    			if($art['catid'] == $vo['id']){
    				$art['catname'] = $vo['name'];
    			}
    		}
    	}
    	//阅读排行
    	$order  = self::$article->where(self::$where)->order('hits desc')->limit(10)->select();
    	//置顶推荐
    	$where1 = self::$where;
    	$where1['_string'] = 'recommend = 1 or settop = 1';
    	$settop = self::$article->where($where1)->order('ptime desc')->limit(10)->select(); 
    	$data  = [
    		'list'	=> $list,
    		'cate'	=> $cate,
    		'page'	=> $page->show(),
    		'order'	=> $order,
    		'settop'=> $settop,
    	];
    	$this->assign($data);
    }
    
    public function test(){
    	$this->display();
    }
    
    
}