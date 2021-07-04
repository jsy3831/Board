package kr.sm2m.noticeBoard.manage.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.sm2m.noticeBoard.manage.domain.UserManage;

@Repository("kr.sm2m.noticeBoard.manage.mapper.UserManageMapper")
public interface UserManageMapper {
	public int countUser(UserManage userManage) throws Exception;
	
	public List<UserManage> selectUser(UserManage userManage) throws Exception;
	
	public List<UserManage> selectRating() throws Exception;
	
	public void updateRating(UserManage userManage) throws Exception;
}
