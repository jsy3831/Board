package kr.sm2m.noticeBoard.manage.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import kr.sm2m.noticeBoard.manage.domain.UserManage;
import kr.sm2m.noticeBoard.manage.mapper.UserManageMapper;
import kr.sm2m.noticeBoard.manage.service.UserManageService;

@Service
public class UserManageSeriviceImpl implements UserManageService{
	
	@Resource(name="kr.sm2m.noticeBoard.manage.mapper.UserManageMapper")
	private UserManageMapper userManageMapper;
	
	public Map<String, Object> selectInfo(UserManage userManage) throws Exception{
		Map<String, Object> selectInfo = new HashMap<String, Object>();
		
		List<UserManage> selectUser = userManageMapper.selectUser(userManage);
		List<UserManage> selectRating = userManageMapper.selectRating();
		
		selectInfo.put("selectUser", selectUser);
		selectInfo.put("selectRating", selectRating);
		return selectInfo;
	}
	
	public void updateRating(UserManage userManage) throws Exception{
		userManageMapper.updateRating(userManage);
	}
	
	public int countUser(UserManage userManage) throws Exception{
		return userManageMapper.countUser(userManage);
	}
}
