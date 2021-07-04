package kr.sm2m.noticeBoard.board.domain;

import java.util.List;

import kr.sm2m.noticeBoard.main.domain.PagingVo;

public class Board extends PagingVo{
	private int bdCode; //글고유번호
	private String bdTitle; //글제목
	private String bdContent; //글내용
	private int miCode; //회원고유번호
	private String miName;
	private String bdEnrollDate; //글등록날짜
	private int bdViews; //조회수
	private int brSum; //댓글합계
	private int bcCode; //카테고리고유번호
	private int pbcCode;
	
	private String bcTitle;
	private String bdIp; //글등록아이피
	private String brIp; //댓글등록아이피
	private int brCode; //댓글고유번호
	private String brContent; //댓글내용
	private String brEnrollDate; //댓글등록날짜
	private int brType; //댓글증감
	private int bdType; //게시글수증감
	
	private int parentCode;
	
	private int bfCode;
	private String bfOriTitle;
	private String bfStoTitle;
	private String bfExtension;
	private String bfPath;
	private String bfSize;
	private String bfMimeType;
	
	private String localBaseFilePath = "D:\\workspace\\noticeBoard\\noticeBoard\\src\\main\\resources\\static\\"; //로컬파일상대경로
	private String tomcatBaseFilePath = "C:\\Program Files\\Apache Software Foundation\\Tomcat 9.0\\webapps\\ROOT\\WEB-INF\\classes\\static\\"; //서버파일상대경로
	
	private String listThumb;
	private String viewThumb;

	private int selected; // 검색조건
	private String searchWrd; //검색어
	private int bdSum;
	
	private int bcType; //게시판타입_text: 1, image: 2, media: 3
	private List<Integer> delFileList;
	
	private int picked; //대표이미지
	private String pickedSrc; //대표이미지 경로

	private int bcRating;
	
	private int groupNo; //그룹번호
	private int groupOrd; //그룹내순서
	private int groupLayer; //계층
	
	private int brFlag; //원글: 0, 답글:1
	private int brDel; //원글일시 삭제여부
	
	public int getBrDel() {
		return brDel;
	}
	public void setBrDel(int brDel) {
		this.brDel = brDel;
	}
	public int getBrFlag() {
		return brFlag;
	}
	public void setBrFlag(int brFlag) {
		this.brFlag = brFlag;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	public int getGroupOrd() {
		return groupOrd;
	}
	public void setGroupOrd(int groupOrd) {
		this.groupOrd = groupOrd;
	}
	public int getGroupLayer() {
		return groupLayer;
	}
	public void setGroupLayer(int groupLayer) {
		this.groupLayer = groupLayer;
	}
	public String getPickedSrc() {
		return pickedSrc;
	}
	public void setPickedSrc(String pickedSrc) {
		this.pickedSrc = pickedSrc;
	}
	public int getBcRating() {
		return bcRating;
	}
	public void setBcRating(int bcRating) {
		this.bcRating = bcRating;
	}
	public int getMiCode() {
		return miCode;
	}
	public void setMiCode(int miCode) {
		this.miCode = miCode;
	}
	public String getBdTitle() {
		return bdTitle;
	}
	public void setBdTitle(String bdTitle) {
		this.bdTitle = bdTitle;
	}
	public String getBdContent() {
		return bdContent;
	}
	public void setBdContent(String bdContent) {
		this.bdContent = bdContent;
	}
	public String getBdEnrollDate() {
		return bdEnrollDate;
	}
	public void setBdEnrollDate(String bdEnrollDate) {
		this.bdEnrollDate = bdEnrollDate;
	}
	public int getBdViews() {
		return bdViews;
	}
	public void setBdViews(int bdViews) {
		this.bdViews = bdViews;
	}
	public int getBrSum() {
		return brSum;
	}
	public void setBrSum(int brSum) {
		this.brSum = brSum;
	}
	public int getBcCode() {
		return bcCode;
	}
	public void setBcCode(int bcCode) {
		this.bcCode = bcCode;
	}
	public int getBdCode() {
		return bdCode;
	}
	public void setBdCode(int bdCode) {
		this.bdCode = bdCode;
	}
	public int getBrCode() {
		return brCode;
	}
	public void setBrCode(int brCode) {
		this.brCode = brCode;
	}
	public String getBrContent() {
		return brContent;
	}
	public void setBrContent(String brContent) {
		this.brContent = brContent;
	}
	public String getBdIp() {
		return bdIp;
	}
	public void setBdIp(String bdIp) {
		this.bdIp = bdIp;
	}
	public String getBrIp() {
		return brIp;
	}
	public void setBrIp(String brIp) {
		this.brIp = brIp;
	}
	public String getBrEnrollDate() {
		return brEnrollDate;
	}
	public void setBrEnrollDate(String brEnrollDate) {
		this.brEnrollDate = brEnrollDate;
	}
	public int getBrType() {
		return brType;
	}
	public void setBrType(int brType) {
		this.brType = brType;
	}
	public String getMiName() {
		return miName;
	}
	public void setMiName(String miName) {
		this.miName = miName;
	}
	public String getBcTitle() {
		return bcTitle;
	}
	public void setBcTitle(String bcTitle) {
		this.bcTitle = bcTitle;
	}
	public int getBdType() {
		return bdType;
	}
	public void setBdType(int bdType) {
		this.bdType = bdType;
	}
	public int getParentCode() {
		return parentCode;
	}
	public void setParentCode(int parentCode) {
		this.parentCode = parentCode;
	}
	public int getBfCode() {
		return bfCode;
	}
	public void setBfCode(int bfCode) {
		this.bfCode = bfCode;
	}
	public String getBfOriTitle() {
		return bfOriTitle;
	}
	public void setBfOriTitle(String bfOriTitle) {
		this.bfOriTitle = bfOriTitle;
	}
	public String getBfStoTitle() {
		return bfStoTitle;
	}
	public void setBfStoTitle(String bfStoTitle) {
		this.bfStoTitle = bfStoTitle;
	}
	public String getBfExtension() {
		return bfExtension;
	}
	public void setBfExtension(String bfExtension) {
		this.bfExtension = bfExtension;
	}
	public String getBfPath() {
		return bfPath;
	}
	public void setBfPath(String bfPath) {
		this.bfPath = bfPath;
	}
	public String getBfSize() {
		return bfSize;
	}
	public void setBfSize(String bfSize) {
		this.bfSize = bfSize;
	}
	public String getBfMimeType() {
		return bfMimeType;
	}
	public void setBfMimeType(String bfMimeType) {
		this.bfMimeType = bfMimeType;
	}
	public String getLocalBaseFilePath() {
		return localBaseFilePath;
	}
	public void setLocalBaseFilePath(String localBaseFilePath) {
		this.localBaseFilePath = localBaseFilePath;
	}
	public String getTomcatBaseFilePath() {
		return tomcatBaseFilePath;
	}
	public void setTomcatBaseFilePath(String tomcatBaseFilePath) {
		this.tomcatBaseFilePath = tomcatBaseFilePath;
	}
	public String getListThumb() {
		return listThumb;
	}
	public void setListThumb(String listThumb) {
		this.listThumb = listThumb;
	}
	public String getViewThumb() {
		return viewThumb;
	}
	public void setViewThumb(String viewThumb) {
		this.viewThumb = viewThumb;
	}
	public int getBcType() {
		return bcType;
	}
	public void setBcType(int bcType) {
		this.bcType = bcType;
	}
	public int getPbcCode() {
		return pbcCode;
	}
	public void setPbcCode(int pbcCode) {
		this.pbcCode = pbcCode;
	}
	public List<Integer> getDelFileList() {
		return delFileList;
	}
	public void setDelFileList(List<Integer> delFileList) {
		this.delFileList = delFileList;
	}
	public int getPicked() {
		return picked;
	}
	public void setPicked(int picked) {
		this.picked = picked;
	}
	public int getSelected() {
		return selected;
	}
	public void setSelected(int selected) {
		this.selected = selected;
	}
	public String getSearchWrd() {
		return searchWrd;
	}
	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}
	public int getBdSum() {
		return bdSum;
	}
	public void setBdSum(int bdSum) {
		this.bdSum = bdSum;
	}
}
