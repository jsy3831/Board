package kr.sm2m.noticeBoard.manage.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ManageController {

	@RequestMapping("/cateManage")
	public String cateManage() throws Exception {	
		return ".cateManage";
	}
	
	@RequestMapping("/userManage")
	public String userManage() throws Exception {	
		return ".userManage";
	}
}
