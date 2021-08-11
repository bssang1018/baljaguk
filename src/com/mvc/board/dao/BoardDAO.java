package com.mvc.board.dao;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.mvc.board.dto.FootprintDTO;
import com.sun.org.apache.xml.internal.serializer.utils.StringToIntTable;

public class BoardDAO {

	public Connection conn = null;
	public PreparedStatement ps = null;
	public ResultSet rs = null;
	
	
	public BoardDAO() {
		Context ctx;
		try {
			ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	public void resClose() {
		try {
			if(rs != null && !rs.isClosed()) {rs.close();}
			if(ps != null && !ps.isClosed()) {ps.close();}
			if(conn != null && !conn.isClosed()) {conn.close();}
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	
	public ArrayList<FootprintDTO> fplist(String email, int page) {
		String sql="SELECT fnum, footPrintNO, email, reg_date, footprintText , likeCnt, oriFileName, newFileName, lat, lng" + 
				" FROM (SELECT ROW_NUMBER() OVER (ORDER BY f.footprintNO DESC) " + 
				" AS fnum, f.footPrintNO, f.email, f.reg_date, f.footprintText, f.likeCnt, f.postblind ,P.oriFileName, P.newFileName, f.lat, f.lng" + 
				" FROM footprint f LEFT OUTER JOIN PostPic P ON f.footPrintNO =P.footPrintNO" + 
				" WHERE f.email= ? AND postblind IS NULL OR postblind=0)WHERE fnum BETWEEN 1 AND ?";
	    
		       // 한블럭당 페이지 갯수
				int pageLength = 5;
				// 블럭 인덱스
				int currentBlock = page % pageLength == 0 ? page / pageLength : (page / pageLength) + 1;
				// 시작페이지
				int startPage = (currentBlock - 1) * pageLength + 1;
				// 끝페이지
				int endPage = startPage + pageLength - 1;
				// 노출할 데이터 갯수
				int pagePerCnt = 8;
				int end = page * pagePerCnt;
				int start = (end - pagePerCnt) + 1;
		
		
		ArrayList<FootprintDTO>fplist = null;
	    FootprintDTO dto = null;
	    
	    try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setInt(2, end);
			rs = ps.executeQuery();
			fplist = new ArrayList<FootprintDTO>();
			while(rs.next()) {
				dto = new FootprintDTO();
				dto.setBoardNO(rs.getInt("fnum"));
				dto.setFootPrintNO(rs.getInt("footPrintNO"));
				dto.setEmail(rs.getString("email"));
				dto.setReg_date(rs.getDate("reg_date"));
				dto.setFootprintText(rs.getString("footprintText"));
				dto.setLikeCnt(rs.getInt("likeCnt"));
				dto.setOriFileName(rs.getString("oriFileName"));
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setLat(rs.getBigDecimal("lat"));
				dto.setLng(rs.getBigDecimal("lng"));
				fplist.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return fplist;
	}
	//피드 리스트
	public ArrayList<FootprintDTO> feedlist(int page) {
		String sql="SELECT fnum, footPrintNO,  email, reg_date, footprintText, likeCnt ,oriFileName, newFileName, lat, lng " + 
				 " FROM (SELECT ROW_NUMBER() OVER (ORDER BY f.footprintNO DESC)" + 
				 " AS fnum, f.footPrintNO,  f.email, f.reg_date, f.footprintText, f.likeCnt , f.postblind,  P.oriFileName, P.newFileName, f.lat, f.lng " + 
				 " FROM footprint f LEFT OUTER JOIN PostPic P ON f.footPrintNO = P.footPrintNO"  + 
				 " WHERE f.release = 1 AND f.postblind IS NULL OR f.postblind=0) WHERE fnum BETWEEN 1 AND ?";
	   
		// 한블럭당 페이지 갯수
				int pageLength = 5;
				// 블럭 인덱스
				int currentBlock = page % pageLength == 0 ? page / pageLength : (page / pageLength) + 1;
				// 시작페이지
				int startPage = (currentBlock - 1) * pageLength + 1;
				// 끝페이지
				int endPage = startPage + pageLength - 1;
				// 노출할 데이터 갯수
				int pagePerCnt = 8;
				int end = page * pagePerCnt;
				int start = (end - pagePerCnt) + 1;
		
		
		ArrayList<FootprintDTO> feedlist = null;
	    FootprintDTO dto = null;
	    try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, end);
			rs = ps.executeQuery();
			feedlist = new ArrayList<FootprintDTO>();
			while(rs.next()) {
				dto = new FootprintDTO();
				dto.setBoardNO(rs.getInt("fnum"));
				dto.setFootPrintNO(rs.getInt("footPrintNO"));
				dto.setEmail(rs.getString("email"));
				dto.setReg_date(rs.getDate("reg_date"));
				dto.setFootprintText(rs.getString("footprintText"));
				dto.setLikeCnt(rs.getInt("likeCnt"));
				dto.setOriFileName(rs.getString("oriFileName"));
				dto.setNewFileName(rs.getString("newFileName"));
				feedlist.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return feedlist;
	}
    
	
	
	//메인 피드 리스트
	public ArrayList<FootprintDTO> Mfeedlist(int page) {
		String sql ="SELECT fnum, footPrintNO,  email, reg_date, footprintText, oriFileName, newFileName, lat, lng "
				+ "FROM (SELECT ROW_NUMBER() OVER (ORDER BY f.footprintNO DESC) "
				+ "AS fnum, f.footPrintNO,  f.email, f.reg_date, f.footprintText, f.postblind, P.oriFileName, P.newFileName, f.lat, f.lng "
				+ "FROM footprint f LEFT OUTER JOIN PostPic P ON f.footPrintNO = P.footPrintNO "
				+ "WHERE f.release = 1 AND f.postblind IS NULL OR f.postblind=0) WHERE fnum BETWEEN ? AND ? ";
		// 한블럭당 페이지 갯수
		int pageLength = 5;
		// 블럭 인덱스
		int currentBlock = page % pageLength == 0 ? page / pageLength : (page / pageLength) + 1;
		// 시작페이지
		int startPage = (currentBlock - 1) * pageLength + 1;
		// 끝페이지
		int endPage = startPage + pageLength - 1;
		// 노출할 데이터 갯수
		int pagePerCnt = 8;
		int end = page * pagePerCnt;
		int start = (end - pagePerCnt) + 1;
		ArrayList<FootprintDTO> Mfeedlist = null;
		    FootprintDTO dto = null;
		    try {
		    	
				ps = conn.prepareStatement(sql);
				ps.setInt(1, start);
				ps.setInt(2, end);
				rs = ps.executeQuery();
				Mfeedlist = new ArrayList<FootprintDTO>();
				while(rs.next()) {
					dto = new FootprintDTO();
					dto.setBoardNO(rs.getInt("fnum"));
					dto.setFootPrintNO(rs.getInt("footPrintNO"));
					dto.setEmail(rs.getString("email"));
					dto.setReg_date(rs.getDate("reg_date"));
					dto.setFootprintText(rs.getString("footprintText"));
					dto.setOriFileName(rs.getString("oriFileName"));
					dto.setNewFileName(rs.getString("newFileName"));
					Mfeedlist.add(dto);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return Mfeedlist;
	}
	
	//공개 글쓰기
		public int fpwriteOk(FootprintDTO dto, String email) {
			//발자국 글 등록 sql//찜마커가 지금 없으므로 뺴고 진행
			String sql1 = "INSERT INTO footprint(footPrintNO, email,release, footprintText, likeCnt, lat, lng)"
					+ " VALUES(footprint_seq.NEXTVAL,?,?,?,0,?,?)";
			//해시태그 등록 sql
			
			String sql2 ="INSERT INTO Post_Tag(footPrintNO, hashTag) VALUES(?,?)";
			//사진업로드 sql
			String sql3 ="INSERT INTO PostPic(footPrintNO, oriFileName, newFileName)"
					 +" VALUES(?,?,?)";
			int pk =0;
			try {
				ps = conn.prepareStatement(sql1, new String[] {"footPrintNO"});
				ps.setString(1, email);
				ps.setString(2, String.valueOf(dto.getRelease()));// 공개가 1!!!
				ps.setString(3, dto.getFootprintText());
			    ps.setBigDecimal(4, dto.getLat());	
			    ps.setBigDecimal(5, dto.getLng());
				ps.executeUpdate();
				rs = ps.getGeneratedKeys();
				if(rs.next()) {
					//pk = Integer.parseInt(rs.getString("footPrintNO"));	
					ps = conn.prepareStatement(sql3);
					pk = rs.getInt(1);
					ps.setInt(1, pk);
					ps.setString(2, dto.getOriFileName());
					ps.setString(3, dto.getNewFileName());
					System.out.println(dto.getOriFileName()+"/"+dto.getNewFileName());
					ps.executeUpdate();
					//여기에 복사
						ps = conn.prepareStatement(sql2);
						System.out.println("pk: "+rs.getInt(1));
						ps.setInt(1, pk);
						ps.setString(2, dto.getHashTag());
						int a = ps.executeUpdate();
						System.out.println("성공해썽?"+a);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			return pk;
		}
	//신고글 원본을 보기위한 함수생성 준성
	public FootprintDTO fpdetail(String footPrintNO) {
		FootprintDTO dto = null;
		String sql = "SELECT f.footPrintNO , f.email, f.footprintText, f.reg_date, P.oriFileName, P.newFileName, f.release,  f.lat, f.lng FROM footprint f LEFT OUTER JOIN PostPic P ON f.footPrintNO = P.footPrintNO WHERE f.footPrintNO = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, footPrintNO);
			rs = ps.executeQuery();
			if(rs.next()) {
				dto = new FootprintDTO();
				dto.setFootPrintNO(rs.getInt("footPrintNO"));
				dto.setEmail(rs.getString("email"));
				dto.setFootprintText(rs.getString("footprintText"));
				dto.setReg_date(rs.getDate("reg_date"));
				dto.setOriFileName(rs.getString("oriFileName"));
				dto.setNewFileName(rs.getString("newFileName"));
				dto.setLat(rs.getBigDecimal("lat"));
				dto.setLng(rs.getBigDecimal("lng"));
				dto.setRelease(rs.getString("release").charAt(0));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return dto;
	}

	
	
	
	
	public int fpdel(String footPrintNO) {
		int success = 0;
		String sql ="UPDATE footprint SET postblind = 1 , release =1 WHERE footPrintNO = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, footPrintNO);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}




	public int fpupdate(FootprintDTO dto) {
		int success = 0;
		String sql = "UPDATE footprint SET footprintText =?, release = ? WHERE footPrintNO=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, dto.getFootprintText());
			toString();
			ps.setString(2, String.valueOf(dto.getRelease()));
			ps.setInt(3, dto.getFootPrintNO());
			success = ps.executeUpdate();
			System.out.println("피드 신고 완료됨??"+success);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

	public FootprintDTO getFileName(String footPrintNO) {
		
		FootprintDTO dto = null;
		String sql ="SELECT oriFileName, newFileName FROM PostPic WHERE footPrintNO=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, footPrintNO);
			rs = ps.executeQuery();
			
			if(rs.next()) {
				dto = new FootprintDTO();
				dto.setOriFileName(rs.getString("oriFileName"));
				dto.setNewFileName(rs.getString("newFileName"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return dto;
	}



	public FootprintDTO getFileName1(String footPrintNO) {
		FootprintDTO dto = null;
		String sql ="SELECT oriFileName, newFileName  FROM Postpic WHERE footPrintNO=?";
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, footPrintNO);
			rs=ps.executeQuery();
			
			if(rs.next()) {
				dto = new FootprintDTO();
				dto.setOriFileName(rs.getString("oriFileName"));
				dto.setNewFileName(rs.getString("newFileName"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return dto;
	}

	public void fpupdateFileName(String delFileName, FootprintDTO dto) {
		
		String sql ="";
		
		try {
			if(delFileName != null) {
			sql ="UPDATE PostPic SET newFileName =?, oriFileName =? WHERE footPrintNO=?";	
			ps = conn.prepareStatement(sql);
		    ps.setString(1, dto.getNewFileName());
			ps.setString(2, dto.getNewFileName());
			ps.setInt(3, dto.getFootPrintNO());
			ps.executeQuery();
			}else {
				sql="INSERT INTO PostPic(footPrintNO, oriFileName, newFileName)"
						 +"VALUES(PostPic_seq.NEXTVAL,?,?)";
				ps = conn.prepareStatement(sql);
				ps.setString(1, dto.getNewFileName());
				ps.setString(2, dto.getOriFileName());
				ps.executeQuery();
			}
			
			
			
			} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

	public ArrayList<FootprintDTO> hashtaglist(String hashtag) {
		  String sql = "SELECT f.footPrintNO, f.footprintText, p.hashtag"
				  +" FROM footprint f LEFT OUTER JOIN post_tag p ON f.footprintno = p.footprintno"
				  +" WHERE f.footprintno IN (select footprintno from post_tag WHERE hashtag LIKE ?)";
				  
		  ArrayList<FootprintDTO> hashtaglist = null;
		  FootprintDTO dto = null;
		  
		  try {
			ps = conn.prepareStatement(sql);
			
		    ps.setString(1, hashtag+'%');
			rs = ps.executeQuery();
			hashtaglist = new ArrayList<FootprintDTO>();
			while(rs.next()){
				dto = new FootprintDTO();
				dto.setFootPrintNO(rs.getInt("footPrintNO"));
				dto.setFootprintText(rs.getString("footprintText"));
				dto.setHashTag(rs.getString("hashtag"));
				hashtaglist.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
			return hashtaglist;
		}

	public int fdReport(String contentNO, String email, String reportContent) {
		int success =0;
		String sql1 ="SELECT reportNo FROM report1 WHERE contentNO =? AND state =1";
		String sql2 ="INSERT INTO report1(reportNo, contentNO, email, reportText, state)"
				          +"VALUES(reportNo_seq.NEXTVAL,?,?,?,1)";

		try {
			ps = conn.prepareStatement(sql1);
			ps.setString(1, contentNO);
			rs = ps.executeQuery();
			if(!rs.next()) {
				try {
				ps = conn.prepareStatement(sql2);
				ps.setString(1, contentNO);
				ps.setString(2, email);
				ps.setString(3, reportContent);
				success = ps.executeUpdate();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		
		return success;
	}

	public void like(String fpn, String email) {
		String sql1 = "select likecnt from likes where contentno=? AND email=?";
		String sql2 = "INSERT  INTO likes(contentno, likecnt, email) VALUES(?,1,?)";
		String sql3 = "UPDATE footprint SET likecnt  = (select count(email) from likes where contentno=? AND likecnt = 1) where footprintno = ?";
		String sql4 = "UPDATE likes SET likecnt = ? WHERE contentno =?";
		try {
			
			ps = conn.prepareStatement(sql1);
			ps.setString(1, fpn);
			ps.setString(2, email);
			rs = ps.executeQuery();
			boolean success = rs.next();
			System.out.println("성공 유무 :"+success);
			if(!success) {
				ps = conn.prepareStatement(sql2);
				ps.setString(1, fpn);
				ps.setString(2, email);
				ps.executeUpdate();
				System.out.println("false - sql2 번 실행" );

				ps = conn.prepareStatement(sql3);
				ps.setString(1, fpn);
				ps.setString(2, fpn);
				ps.executeUpdate();
				System.out.println("false - sql3 번 실행" );
			
			}else {
				ps = conn.prepareStatement(sql1);
				ps.setString(1, fpn);
				ps.setString(2, email);
				rs = ps.executeQuery();
				int i = 1;
				System.out.println(rs.next());
				System.out.println("rs 저장 값 int : "+rs.getInt(1));
				if(rs.getInt(1)==1) {
					i = 0;
					System.out.println("rs 값은:"+i);
				}
					ps = conn.prepareStatement(sql4);
					ps.setInt(1, i);
					ps.setString(2, fpn);
					ps.executeUpdate();
				
				ps = conn.prepareStatement(sql3);
				ps.setString(1, fpn);
				ps.setString(2, fpn);
				ps.executeUpdate();
				System.out.println("sql3 번 실행");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			resClose();
		}
	}
}

