package com.mvc.comment.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.comment.service.CommentService;

@WebServlet({"/commentWrite","/commentWriteForm","/commentList","/commentDel", "/qnacommentWrite", "/qnacommentWriteForm", "/qnacommentList", "/qnacommentDel"})
public class CommentController extends HttpServlet {


	private static final long serialVersionUID = 1L;

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
		
		String commentMsg = "";
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
			String commentText = req.getParameter("commentText");
			service.commentWrite(loginemail, footPrintNO, commentText);
			req.setAttribute("footPrintNO", footPrintNO);
			dis = req.getRequestDispatcher("/fpdetail");
			dis.forward(req, resp);
			break;
			
		case "/commentList":
			System.out.println("댓글 리스트 요청...");
			footPrintNO = req.getParameter("footPrintNO");
			System.out.println(footPrintNO);
			req.setAttribute("map", service.commentList(footPrintNO));
			req.setAttribute("footPrintNO", footPrintNO);
			dis = req.getRequestDispatcher("fpdetail.jsp");
			dis.forward(req, resp);
			break;
				
		case "/commentDel":
			System.out.println("댓글 삭제 요청...");
			footPrintNO = req.getParameter("footPrintNO");
			String commentNO = req.getParameter("commentNO");
			int success = service.commentDel(loginemail, footPrintNO, commentNO);
			if (success > 0) {
				commentMsg = "댓글을 삭제했습니다!";
				req.setAttribute("commentMsg", commentMsg);
				dis = req.getRequestDispatcher("/fpdetail");
				dis.forward(req, resp);
			}else {
				commentMsg = "댓글 삭제를 실패했습니다!";
				req.setAttribute("commentMsg", commentMsg);
				dis = req.getRequestDispatcher("/fpdetail");
				dis.forward(req, resp);
			}
			break;
			
		case "/qnacommentList":
			System.out.println("댓글 리스트 요청...");
			String qnano = req.getParameter("qnano");
			System.out.println(qnano);
			req.setAttribute("map", service.qnacommentList(qnano));
			req.setAttribute("qnano", qnano);
			dis = req.getRequestDispatcher("qnadetail.jsp");
			dis.forward(req, resp);
			break;	
			
			
		case "/qnacommentWriteForm":
			System.out.println("댓글 작성 폼 요청, 피드번호 추출");
			qnano = req.getParameter("qnano");
			System.out.println("qna 번호는?: "+qnano);
			req.setAttribute("qnano", qnano);
			dis = req.getRequestDispatcher("qnacommentWrite");
			dis.forward(req, resp);
			break;
			
		case "/qnacommentWrite" :
			System.out.println("댓글 작성 요청...");
			qnano = req.getParameter("qnano");
			System.out.println(qnano);
			String commentText1 = req.getParameter("commentText1");
			service.commentWrite1(loginemail, qnano, commentText1);
			req.setAttribute("qnano", qnano);
			dis = req.getRequestDispatcher("/qnadetail");
			dis.forward(req, resp);
			break;
			
		case "/qnacommentDel":
			System.out.println("댓글 삭제 요청...");
			qnano = req.getParameter("qnano");
			String answerno = req.getParameter("answerno");
			success = service.qnacommentDel(loginemail, qnano, answerno);
			if (success > 0) {
				commentMsg = "댓글을 삭제했습니다!";
				req.setAttribute("commentMsg", commentMsg);
				dis = req.getRequestDispatcher("/qnadetail");
				dis.forward(req, resp);
			}else {
				commentMsg = "댓글 삭제를 실패했습니다!";
				req.setAttribute("commentMsg", commentMsg);
				dis = req.getRequestDispatcher("/qnadetail");
				dis.forward(req, resp);
			}
			break;
	
		}
		
		
	}
	
	
}
