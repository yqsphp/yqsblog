<?php
$url=$_SERVER['DOCUMENT_ROOT'].$_REQUEST['url'];
//2016.11.7  ɾ��ͼƬ
if($_REQUEST['action']=='delete'){
	echo delete_file($url);
}else if($_REQUEST['action']=='file_delete'){
	if($_REQUEST['file']==1){
		//ɾ��Ŀ¼�����µ������ļ�
		echo delete_dir($url);
	}else{
		//ɾ���ļ�
		echo delete_file($url);
	}
}
//ɾ��Ŀ¼�����µ������ļ�
function delete_dir($url){
	if($dir=opendir($url)){
		while(($item=readdir($dir)) !== false){
			if($item!='.' && $item!='..'){
				if(is_dir($url.'/'.$item)){
					delete_dir($url);
				}else{
					unlink($url.'/'.$item);
				}
			}
		}
		closedir($dir);
		$res=rmdir($url);
	}
	return $res?1:0;
}
//ɾ���ļ����ļ���
function delete_file($url){
	if(file_exists($url)){
		$result=unlink($url);
		if($result){
			$res=1;	
		}else{
			$res=0;
		}
	}else{
		$res=0;
	}
	return $res;
}