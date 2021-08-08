package com.mvc.comment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mvc.comment.dto.CommentDTO;
import com.mvc.msg.dto.MsgDTO;

public class CommentDAO {
	
	public Connection conn = null;
	public PreparedStatement ps = null;
	public ResultSet rs = null;
	
	public CommentDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int commentWrite(String loginemail, String footprintNO, String commentText) {
		int success = 0;
		String sql = "INSERT INTO comment1(commentno, footprintno, email, commenttext) VALUES(comment1_seq.NEXTVAL,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Integer.parseInt(footprintNO));
			ps.setString(2, loginemail);
			ps.setString(3, commentText);
			success = ps.executeUpdate();
			if(success>0) {
				System.out.println("댓글등록 성공"+success);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

	
	public void resClose() {
		try {
			if (rs !=null && !rs.isClosed()) {
				rs.close();
			}
			if (ps !=null && !ps.isClosed()) {
				ps.close();
			}
			if (conn !=null && !conn.isClosed()) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}

	public HashMap<String, Object> commentList(int page, String footPrintNO) {
		String sql = "SELECT * FROM "
				+"(SELECT ROW_NUMBER() OVER(ORDER BY commentno DESC)AS rnum, commentno, footprintno, regdate, commenttext, commentblind, email FROM comment1 WHERE footprintno= ?) "
				+"WHERE rnum BETWEEN ? AND ?";
				
				ArrayList<CommentDTO> commentList = null;
				HashMap<String, Object> commentMap = new HashMap<String, Object>();
				CommentDTO dto = null;
				
				// 한블럭당 페이지 갯수
				int pageLength = 5;
				// 블럭 인덱스
				int currentBlock = page % pageLength == 0 ? page / pageLength : (page / pageLength) + 1;
				// 시작페이지
				int startPage = (currentBlock - 1) * pageLength + 1;
				// 끝페이지
				int endPage = startPage + pageLength - 1;
				System.out.println("시작 페이지 : " + startPage + " / 끝 페이지 : " + endPage);
				// 노출할 데이터 갯수
				int pagePerCnt = 10;
				int end = page * pagePerCnt;
				int start = (end - pagePerCnt) + 1;
				
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, footPrintNO);
					ps.setInt(2, start);
					ps.setInt(3, end);
					rs = ps.executeQuery();
					commentList = new ArrayList<CommentDTO>();
					while (rs.next()) {
						dto = new CommentDTO();
						dto.setFootPrintNO(rs.getInt("footprintno"));
						dto.setCommentNo(rs.getInt("commentno"));
						dto.setCommentText(rs.getString("commenttext"));
						dto.setEmail(rs.getString("email"));
						dto.setRegDate(rs.getString("regdate"));
						dto.setCommentBlind(rs.getString("commentBlind"));
						commentList.add(dto);
					}
					System.out.println("댓글 리스트의 값이 있나욘?: "+ commentList);
					
					int total = totalCount(footPrintNO);
					// 총 게시글 수에 나올 페이지수 나눠서 짝수면 나눠주고 홀수면 +1
					int totalPages = total % pagePerCnt == 0 ? total / pagePerCnt : (total / pagePerCnt) + 1;
					if (totalPages == 0) {
						totalPages = 1;
					}
					// 끝지점을 맨 마지막 페이지로 지정
					if (endPage > totalPages) {
						endPage = totalPages;
					}
					
					System.out.println("토탈카운팅할 피드넘버: " + footPrintNO);
					System.out.println("총 데이터수 : " + total);
					System.out.println("토탈 페이지 : " + totalPages);
					System.out.println();
					
					//int pages = total / pagePerCnt; // 만들 수 있는 페이지 숫자
					
					commentMap.put("commentList", commentList);
					commentMap.put("totalPage", totalPages);
					commentMap.put("currPage", page);
					commentMap.put("pageLength", pageLength);
					commentMap.put("startPage", startPage);
					commentMap.put("endPage", endPage);	
				} catch (SQLException e) {
					e.printStackTrace();
				} 
				
				return commentMap;
			}
	
	//댓글 리스트 페이징 처리용
	private int totalCount(String footPrintNO) throws SQLException {
		String sql = "SELECT COUNT(commentno) FROM comment1 WHERE footprintno = ? ";
		ps = conn.prepareStatement(sql);
		ps.setString(1, footPrintNO);
		rs = ps.executeQuery();
		int total = 0;
		if(rs.next()) {
			total = rs.getInt(1);
		}	
		return total;
	}

	public int commentDel(String loginemail, String footPrintNO, String commentNO) {
		String sql = "DELETE FROM comment1 WHERE (footprintno = ? AND commentno = ?) AND email = ?";
		int success = 0;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(3, loginemail);
			ps.setString(1, footPrintNO);
			ps.setString(2, commentNO);
			success = ps.executeUpdate();
			if (success > 0 ) {
				System.out.println("댓글 DB 삭제 성공! 삭제개수: "+success);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}
	
	
	
	
	
	} // dao class end


