package kr.sm2m.noticeBoard.board.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.sm2m.noticeBoard.board.domain.Board;

@Controller
public class BoardController {
	
	//text게시판 창이동
	@RequestMapping("/board")
	public String board(Board board, Model model) throws Exception {
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
		
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcRating", board.getBcRating());
		
		return ".board";
	}
	
	//img게시판 창이동
	@RequestMapping("/imgBoard")
	public String imgBoard(Board board, Model model) throws Exception {
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
		
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcRating", board.getBcRating());
		return ".imgBoard";
	}
	
	//media게시판 창이동
	@RequestMapping("/mediaBoard")
	public String mediaBoard(Board board, Model model) throws Exception {
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
			
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
			
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcRating", board.getBcRating());
		return ".mediaBoard";
	}
		
	//img게시판상세 창이동
	@RequestMapping("/imgBoardView")
	public String imgBoardView(Board board, Model model) throws Exception {
		model.addAttribute("bdCode", board.getBdCode());
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
		
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcRating", board.getBcRating());
		return ".imgBoardView";
	}
	
	//img게시판상세 창이동
	@RequestMapping("/mediaBoardView")
	public String mediaBoardView(Board board, Model model) throws Exception {
		model.addAttribute("bdCode", board.getBdCode());
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
			
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcRating", board.getBcRating());
		return ".mediaBoardView";
	}
		
	//게시판상세 창이동
	@RequestMapping("/boardView")
	public String boardView(Board board, Model model) throws Exception {
		model.addAttribute("bdCode", board.getBdCode());
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
		
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcRating", board.getBcRating());
		return ".boardView";
	}
	
	//img게시판글등록 창이동
	@RequestMapping("/imgBoardInsert")
	public String imgBoardInsert(Board board, Model model) throws Exception {
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
		
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcRating", board.getBcRating());
		return ".imgBoardInsert";
	}

	//img게시판글등록 창이동
	@RequestMapping("/mediaBoardInsert")
	public String mediaBoardInsert(Board board, Model model) throws Exception {
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
		
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcRating", board.getBcRating());
		return ".mediaBoardInsert";
	}
	
	//게시판글등록 창이동
	@RequestMapping("/boardInsert")
	public String boardInsert(Board board, Model model) throws Exception {
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
		
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcRating", board.getBcRating());
		return ".boardInsert";
	}
	
	//게시판수정 창이동
	@RequestMapping("/goBoardUpdate")
	public String goBoardUpdate(Board board, Model model) throws Exception {
		model.addAttribute("bdCode", board.getBdCode());
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
		
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcRating", board.getBcRating());
		return ".boardUpdate";
	}
	
	//img게시판수정 창이동
	@RequestMapping("/goImgBoardUpdate")
	public String goImgBoardUpdate(Board board, Model model) throws Exception {
		model.addAttribute("bdCode", board.getBdCode());
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
		
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcRating", board.getBcRating());
		return ".imgBoardUpdate";
	}

	//media게시판수정 창이동
	@RequestMapping("/goMediaBoardUpdate")
	public String goMediaBoardUpdate(Board board, Model model) throws Exception {
		model.addAttribute("bdCode", board.getBdCode());
		model.addAttribute("bcCode", board.getBcCode());
		model.addAttribute("bcTitle", board.getBcTitle());
		model.addAttribute("bcType", board.getBcType());
		model.addAttribute("pbcCode", board.getPbcCode());
		
		model.addAttribute("currentPage", board.getCurrentPage());
		model.addAttribute("selected", board.getSelected());
		model.addAttribute("searchWrd", board.getSearchWrd());
		
		model.addAttribute("bcRating", board.getBcRating());
		return ".mediaBoardUpdate";
	}	
}