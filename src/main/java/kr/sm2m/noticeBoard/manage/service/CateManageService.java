package kr.sm2m.noticeBoard.manage.service;

import java.util.List;

import kr.sm2m.noticeBoard.manage.domain.CateManage;

public interface CateManageService {
	public List<CateManage> selectParent() throws Exception;
	
	public List<CateManage> selectChild(CateManage cateManage) throws Exception;
	
	public void insertCate(CateManage catemanage) throws Exception;
	
	public void updateCate(CateManage catemanage) throws Exception;
	
	public void deleteCate(CateManage catemanage) throws Exception;
}
