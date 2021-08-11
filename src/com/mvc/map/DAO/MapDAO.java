package com.mvc.map.DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.mvc.map.DTO.MapDTO;

public class MapDAO {

	public Connection conn = null;
	public PreparedStatement ps = null;
	public ResultSet rs = null;

	public MapDAO() {
		try {
			Context ctx = new InitialContext();
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Oracle");
			conn = ds.getConnection();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public int fav(String email, String contentsid) throws SQLException {

		String sql = "SELECT email, apiNo FROM tourinfofavorit WHERE email=? AND apiNo=?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, email);
		ps.setString(2, contentsid);
		rs = ps.executeQuery(); 
		if(rs.next()) {
			return 0;
		}else {
			sql = "INSERT INTO tourinfofavorit(email,apino) VALUES(?,?)";
			ps = conn.prepareStatement(sql);
			ps.setString(1, email);
			ps.setString(2, contentsid);
			return ps.executeUpdate();//
		}
	}

	public void resClose() {
		try {
			if (rs != null && !rs.isClosed()) {
				rs.close();
			}
			if (ps != null && !ps.isClosed()) {
				ps.close();
			}
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public ArrayList<MapDTO> favList(String email) throws SQLException {
		String sql = "SELECT apiNo,  reg_date FROM tourinfofavorit WHERE email =  ? ";
		ArrayList<MapDTO> list = new ArrayList<MapDTO>();
		MapDTO dto = null;
		// System.out.println("MapDAO favList");
		
		System.out.println("email:" + email);

		ps = conn.prepareStatement(sql);
		ps.setString(1, email);
		rs = ps.executeQuery();

		while (rs.next()) {
			dto = new MapDTO();
			dto.setApiNo(rs.getString("apiNo"));
			//System.out.println(dto.getApiNo());
			dto.setReg_date(rs.getDate("reg_date"));
			//System.out.println(dto.getReg_date());
			list.add(dto);
		}
		return list;
	}

	public int del(String apiNo, String email) throws SQLException {
		//email = "test";
		String sql = "DELETE FROM tourinfofavorit WHERE email=? AND apiNo = ?";

		ps = conn.prepareStatement(sql);
		ps.setString(2, apiNo);
		ps.setString(1, email);
		return ps.executeUpdate();

	}
}
