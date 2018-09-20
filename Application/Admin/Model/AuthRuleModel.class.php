<?php
namespace Admin\Model;
use Think\Model;
use Admin\Common\Tree;
use Admin\Common\Log;
/**
 * 权限控制模型类
 * @author yqs
 */
class AuthRuleModel extends Model{
	private static $admin;
	private static $group;
	private static $access;
	private static $auth;
    public function _initialize(){
        self::$admin  = D('Admin');
        self::$group  = D('AuthGroup');
        self::$access = D('AuthAccess');
        self::$auth   = $this;
    }
    /**
     * 权限列表
     * @return multitype:array
     */
    public static function rule_list(){
        $data = self::$auth->where('isdel = 0')->select();
        $tree = Tree::tree($data,'title');
        //$tree=self::$auth->tree($data);
        return $tree;
    }
    /**
     * 权限添加与编辑
     * @param array $post 数据
     * @param string $type 类型 1.添加  2.编辑
     * @return Ambigous <mixed, boolean, unknown, string>|boolean
     */
    public static function rule_edit($post,$type = 1){
        //判断是否启用权限
        if(isset($post['status'])){
            $post['status'] = 1;
        }else{
            $post['status'] = 0;
        }
        //如果pid为空，则设置为顶级栏目
        if(empty($post['pid'])) $post['pid'] = 0;
        unset($post['type']);
        if($type == 1){//添加
            unset($post['id']);
            if(self::$auth->create($post)){
                $id = self::$auth->add($post);
                Log::write('auth_rule', $id, 1);
                return $id;
            }
        }else{//编辑
        	//如果是顶级菜单停用， 那么旗下的所有次级菜单都要停用
        	$childid = self::$auth->field('id')->where('pid = '.$post['id'])->select();
        	if(count($childid) > 0){
        		foreach ($childid as $val){
        			Log::update('auth_rule', $val['id'], 2);
        			$id .= $val['id'].',';
        		}
        		$id = rtrim($id,',');
        		self::$auth->where('id in('.$id.')')->save(['status' => $post['status']]);
        		foreach ($childid as $val){
        			Log::write('auth_rule', $val['id'], 2);
        		}
        	}
        	Log::update('auth_rule', $post['id'], 2);
            return self::$auth->save($post);
            Log::write('auth_rule', $post['id'], 2);
        }
    }
    /**
     * 权限删除
     * @param string $id
     * @return Ambigous <mixed, boolean>
     */
    public static function rule_del($id){
        if(empty($id)) return false;
        Log::write('auth_rule', $id, 3);
        return self::$auth->delete($id);
    }
    /**
     * 分配权限
     * @param string $post 数据 默认为空
     * @param string $id 用户组id
     * @return mixed, boolean,array
     */
    public static function rule_group($post = '',$id = ''){
        if(empty($post)){
            //显示已存在的权限
            if($id != '') $ids = self::$group->find($id);
            $data = self::$auth->select();
            return ['tree' => Tree::tree($data,'title'),'ids' => $ids];
        }else{
            //权限id以 ','分隔开
            if(isset($post['rules'])) $post['rules'] = implode(',', $post['rules']);
            return self::$group->save($post);
        }
    }
    /**
     * 管理员列表
     * @param int $groupid 组id
     * @return array|boolean
     */
    public static function admin_list($groupid=''){
    	if(empty($groupid)){
    		$admin = self::$admin->select();
    		$group = self::$group;
    		foreach($admin as &$val){
    			$info = $group->field('title')->where('id in ('.$val['groupid'].') and status = 1')->select();
    			foreach($info as $g){
    				$val['title'] .= $g['title'].',';
    			}
    			$val['title'] = trim($val['title'],',');
    		}
    		return $admin;
    	}else{
    		$res = self::$admin->field(C('DB_PREFIX').'admin.*,g.title')
    			->join(C('DB_PREFIX').'auth_group as g on g.id in('.C('DB_PREFIX').'admin.groupid)','left')
    			->where('find_in_set('.$groupid.','.C('DB_PREFIX').'admin.groupid)')->select();
    		return $res;
    	}
    }
    /**
     * 管理员编辑与添加
     * @param array $post 数据
     * @param int $type 1.添加，2.编辑
     * @param int $id 管理员id
     * @return Ambigous <mixed, boolean, unknown, string>|boolean
     */
    public static function admin_edit($post,$type,$id = ''){
        $post['status']  = isset($post['status']) ? 1 : 0;
        $post['pass']    = md5(base64_encode($post['pass']));
        $groupid		 = $post['groupid'];
        if(is_array($groupid))
        	$post['groupid'] = implode(',', $groupid);
        
        if($type == 1){
        	//判断当前添加的用户是否存在
        	$current = self::$admin->getByName($post['name']);
        	if($current) return false;
            if(self::$admin->create($post)){
            	$id = self::$admin->add();
                Log::write('admin', $id, 1);
                
                if(is_array($groupid)){
	                //操作表auth_access ,用户属于多组成员
	                $access = [];
	                foreach ($groupid as $gid){
	                	array_push($access,['uid' => $id,'group_id' => $gid]);
	                }	                
	                $id = self::$access->addAll($access);
                }else{
                	self::$access->add(['uid'=>$id,'group_id'=>$groupid]);
                }
                return $id;
            }
        }else{
            if($id != ''){
            	unset($post['pass']);
                $post['id'] = $id;
                Log::update('admin', $id, 2);
                $res = self::$admin->save($post);
                Log::write('admin', $id, 2);
                return $res;
            }else{
                return false;
            }
        }
    }
    /**
     * 管理员删除
     * @param int $id 管理员id
     * @return Ambigous <mixed, boolean, unknown>
     */
    public static function admin_del($id){
    	Log::write('auth_access', $id, 3);
    	self::$access->where('uid = '.$id)->delete();
    	
    	Log::write('admin', $id, 3);
    	return self::$admin->delete($id);
    }
    /**
     * 用户组信息
     * @param string $id 用户组id
     * @return Ambigous <mixed, boolean, unknown>
     */
    public static function group_list($id=''){
        if($id == ''){
           $group  = self::$group->select();
        }else{//获取登陆用户的所有权限
            $group = self::$group->find($id);
        };
        return $group;
    }
    /**
     * 用户组编辑与添加
     * @param array $post 数据
     * @param string $type 类型 1.添加 2.编辑
     * @param string $id 用户组id
     * @return Ambigous <mixed, boolean, unknown, string>|boolean
     */
    public static function group_edit($post,$type,$id=''){
        if(isset($post['status'])) 
        	$post['status'] = 1;
        else 
        	$post['status'] = 0;
        if($type == 1){
            if(self::$group->create($post)){
                $id = self::$group->add();
                Log::write('auth_group', $id, 1);
                return $id;
            }
        }else{//编辑
            if($id != ''){
                $post['id'] = $id;
                Log::update('auth_group', $id, 2);
                $res = self::$group->save($post);
                Log::write('auth_group', $id, 2);
                
                return $res;
            }else{
                return false;
            }
        }
    }
    /**
     * 用户组删除
     * @param int $id 用户组id
     * @return Ambigous <mixed, boolean, unknown>
     */
    public static function group_del($id){
    	Log::write('auth_group', $id, 3);
        return self::$group->delete($id);
    }
}