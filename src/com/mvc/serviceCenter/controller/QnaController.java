package com.mvc.serviceCenter.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.serviceCenter.service.QnaService;

@WebServlet({ "/qnalist", "/qnawrite", "/qnadetail", "/qnadel", "/qnaupdateForm", "/qnaupdate", "/qnasearch" })
public class QnaController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		daul(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		daul(req, resp);
	}

	private void daul(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("addr : " + addr);

		RequestDispatcher dis = null;
		req.setCharacterEncoding("UTF-8");
		String page = "";
		String msg = "";
		QnaService service = new QnaService(req);

		switch (addr) {
		case "/qnalist":
			System.out.println("QNA 리스트 요청");
			String loginemail = (String)req.getSession().getAttribute("loginemail");
			System.out.println("현재 loginemail: "+loginemail);
			req.setAttribute("map", service.list(loginemail));
			req.setAttribute("loginemail", loginemail);
			dis = req.getRequestDispatcher("qnalist.jsp");
			dis.forward(req, resp);
			break;
			
		case "/qnawrite":
			System.out.println("Q&A 글쓰기 요청");
			msg = "글 작성 실패";
			page = "qnawriteForm.jsp";
			if (service.write() == 1) {
				msg = "글 작성 성공";
				page = "qnalist";
			}
			req.setAttribute("msg", msg);

			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp);

			break;
			
		case "/qnadetail":
			System.out.println("Q&A 상세보기");
			req.setAttribute("qna", service.detail());
			dis = req.getRequestDispatcher("qnacommentList");
			dis.forward(req, resp);
			
			break;
	
			
		case "/qnadel":
			System.out.println("Q&A 삭제 요청");

			msg = "삭제 성공";
			page = "qnalist";
			if(service.del()>0) {
				msg="글 작성 성공";
				page="qnalist";
			}
			req.setAttribute("msg", msg);
			resp.sendRedirect(page);			

			break;
			
		case "/qnaupdateForm":
			System.out.println("Q&A 수정 요청");
			req.setAttribute("qna", service.qnaupdateForm());
			req.setAttribute("email", req.getParameter("email"));
			dis = req.getRequestDispatcher("qnaupdateForm.jsp");
			dis.forward(req, resp);
			break;

			
		case "/qnaupdate":
			System.out.println("Q&A 업데이트 완료");
			String qnano = req.getParameter("qnano");
			System.out.println("qnano : " + qnano);
			msg = "수정에 실패 했다";
			page = "qnaupdateForm?qnano=" + qnano;
			if (service.qnaupdate(qnano) > 0) {
				msg = "수정에 성공";
				page = "qnadetail?qnano=" + qnano;
			}
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp);
			break;

		
		case "/qnasearch" :
			System.out.println("qna 검색 요청");
			String searchKey = req.getParameter("searchKey");//검색어
			System.out.println("검색어 : " + searchKey);
			req.setAttribute("srmap", service.searchlist(searchKey));
			req.setAttribute("searchlist", searchKey);
			dis= req.getRequestDispatcher("qnasearch.jsp");
			dis.forward(req, resp);
			
			break;
				
		}
	}

}
