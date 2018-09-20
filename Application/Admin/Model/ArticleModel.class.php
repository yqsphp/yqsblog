<?php
namespace Admin\Model;
use Think\Model;
use Think\Page;
use Admin\Common\Log;
class ArticleModel extends Model{
	
   /**
    * 文章数据分页显示
    * @param int $status 文章状态默认为空,这是非草稿状态  0 未发布,1 已发布,2 草稿, 3 撤回
    * @param array $get 查询条件
    * @return multitype:二维array
    */
    public function info($status='',$get=[]){
    	$p       = isset($_GET['p']) ? $_GET['p'] : 0;
    	//$cache   = S('artinfo_'.$p.'_'.$status);
    	$article = C('DB_PREFIX').'article.';
    	//if($cache && $status != 2 && $status != 3 && empty($get)){  //判断缓存是否存在。存在直接读取缓存
    	//	return $cache;
    	//}
        if($status == 2){//文章草稿状态 2 和撤回状态3
            $where  = "(".$article."status=2 or ".$article."status=3) and ".$article."isdel=0 ";
            $order  = "";
            //搜索类别
        }else{//文章发布状态 0 未发布,1 已发布
            $where  = "(".$article."status=0 or ".$article."status=1) and ".$article."isdel=0 ";
            $order  = $article."status,";
        }
        //判断搜索条件存在状态时
        if(!empty($get['status'])){
        	$where  = $article."isdel=0 ";
        }
        if(session('user_info.user_id')!=1){
        	$where .= ' and '.$article.'editorid='.session('user_info.user_id');
        }
        //搜索条件
        $parameter = I('get.');
        if(!empty($get)){
        	foreach($get as $key => $val){
        		if(strlen($val)){
        			if($key == 'name'){
        				$where.=' and '.$article.$key.' like "%'.$val.'%"';
        			}else{
        				if($key == 'portshow'){
        					if($val == '电脑端') $where  .= ' and '.$article.'pc = 1';
        					if($val == '移动端') $where  .= ' and '.$article.'mobile = 1';
        					if($val == '微信端') $where  .= ' and '.$article.'weixin = 1';
        					if($val == 'APP端') $where  .= ' and '.$article.'app = 1';
        					if($val == '小程序端') $where .= ' and '.$article.'wshort = 1';
        				}elseif($key == 'porttype'){
        					if($val == '置顶') $where   .= ' and '.$article.'settop = 1';
        					if($val == '推荐') $where   .= ' and '.$article.'recommend = 1';
        				}else{
	        				$where .= ' and '.$article.$key.'='.$val;
        				}
        			}
        		}
        	}
        }
        $count = $this->where($where)->count();
        $page  = new Page($count,10,$parameter);
        $info  = $this->field($article.'*,cat.name as cname')->where($where)->join(C('DB_PREFIX').'category cat on '.$article.'catid=cat.id','left')
        	->order($order.'ptime desc')->limit(mypage($page))->select();
        //查询所属类别名称
        $cat   = D('Category')->where('isdel = 0')->select();
        $pager = $page->show();
        if($p == 0) $p = 1;
        //S('artinfo_'.$p.'_'.$status,array('page'=>$pager,'info'=>$info,'cat'=>$cat),1800);
        return array('info'=>$info,'page'=>$pager,'cat'=>$cat);
    }
    /**
     * 文章添加与编辑
     * @param 数据添加请求的信息 $post
     * @param 文章id值 $id
     * @param 栏目图片上传 $fileup
     * @return Ambigous <mixed, boolean, NULL, string, unknown, multitype:, object>
     */
    public function artedit($id = '',$post = '',$fileup = ''){
        if($post != ''){
            if($fileup['error'] != 4){
                $imgpath 	   = fileuploadOne($fileup);
                $post['image'] = $imgpath;
            }
            $post['status'] 	= 2;
            $post['ctime']  	= date('Y-m-d');
            if(!$post['ptime']){
                $post['ptime'] 	= date('Y-m-d');
            }
            if(!$post['copyfrom']){
                $post['copyfrom'] = '本站原创';
            }
            //点击量不填默认随机0-100
            if(!$post['hits']){
            	$post['hits'] = rand(0,100);
            }
            $post['pc']		   = isset($post['pc']) ? $post['pc'] : 0;
            $post['weixin']	   = isset($post['weixin']) ? $post['weixin'] : 0;
            $post['mobile']	   = isset($post['mobile']) ? $post['mobile'] : 0;
            $post['app']	   = isset($post['app']) ? $post['app'] : 0;
            $post['wshort']	   = isset($post['wshort']) ? $post['wshort'] : 0;
            $post['isshow']	   = isset($post['isshow']) ? $post['isshow'] : 0;
            $post['settop']	   = isset($post['settop']) ? $post['settop'] : 0;
            $post['recommend'] = isset($post['recommend']) ? $post['recommend'] : 0;
        	$post['content']   = htmlspecialchars_decode($post['content']);
        }
        if($id == ''){//添加文章
            if($this->create($post)){
            	//dump($this->create($post));die;
            	$id = $this->add();
                if($id){
                	//添加成功后写入日志
                	Log::write('article',$id,1);
                	//更新附件表
                	if($post['attachid']){
	                	$attach = D('attachment')->where('id in ('.$post['attachid'].')')->save(['aid'=>$id,'atable'=>'article']);
                	}
                    return $id;
                }else{
                    return false;
                }
            }
        }else{//编辑文章
            if($post == ''){
               	$info = $this->find($id);
            	//查询附件
            	$attach 		= D('attachment')->where('atable="article" and aid = '.$id)->select();
            	$info['attach'] = $attach;
            	return $info;
            }else{
        		unset($post['status']);//修改时状态不变
        		//更新附件表
        		if($post['attachid']){
        			$attach 	   = D('attachment')->where('id in ('.$post['attachid'].')')->save(['aid'=>$post['id'],'atable'=>'article']);
        		}
        		$post['utime']     = date('Y-m-d');
        		$logid 			   = Log::update('article', $post['id'], 2);
        		$res 			   = $this->save($post);
        		Log::write('article',$post['id'],2,$logid);
                return $res;
            }
        }
    }
    /**
     * 文章发布
     * @param int $status 请求状态: 0 撤回编辑 ,1发布 , 2 取消发布
     * @param int|array $id 文章id
     * @return multitype:int
     */
    public function artpublish($status,$id){
        if(is_array($id)){
             $ids   = implode(',', $id);
             $where = 'id in('.$ids.')';
        }else{
        	 $where = 'id='.$id;
        }
        switch ($status){
        	case 0: $up = ['status'=>0]; break;
        	case 1: $up = ['status'=>1]; break;
        	case 2: $up = ['status'=>2]; break;
        	case 3: $up = ['status'=>3]; break;
        	default: break;
        }
        $res = $this->where($where)->save($up);
        Log::write('article', $id, 2);
        return $res;
    }
    /**
     * 文章删除
     * @param int $id
     * @return Ambigous <mixed, boolean>
     */
    public function artdel($id){
        $ids = $id;
        if(is_array($id)){
            $id  = implode(',', $id);
        }
        $res = $this->where('id in('.$id.')')->save(['isdel'=>1]);
        Log::write('article', $ids, 3);
        
        if($res !== false){
	        return recover_delete('article', '文章表', $ids);
        }
    }
    /*--------------------------------------文章类别区--------------------------------------------------*/
    /**
     * 文章类别
     * @return multitype:二维array
     */
    public function cate(){
        $cat  = D('Category');
        //使用树形结构
        $info = $cat->where('isdel=0')->order('id')->select();
        return $info;
        /* $count=$cat->where('isdel=0')->count();
        $page=new Page($count,10);
        $info=$cat->where('isdel=0')->order('id')->limit(mypage($page))->select();
        S('catinfo',array('page'.$_GET['p']=>$page->show(),'info'.$_GET['p']=>$info));
        return array('info'=>$info,'page'=>$page->show()); */
    }
    /**
     * 文章类别添加与修改
     * @param int $status 1.添加类别，2.编辑类别
     * @param string $id 类别id
     * @param array|string $post
     * @return multitype:array|boolean
     */
    public function catedit($status,$post='',$id=''){
        $cat = D('Category');
        if($post == ''){//数据显示
            $parent = $cat->where('isdel=0 and pid=0')->select();
            if($status == 2){
                $child = $cat->where('isdel=0 and pid<>0 and mobile <> 0 and pc <> 0')->select();
                $info  = $cat->find($id);
            }
            return array('parent'=>$parent,'child'=>$child,'info'=>$info);
        }else{
        	$post['pc']     = isset($post['pc']) ? 1  : 0;
        	$post['mobile'] = isset($post['mobile']) ? 1  : 0;
            if($status == 1){//添加数据
                if($cat->create($post)){
                    $catid = $cat->add($post);
                    //写入日志
                    Log::write('category', $catid, 1);
                    return $catid;
                }
            }else{
                $logid = Log::update('category', $post['id'], 2);
            	$res   = $cat->save($post);
                Log::write('category', $post['id'], 2, $logid);
                return $res;
            }

        }
    }
    /**
     * 文章类别删除
     * @param int $id
     * @return Ambigous <mixed, boolean, unknown>
     */
    public function catdel($id) {
        $cat = D('Category');
        if($id){
            //$res = $cat->delete($id);
            $res = $cat->save(['id'=>$id,'isdel'=>1]);
            Log::write('category', $id, 3);
            return $res;
        }
    }
}