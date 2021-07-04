package kr.sm2m.noticeBoard.manage.service;

import java.util.List;
import java.util.Map;

import kr.sm2m.noticeBoard.manage.domain.UserManage;

public interface UserManageService {
	
	public Map<String, Object> selectInfo(UserManage userManage) throws Exception;
	
	public void updateRating(UserManage userManage) throws Exception;
	
	public int countUser(UserManage userManage) throws Exception;
}
