package kr.sm2m.noticeBoard.manage.domain;

import kr.sm2m.noticeBoard.main.domain.PagingVo;

public class UserManage extends PagingVo {
	private int miCode;
	private String miId;
	private String miName;
	private String miEmail;
	private String miIp;
	private int miCtg;
	private int mrCtg;
	private String mrTitle;
	private int mrCode;
	
	private int selected; // 검색조건
	private String searchWrd; //검색어
	
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
	public String getMiIp() {
		return miIp;
	}
	public void setMiIp(String miIp) {
		this.miIp = miIp;
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
	public String getMrTitle() {
		return mrTitle;
	}
	public void setMrTitle(String mrTitle) {
		this.mrTitle = mrTitle;
	}
	public int getMrCode() {
		return mrCode;
	}
	public void setMrCode(int mrCode) {
		this.mrCode = mrCode;
	}
	
}
