package kr.sm2m.noticeBoard.main.service;

import java.util.List;
import java.util.Map;

import kr.sm2m.noticeBoard.main.domain.Main;

public interface MainService{
	public int idCheck(Main main) throws Exception; //아이디중복검사
	
	public void insertRegister(Main main) throws Exception; //회원가입
	
	public void deleteRegister(Main main) throws Exception; //회원탈퇴
	
	public Main selectLogin(Main main) throws Exception; //로그인
	
	public List<Main> selectCate() throws Exception; //카테고리조회
	
	public void editMemInfo(Main main) throws Exception; //회원정보수정
	
	public Map<String, Object> selectBarData() throws Exception; //bar차트 데이터
	
	public Map<String, Object> selectLineData() throws Exception; //line차트 데이터
	
	public Map<String, Object> selectPieData() throws Exception; //pie차트 데이터
	
	public Map<String, Object> selectTabData() throws Exception; //테이블 데이터
}
