package kr.sm2m.noticeBoard.manage.domain;


public class CateManage {

	private int bcCode; //카테고리고유번호
	private String bcTitle; //카테고리명
	private String bcRoot; //카테고리관계
	private int bdSum; //글갯수
	private int bcType; //게시판타입_text: 1, image: 2, media: 3
	private int bcRating; //게시판권한_모두에게: 0, 일반: 10, 관리자: 90
	
	public int getBcRating() {
		return bcRating;
	}

	public void setBcRating(int bcRating) {
		this.bcRating = bcRating;
	}

	public int getBcCode() {
		return bcCode;
	}

	public void setBcCode(int bcCode) {
		this.bcCode = bcCode;
	}

	public String getBcTitle() {
		return bcTitle;
	}

	public void setBcTitle(String bcTitle) {
		this.bcTitle = bcTitle;
	}

	public String getBcRoot() {
		return bcRoot;
	}

	public void setBcRoot(String bcRoot) {
		this.bcRoot = bcRoot;
	}

	public int getBdSum() {
		return bdSum;
	}

	public void setBdSum(int bdSum) {
		this.bdSum = bdSum;
	}

	public int getBcType() {
		return bcType;
	}

	public void setBcType(int bcType) {
		this.bcType = bcType;
	}
	
}
