package com.mvc.comment.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.board.dto.FootprintDTO;
import com.mvc.comment.dao.CommentDAO;
import com.mvc.msg.dao.MsgDAO;

public class CommentService {

	private HttpServletRequest req = null;
	private HttpServletResponse resp = null;
		
	public CommentService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}

	public int commentWrite(String loginemail, String footPrintNO, String commentText) {
		System.out.println("loginemail: "+loginemail);
		System.out.println("footPrintNo: " + footPrintNO);
		System.out.println("commentText: " + commentText);
		int success = 0;
		CommentDAO dao = new CommentDAO();
		success = dao.commentWrite(loginemail,footPrintNO ,commentText);
		dao.resClose();
		System.out.println("자원반납 했음!");
		
		return success;
	}

	public HashMap<String,Object> commentList(String footPrintNO) {
		String page = req.getParameter("page");
		CommentDAO dao = new CommentDAO();
		if(page==null) {
			page= "1";
		}
		System.out.println("현재 page: " + page);
		
		HashMap<String, Object> map = dao.commentList(Integer.parseInt(page), footPrintNO);
		dao.resClose();
		System.out.println("자원반납 했음!");
		return map;
		
	}

	public int commentDel(String loginemail, String footPrintNO, String commentNO) {
		System.out.println("loginemail: "+loginemail);
		System.out.println("footPrintNo: " + footPrintNO);
		System.out.println("commentno: "+commentNO);
		CommentDAO dao = new CommentDAO();
		int success = 0;
		success = dao.commentDel(loginemail, footPrintNO, commentNO);
		dao.resClose();
		System.out.println("자원반납 했음!");
		return success;
	}
		
	
	
	
	
	
	
	
	
	 
	} //class end


