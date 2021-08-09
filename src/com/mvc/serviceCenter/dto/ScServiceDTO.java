package com.mvc.serviceCenter.dto;

public class ScServiceDTO {

	private String adminEmail;
	private String banedEmail;
	private String categoryNo;
	private String reg_date;
	private String reason;
	
	
	public String getAdminEmail() {
		return adminEmail;
	}
	public void setAdminEmail(String adminEmail) {
		this.adminEmail = adminEmail;
	}
	public String getBanedEmail() {
		return banedEmail;
	}
	public void setBanedEmail(String banedEmail) {
		this.banedEmail = banedEmail;
	}
	public String getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(String categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}

	
	
}
