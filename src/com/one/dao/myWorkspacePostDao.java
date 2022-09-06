package com.one.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.one.dto.MyPostDto;

public class myWorkspacePostDao {
	public ArrayList<MyPostDto> getMyPost(int member_id, int workspace_id) { 
		ArrayList<MyPostDto> list = new ArrayList<MyPostDto>();
		String sql = "SELECT k.kanban_icon_p, d.title, w.workspace_name, d.edit_date, to_char(c.creation_date, '\"\"yy\"년 \"mm\"월 \"dd\"일\"') \"creation_date\" " + 
				"FROM document d, workspace w, comments c, kanban_icon k WHERE w.workspace_id = d.workspace_id AND d.document_id = c.document_id " + 
				"AND k.kanban_icon_id = d.kanban_icon_id AND c.comment_writer = ? AND d.workspace_id = ? AND c.content = '새 문서 작성' ORDER BY c.creation_date DESC";
		Connection conn = null;
		try {
			conn = DBConnection.getConnection();//db랑 연결
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, member_id); //로그인한 멤버 세션?
			pstmt.setInt(2, workspace_id);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				String kanban_icon_p = rs.getString("kanban_icon_p");
				String title = rs.getString("title");
				String workspace_name = rs.getString("workspace_name");
				String date = rs.getString("creation_date");
				MyPostDto dto = new MyPostDto(kanban_icon_p, title, workspace_name, date);
				list.add(dto);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return list;
	} 
}
