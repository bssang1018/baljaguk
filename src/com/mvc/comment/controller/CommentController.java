package com.mvc.comment.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.comment.service.CommentService;

@WebServlet({"/commentWrite","/commentWriteForm","/commentList"})
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
		
		case "/commentWriteForm":
			System.out.println("댓글 작성 폼 요청, 피드번호 추출");
			String footPrintNO = req.getParameter("footPrintNO");
			System.out.println("피드 번호는?: " +footPrintNO);
			req.setAttribute("footPrintNO", footPrintNO);
			dis = req.getRequestDispatcher("commentWrite");
			dis.forward(req, resp);
			break;
		
		case "/commentWrite" :
			System.out.println("댓글 작성 요청...");
			footPrintNO = req.getParameter("footPrintNO");
			System.out.println(footPrintNO);
			String commentText = req.getParameter("commentText");
			service.commentWrite(loginemail, footPrintNO, commentText);
			req.setAttribute("footPrintNO", footPrintNO);
			dis = req.getRequestDispatcher("/fpdetail");
			dis.forward(req, resp);
			break;
			
		case "/commentList":
			System.out.println("댓글 리스트 요청");
			footPrintNO = req.getParameter("footPrintNO");
			System.out.println(footPrintNO);
			req.setAttribute("map", service.commentList(footPrintNO));
			req.setAttribute("footPrintNO", footPrintNO);
			dis = req.getRequestDispatcher("fpdetail.jsp");
			dis.forward(req, resp);
			break;
				
		}
		
		
	}
	
	
}
