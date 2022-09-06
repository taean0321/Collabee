package com.one.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class PrivateIdDao {
	public int getPrivateId(int member_id) {
		String sql = "SELECT workspace_id FROM workspace_mb WHERE member_id = ? AND private_fl = 1";
		Connection conn = DBConnection.getConnection();
		int privateScpaceId = 0;
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				privateScpaceId = rs.getInt("workspace_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return privateScpaceId;
	}
}
