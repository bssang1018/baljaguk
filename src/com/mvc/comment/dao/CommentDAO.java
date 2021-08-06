package com.mvc.comment.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

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

	public int commentWrite(int footprintNo, String loginemail, String commentText) {
		int success = 0;
		String sql = "INSERT INTO comment1(commentno, footprintno, email, commenttext) VALUES(comment1_seq.NEXTVAL,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, footprintNo);
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

}
