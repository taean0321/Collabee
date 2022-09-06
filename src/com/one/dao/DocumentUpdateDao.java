package com.one.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class DocumentUpdateDao {
	public void updateDocument(String title, String content, int document_id) {
			String sql = "UPDATE document SET title = ?, content = ?, edit_date = SYSDATE WHERE document_id = ?";
			try {
				Connection conn = DBConnection.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, title);
				pstmt.setString(2, content); //스캐너 입력
				pstmt.setInt(3, document_id); //현재문서
				pstmt.executeUpdate();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}	
	}
}
