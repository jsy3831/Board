package kr.sm2m.noticeBoard.board.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.sm2m.noticeBoard.board.domain.Board;

public interface BoardService {
	
	public void delYoutubeThumb(Board board) throws Exception; //유튜브썸네일삭제
	
	public int insertYoutubeThumb(Board board) throws Exception; //유튜브썸네일등록
	
	public List<Board> selectYoutubeThumb(Board board) throws Exception; //유튜브썸네일조회
	
	public void updateImgBoard(Board board) throws Exception;
	
	public void insertImgBoard(Board board) throws Exception;//갤러리글등록
	
	public List<Board> selectFile(Board board) throws Exception;
	
	public void removeImg(Board board) throws Exception; //갤러리 등록수정시 파일삭제
	
	public void insertFile(Board board, MultipartHttpServletRequest request) throws Exception; //갤러시 등록수정시 파일업로드
	
	public int dumpBoard(Board board) throws Exception; //글임시등록
	
	public int insertBoard(Board board, MultipartHttpServletRequest request) throws Exception; //글등록
	
	public Map<String, Object> selectBoard(Board board) throws Exception; //글조회
	
	public void updateView(Board board) throws Exception; //조회수증가
	
	public Map<String, Object> boardInfo(Board board) throws Exception; //글상세조회
	
	public void downloadFile(Board board, HttpServletResponse response) throws Exception; //파일다운로드
	
	public void boardUpdate(Board board, MultipartHttpServletRequest request) throws Exception; //글수정
	
	public void boardDelete(Board board) throws Exception; //글삭제
	
	public int replyInsert(Board board) throws Exception; //댓글등록
	
	public List<Board> replySelect(Board board) throws Exception; //댓글조회
	
	public int replyDelete(Board board) throws Exception; //댓글삭제
	
	public Map<String, Object> selectImgBoard(Board board) throws Exception;//갤러리글조회
             	
}
