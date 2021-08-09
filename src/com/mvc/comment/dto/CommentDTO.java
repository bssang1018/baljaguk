package com.mvc.comment.dto;

public class CommentDTO {
	private int commentNo;
	private int footPrintNO;
	private String regDate;
	private String commentText;
	private String commentBlind;
	private String email;
	private String qnano;
	
	public String getQnano() {
		return qnano;
	}
	public void setQnano(String qnano) {
		this.qnano = qnano;
	}
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
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
	public int getFootPrintNO() {
		return footPrintNO;
	}
	public void setFootPrintNO(int footPrintNO) {
		this.footPrintNO = footPrintNO;
	}

	
	
	
}
