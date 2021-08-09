package com.mvc.map.DTO;

import java.sql.Date;

public class MapDTO {
	
	private String email;
	private String apiNo;
	private Date reg_date;
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getApiNo() {
		return apiNo;
	}
	public void setApiNo(String apiNo) {
		this.apiNo = apiNo;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	
}
