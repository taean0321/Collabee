package com.one.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.one.dto.MyPostDto;

public class MyPostDao {
	//내가 작성한 문서
	public ArrayList<MyPostDto> getMyPost(int fl, int member_id) { 
		ArrayList<MyPostDto> list = new ArrayList<MyPostDto>();//데이터 담을 리스트
		String sql = "SELECT k.kanban_icon_p, d.title, w.workspace_name, to_char(c.creation_date, '\"\"yy\"년 \"mm\"월 \"dd\"일\"') \"creation_date\" " + 
				"FROM document d, workspace w, comments c, kanban_icon k WHERE w.workspace_id = d.workspace_id AND d.document_id = c.document_id " + 
				"AND k.kanban_icon_id = d.kanban_icon_id AND c.comment_writer = ? AND c.content = '새 문서 작성' ORDER BY ? DESC";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, member_id); 
			pstmt.setString(2, "creation_date");
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
