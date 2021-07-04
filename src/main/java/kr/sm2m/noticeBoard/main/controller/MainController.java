package kr.sm2m.noticeBoard.main.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;




@Controller
public class MainController {

	@RequestMapping("/")
	public String main() throws Exception {	
		return ".main";
	}
	
	//에러페이지
	@RequestMapping("/page404")
	public String page404() throws Exception {	
		return ".page404";
	}
	
	//로그인 창이동
	@RequestMapping("/login1")
	public String login(String returnUrl, Model model) throws Exception {
		System.out.println("리턴url " + returnUrl);
		model.addAttribute("returnUrl", returnUrl);
		return ".login";
	}
	
	//비밀번호 찾기 창이동
//	@RequestMapping("/forgotPwd")
//	public String forgotPwd() throws Exception {
//		return ".forgotPwd";
//	}
	
	//회원가입 창이동
	@RequestMapping("/register")
	public String register() throws Exception {
		return ".register";
	}
	
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpSession session) throws Exception {
		session.removeAttribute("mi");
		System.out.println("로그아웃");
		return ".main";
	}
}
