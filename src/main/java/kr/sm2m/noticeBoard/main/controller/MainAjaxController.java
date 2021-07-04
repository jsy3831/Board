package kr.sm2m.noticeBoard.main.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.sm2m.noticeBoard.main.domain.Main;
import kr.sm2m.noticeBoard.main.service.MainService;

@RestController
//@RequestMapping("/main")
public class MainAjaxController {

	@Autowired
	private MainService mainService;
	
	//아이디중복검사
	@RequestMapping("/idCheck")
	public int idCheck(Main main) throws Exception{
		return mainService.idCheck(main);
	}
	
	//회원가입
	@RequestMapping("/insertRegister")
	public void insertRegister(Main main) throws Exception{
		mainService.insertRegister(main);
	}
	
	//회원탈퇴
	@RequestMapping("/deleteRegister")
	public void deleteRegister(Main main) throws Exception{
		mainService.deleteRegister(main);
	}
	
	//회원수정
	@RequestMapping("/editMemInfo")
	public void editMemInfo(Main main) throws Exception{
		mainService.editMemInfo(main);
	}
	
	//세션가져오기
	@RequestMapping("/getSession")
	public Main getSession(Main main, HttpSession session) throws Exception{
		if(session.getAttribute("mi") == null) {
			System.out.println("세션없음");
		}else {
			main.setMiCode(((Main)session.getAttribute("mi")).getMiCode());
			main.setMiName(((Main)session.getAttribute("mi")).getMiName());
			main.setMrCtg(((Main)session.getAttribute("mi")).getMrCtg());
			
			main.setMiId(((Main)session.getAttribute("mi")).getMiId());
			main.setMiEmail(((Main)session.getAttribute("mi")).getMiEmail());
		}
		return main;
	}
	
	//로그인
	@RequestMapping("/selectLogin")
	public int selectLogin(Main main, HttpSession session) throws Exception{
		int check = 1;
		main = mainService.selectLogin(main);
		if(main != null) {
			session.setAttribute("mi", main);
			System.out.println(((Main)session.getAttribute("mi")).getMiName());
		} else {
			check = 0;
		}
		return check;
	}
	
	//카테고리조회
	@RequestMapping("/selectCate")
	public List<Main> selectCate() throws Exception{
		return mainService.selectCate();
	}
	
	//로그아웃 테스트
	@RequestMapping("/logoutTest")
	public void logoutTest(HttpSession session) throws Exception{
		session.removeAttribute("mi");
		System.out.println("로그아웃");
	}
	
	//bar차트 데이터
	@RequestMapping("/selectBarData")
	public Map<String, Object> selectBarData() throws Exception{
		return mainService.selectBarData();
	}
	
	//line차트 데이터
	@RequestMapping("/selectLineData")
	public Map<String, Object> selectLineData() throws Exception{
		return mainService.selectLineData();
	}
	
	//pie차트 데이터
	@RequestMapping("/selectPieData")
	public Map<String, Object> selectPieData() throws Exception{
		return mainService.selectPieData();
	}
	
	//테이블 데이터
	@RequestMapping("/selectTabData")
	public Map<String, Object> selectTabData() throws Exception{
		return mainService.selectTabData();
	}
	
}
