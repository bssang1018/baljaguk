package com.mvc.board.service;

import java.io.UnsupportedEncodingException;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;


import com.mvc.board.dao.BoardDAO;
import com.mvc.board.dto.FootprintDTO;

public class BoardService {

	HttpServletRequest req = null;
	
	
	public BoardService(HttpServletRequest req) {
		try {
			req.setCharacterEncoding("UTF-8");
			this.req = req;
			
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<FootprintDTO> fplist(String email) {
		
		BoardDAO dao = new BoardDAO();
		String page = req.getParameter("page");
		if(page == null) {
			page= "1";
		}
		ArrayList<FootprintDTO> fplist = dao.fplist(email,Integer.parseInt(page));
		System.out.println(fplist.size()+"건의 발자국");
		
		dao.resClose();
		return fplist;
	}
	
	
	public ArrayList<FootprintDTO> feedlist() {
		BoardDAO dao = new BoardDAO();
		String page = req.getParameter("page");
		if(page == null) {
			page= "1";
		}
		ArrayList<FootprintDTO> feedlist = dao.feedlist(Integer.parseInt(page));
		System.out.println(feedlist.size()+"건의 피드");
		
		dao.resClose();
		return feedlist;
	}

	public ArrayList<FootprintDTO> Mfeedlist() {
		BoardDAO dao = new BoardDAO();
		String page = req.getParameter("page");
		if(page == null) {
			page= "1";
		}
		ArrayList<FootprintDTO> Mfeedlist = dao.Mfeedlist(Integer.parseInt(page));
		System.out.println(Mfeedlist.size()+"건의 피드");
		
		dao.resClose();
		return Mfeedlist;
	}
	//공개
		public int fpwriteOk(String email) {
			System.out.println("로그인한 이메일: "+ email);
			int pk =0;
			UploadService  upload = new UploadService(req);
			FootprintDTO dto = upload.photoUpload();//사진 업로드
			//글 쓰기
			BoardDAO dao = new BoardDAO();
			pk = dao.fpwriteOk(dto, email);
			System.out.println("footPrintNO : "+pk);
			dao.resClose();
			return pk;
		}


	public FootprintDTO fpdetail() {
		
		FootprintDTO dto = null;
		String footPrintNO = req.getParameter("footPrintNO");
        BoardDAO dao = new BoardDAO();
		dto = dao.fpdetail(footPrintNO);
		//System.out.println("dto : "+dto);
		dao.resClose();
		return dto;
	}
	public FootprintDTO fpdetail(String footPrintNO) {
		
		FootprintDTO dto = null;
		System.out.println("footPrintNO : "+footPrintNO);
        BoardDAO dao = new BoardDAO();
		dto = dao.fpdetail(footPrintNO);
		//System.out.println("dto : "+dto);
		dao.resClose();
		return dto;
	}

	public int fpdel() {
		String footPrintNO = req.getParameter("footPrintNO");
		System.out.println("footPrintNO : "+footPrintNO);
		
		BoardDAO dao = new BoardDAO();
		//int success = dao.del(footPrintNO);
		//System.out.println("del success : "+success);
		//dao.resClose();
		
		//1. footprintNO 로 사진이 있는지 확인
		FootprintDTO dto = dao.getFileName(footPrintNO);
		System.out.println("photo dto : "+dto);
		
		//2. 글 삭제
		int success = dao.fpdel(footPrintNO);
		System.out.println("del success : "+success);
		
		//3. 글삭제 성공 && 업로드한 파일이 있다면
		if(success > 0 && dto != null) {
			System.out.println("파일 삭제 실행!!");
			UploadService upload = new UploadService(req);
			upload.fpdel(dto.getNewFileName());
		}
		dao.resClose();
		return success;
	}

	public FootprintDTO fpupdateForm() {
		String footPrintNO = req.getParameter("footPrintNO");
		System.out.println("footPrintNO : "+footPrintNO);
		BoardDAO dao = new BoardDAO();
		FootprintDTO dto = dao.fpdetail(footPrintNO);
		System.out.println("dto : "+dto);
		dao.resClose();
		return dto;
	}

	/*
	 * public int fpupdate(String footPrintNO) {
	 * 
	 * int success =0;
	 * 
	 * String footprintText = req.getParameter("footprintText");
	 * System.out.println(footprintText);
	 * 
	 * BoardDAO dao = new BoardDAO(); success =
	 * dao.fpupdate(footPrintNO,footprintText);
	 * System.out.println("fpupdate success : "+success); dao.resClose();
	 * 
	 * UploadService upload = new UploadService(req); FootprintDTO dto =
	 * upload.photoUpload();
	 * 
	 * dao.resClose(); return success; }
	 */

	public int fpupdate() {
		
		int footPrintNO = 0;
		
		UploadService upload = new UploadService(req);
		
		FootprintDTO dto = upload.photoUpload();
		System.out.println(dto.getOriFileName()+"/"+dto.getNewFileName());
		
		BoardDAO dao = new BoardDAO();
		int success = dao.fpupdate(dto);
		System.out.println("fpupdate success : "+success);
		
		  if(dto != null && success >0) { footPrintNO = dto.getFootPrintNO(); }
		 
		if(dto.getNewFileName() != null) {
			
			FootprintDTO PostPicInfo = dao.getFileName(String.valueOf(footPrintNO));
			String delFileName = null;
			if(PostPicInfo != null) {
				delFileName = PostPicInfo.getNewFileName();
			}
			System.out.println("delFileName : "+delFileName);
		dao.fpupdateFileName(delFileName, dto);
		upload.fpdel(delFileName);
		}
		dao.resClose();
		return footPrintNO;
	}

	
	/**/
public ArrayList<FootprintDTO> hashtaglist(String hashtag){
		
		BoardDAO dao = new BoardDAO();
		ArrayList<FootprintDTO> hashtaglist = dao.hashtaglist(hashtag);
		
		System.out.println("검색 결과 수 : "+hashtaglist.size());
		dao.resClose();
		return hashtaglist;
		
	}

   public int fdReport() {
	   //신고넘버, 글넘버, 등록일, 신고내용, 신고자 이메일
	   int success =0;
	   String contentNO = req.getParameter("contentNO");
	   String email = req.getParameter("email");
	   String reportContent = req.getParameter("reportContent");
	   System.out.println("글번호 :" +contentNO );
	   BoardDAO dao = new BoardDAO();
	   success = dao.fdReport(contentNO,email,reportContent);
	   dao.resClose();
	   System.out.println("자원 반납 완료~!!");
	    return success;
}

public void like(String fpn, String email) {
	BoardDAO dao = new BoardDAO();
 dao.like(fpn, email);
}



	
}









