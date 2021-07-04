package kr.sm2m.noticeBoard.manage.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.sm2m.noticeBoard.manage.domain.CateManage;
import kr.sm2m.noticeBoard.manage.service.CateManageService;

@RestController
public class CateManageAjaxController {

	@Autowired
	private CateManageService cateManageService;
	
	@RequestMapping("/selectParent")
	public List<CateManage> selectParent() throws Exception{
		return cateManageService.selectParent();
	}
	
	@RequestMapping("/selectChild")
	public List<CateManage> selectChild(CateManage cateManage) throws Exception{
		return cateManageService.selectChild(cateManage);
	}
	
	@RequestMapping("/insertCate")
	public void insertCate(CateManage cateManage) throws Exception{
		cateManageService.insertCate(cateManage);
	}
	
	@RequestMapping("/updateCate")
	public void updateCate(CateManage cateManage) throws Exception{
		cateManageService.updateCate(cateManage);
	}
	
	@RequestMapping("/deleteCate")
	public void deleteCate(CateManage cateManage) throws Exception{
		cateManageService.deleteCate(cateManage);
	}
}
