package com.one.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DocumentEtcDao {
	public int getDocumentBookmark(int document_id, int member_id) { //북마크 확인
		String sql ="SELECT count(bookmark_id) \"bookmark\" FROM bookmark WHERE document_id = ? AND member_id = ?";
		int result=0;
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, document_id);
			pstmt.setInt(2, member_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt("bookmark")!=0) {
					result++;
				}
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
		return result;
	}
	
	public void setBookmark(int member_id, int document_id) { //북마크 추가
		String sql = "INSERT INTO bookmark values (bookmark_id.nextval , ?, ?)";
		Connection conn = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_id);
			pstmt.setInt(2, document_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void DelBookmark(int member_id, int document_id) { //북마크 삭제
		String sql = "DELETE FROM bookmark WHERE member_id = ? AND document_id = ?";
		Connection conn = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_id);
			pstmt.setInt(2, document_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public int getDocumentAlarm(int document_id, int member_id) { //알람확인
		String sql = "SELECT count(document_alarm_id) \"alarm\" FROM document_alarm WHERE document_id = ? AND member_id = ?";
		int result=0;
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,  document_id);
			pstmt.setInt(2,  member_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt("alarm")!=0) {
					result++;
				}
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
	
	public void setDocumentAlarm(int document_id, int member_id) {
		String sql = "INSERT INTO document_alarm values (document_alarm_id.nextval , ?, ?)";
		Connection conn = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_id);
			pstmt.setInt(2, document_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void delDocumentAlarm(int document_id, int member_id) {
		String sql = "DELETE FROM document_alarm WHERE document_id = ? AND member_id = ?";
		Connection conn = DBConnection.getConnection();
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, document_id);
			pstmt.setInt(2, member_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
