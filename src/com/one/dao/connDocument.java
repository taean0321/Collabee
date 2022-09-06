package com.one.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.ta.dao.DBConnection;

public class connDocument {
	//기존문서연결
	void connDocument(int document_id, int schedule_id) {
		String sql = "UPDATE schedule SET document_id = ?, edit_date = SYSDATE WHERE schedule_id = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, document_id); //연결한 문서id
			pstmt.setInt(2, schedule_id); //연결한일정id
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		/*
		 * setEdit_date(member_id, document_id); setFixed_Comment("일정 문서에 연결됨");
		 */
	}
}
