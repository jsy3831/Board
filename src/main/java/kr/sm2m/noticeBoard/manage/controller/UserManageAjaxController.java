package kr.sm2m.noticeBoard.manage.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.sm2m.noticeBoard.manage.domain.UserManage;
import kr.sm2m.noticeBoard.manage.service.UserManageService;

@RestController
public class UserManageAjaxController {
	
	@Autowired
	private UserManageService userManageService;
	
	@RequestMapping("/countUser")
	public int countUser(UserManage userManage) throws Exception{
		return userManageService.countUser(userManage);
	}
	
	@RequestMapping("/selectInfo")
	public Map<String, Object> selectInfo(UserManage userManage) throws Exception{
		return userManageService.selectInfo(userManage);
	}
	
	@RequestMapping("/updateRating")
	public void updateRating(UserManage userManage) throws Exception{
		userManageService.updateRating(userManage);
	}
}
