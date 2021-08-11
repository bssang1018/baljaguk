package com.mvc.serviceCenter.service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.mvc.comment.dto.CommentDTO;
import com.mvc.board.dto.FootprintDTO;
import com.mvc.member.dto.MemberDTO;
import com.mvc.msg.dto.MsgDTO;
import com.mvc.serviceCenter.dao.ScDAO;
import com.mvc.serviceCenter.dto.ReportDTO;
import com.mvc.serviceCenter.dto.ScServiceDTO;



public class ScService {

	private HttpServletRequest req = null;
	private HttpServletResponse resp = null;

	public ScService(HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException {
		this.req = req;
		this.resp = resp;
		req.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html; charset=UTF-8");
	}

	public void contdetail() throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();

		ScDAO dao = new ScDAO();
		ArrayList<FootprintDTO> list = null;
		try {
			list = dao.contdetail();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			map.put("list", list);
		}

		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
	}

	public void commdetail() throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();

		ScDAO dao = new ScDAO();
		ArrayList<CommentDTO> list = null;
		try {
			list = dao.commdetail();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			map.put("list", list);
		}

		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));

	}

	public void messdetail() throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();

		ScDAO dao = new ScDAO();
		ArrayList<MsgDTO> list = null;
		try {
			list = dao.messdetail();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			dao.resClose();
			map.put("list", list);
		}

		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));

	}

	public void rcontload(int page) throws IOException{
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		
		map = dao.rcontload(page);
		dao.resClose();
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
	}

	public void rmessload(int page) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		
		map = dao.rmessload(page);
		dao.resClose();
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		
	}
	public String contentload(int reportno) {
		String footPrintNO = null;
		ScDAO dao = new ScDAO();
		footPrintNO = dao.contentload(reportno);
		dao.resClose();
		return footPrintNO;
	}

	public int messageload(int reportno) {
		int msgNo = 0;
		ScDAO dao = new ScDAO();
		msgNo = dao.messageload(reportno);
		dao.resClose();
		return msgNo;
	}
	
	public void blacklist(int page) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		
		map = dao.blacklist(page);
		dao.resClose();
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
	}

	public void blackdetail() throws IOException {
		String email = (String) req.getSession().getAttribute("email");
		System.out.println("상세 데이터 가져올 아이디: "+email);
		
		ScDAO dao = new ScDAO();
		MemberDTO dto = null;
		HashMap<String, Object> map = new HashMap<String, Object>();
		boolean success = false;
		try {
			dto = dao.detail(email);
			success = true;
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			dao.resClose();
			System.out.println("가져올 이메일: "+dto.getEmail());
			map.put("info", dto);
			map.put("success", success);
		}
		if(email != null) {
			req.getSession().removeAttribute("email");
		}
		
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().print(new Gson().toJson(map));
		
	}

	public void memberlist(int page) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		
		map = dao.memberlist(page);
		dao.resClose();
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
	}
	
	public void membersearch(String email) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		ArrayList<MemberDTO> list = null;
		
		list = dao.membersearch(email);
		dao.resClose();
		map.put("list", list);
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		
	}

	public void stoplist(int page) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		
		map = dao.stoplist(page);
		dao.resClose();
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
	}

	public void stopmembersearch(String email) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		ArrayList<MemberDTO> list = null;
		
		list = dao.stopmembersearch(email);
		dao.resClose();
		map.put("list", list);
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		
	}

	public MemberDTO memberdetail() throws IOException {
		MemberDTO dto = null;
		ScDAO dao = new ScDAO();
		String email = req.getParameter("email");
		dto = dao.memberdetail(email);
		System.out.println("DTO: "+dto);
		dao.resClose();
		return dto;
		
	}

	public MemberDTO stopwriteform(String email) {
		MemberDTO dto = null;
		ScDAO dao = new ScDAO();
		email = req.getParameter("email");
		System.out.println("email: "+email);
		dto = dao.stopwriteform(email);
		dao.resClose();
		return dto;
		
	}

	public MemberDTO blackwriteform(String email) {
		MemberDTO dto = null;
		ScDAO dao = new ScDAO();
		email = req.getParameter("email");
		System.out.println("email: "+email);
		dto = dao.blackwriteform(email);
		dao.resClose();
		return dto;
		
	}

	public int blackregister(String loginemail, String email, String reason) {
		int success = 0;
		int success1 = 0;
		ScDAO dao = new ScDAO();
		System.out.println("관리자 이메일: "+loginemail+ "이메일: "+email+"사유: "+reason);
		success = dao.blackregister(loginemail, email, reason);
		if(success > 0 ) {
			System.out.println("admin에 등록완료");
			success1 = dao.blackregister1(email, reason);
			if(success1>0) {
				System.out.println("member에 업데이트 완료");
			}
		}
		dao.resClose();
		
		return success1;
	}

	public int stopregister(String loginemail, String email, String reason) {
		int success = 0;
		ScDAO dao = new ScDAO();
		System.out.println("관리자 이메일: "+loginemail+ "이메일: "+email+"사유: "+reason);
		success = dao.stopregister(loginemail, email, reason);
		dao.resClose();
		
		return success;
	}

	public int stopremove(String email) {
		int success = 0;
		int success1 = 0;
		ScDAO dao = new ScDAO();
		success = dao.stopremove(email);
		if(success>0) {
			System.out.println("member 테이블 0으로 변경");
			success1 = dao.stopremove1(email);
			System.out.println("admin 테이블 삭제 완료");
		}
		dao.resClose();
		
		return success1;
		
	}

	public void withdrawlist(int page) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		
		map = dao.withdrawlist(page);
		dao.resClose();
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
	}

	public void blacksearch(String email) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		ArrayList<MemberDTO> list = null;
		
		list = dao.blacksearch(email);
		dao.resClose();
		map.put("list", list);
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		
	}

	public int blackremove(String email) {
		int success = 0;
		int success1 = 0;
		ScDAO dao = new ScDAO();
		success = dao.blackremove(email);
		if(success>0) {
			System.out.println("member 테이블 0으로 변경");
			success1 = dao.blackremove1(email);
			if(success1>0) {
				System.out.println("admin 테이블 삭제 완료");
			}
		}
		dao.resClose();
		
		return success1;
	}

	public ScServiceDTO stopReason(String email) {
		System.out.println("정지사유를 볼 이메일은?: " + email);
		ScDAO dao = new ScDAO();
		ScServiceDTO dto = null; 
		dto = dao.stopReason(email);
		dao.resClose();
		return dto;
	}
	
	public void reportsearch(String email) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		ArrayList<ReportDTO> list = null;
		
		list = dao.reportsearch(email);
		dao.resClose();
		map.put("list", list);
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
	}

	public void withdrawsearch(String email) throws IOException {
		HashMap<String, Object> map = new HashMap<String, Object>();
		ScDAO dao = new ScDAO();
		ArrayList<MemberDTO> list = null;
		
		list = dao.withdrawsearch(email);
		dao.resClose();
		map.put("list", list);
		resp.setContentType("text/html; charset=UTF-8");
		resp.getWriter().println(new Gson().toJson(map));
		
	}
	
	//정지회원 DB에 1 추가
	public int stopregister1(String email) {
		int success = 0;
		ScDAO dao = new ScDAO();
		String reason = req.getParameter("reason");
		System.out.println("이메일: "+email+"사유: "+reason);
		success = dao.stopregister1(email,reason);
		dao.resClose();
		System.out.println("success: "+success);
		return success;
		
	}

	public int blackregister1(String email) {
		int success = 0;
		ScDAO dao = new ScDAO();
		String reason = req.getParameter("reason");
		System.out.println("이메일: "+email+"사유: "+reason);
		success = dao.blackregister1(email,reason);
		dao.resClose();
		System.out.println("success: "+success);
		return success;
	}

	public ScServiceDTO blackReason(String email) {
		System.out.println("블랙사유를 볼 이메일은?: " + email);
		ScDAO dao = new ScDAO();
		ScServiceDTO dto = null; 
		dto = dao.blackReason(email);
		dao.resClose();
		return dto;
	}

	
		
}

