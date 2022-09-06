package com.one.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DocumentDelDao {
	public int delDocument(int document_id) {
		//제약조건 확인
		String sql = "DELETE FROM document WHERE document_id = ?";
		int result=0;
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, document_id);
			result = pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}//선택한 문서
		return result;
	} 
}
