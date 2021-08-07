package com.mvc.comment.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.comment.service.CommentService;

@WebServlet({"/commentWrite"})
public class CommentController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	private void dual(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("addr: "+addr);
		
		RequestDispatcher dis = null;
		req.setCharacterEncoding("UTF-8");
		CommentService service = new CommentService(req, resp);
		
		String msgMsg = "";
		String loginemail = (String) req.getSession().getAttribute("loginemail");

		switch (addr) {
		
		case "/commentWrite" :
			System.out.println("댓글 작성 요청...");
			System.out.println("뭐가 문제니...");
			//String footPrintNO = req.getParameter("footPrintNO");
			//System.out.println("댓글을 등록할 발자국 넘버: "+ footPrintNO);
			if(service.commentWrite(loginemail) > 0) {
				//메세지 메인으로
				msgMsg = "댓글 작성 성공";
				req.setAttribute("msgMsg", msgMsg);
				dis = req.getRequestDispatcher("/#");
				dis.forward(req, resp);
			} else {
				msgMsg = "댓글 작성을 실패했습니다...ㅠ";
				req.setAttribute("msgMsg", msgMsg);
				dis = req.getRequestDispatcher("#.jsp");
				dis.forward(req, resp);
			}
			break;
		
		
		}
		
		
	}
	
	
}
