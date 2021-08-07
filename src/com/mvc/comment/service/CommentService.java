package com.mvc.comment.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.board.dto.FootprintDTO;
import com.mvc.comment.dao.CommentDAO;

public class CommentService {

	private HttpServletRequest req = null;
	private HttpServletResponse resp = null;
		
	public CommentService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}

	public int commentWrite(String loginemail) {
		System.out.println("loginemail: "+loginemail);
		System.out.println("footprintNo: " + footprintNo);
		int success = 0;

		String commentText = req.getParameter("commentText");
		System.out.println("댓글 내용: "+commentText);
		CommentDAO dao = new CommentDAO();
		success = dao.commentWrite(footprintNo, loginemail, commentText);
		dao.resClose();
		System.out.println("자원반납 했음!");
		
		return success;
	}
		
	
	
	
	
	
	
	
	
	 
	} //class end


