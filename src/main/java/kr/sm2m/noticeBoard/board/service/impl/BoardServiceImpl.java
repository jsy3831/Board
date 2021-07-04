package kr.sm2m.noticeBoard.board.service.impl;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.sm2m.noticeBoard.board.domain.Board;
import kr.sm2m.noticeBoard.board.mapper.BoardMapper;
import kr.sm2m.noticeBoard.board.service.BoardService;
import kr.sm2m.noticeBoard.board.util.CommonUtils;
import kr.sm2m.noticeBoard.board.util.FilUtils;

@Service
public class BoardServiceImpl implements BoardService {

	@Resource(name = "kr.sm2m.noticeBoard.board.mapper.BoardMapper")
	private BoardMapper boardMapper;
	
	@Resource(name="filUtils")
	private FilUtils filUtils;
	
	//유튜브썸네일삭제
	public void delYoutubeThumb(Board board) throws Exception{
		boardMapper.delYoutubeThumb(board);
	}
	
	//유튜브썸네일등록
	public int insertYoutubeThumb(Board board) throws Exception{
		boardMapper.insertYoutubeThumb(board);
		
		int code = board.getBfCode();
		return code;
	}
	
	//유튜브썸네일조회
	public List<Board> selectYoutubeThumb(Board board) throws Exception{
		return boardMapper.selectYoutubeThumb(board);
	}
	
	//갤러리 글수정
	public void updateImgBoard(Board board) throws Exception{
		boardMapper.updateImgBoard(board); //글수정
		boardMapper.updatePicked(board); //해당글 대표이미지 설정 모두 해제
		boardMapper.picked(board); //해당글 대표이미지 설정
	}
	
	//갤러리 등록수정시 파일삭제
	public void removeImg(Board board) throws Exception{
		
		String sto = board.getLocalBaseFilePath() + board.getBfPath() + board.getBfStoTitle();
		String list = board.getLocalBaseFilePath() + board.getBfPath() + board.getListThumb();
		
		File stoImg = new File(sto);
		File listImg = new File(list);
		
		stoImg.delete();
		listImg.delete();
		
		//이미지일시 본문썸네일이 존재할때만 삭제
		if(board.getBcType() == 2) {
			if(!board.getBfStoTitle().equals(board.getViewThumb())) {
				String view = board.getLocalBaseFilePath() + board.getBfPath() + board.getViewThumb();
				File viewImg = new File(view);
				viewImg.delete();
			}
		}
		
		//비디오일시 비디오 원본썸네일을 삭제하기위함
		else if(board.getBcType() == 3) {
			String removeExt = board.getBfStoTitle().substring(0, board.getBfStoTitle().lastIndexOf("."));
			String videoImg = board.getLocalBaseFilePath() + board.getBfPath() + removeExt + ".jpg";
			File videoStoImg = new File(videoImg);
			videoStoImg.delete();
		}
		
		boardMapper.removeImg(board);
	}
	
	//갤러리 등록수정시 파일업로드
	public void insertFile(Board board, MultipartHttpServletRequest request) throws Exception{
		List<Board> fileInfo = filUtils.parseInsertFileInfo(board, request);
		boardMapper.fileUpload(fileInfo);
	}
	
	//글임시등록
	public int dumpBoard(Board board) throws Exception{
		// client ip
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String ip = req.getHeader("X-FORWARDED-FOR");
			if (ip == null) {
		   		ip = req.getRemoteAddr();
		    }
		board.setBdIp(ip);
						
		boardMapper.dumpBoard(board);
				
		int code = board.getBdCode();
		
		return code;
	}
	
	//갤러리글등록
	public void insertImgBoard(Board board) throws Exception{
		boardMapper.insertImgBoard(board);
		
		boardMapper.picked(board); //대표이미지선택
		
		int parentCode = boardMapper.findParent(board); //부모카테고리찾기	
		board.setParentCode(parentCode);
		
		boardMapper.updateBdSum(board); //게시글수증감
	}
	
	//글등록
	public int insertBoard(Board board, MultipartHttpServletRequest request) throws Exception {
		// client ip
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
		String ip = req.getHeader("X-FORWARDED-FOR");
	    	if (ip == null) {
	    		ip = req.getRemoteAddr();
		    }
		board.setBdIp(ip);
				
		boardMapper.insertBoard(board);
		
		int code = board.getBdCode();
		
		List<Board> fileInfo = filUtils.parseInsertFileInfo(board, request);
		
		if(fileInfo.size() != 0) {
			boardMapper.fileUpload(fileInfo);	
		}
		
		int parentCode = boardMapper.findParent(board); //부모카테고리찾기	
		board.setParentCode(parentCode);
		
		boardMapper.updateBdSum(board); //게시글수증감
		
		return code;
	}
	
	//파일다운로드
	public void downloadFile(Board board, HttpServletResponse response) throws Exception{
		String oriTitle = board.getBfOriTitle();
		String stoTitle = board.getBfStoTitle();
		String path = board.getBfPath();
		
		String localBaseFilePath = board.getLocalBaseFilePath();
//		String tomcatBaseFilePath = board.getTomcatBaseFilePath();
		
		byte fileByte[] = FileUtils.readFileToByteArray(new File(localBaseFilePath + path + stoTitle));
		
		response.setHeader("Set-Cookie", "fileDownload=true; path=/");
		
		response.setContentType("application/octet-stream"); 
		response.setContentLength(fileByte.length); 
		response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(oriTitle, "UTF-8")+"\";"); 
		response.setHeader("Content-Transfer-Encoding", "binary"); 
		response.getOutputStream().write(fileByte); 
		
		response.getOutputStream().flush(); 
		response.getOutputStream().close();

	}
	
	//글조회
	public Map<String, Object> selectBoard(Board board) throws Exception {
		Map<String, Object> selectBoard = new HashMap<String, Object>();

		int bdSum = boardMapper.countBoard(board);
		selectBoard.put("bdSum", bdSum);
		
		List<Board> selectBoardList = boardMapper.selectBoard(board);
		
		selectBoard.put("selectBoard", selectBoardList);
		
		return selectBoard;
	}
	
	//조회수증가
	public void updateView(Board board) throws Exception{
		boardMapper.updateView(board);
	}
	//글상세조회
	public Map<String, Object> boardInfo(Board board) throws Exception {
		Map<String, Object> boardInfo = new HashMap<String, Object>();
		
		Board boardView = boardMapper.boardInfo(board);
		List<Board> selectFile = boardMapper.selectFile(board);
		
		boardInfo.put("boardView", boardView);
		boardInfo.put("selectFile", selectFile);
		
		if(board.getBcType() == 3) {
			List<Board> selectYoutube = boardMapper.selectYoutubeThumb(board);
			boardInfo.put("selectYoutube", selectYoutube);
		}
		
		return boardInfo;
	}
	
	//파일조회
	public List<Board> selectFile(Board board) throws Exception{
		return boardMapper.selectFile(board);
	}
	
	//글수정
	public void boardUpdate(Board board, MultipartHttpServletRequest request) throws Exception {
		boardMapper.boardUpdate(board);
		
		String delFileList;
		
		if(board.getDelFileList().size() != 0) {
			List<Board> selectDelFile = boardMapper.selectDelFile(board.getDelFileList());
			
			boardMapper.removeDelFile(board.getDelFileList());
			for(int i=0; i<selectDelFile.size(); i++) {
				delFileList = board.getLocalBaseFilePath() + selectDelFile.get(i).getBfPath() + selectDelFile.get(i).getBfStoTitle();
				
				File delFile = new File(delFileList);
				
				delFile.delete();
			}
		}
		
		List<Board> fileInfo = filUtils.parseInsertFileInfo(board, request);
		
		if(fileInfo.size() != 0) {
			boardMapper.fileUpload(fileInfo);	
		}
	
	}
	
	//글삭제
	public void boardDelete(Board board) throws Exception {
		
		String localBaseFilePath = board.getLocalBaseFilePath();
//		String tomcatBaseFilePath = board.getTomcatBaseFilePath();
		
		String delFolder = null;
		
		if(board.getBcType() == 1) {
			delFolder = "basicBoard";
		}
		else if(board.getBcType() == 2) {
			delFolder = "imgBoard";
		}
		else {
			delFolder = "mediaBoard";
		}
		
		String filePath = "uploadFiles\\"+delFolder+"\\board" + board.getBdCode();
		
		File folder = new File(localBaseFilePath + filePath);
		
		while(folder.exists()) {
			File[] folderList = folder.listFiles();
			for(int i=0; i<folderList.length; i++) {
				folderList[i].delete();
			}
			if(folderList.length == 0 && folder.isDirectory()) {
				folder.delete();
			}
		}
		
		boardMapper.boardDelete(board);
		
		if(board.getBdType() != 0) {
			int parentCode = boardMapper.findParent(board); //부모카테고리찾기
			board.setParentCode(parentCode);
			
			boardMapper.updateBdSum(board); //게시글수증감
		}
		
	}
	
	//댓글등록
	public int replyInsert(Board board) throws Exception {
		// client ip
		HttpServletRequest req = ((ServletRequestAttributes)RequestContextHolder.currentRequestAttributes()).getRequest();
	   	String ip = req.getHeader("X-FORWARDED-FOR");
	       if (ip == null) {
	    	   ip = req.getRemoteAddr();
	       }
		board.setBrIp(ip);
		
		//원글일때
		if(board.getBrFlag() == 0) {
			boardMapper.replyInsert(board); //댓글등록
			int brCode = board.getBrCode();
			boardMapper.updateGroupNo(brCode); //원글 그룹번호 업데이트
		}
		//답글일때
		else {
			
			int groupNo = board.getGroupNo();
			int maxOrd = boardMapper.maxOrd(groupNo); //해당 그룹 중 가장 큰 group_ord 조회
			
			board.setGroupOrd(maxOrd + 1);
			board.setGroupLayer(board.getGroupLayer() + 1);
			
			boardMapper.replyInsert(board); //댓글등록
		}
		
		boardMapper.updateBrSum(board); //댓글수증감
		
		return boardMapper.replySum(board); //댓글합계
	}
	
	//댓글조회
	public List<Board> replySelect(Board board) throws Exception {
		return boardMapper.replySelect(board);
	}
	
	//댓글삭제
	public int replyDelete(Board board) throws Exception {
		
		int brCode = board.getBrCode(); //게시판코드
		int groupNo = board.getGroupNo(); //그룹번호
		
		int countChildBr = boardMapper.countChildBr(groupNo); //그룹내 댓글갯수
		
		//원글일시
		if(board.getBrFlag() == 0) { 
			
			//답글 존재할시
			if(countChildBr > 1) {
				boardMapper.updateBrDel(brCode); //원글삭제여부 1로 수정
			} else {
				boardMapper.replyDelete(board); //원글삭제
			}
			
		}
		//답글일시
		else {
			
			boardMapper.replyDelete(board); //답글삭제
			
			//답글이 한개일시
			if(countChildBr == 2) {
				
				int brDel = boardMapper.selectBrDel(groupNo); //원글 삭제여부 조회
				
				if(brDel == 1) {
					board.setBrCode(groupNo);
					boardMapper.replyDelete(board); //원글삭제
				}
			}
			
		}
		
		boardMapper.updateBrSum(board); //댓글수증감
		
		return boardMapper.replySum(board); //댓글합계
	}
	
	//갤러리글조회
	public Map<String, Object> selectImgBoard(Board board) throws Exception{
		Map<String, Object> selectImgBoard = new HashMap<String, Object>();
		
		List<Board> selectImgBoardList = boardMapper.selectBoard(board);
		
//		List<Integer> imgBoardCode = new ArrayList<Integer>();
		
//		for(int i=0; i < selectImgBoardList.size(); i++) {
//			imgBoardCode.add(selectImgBoardList.get(i).getBdCode());
			
//		}
		
//		if(imgBoardCode.size() !=0) {
//			List<Board> selectListThumb = boardMapper.selectListThumb(imgBoardCode);
//			for(int i=0; i < selectImgBoardList.size(); i++) {
//				selectImgBoardList.get(i).setBfCode(selectListThumb.get(i).getBfCode());
//				selectImgBoardList.get(i).setBfPath(selectListThumb.get(i).getBfPath());
//				selectImgBoardList.get(i).setListThumb(selectListThumb.get(i).getListThumb());
//			}
//		}
		
		selectImgBoard.put("selectImgBoardList", selectImgBoardList);
		
		int bdSum = boardMapper.countBoard(board);
		selectImgBoard.put("bdSum", bdSum);
		
		return selectImgBoard;
	}
}
