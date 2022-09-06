package com.one.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.one.dto.BoardDto;
import com.ta.dao.DBConnection;

public class BoardDao {
	public ArrayList<BoardDto> getAllBoardList() throws Exception {
		ArrayList<BoardDto> list1 = new ArrayList<BoardDto>();//데이터를 담을 그릇 만듦.
		Connection conn = DBConnection.getConnection();
		String sql= "select * from simple_board order by bno desc";
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			int bno = rs.getInt("bno");
			String writer = rs.getString("writer");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String writedate = rs.getString("writedate");
			
			BoardDto dto = new BoardDto(bno, writer, title, content, writedate);
			list1.add(dto);
		}
		return list1;
	}
}
