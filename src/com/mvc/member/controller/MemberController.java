package com.mvc.member.controller;

import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.mvc.board.service.BoardService;
import com.mvc.member.dto.MemberDTO;
import com.mvc.member.service.MemberService;

@WebServlet({"/resetpw","/mailchk","/findE","/plusMain","/","/main","/login", "/join","/logout","/overlay", "/memberInfo","/memberUpdate","/memberUpdateForm","/uploadphoto","/cancel","/chk"})
public class MemberController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		dual(req, resp);
	}

	private void dual(HttpServletRequest req, HttpServletResponse resp)  throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String addr = req.getRequestURI().substring(req.getContextPath().length());
		System.out.println("addr : "+ addr);
		
		MemberService service = new MemberService(req, resp);
		RequestDispatcher dis;
		
		switch (addr) {
		
		  case "/main": 
		 System.out.println("홈");
		 BoardService bservice = new BoardService(req);
		 req.setAttribute("M", bservice.Mfeedlist());
		  dis = req.getRequestDispatcher("main.jsp");
		  System.out.println("실행완료");
		  dis.forward(req, resp);
		 break;
		 
		  case "/plusMain":
			  bservice = new BoardService(req);
			  HashMap<String, Object> map = new HashMap<String, Object>();
			  map.put("list", bservice.Mfeedlist());
			  resp.setContentType("text/html; charset=UTF-8");
			  resp.getWriter().print(new Gson().toJson(map));
			  break;
		
		case "/join":
			
			System.out.println("회원가입 요청");
			String email = req.getParameter("email");
			String nickname = req.getParameter("nickname");
			String pw = req.getParameter("pw");
			String name = req.getParameter("name");
			String gender = req.getParameter("gender");
			String birth = req.getParameter("birth");
			String phone = req.getParameter("phone");
			String style = req.getParameter("style");
			
			boolean success = service.join(email, nickname, pw, name, gender, birth, phone, style);
			System.out.println("회원가입 성공?"+success);
			
			  req.setAttribute("success", success);
			  dis =  req.getRequestDispatcher("joinForm.jsp"); 
			  dis.forward(req, resp);
			 
			break;
			
		case "/findE" :
			System.out.println("계정 찾기");
			name = req.getParameter("name");
			birth = req.getParameter("birth");
			boolean suc = false;
			MemberDTO dt = service.findE(name, birth);
			if(dt !=null) {
				suc = true;
				req.setAttribute("info", dt);
				req.setAttribute("suc", suc);
				dis = req.getRequestDispatcher("findE.jsp");
				dis.forward(req, resp);
			}else {
			req.setAttribute("suc", suc);
			dis = req.getRequestDispatcher("findE.jsp");
			dis.forward(req, resp);
			}
			break;
			
		case "/login":
			System.out.println("로그인 요청");
			email = req.getParameter("email");
			pw = req.getParameter("pw");
		    MemberDTO dto = service.login(email, pw);
		  
		    if(dto!=null) {
		    	success=false;
		    	String cancel = "";
		    //System.out.println("dto 값은? "+dto);
		    if(dto.getCancelMember() == '1') {
		    	System.out.println("탈퇴한 회원"+dto.getCancelMember());
		    	//System.out.println("실행");
		    	cancel = "ok";
		    	req.setAttribute("cancel", cancel);
		    	dis = req.getRequestDispatcher("login.jsp");
				  req.getSession().removeAttribute("loginemail");
				  req.getSession().removeAttribute("nickname");
				dis.forward(req, resp);
				break;
			}else {
		    success = true;
		    req.getSession().setAttribute("loginemail", email);
		    req.getSession().setAttribute("nickname", dto.getNickname());
		   // req.getSession().setAttribute("suc", success);
		    req.getSession().setAttribute("admin", dto.getAdminState());
		   // System.out.println("관리자면 1! :" + dto.getAdminState());
			System.out.println("로그인 성공?"+dto.getEmail());
			req.setAttribute("dto", dto);
			req.setAttribute("success", success);
			//dis = req.getRequestDispatcher("main.jsp");
			dis = req.getRequestDispatcher("main"); //메인화면 완성시 주석 풀고 103행 지우기
			dis.forward(req, resp);
			}
		    }else {
		    	 success = false;
		    	req.setAttribute("success", success);
		    	System.out.println(success);
		    	//req.getSession().setAttribute("suc", success);
				dis = req.getRequestDispatcher("login.jsp");
				dis.forward(req, resp);
		    }
			break;
			
		case "/overlay"	:
			email = req.getParameter("email");
			if(email!=null) {
			System.out.println("중복체크"+email);
			String obj = service.overlay(email);
			Gson json = new Gson();
			resp.getWriter().print(obj);
			}
			break;
			
		case "/logout":
			System.out.println("로그아웃");
			req.getSession().removeAttribute("loginemail");
			  req.getSession().removeAttribute("nickname");
			  req.getSession().removeAttribute("suc");
			resp.sendRedirect("index.jsp");
			break;
			
			
		case "/memberInfo":
			System.out.println("개인정보 요청");
			boolean loginChk = false;
				System.out.println("로그인상태"+req.getSession().getAttribute("loginemail"));
				loginChk = true;
				email = (String) req.getSession().getAttribute("loginemail");
				System.out.println("누구? :"+email);
				 dto = service.detail(email);
				 //System.out.println(dto.getEmail()+"가져오나?");
				req.setAttribute("info", dto);
				dis = req.getRequestDispatcher("memberinfo.jsp");
				dis.forward(req, resp);
			break;
			
		case "/memberUpdate":
			System.out.println("회원 정보 수정 요청");
			 email = req.getParameter("email");
			 nickname = req.getParameter("nickname");
			 pw = req.getParameter("pw");
			 name = req.getParameter("name");
			 gender = req.getParameter("gender");
			 birth = req.getParameter("birth");
			 phone = req.getParameter("phone");
			 style = req.getParameter("style");
			success = service.update(email, nickname, pw, name, gender, birth, phone, style);
			System.out.println("회정 정보 수정 완료?" + success);
			 String msg = "수정에 실패 하였습니다.";
			if(success) {
				msg = "수정에 성공 하였습니다.";
			}
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher("memberInfo");
			dis.forward(req, resp);
			break;
			
		case "/memberUpdateForm":
			req.setAttribute("info", service.updateForm());
			dis = req.getRequestDispatcher("memberUpdateForm.jsp");
			dis.forward(req, resp);
			break;
			
		case"/uploadphoto":
			System.out.println("프로필 사진 업로드 요청");
			email = (String) req.getSession().getAttribute("loginemail");
			 suc = service.upload(email);
			System.out.println("업로드 성공?"+ suc);
			//req.setAttribute("photo", service.photo(email));
			dis = req.getRequestDispatcher("memberInfo");
			dis.forward(req, resp);
			//resp.sendRedirect("memberinfo.jsp");
			break;
			
		case"/chk":
			System.out.println("회원탈퇴 전 비번 확인");
			email = (String) req.getSession().getAttribute("loginemail");
			pw = req.getParameter("pw");
			 dto = new MemberDTO();
			dto = service.chk(email, pw);
			System.out.println("서비스 실행");
			if(dto != null) {
				msg="비밀번호 일치 회원 탈퇴 하겠습니까?";
				req.setAttribute("msg", msg);
				dis = req.getRequestDispatcher("cancel.jsp");
				dis.forward(req, resp);
			}else {
				String msgc = "비밀번호 틀림";
				req.setAttribute("msgc", msgc);
				dis = req.getRequestDispatcher("cancel.jsp");
				dis.forward(req, resp);
			}
			break;
			
		case "/cancel":
			System.out.println("회원탈퇴");
			success = false;
			email = (String) req.getSession().getAttribute("loginemail");
			success = service.cancel(email);
			System.out.println("회원 탈퇴 성공? "+success);
			req.getSession().removeAttribute("loginemail");
			  req.getSession().removeAttribute("nickname");
			  req.getSession().removeAttribute("suc");
			dis = req.getRequestDispatcher("index.jsp");
			dis.forward(req, resp);
			break;
		
		case "/mailchk" :
			System.out.println("계정 일치확인");
			email = req.getParameter("email");
			name = req.getParameter("name");
			phone = req.getParameter("phone");
			suc =  service.mailchk(email, name, phone);
			System.out.println("계정 일치 확인 "+suc);
				req.setAttribute("suc", suc);
				req.setAttribute("email", email);
				dis = req.getRequestDispatcher("restpw.jsp");
				dis.forward(req, resp);
			break;
			
		case "/resetpw":
			String pw1= req.getParameter("newpw1");
			String pw2 = req.getParameter("newpw2");
			System.out.println("실행 1pw " + pw1+"/ 2pw "+pw2);
			email = req.getParameter("send");
			System.out.println(email);
			if(pw1.equals(pw2)) {
				suc = service.resetpw(email, pw1);
				//dis = req.getRequestDispatcher("login.jsp");
				resp.sendRedirect("login.jsp");
				System.out.println("비밀번호 변경");
			}else {
				resp.sendRedirect("resetpw.jsp");
			}
			break;
		}
	}
	}
