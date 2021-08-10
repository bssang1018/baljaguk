package com.mvc.map.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.mvc.map.DAO.MapDAO;
import com.mvc.map.DTO.MapDTO;

public class MapService {
	private HttpServletRequest req = null;
	private HttpServletResponse resp = null;

	public MapService(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
	}

	public void fav() throws IOException {

		String email = (String) req.getSession().getAttribute("loginemail");
		String contentsid = req.getParameter("contentsid");
		//email = "test";
		System.out.println("contentsid : " + contentsid);
		int success = 0;

		MapDAO dao = new MapDAO();

		try {
			success = dao.fav(email, contentsid);
			/*자동 커밋이 설정됨...?
			 * if(success != 0) {//commit || rollback dao.conn.commit(); }else {
			 * dao.conn.rollback(); }
			 */
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			System.out.println("찜하기 성공 여부 : " + success);
			HashMap<String, Object> map = new HashMap<String, Object>();
			map.put("success", success);
			Gson gson = new Gson();
			String obj = gson.toJson(map);
			resp.getWriter().println(obj);
		}
	}

	public void favList() throws IOException {
		boolean loginChk = false;
		// ajax로 데이터를 넘겨주기 위한 hashmap
		HashMap<String, Object> map = new HashMap<String, Object>();

		String email = (String) req.getSession().getAttribute("loginemail");
		// System.out.println("email : "+email);
		// MapDAO dao = new MapDAO();
		// ArrayList<MapDTO> list = dao.favList(email);
		//email = "test";

		if (email != null) {// 로그인 check
			System.out.println("로그인이 됨");
			loginChk = true;

			MapDAO dao = new MapDAO();
			ArrayList<MapDTO> list = null;
			try {
				list = dao.favList(email);
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} finally {
				dao.resClose();
				map.put("favList", list);
			}
		}

		map.put("loginYN", loginChk);
		resp.setContentType("text/html; charset=UTF-8");// 한글 꺠짐 방지
		resp.getWriter().println(new Gson().toJson(map));

	}

	public int favDel() throws IOException {
		String email = (String) req.getSession().getAttribute("loginemail");
		// System.out.println("email : "+email);
		//String apiNo = req.getParameter("contentsid");
		String apiNo = req.getParameter("apiNo");
		System.out.println("contentsID : " + apiNo);
		MapDAO dao = new MapDAO();

		// 삭제
		int success = 0;
		try {
			success = dao.del(apiNo, email);
			//System.out.println("del success : " + success);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			dao.resClose();

			System.out.println("삭제 성공 여부 : " + success);
			/*
			 * HashMap<String, Object> map = new HashMap<String, Object>();
			 * map.put("success", success); Gson gson = new Gson(); String obj =
			 * gson.toJson(map); resp.getWriter().println(obj);
			 */

		}
		return success;

	}
}
