package kr.sm2m.noticeBoard.manage.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.sm2m.noticeBoard.manage.domain.CateManage;
import kr.sm2m.noticeBoard.manage.mapper.CateManageMapper;
import kr.sm2m.noticeBoard.manage.service.CateManageService;

@Service
public class CateManageServiceImpl implements CateManageService{
	
	@Resource(name="kr.sm2m.noticeBoard.manage.mapper.CateManageMapper")
	private CateManageMapper cateManageMapper;
	
	public List<CateManage> selectParent() throws Exception{
		return cateManageMapper.selectParent();
	}
	
	public List<CateManage> selectChild(CateManage cateManage) throws Exception{
		return cateManageMapper.selectChild(cateManage);
	}
	
	public void insertCate(CateManage cateManage) throws Exception{
		cateManageMapper.insertCate(cateManage);
	}
	
	public void updateCate(CateManage cateManage) throws Exception{
		cateManageMapper.updateCate(cateManage);
	}
	
	public void deleteCate(CateManage cateManage) throws Exception{
		
		List<Integer> findChild = cateManageMapper.findChild(cateManage);		
		findChild.add(cateManage.getBcCode());
		
		cateManageMapper.deleteCate(findChild);
	}
}
