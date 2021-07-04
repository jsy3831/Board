package kr.sm2m.noticeBoard.manage.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.sm2m.noticeBoard.manage.domain.CateManage;

@Repository("kr.sm2m.noticeBoard.manage.mapper.CateManageMapper")
public interface CateManageMapper {
	public List<CateManage> selectParent() throws Exception;
	
	public List<CateManage> selectChild(CateManage cateManage) throws Exception;
	
	public void insertCate(CateManage cateManage) throws Exception;
	
	public void updateCate(CateManage catemanage) throws Exception;
	
	public void deleteCate(List<Integer> findChild) throws Exception;
	
	public List<Integer> findChild(CateManage catemanage) throws Exception;
}
