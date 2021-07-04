package kr.sm2m.noticeBoard.board.mapper;

import java.util.List;

import org.springframework.stereotype.Repository;

import kr.sm2m.noticeBoard.board.domain.Board;

@Repository("kr.sm2m.noticeBoard.board.mapper.BoardMapper")
public interface BoardMapper {
	public int selectBrDel(int groupNo) throws Exception; //원글 삭제여부 조회
	
	public void updateBrDel(int brCode) throws Exception; //원글삭제여부 1로 수정
	
	public int countChildBr(int groupNo) throws Exception; //그룹내 댓글갯수
	
	public int maxOrd(int groupNo) throws Exception; //해당 그룹 중 가장 큰 group_ord 조회
	
	public void updateGroupNo(int brCode) throws Exception; //원글 그룹번호 업데이트
	
	public int replySum(Board board) throws Exception; //댓글합계
	
	public void delYoutubeThumb(Board board) throws Exception; //유튜브썸네일삭제
	
	public void insertYoutubeThumb(Board board) throws Exception; //유튜브썸네일등록
	
	public List<Board> selectYoutubeThumb(Board board) throws Exception; //유튜브썸네일조회
	
	public int countBoard(Board board) throws Exception;
	
	public void updatePicked(Board board) throws Exception;
	
	public void updateImgBoard(Board board) throws Exception;
	
	public void picked(Board board) throws Exception; //대표이미지선택
	
	public void insertImgBoard(Board board) throws Exception;//갤러리글등록
	
	public void removeImg(Board board) throws Exception; //갤러리 등록수정시 파일삭제
	
	public List<Board> selectDelFile(List<Integer> delFileList) throws Exception;
	
	public void removeDelFile(List<Integer> delFileList) throws Exception;
	
	public void dumpBoard(Board board) throws Exception; //글임시등록
	
	public void insertBoard(Board board) throws Exception; // 글등록
	
	public void fileUpload(List<Board> fileUpload) throws Exception; //파일업로드
	
	public List<Board> selectBoard(Board board) throws Exception; //글조회
	
	public void updateView(Board board) throws Exception;
	
	public Board boardInfo(Board board) throws Exception; // 글상세조회
	
	public List<Board> selectFile(Board board) throws Exception; //파일조회
	
	public void boardUpdate(Board board) throws Exception; //글수정
	
	public void boardDelete(Board board) throws Exception; //글삭제
	
	public void replyInsert(Board board) throws Exception; //댓글등록
	
	public List<Board> replySelect(Board board) throws Exception; //댓글조회
	
	public void replyDelete(Board board) throws Exception; //댓글삭제
	
	public void updateBrSum(Board board) throws Exception; //댓글수증감
	
	public void updateBdSum(Board board) throws Exception; //게시글수증감
	
	public int findParent(Board board) throws Exception; //부모카테고리찾기
	
//	public List<Board> selectListThumb(List<Integer> imgBoardCode) throws Exception; //리스트썸네일조회
}
