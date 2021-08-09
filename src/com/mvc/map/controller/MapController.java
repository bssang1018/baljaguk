package com.mvc.map.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.map.service.MapService;

@WebServlet({ "/favorite", "/favList", "/favDel" })
public class MapController extends HttpServlet {

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
		req.setCharacterEncoding("UTF-8");
		MapService service = new MapService(req, resp);

		RequestDispatcher dis = null;
		String page = "";
		String msg = "";
		// req.setCharacterEncoding("UTF-8");

		switch (addr) {
		case "/":
			System.out.println("처음");
			/*
			 * File dataFile = new File("../WebContent/page11.json"); try { InputStream
			 * stream = new FileInputStream(dataFile); JsonParser parser =
			 * Json.createParser(stream); }catch(FileNotFoundException e) {
			 * System.out.println(e); }catch(IOException e) { System.out.println(e); }
			 * resp.sendRedirect("index.jsp");
			 */
			break;

		case "/favorite"://ajax
			System.out.println("찜하기");
			String contentsid = req.getParameter("contentsid");			
			service.fav();
			break;
		case "/favList"://ajax
			System.out.println("찜목록 보기");
			service.favList();
			//resp.sendRedirect("list.jsp");
			break;
		case "/favDel":
			System.out.println("찜목록 삭제");
			// service.favDel();
			//String apiNo = req.getParameter("apiNo");
			// System.out.println("apiNo:"+apiNo);
			service.favDel();
			/*
			 * msg = "삭제에 실패 했습니다."; page = "favDel"; if (service.favDel() > 0) { msg =
			 * "삭제에 성공 했습니다."; //page += "?apiNo" + apiNo; } req.setAttribute("msg", msg);
			 * dis = req.getRequestDispatcher("list.jsp"); dis.forward(req, resp);
			 */
			resp.sendRedirect("list.jsp");
			break;

		}

	}

}
