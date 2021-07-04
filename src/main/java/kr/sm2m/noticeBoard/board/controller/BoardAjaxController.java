package kr.sm2m.noticeBoard.board.controller;

import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import org.springframework.web.bind.annotation.RequestMapping;

import kr.sm2m.noticeBoard.board.domain.Board;
import kr.sm2m.noticeBoard.board.service.BoardService;
import kr.sm2m.noticeBoard.main.domain.Main;

@RestController
public class BoardAjaxController {
	
	@Autowired
	private BoardService boardService;
	
	//유튜브썸네일삭제
	@RequestMapping("/delYoutubeThumb")
	public void delYoutubeThumb(Board board) throws Exception{
		boardService.delYoutubeThumb(board);
	}
		
	//유튜브썸네일등록
	@RequestMapping("/insertYoutubeThumb")
	public int insertYoutubeThumb(Board board) throws Exception{
		return boardService.insertYoutubeThumb(board);
	}
	
	//유튜브썸네일조회
	@RequestMapping("/selectYoutubeThumb")
	public List<Board> selectYoutubeThumb(Board board) throws Exception{
		return boardService.selectYoutubeThumb(board);
	}
	
	@RequestMapping("/sender")
	public void sender() throws Exception{
	}
	
	//갤러리글수정
	@RequestMapping("/updateImgBoard")
	public void updateImgBoard(Board board) throws Exception{
		boardService.updateImgBoard(board);
	}
	
	//갤러리 등록수정시 파일삭제
	@RequestMapping("/removeImg")
	public void removeImg(Board board) throws Exception{
		boardService.removeImg(board);
	}
	
	//갤러리 등록수정시 파일업로드
	@RequestMapping("/insertFile")
	public void insertFile(Board board, MultipartHttpServletRequest request) throws Exception{
		boardService.insertFile(board, request);
	}
	
	@RequestMapping("/selectFile")
	public List<Board> selectFile(Board board) throws Exception{
		return boardService.selectFile(board);
	}
	
	//글임시등록
	@RequestMapping("/dumpBoard")
	public int dumpBoard(Board board, HttpSession session) throws Exception {
		board.setMiCode(((Main)session.getAttribute("mi")).getMiCode());
		System.out.println("세션코드   " + board.getMiCode());
		return boardService.dumpBoard(board);
	}
	
	//갤러리 글등록
	@RequestMapping("/insertImgBoard")
	public void insertImgBoard(Board board) throws Exception{
		boardService.insertImgBoard(board);
	}
	
	//글등록
	@RequestMapping("/insertBoard")
	public int insertBoard(Board board, HttpSession session, MultipartHttpServletRequest request) throws Exception {
		board.setMiCode(((Main)session.getAttribute("mi")).getMiCode());
		System.out.println("세션코드   " + board.getMiCode());
		return boardService.insertBoard(board, request);
	}
	
	//파일다운로드
	@RequestMapping("/downloadFile")
	public void downloadFile(Board board, HttpServletResponse response) throws Exception{
		boardService.downloadFile(board, response);
	}
	
	//글조회
	@RequestMapping("/selectBoard")
	public Map<String, Object> selectBoard(Board board) throws Exception {
		return boardService.selectBoard(board);
	}
	
	//조회수증가
	@RequestMapping("/updateView")
	public void updateView(Board board) throws Exception{
		boardService.updateView(board);
	}
		
	//글상세조회
	@RequestMapping("/boardInfo")
	public Map<String, Object> boardInfo(Board board) throws Exception {
		return boardService.boardInfo(board);
	}
	
	//글수정
	@RequestMapping("/boardUpdate")
	public void boardUpdate(Board board, MultipartHttpServletRequest request) throws Exception{
		boardService.boardUpdate(board, request);
	}
	
	//글삭제
	@RequestMapping("/boardDelete")
	public void boardDelete(Board board) throws Exception{
		boardService.boardDelete(board);
	}
	
	//댓글등록
	@RequestMapping("/replyInsert")
	public int replyInsert(Board board, HttpSession session) throws Exception {
		board.setMiCode(((Main)session.getAttribute("mi")).getMiCode());
		System.out.println("세션코드   " + board.getMiCode());
		return boardService.replyInsert(board);
	}
	
	//댓글조회
	@RequestMapping("/replySelect")
	public List<Board> replySelect(Board board) throws Exception{
		return boardService.replySelect(board);
	}
	
	//댓글삭제
	@RequestMapping("/replyDelete")
	public int replyDelete(Board board) throws Exception{
		return boardService.replyDelete(board);
	}
	
	//갤러리글조회
	@RequestMapping("/selectImgBoard")
	public Map<String, Object> selectImgBoard(Board board) throws Exception{
		return boardService.selectImgBoard(board);
	}
	
}
