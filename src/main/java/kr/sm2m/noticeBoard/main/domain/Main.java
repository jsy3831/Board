package kr.sm2m.noticeBoard.main.domain;

public class Main {
	private int miCode; //회원고유번호
	private String miId; //회원아이디
	private String miPwd; //회원패스워드
	private String miName; //회원이름
	private String miEmail; //회원이메일
	private int miCtg; //회원가입승인
	private int mrCtg; //회원등급
	private String miIp; //회원가입경로
	
	private int bcCode; //카테고리고유번호
	private String pbcCode;
	private String bcTitle; //카테고리제목
	private String bcRoot; //카테고리관계
	private int bdSum;
	private int bcType; //게시판타입_text: 1, image: 2, media: 3
	private int bcRating;
	
	private String returnUrl;
	
	private int bdCode;
	private String bdTitle;
	private int brSum;
	
	private int selector;
	private int pselector;
	
	public String getPbcCode() {
		return pbcCode;
	}
	public void setPbcCode(String pbcCode) {
		this.pbcCode = pbcCode;
	}
	public int getBdCode() {
		return bdCode;
	}
	public void setBdCode(int bdCode) {
		this.bdCode = bdCode;
	}
	public String getBdTitle() {
		return bdTitle;
	}
	public void setBdTitle(String bdTitle) {
		this.bdTitle = bdTitle;
	}
	public int getBrSum() {
		return brSum;
	}
	public void setBrSum(int brSum) {
		this.brSum = brSum;
	}
	public String getReturnUrl() {
		return returnUrl;
	}
	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}
	public int getBcRating() {
		return bcRating;
	}
	public void setBcRating(int bcRating) {
		this.bcRating = bcRating;
	}
	
	public String getMiIp() {
		return miIp;
	}
	public void setMiIp(String miIp) {
		this.miIp = miIp;
	}
	public int getMiCode() {
		return miCode;
	}
	public void setMiCode(int miCode) {
		this.miCode = miCode;
	}
	public String getMiId() {
		return miId;
	}
	public void setMiId(String miId) {
		this.miId = miId;
	}
	public String getMiPwd() {
		return miPwd;
	}
	public void setMiPwd(String miPwd) {
		this.miPwd = miPwd;
	}
	public String getMiName() {
		return miName;
	}
	public void setMiName(String miName) {
		this.miName = miName;
	}
	public String getMiEmail() {
		return miEmail;
	}
	public void setMiEmail(String miEmail) {
		this.miEmail = miEmail;
	}
	public int getMiCtg() {
		return miCtg;
	}
	public void setMiCtg(int miCtg) {
		this.miCtg = miCtg;
	}
	public int getMrCtg() {
		return mrCtg;
	}
	public void setMrCtg(int mrCtg) {
		this.mrCtg = mrCtg;
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
	public int getSelector() {
		return selector;
	}
	public void setSelector(int selector) {
		this.selector = selector;
	}
	public int getPselector() {
		return pselector;
	}
	public void setPselector(int pselector) {
		this.pselector = pselector;
	}
	
}
