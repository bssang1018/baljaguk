package com.mvc.board.controller;



import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mvc.board.service.BoardService;

import com.oreilly.servlet.MultipartRequest;
<<<<<<< HEAD





@WebServlet({"/fpsearch","/fplist","/fpwriteOk","/fpwriteNo","/fpdetail","/fpdel","/fpupdateForm","/fpupdate","/fpserach","/feedlist","/fdReport","/fdReportWrite","/like"})



=======
@WebServlet({"/like","/fpsearch","/fplist","/fpwriteOk","/fpwriteNo","/fpdetail","/fpdel","/fpupdateForm","/fpupdate","/fpserach","/feedlist","/fdReport","/fdReportWrite"})
>>>>>>> 3a9c52670ca22f92ef4c02f9ba64f1e962ce1506



public class BoardController extends HttpServlet {


	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
	dual(req, resp);
		
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
	dual(req,resp);
		
	
	}

	private void dual(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException{
	
		
		
		String uri = req.getRequestURI();
		String ctx = req.getContextPath();
		String addr = uri.substring(ctx.length());
		System.out.println("addr : "+addr);
		
		RequestDispatcher dis = null;
		BoardService service = new BoardService(req);
		String page ="";
		String msg = "";
	    String fdmsg ="";
		
		switch(addr) {
		
		  case "/fplist": 
			  System.out.println("발자국 불러오기"); 
			  String email = (String) req.getSession().getAttribute("loginemail");
			  req.setAttribute("fplist",  service.fplist(email));
			  dis = req.getRequestDispatcher("fplist.jsp");
		  dis.forward(req, resp); 
		  break;
		  
		  case "/feedlist":
			  System.out.println("피드 불러오기");
			  req.setAttribute("feedlist", service.feedlist());
			  dis = req.getRequestDispatcher("feedlist.jsp");
			  dis.forward(req, resp);
			  break;
		 
		
		case "/fpwriteOk":
			System.out.println("발자국 글쓰기 요청");
			/*
			 * String hashtag = req.getParameter("hashtag"); String text =
			 * req.getParameter("footprintText")
			 * System.out.println("컨트롤러 겟 파라미터 hashtag: "+hashtag);
			 * System.out.println("컨트롤러 겟 파라미터 footprintText"+text);
			 */
			email = (String) req.getSession().getAttribute("loginemail");
		    int num = service.fpwriteOk(email);
		    //feedlist에서 fplist로 바꿈
		   page = num > 0 ? "./fpdetail?footPrintNO="+num:"fplist.jsp";
		    resp.sendRedirect(page);
		    
		break;
		
	/*
	 * case "/fpwriteNo": System.out.println("발자국 글쓰기 요청"); num =
	 * service.fpwriteNo(); page = num > 0 ?
	 * "./fpdetail?footPrintNO="+num:"fplist.jsp"; resp.sendRedirect(page);
	 * 
	 * break;
	 */
		
		case "/fpdetail":
		System.out.println("발자국 상세보기 요청");
		req.setAttribute("footprint", service.fpdetail());
		dis = req.getRequestDispatcher("commentList");
		dis.forward(req, resp);
		break;
		
		
		case "/fpdel":
			System.out.println("삭제 요청");
			service.fpdel();
			resp.sendRedirect("fplist");
			break;
		
		case "/fpupdateForm":
		System.out.println("수정 요청");
		req.setAttribute("footprint", service.fpupdateForm());
		System.out.println("공개 여부 :"+service.fpupdateForm().getRelease());
		dis = req.getRequestDispatcher("fpupdate.jsp");
		dis.forward(req, resp);
		break;
		
		
		case "/fpupdate":
			System.out.println("수정 요청");
			int footPrintNO = service.fpupdate();
			System.out.println("footPrintNO :"+footPrintNO);
			msg ="수정 실패 ㅠㅠ";
			page ="fpupdateForm?footPrintNO="+footPrintNO;
			if(footPrintNO>0) {
				msg="수정 성공!!";
				page ="fpdetail?footPrintNO="+footPrintNO;
			}
			
			req.setAttribute("msg", msg);
			dis = req.getRequestDispatcher(page);
			dis.forward(req, resp);
			
			break;
			
		case "/fpsearch":
			System.out.println("발자국 검색 요청");		
			email = (String)req.getSession().getAttribute("loginemail");
	        String hashtag = req.getParameter("hashtag");// 옵션 키워드
	        System.out.println("해시태그 : "+hashtag);
	        req.setAttribute("hashtaglist", service.hashtaglist(hashtag));
	        dis = req.getRequestDispatcher("fpsearch.jsp");
	        dis.forward(req, resp);
	        
             
			break;
			
			
		case "/fdReportWrite":
			System.out.println("피드 신고폼 요청");
			String fdn = req.getParameter("footPrintNO");
			req.setAttribute("fpdetail", service.fpdetail(fdn));
			dis = req.getRequestDispatcher("fdReportWrite.jsp");
			dis.forward(req, resp);
			break;
			
		case "/fdReport":
			int success =0;
			System.out.println("피드 신고 요청");
			//신고 넘버, 발자국 넘버, 등록일, 신고내용, 신고자 이메일
			 success = service.fdReport();
				
			if(success > 0){
				System.out.println("신고 완료");
				fdmsg="피드를 신고했습니다!!";
			}else {
				System.out.println("피드 신고 실패...");
				fdmsg ="피드 신고를 실패했습니다! 재시도 해주세요(이미 신고된 피드)";
						
			}
			req.setAttribute("fdmsg", fdmsg);
			dis = req.getRequestDispatcher("/feedlist");
			dis.forward(req, resp);
			break;
<<<<<<< HEAD

			
=======
>>>>>>> 3a9c52670ca22f92ef4c02f9ba64f1e962ce1506
		
		  case "/like": 
			  boolean suc;
			  System.out.println("조아용"); 
			  email = (String)  req.getSession().getAttribute("loginemail"); 
			  String fpn = req.getParameter("footPrintNO");
			  System.out.println(fpn+"/ "+email);
			  service.like(fpn, email);
			  dis = req.getRequestDispatcher("/feedlist");
			  dis.forward(req, resp);
		  break;
<<<<<<< HEAD
		 
		}		

		
		   
		case "/like":
		    	System.out.println("좋아요 요청");
		    	success = service.like();
				
				if(success > 0){
					System.out.println("좋아요 완료");
					msg="좋아요를 추가했습니다!!";
				}else {
					System.out.println("좋아요 실패...");
					msg ="좋아요 중복은 불가합니다";
							
				}
				req.setAttribute("msg", msg);
				dis = req.getRequestDispatcher("/feedlist");
				dis.forward(req, resp);
				break;
			
			
		
		}		
	     
		
		
=======
		}
>>>>>>> 3a9c52670ca22f92ef4c02f9ba64f1e962ce1506
	}
}
