package com.mvc.friends.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mvc.friends.dto.FriendsDTO;
import com.mvc.friends.dto.TourStyleDTO;

public class FriendsDAO {

	public Connection conn = null;
	public PreparedStatement ps = null;
	public ResultSet rs = null;
	
	public FriendsDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	} //생성자 end

	//회원탈퇴 여부와 친구추가 중복여부 확인
	public boolean friendsAddOverlay(String loginemail, String friends_email) {
		boolean overlay = false;
		String cancleMember;
		
		String sql2 = "SELECT cancelmember FROM member WHERE email = ?";
		String sql = "SELECT email,friends_email,block FROM friends "+
							"WHERE (email = ? AND friends_email = ?) AND relation = 1";
		
		try {
			ps = conn.prepareStatement(sql2);
			ps.setString(1, friends_email);
			rs = ps.executeQuery();
			rs.next();
			cancleMember = rs.getString(1);
			
			if(cancleMember.equals("1")) {
				System.out.println("상대방이 회원탈퇴한 유저 입니다...");
				overlay = true;
			} else {
			
				try {
					ps = conn.prepareStatement(sql);
					ps.setString(1, loginemail);
					ps.setString(2, friends_email);
					rs = ps.executeQuery();
					if(rs.next()) { //이미 친구등록이 돼서 나온결과 있다면...
						System.out.println("친구등록 불가능한 이메일!");
						overlay = true; //친구등록 실패!
					} else { //조회결과가 없다면..
						System.out.println("친구등록 가능한 이메일!");
						overlay = false;
						
						sql = "INSERT INTO friends(email,friends_email,block, relation) "
								+ "VALUES(?,?,0,1)";
						
						try {
							ps = conn.prepareStatement(sql);
							ps.setString(1, loginemail);
							ps.setString(2, friends_email);
							ps.executeUpdate();
						} catch (SQLException e) {
							e.printStackTrace();
						}
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		return overlay;
	}
	
	public int friendsAdd(String loginemail, String friends_email) {
		
		int success = 0;
		String sql = "UPDATE friends SET relation = 1, block = 0 WHERE (email = ? AND friends_email = ?)";
		//block 컬럼에 0 넣는건, 차단하지 않았다는 뜻임! //1이 차단! 생성할땐 무조건 안차단!
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginemail);
			ps.setString(2, friends_email);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}

	
	public int friendsDel(String loginemail, String friends_email) {
		int success = 0;
		String sql = "DELETE FROM friends WHERE email = ? AND friends_email = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginemail);
			ps.setString(2, friends_email);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}
	
	public int friendsBlock(String loginemail, String friends_email) {
		int success = 0;
		String sql = "UPDATE friends SET block = 1, relation = 0 "+
							"WHERE email = ? AND friends_email = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginemail);
			ps.setString(2, friends_email);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}
	
	public int friendsBlockCancle(String loginemail, String friends_email) {
		int success = 0;
		String sql = "DELETE FROM friends WHERE email = ? AND friends_email = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginemail);
			ps.setString(2, friends_email);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}
	
	/*
	public int friendsBlockCancle(String loginemail, String friends_email) {
		int success = 0;
		String sql = "UPDATE friends SET block = 0, relation = 0 "+
							"WHERE email = ? AND friends_email = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginemail);
			ps.setString(2, friends_email);
			success = ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return success;
	}
	*/	
	
	
	
	
	public void resClose() { //자원반납
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
		System.out.println("자원반납했음!");
	} //resClose end

	public ArrayList<TourStyleDTO> friendsRecomend(String loginemail) {
		/*
		String sql = "SELECT email FROM "
				+ "(SELECT ROW_NUMBER() OVER(ORDER BY email DESC) AS rnum, email, categoryNo FROM TourStyle WHERE categoryNo = (SELECT categoryNo FROM TourStyle WHERE email = ?)) "
				+ " WHERE rnum BETWEEN 1 AND 5";
		String sql = "SELECT email FROM "
				+"(SELECT ROW_NUMBER() OVER(ORDER BY email DESC) AS rnum, categoryNo, email FROM TourStyle WHERE email NOT IN (SELECT friends_email FROM friends WHERE email = 'test@test') AND categoryNo = (SELECT categoryNo FROM TourStyle WHERE email = 'test@test')) "
				+"WHERE rnum BETWEEN 1 AND 5";
		*/
		
		String sql = "SELECT email FROM "
				+"(SELECT ROW_NUMBER() OVER(ORDER BY DBMS_RANDOM.RANDOM()) AS rnum, categoryNo, email FROM TourStyle WHERE email NOT IN (SELECT friends_email FROM friends WHERE email = ?) AND categoryNo = (SELECT categoryNo FROM TourStyle WHERE email = ?) AND email != ?) "
				+"WHERE rnum BETWEEN 1 AND 5";
		//ORDER BY DBMS_RANDOM.RANDOM() => 랜덤으로 정렬!
		
		TourStyleDTO dto = null;
		ArrayList<TourStyleDTO> recomendList = null;
		
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, loginemail);
			ps.setString(2, loginemail);
			ps.setString(3, loginemail);
			rs = ps.executeQuery();
			recomendList = new ArrayList<TourStyleDTO>();
			while(rs.next()){
				dto = new TourStyleDTO();
				dto.setEmail(rs.getString("email"));
				recomendList.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return recomendList;
	}

	//내가 차단한 친구리스트 페이징 처리용(friendsBlockList)
	private int totalCount(String loginemail) throws SQLException {
		String sql = "SELECT COUNT(friends_email) FROM (SELECT friends_email FROM friends WHERE block=1 AND email = ?)";
		ps = conn.prepareStatement(sql);
		ps.setString(1, loginemail);
		rs = ps.executeQuery();
		int total = 0;
		if(rs.next()) {
			total = rs.getInt(1);
		}
		resClose();
		return total;
	}
	
	public HashMap<String, Object> friendsBlockList(int page, String loginemail) {
		String sql ="SELECT friends_email FROM " 
						+"(SELECT ROW_NUMBER() OVER(ORDER BY email DESC)AS rnum, friends_email FROM friends WHERE block=1 AND email = ?)"
						+"WHERE rnum BETWEEN ? AND ?";
		FriendsDTO dto = null;
		ArrayList<FriendsDTO> friendsBlockList = null;
		HashMap<String, Object> friendsMap = new HashMap<String, Object>();
		
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
					ps.setString(1, loginemail);
					ps.setInt(2, start);
					ps.setInt(3, end);
					rs = ps.executeQuery();
					friendsBlockList = new ArrayList<FriendsDTO>();
					while(rs.next()) {
						dto = new FriendsDTO();
						dto.setFriends_email(rs.getString("friends_email"));
						friendsBlockList.add(dto);
					}
					System.out.println("friendsBlockList 값이 있나욘? : " +friendsBlockList);
					
					int total = totalCount(loginemail);
					// 총 게시글 수에 나올 페이지수 나눠서 짝수면 나눠주고 홀수면 +1
					int totalPages = total % pagePerCnt == 0 ? total / pagePerCnt : (total / pagePerCnt) + 1;
					if (totalPages == 0) {
						totalPages = 1;
					}
					// 끝지점을 맨 마지막 페이지로 지정
					if (endPage > totalPages) {
						endPage = totalPages;
					}
					System.out.println("총 데이터수 : " + total);
					System.out.println("토탈 페이지 : " + totalPages);
					System.out.println();
					
					friendsMap.put("friendsBlockList", friendsBlockList);
					friendsMap.put("totalPage", totalPages);
					friendsMap.put("currPage", page);
					friendsMap.put("pageLength", pageLength);
					friendsMap.put("startPage", startPage);
					friendsMap.put("endPage", endPage);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return friendsMap;
		}

	//친구리스트 페이징 처리용(friendsList)
	private int totalCount2(String loginemail) throws SQLException {
		String sql = "SELECT COUNT(friends_email) FROM friends WHERE email = ? AND block = 0";
		ps = conn.prepareStatement(sql);
		ps.setString(1, loginemail);
		rs = ps.executeQuery();
		int total = 0;
		if(rs.next()) {
			total = rs.getInt(1);
		}	
		resClose();
		return total;
	}
	
	public HashMap<String, Object> friendsList(int page, String loginemail) {
		String sql ="SELECT friends_email FROM "
						 +"(SELECT ROW_NUMBER() OVER(ORDER BY email DESC)AS rnum, email, friends_email, block FROM friends WHERE ( email = ? AND relation = 1) AND block = 0 ) "
						 +"WHERE rnum BETWEEN ? AND ?";
				
		FriendsDTO dto = null;
		ArrayList<FriendsDTO> friendsList = null;
		HashMap<String, Object> friendsMap = new HashMap<String, Object>();
		
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
					ps.setString(1, loginemail);
					ps.setInt(2, start);
					ps.setInt(3, end);
					rs = ps.executeQuery();
					friendsList = new ArrayList<FriendsDTO>();
					while (rs.next()) {
						dto = new FriendsDTO();
						dto.setFriends_email(rs.getString("friends_email"));
						friendsList.add(dto);
					}
					System.out.println("friendsList 값이 있나욘? : " +friendsList);
					
					int total = totalCount2(loginemail);
					// 총 게시글 수에 나올 페이지수 나눠서 짝수면 나눠주고 홀수면 +1
					int totalPages = total % pagePerCnt == 0 ? total / pagePerCnt : (total / pagePerCnt) + 1;
					if (totalPages == 0) {
						totalPages = 1;
					}
					// 끝지점을 맨 마지막 페이지로 지정
					if (endPage > totalPages) {
						endPage = totalPages;
					}
					System.out.println("총 데이터수 : " + total);
					System.out.println("토탈 페이지 : " + totalPages);
					System.out.println();
					
					friendsMap.put("friendsList", friendsList);
					friendsMap.put("totalPage", totalPages);
					friendsMap.put("currPage", page);
					friendsMap.put("pageLength", pageLength);
					friendsMap.put("startPage", startPage);
					friendsMap.put("endPage", endPage);
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return friendsMap;
	}



	


	






	
} // class end
