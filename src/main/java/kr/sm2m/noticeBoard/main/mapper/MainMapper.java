package kr.sm2m.noticeBoard.main.mapper;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import kr.sm2m.noticeBoard.main.domain.Main;

@Repository("kr.sm2m.noticeBoard.main.mapper.MainMapper")
public interface MainMapper {
	
	public int idCheck(Main main) throws Exception; //아이디중복검사
	
	public void insertRegister(Main main) throws Exception; //회원가입
	
	public void deleteRegister(Main main) throws Exception; //회원탈퇴
	
	public Main selectLogin(Main main) throws Exception; //로그인
	
	public List<Main> selectCate() throws Exception; //카테고리조회
	
	public void editMemInfo(Main main) throws Exception; //회원정보수정
	
	public List<Main> selectBarData() throws Exception; //bar차트 데이터
	
	public List<Integer> selectLineData() throws Exception; //line차트 데이터
	
	public List<Main> selectPieData() throws Exception; //pie차트 데이터
	
	public List<Main> selectViewTop() throws Exception;//조회수많은글
	
	public List<Main> selectReplyTop() throws Exception;//댓글많은글
	
}
