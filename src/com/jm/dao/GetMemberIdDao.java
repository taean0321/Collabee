package com.jm.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.ta.dao.DBConnection;

public class GetMemberIdDao {
	public int GetMemberId(String email) {
		
		Connection conn = DBConnection.getConnection();
System.out.println(email);
		String sql = "SELECT member_id FROM member WHERE email = ?";
		int member_id = -1;
		
		PreparedStatement pstmt;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member_id = rs.getInt("member_id");
			}
			
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return member_id; 
	}
}
