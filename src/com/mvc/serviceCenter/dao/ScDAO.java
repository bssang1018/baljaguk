package com.mvc.serviceCenter.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;
<<<<<<< HEAD
import com.mvc.comment.dto.CommentDTO;
import com.mvc.board.dto.FootprintDTO;
=======

import com.mvc.comment.dto.CommentDTO;
import com.mvc.board.dto.FootprintDTO;

>>>>>>> 4255dc68ee8e0e3bb1cdf5bb2889022a6238d948
import com.mvc.member.dto.MemberDTO;
import com.mvc.msg.dto.MsgDTO;
import com.mvc.serviceCenter.dto.ReportDTO;
import com.mvc.serviceCenter.dto.ScServiceDTO;



public class ScDAO {
	
	
	public Connection conn = null;
	public PreparedStatement ps = null;
	public ResultSet rs = null;
	public String sql= null;
	public ScDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void resClose() {
		try {
			if(rs!=null && !rs.isClosed()) {rs.close();}
			if(ps!=null && !ps.isClosed()) {ps.close();}
			if(conn!=null && !conn.isClosed()) {conn.close();}
			System.out.println("자원반납 완");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int toatalCount() throws SQLException {
		String sql = "SELECT COUNT(email) FROM member";
		ps = conn.prepareStatement(sql);
		rs = ps.executeQuery();
		int total = 0;
		if(rs.next()) {
			total = rs.getInt(1);
		}
		return total;
	}
	
	public int toatalCount(String condition) throws SQLException {
		System.out.println("일루와");
		String sql = "SELECT COUNT(email) FROM member WHERE "+condition+" = 0";
		System.out.println(sql);
		ps = conn.prepareStatement(sql);
		System.out.println("일루와");
		rs = ps.executeQuery();
		int total = 0;
		if(rs.next()) {
			total = rs.getInt(1);
		}
		return total;
	}
	
	public int toatalCountR(String condition) throws SQLException {
		System.out.println("일루와");
		String sql = "SELECT COUNT(email) FROM report1 WHERE "+condition+" is not null";
		System.out.println(sql);
		ps = conn.prepareStatement(sql);
		System.out.println("일루와");
		rs = ps.executeQuery();
		int total = 0;
		if(rs.next()) {
			total = rs.getInt(1);
		}
		return total;
	}
	
	//신고 글 상세보기
	public ArrayList<FootprintDTO> contdetail() {
		sql = "SELECT * FROM footprint A INNER JOIN report1 B ON A.footprintno = B.contentno";
		ArrayList<FootprintDTO> list = null;
		FootprintDTO dto = null;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<FootprintDTO>();
			while(rs.next()) {
				dto = new FootprintDTO();
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//신고 댓글 상세보기
	public ArrayList<CommentDTO> commdetail() {
		sql = "SELECT * FROM comment1 A INNER JOIN report1 B ON A.commentno = B.commentno";
		ArrayList<CommentDTO> list = null;
		CommentDTO dto = null;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<CommentDTO>();
			while(rs.next()) {
				dto = new CommentDTO();
				
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	//신고 메세지 상세보기
	public ArrayList<MsgDTO> messdetail() {
		sql = "SELECT * FROM message A INNER JOIN report1 B ON A.msgno = B.msgno";
		ArrayList<MsgDTO> list = null;
		MsgDTO dto = null;
		
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			list = new ArrayList<MsgDTO>();
			while(rs.next()) {
				dto = new MsgDTO();
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	//신고 글 리스트 불러오기
	public HashMap<String, Object> rcontload(int page) {
		int pagePerCnt = 5;
		int end = page*pagePerCnt;
		int start = (end-pagePerCnt)+1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		sql = "SELECT * FROM"+
		 "(SELECT ROW_NUMBER() OVER(ORDER BY email DESC) AS rnum," + 
		 "reportno, categoryno, email, reporttext, reportdate, state " +
		 "FROM report1 WHERE contentno is not null) WHERE rnum BETWEEN ? AND ?";
		ArrayList<ReportDTO> list = null;
		ReportDTO dto = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			list = new ArrayList<ReportDTO>();
			while(rs.next()) {
				dto = new ReportDTO();
				dto.setReportNo(rs.getInt("reportno"));
				dto.setCategoryNo(rs.getInt("categoryno"));
				dto.setReportText(rs.getString("reporttext"));
				dto.setEmail(rs.getString("email"));
				dto.setReportDate(rs.getDate("reportdate"));
				dto.setState(rs.getString("state").charAt(0));
				list.add(dto);
			}
			System.out.println("list: "+list);
			int total = toatalCountR("contentno"); // 총 게시글 수
			int pages = (total%pagePerCnt == 0) ? total/pagePerCnt : total/pagePerCnt+1;
			System.out.println("총 게시글 수 : "+total+"/ 페이지 수 : "+pages);
			map.put("list", list);
			map.put("totalPage", pages);
			map.put("currPage", page);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}

	//신고 메세지 리스트 보기
	public HashMap<String, Object> rmessload(int page) {
		int pagePerCnt = 5;
		int end = page*pagePerCnt;
		int start = (end-pagePerCnt)+1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		sql = "SELECT * FROM"+
				 "(SELECT ROW_NUMBER() OVER(ORDER BY email DESC) AS rnum," + 
				 "reportno, categoryno, email, reporttext, reportdate, state " +
				 "FROM report1 WHERE msgno is not null) WHERE rnum BETWEEN ? AND ?";
		ArrayList<ReportDTO> list = null;
		ReportDTO dto = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			list = new ArrayList<ReportDTO>();
			while(rs.next()) {
				dto = new ReportDTO();
				dto.setReportNo(rs.getInt("reportno"));
				dto.setCategoryNo(rs.getInt("categoryno"));
				dto.setReportText(rs.getString("reporttext"));
				dto.setEmail(rs.getString("email"));
				dto.setReportDate(rs.getDate("reportdate"));
				dto.setState(rs.getString("state").charAt(0));
				list.add(dto);
			}
			System.out.println("list: "+list);
			int total = toatalCountR("msgno"); // 총 게시글 수
			int pages = (total%pagePerCnt == 0) ? total/pagePerCnt : total/pagePerCnt+1;
			System.out.println("총 게시글 수 : "+total+"/ 페이지 수 : "+pages);
			
			map.put("list", list);
			map.put("totalPage", pages);
			map.put("currPage", page);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}

	public HashMap<String, Object> blacklist(int page) {
		//sql = "SELECT email, nickname FROM member WHERE accountBan = 1";
				int pagePerCnt = 5;
				int end = page*pagePerCnt;
				int start = (end-pagePerCnt)+1;
				HashMap<String, Object> map = new HashMap<String, Object>();
				//sql = "SELECT email, name FROM member";
				sql = "SELECT email, name FROM"+
				 "(SELECT ROW_NUMBER() OVER(ORDER BY email DESC) AS rnum," + 
				 "email, name FROM member WHERE blacklist = 1) WHERE rnum BETWEEN ? AND ?";
				ArrayList<MemberDTO> list = null;
				MemberDTO dto = null;
				try {
					ps = conn.prepareStatement(sql);
					ps.setInt(1, start);
					ps.setInt(2, end);
					rs = ps.executeQuery();
					list = new ArrayList<MemberDTO>();
					while(rs.next()) {
						dto = new MemberDTO();
						dto.setEmail(rs.getString("email"));
						//dto.setNickname(rs.getString("nickname"));
						dto.setName(rs.getString("name"));
						list.add(dto);
					}
					int total = toatalCount("blacklist"); // 총 게시글 수
					int pages = (total%pagePerCnt == 0) ? total/pagePerCnt : total/pagePerCnt+1;
					System.out.println("총 게시글 수 : "+total+"/ 페이지 수 : "+pages);
					
					map.put("list", list);
					map.put("totalPage", pages);
					map.put("currPage", page);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return map;
			}

	public MemberDTO detail(String email) {

		MemberDTO dto = null;
		
		sql = "SELECT email,nickname FROM member WHERE email = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setEmail(rs.getString("email"));
				dto.setNickname(rs.getString("nickname"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dto;
	}

	public HashMap<String, Object> memberlist(int page) {
				int pagePerCnt = 5;
				int end = page*pagePerCnt;
				int start = (end-pagePerCnt)+1;
				HashMap<String, Object> map = new HashMap<String, Object>();
				sql = "SELECT email,nickname,name,gender,birth,phone,blacklist,accountban,cancelmember FROM "+
				 "(SELECT ROW_NUMBER() OVER(ORDER BY email DESC) AS rnum," + 
				 "email,nickname,name,gender,birth,phone,blacklist,accountban,cancelmember FROM member) WHERE rnum BETWEEN ? AND ?";
				ArrayList<MemberDTO> list = null;
				MemberDTO dto = null;
				try {
					ps = conn.prepareStatement(sql);
					ps.setInt(1, start);
					ps.setInt(2, end);
					rs = ps.executeQuery();
					list = new ArrayList<MemberDTO>();
					while(rs.next()) {
						dto = new MemberDTO();
						dto.setEmail(rs.getString("email"));
						dto.setNickname(rs.getString("nickname"));
						dto.setName(rs.getString("name"));
						dto.setGender(rs.getString("gender"));
						dto.setBirth(rs.getDate("birth"));
						dto.setPhone(rs.getString("phone"));
						dto.setBlackList(rs.getString("blacklist").charAt(0));
						dto.setAccountBan(rs.getString("accountban").charAt(0));
						dto.setCancelMember(rs.getString("cancelMember").charAt(0));
						list.add(dto);
					}
					int total = toatalCount(); // 총 게시글 수
					int pages = (total%pagePerCnt == 0) ? total/pagePerCnt : total/pagePerCnt+1;
					System.out.println("총 게시글 수 : "+total+"/ 페이지 수 : "+pages);
					
					map.put("list", list);
					map.put("totalPage", pages);
					map.put("currPage", page);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return map;
			}

	public ArrayList<MemberDTO> membersearch(String email) {
		sql = "SELECT email, name FROM member WHERE email=?";
		ArrayList<MemberDTO> list = null;
		MemberDTO dto = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			list = new ArrayList<MemberDTO>();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setEmail(rs.getString("email"));
				dto.setName(rs.getString("name"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public HashMap<String, Object> stoplist(int page) {
		//sql = "SELECT email, nickname FROM member WHERE accountBan = 1";
		int pagePerCnt = 5;
		int end = page*pagePerCnt;
		int start = (end-pagePerCnt)+1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//sql = "SELECT email, name FROM member";
		sql = "SELECT email, name FROM"+
		 "(SELECT ROW_NUMBER() OVER(ORDER BY email DESC) AS rnum," + 
		 "email, name FROM member WHERE accountban = 1) WHERE rnum BETWEEN ? AND ?";
		ArrayList<MemberDTO> list = null;
		MemberDTO dto = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			list = new ArrayList<MemberDTO>();
			while(rs.next()) {
				dto = new MemberDTO();
				dto.setEmail(rs.getString("email"));
				//dto.setNickname(rs.getString("nickname"));
				dto.setName(rs.getString("name"));
				list.add(dto);
			}
			int total = toatalCount("accountban"); // 총 게시글 수
			int pages = (total%pagePerCnt == 0) ? total/pagePerCnt : total/pagePerCnt+1;
			//int pages = total/pagePerCnt+1;// 만들 수 있는 페이지 숫자
			System.out.println("총 게시글 수 : "+total+"/ 페이지 수 : "+pages);
			
			map.put("list", list);
			map.put("totalPage", pages);
			map.put("currPage", page);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}
	
	public ArrayList<MemberDTO> stopmembersearch(String email) {
		//sql = "SELECT email, name FROM member WHERE email=? AND accountBan = 1";
		sql = "SELECT email, name FROM member WHERE email=? AND accountban=1";
		ArrayList<MemberDTO> list = null;
		MemberDTO dto = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			list = new ArrayList<MemberDTO>();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setEmail(rs.getString("email"));
				dto.setName(rs.getString("name"));
				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public MemberDTO memberdetail(String email) {
		MemberDTO dto = null;
		//sql = "SELECT email,nickname FROM member WHERE email = ?";
		sql = "SELECT * FROM member WHERE email=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setEmail(rs.getString("email"));
				dto.setNickname(rs.getString("nickname"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setBirth(rs.getDate("birth"));
				dto.setPhone(rs.getString("phone"));
				dto.setBlackList(rs.getString("blacklist").charAt(0));
				dto.setAccountBan(rs.getString("accountban").charAt(0));
				dto.setCancelMember(rs.getString("cancelmember").charAt(0));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(dto);
		return dto;
	}

	public MemberDTO stopwriteform(String email) {
		MemberDTO dto = null;
		//sql = "SELECT email,nickname FROM member WHERE email = ?";
		sql = "SELECT * FROM member WHERE email=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setEmail(rs.getString("email"));
				dto.setName(rs.getString("name"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(dto);
		return dto;
	}

	public MemberDTO blackwriteform(String email) {
		MemberDTO dto = null;
		//sql = "SELECT email,nickname FROM member WHERE email = ?";
		sql = "SELECT * FROM member WHERE email=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new MemberDTO();
				dto.setEmail(rs.getString("email"));
				dto.setName(rs.getString("name"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(dto);
		return dto;
	}

	public int blackregister(String email, String reason) {
		int success = 0;
		//sql = "UPDATE "
		sql = "UPDATE member SET blacklist=1 WHERE email= ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		System.out.println(reason);
		return success;
	}

	public int stopremove(String email) {
		int success = 0;
		sql = "UPDATE member SET accountban=0 WHERE email=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

	public HashMap<String, Object> withdrawlist(int page) {
		System.out.println("page: "+page);
		int pagePerCnt = 5;
		int end = page*pagePerCnt;
		int start = (end-pagePerCnt)+1;
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		//sql = "SELECT email, name FROM member";
		sql = "SELECT email, name FROM"+
		 "(SELECT ROW_NUMBER() OVER(ORDER BY email DESC) AS rnum," + 
		 "email, name FROM member WHERE cancelmember = 1) WHERE rnum BETWEEN ? AND ?";
		ArrayList<MemberDTO> list = null;
		MemberDTO dto = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, start);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			list = new ArrayList<MemberDTO>();
			while(rs.next()) {
				dto = new MemberDTO();
				dto.setEmail(rs.getString("email"));
				//dto.setNickname(rs.getString("nickname"));
				dto.setName(rs.getString("name"));
				list.add(dto);
			}
			int total = toatalCount("cancelmember"); // 총 게시글 수
			int pages = (total%pagePerCnt == 0) ? total/pagePerCnt : total/pagePerCnt+1;
			System.out.println("총 게시글 수 : "+total+"/ 페이지 수 : "+pages);
			
			map.put("list", list);
			map.put("totalPage", pages);
			map.put("currPage", page);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return map;
	}

	public ArrayList<MemberDTO> blacksearch(String email) {
				sql = "SELECT email, name FROM member WHERE email=? AND blacklist=1";
				ArrayList<MemberDTO> list = null;
				MemberDTO dto = null;
				
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, email);
					rs = ps.executeQuery();
					list = new ArrayList<MemberDTO>();
					if(rs.next()) {
						dto = new MemberDTO();
						dto.setEmail(rs.getString("email"));
						dto.setName(rs.getString("name"));
						list.add(dto);
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return list;
	}

	public int blackremove(String email) {
		int success = 0;
		sql = "UPDATE member SET blacklist=0 WHERE email=?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

	// 원본 불러오기 함수
	public String contentload(int reportno) {
		System.out.println("다오도착");
		String footPrintNO = null;
		sql = "SELECT a.footprintno FROM footprint a JOIN report1 b ON a.footprintno = b.contentno WHERE b.reportno = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reportno);
			rs = ps.executeQuery();
			if(rs.next()) {
				System.out.println("여기옴?");
				footPrintNO = rs.getString("footprintno");
				System.out.println("footprintno: "+rs.getInt("footprintno"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return footPrintNO;
	}

	public void commentload(int reportno) {
		sql = "SELECT * FROM comment a JOIN report1 b ON a.commentno = b.commentno WHERE b.reportno = 1";
	}

	public int messageload(int reportno) {
		int msgNo = 0;
		sql = "SELECT a.msgno FROM message a JOIN report1 b ON a.msgno = b.msgno WHERE b.reportno = ?";
		System.out.println("다오도착");
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, reportno);
			rs = ps.executeQuery();
			if(rs.next()) {
				System.out.println("다오msgno: "+rs.getInt("msgno"));
				msgNo = rs.getInt("msgno");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return msgNo;
	}

	public ArrayList<ReportDTO> reportsearch(String email) {
		sql = "SELECT reportno, categoryno, email, reporttext, reportdate, state FROM report1 WHERE email=?";
		ArrayList<ReportDTO> list = null;
		ReportDTO dto = null;
	}
	
	public int stopregister(String loginemail, String email, String reason) {
		int success = 0;
		ArrayList<ReportDTO> list = null;
		ReportDTO dto = null;
		sql = "SELECT * FROM admin WHERE banedemail = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			list = new ArrayList<ReportDTO>();
			while(rs.next()) {
				dto = new ReportDTO();
				dto.setReportNo(rs.getInt("reportno"));
				dto.setCategoryNo(rs.getInt("categoryno"));
				dto.setEmail(rs.getString("email"));
				dto.setReportText(rs.getString("reporttext"));
				dto.setReportDate(rs.getDate("reportdate"));
				dto.setState(rs.getString("state").charAt(0));
				list.add(dto);
			if (rs.next()) {
				System.out.println("이미 신고된 회원");
				
			} else {
				sql = "INSERT INTO admin(adminemail, banedemail, reason, categoryno) VALUES(?,?,?,14)";
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, loginemail);
					ps.setString(2, email);
					ps.setString(3, reason);
					success = ps.executeUpdate();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return success;
	}

	public ScServiceDTO stopReason(String email) {
		sql = "SELECT * FROM admin WHERE banedemail = ?";
		ScServiceDTO dto = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			rs = ps.executeQuery();
			if(rs.next()) {
				System.out.println("정지사유 조회성공");
				dto = new ScServiceDTO();
				dto.setAdminEmail(rs.getString("adminemail"));
				dto.setBanedEmail(rs.getString("banedemail"));
				dto.setReason(rs.getString("reason"));
				dto.setCategoryNo(rs.getString("categoryNo"));
				dto.setReg_date(rs.getString("reg_date"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

		return dto;
	}
}

