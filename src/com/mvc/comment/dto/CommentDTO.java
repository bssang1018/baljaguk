package com.mvc.comment.dto;

import java.sql.Date;

public class CommentDTO {
	private int commentNo;
	private int fooprintNo;
	private Date regDate;
	private String commentText;
	private String commentBlind;
	private String email;
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getFooprintNo() {
		return fooprintNo;
	}
	public void setFooprintNo(int fooprintNo) {
		this.fooprintNo = fooprintNo;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getCommentText() {
		return commentText;
	}
	public void setCommentText(String commentText) {
		this.commentText = commentText;
	}
	public String getCommentBlind() {
		return commentBlind;
	}
	public void setCommentBlind(String commentBlind) {
		this.commentBlind = commentBlind;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getconnentTest() {
		// TODO Auto-generated method stub
		return getconnentTest();
	}
	
	
	
}
