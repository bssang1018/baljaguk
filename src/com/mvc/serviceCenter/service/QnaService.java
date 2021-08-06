package com.mvc.serviceCenter.service;

import java.io.UnsupportedEncodingException;
import java.sql.SQLException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import com.mvc.serviceCenter.dao.QnaDAO;
import com.mvc.serviceCenter.dto.QnaDTO;

public class QnaService {
	private HttpServletRequest req = null;
	
	public QnaService(HttpServletRequest req) {
		try {
			req.setCharacterEncoding("UTF-8");
			this.req = req;
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public HashMap<String, Object> list() {
		
		String page = req.getParameter("page");
		System.out.println("현재 page : " + page);
		QnaDAO dao = new QnaDAO();
		if(page == null) {
			page= "1";
		}
		HashMap<String, Object> map = dao.list(Integer.parseInt(page));
		dao.resClose();// 자원 반납
		return map;
	}

	public int write() {
		int success = 0;
		
		String title = req.getParameter("title");
		String email = req.getParameter("email");
		String content = req.getParameter("content");
		System.out.println(title+"/"+email+"/"+content);
		QnaDAO dao = new QnaDAO();
		
		if(title.equals("")||email.equals("")||content.equals("")) {
			System.out.println("경고 빈 칸이 있습니다.");
			success = 0;
			
		}else {

			success = dao.write(title,email,content);
			System.out.println("insert success : " +success);
		}
			dao.resClose();
			return success;		
		
	}





	public Object detail() {
		
		QnaDTO dto = null;
		String qnano = req.getParameter("qnano");
		System.out.println(" qnano : "+qnano);
		
		QnaDAO dao = new QnaDAO();
		
		try {
			dao.conn.setAutoCommit(false);
			dto = dao.detail(qnano);
			System.out.println("detail DTO : "+dto);
			
			if(dto == null) {//commit || rollback
				dao.conn.rollback();
			}else {
				dao.conn.commit();
			}
			
		}catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				dao.resClose();//자원반납			
			}
		
		return dto;
	}

	public int del() {
		int success = 0;
		String qnano = req.getParameter("qnano");
		System.out.println("qnano : " + qnano);
		
		QnaDAO dao = new QnaDAO();
		success = dao.del(qnano);
		System.out.println("del success : " +success);
		
		dao.resClose();		
		return success;
	}

	public Object qnaupdateForm() {
		String qnano = req.getParameter("qnano");
		System.out.println("qnano : " +qnano);
		QnaDAO dao = new QnaDAO();
		QnaDTO dto = dao.qnadetail(qnano);
		System.out.println("dto : " +dto);
		dao.resClose();
		return dto;

	}

	public int qnaupdate(String qnano) {
		int success = 0;
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String email = req.getParameter("email");
		System.out.println(title+"/"+content+"/"+email);
		
		if(title.equals("")||email.equals("")||content.equals("")) {
			System.out.println("경고 빈 칸이 있습니다.");
			success = 0;
			
		}else {
			QnaDAO dao = new QnaDAO();
			success = dao.qnaupdate(qnano,title,content,email);
			System.out.println("update success : " + success);
			dao.resClose();
			System.out.println("완료");
		}
			return success;		
	}


	public HashMap<String, Object> searchlist(String searchKey) {
		String page = req.getParameter("page");
		
		QnaDAO dao = new QnaDAO();
		if(page==null) {
			page= "1";
		}
		System.out.println("현재 page: " + page);
		
		HashMap<String, Object> map = dao.searchlist(Integer.parseInt(page), searchKey);
		dao.resClose();
		System.out.println("자원반납 했음!");
		return map;
	}


}
