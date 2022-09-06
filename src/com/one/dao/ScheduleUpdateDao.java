package com.one.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ScheduleUpdateDao {
	//일정 update
	public void updateSchedule(int schedule_id, String title, String summary, String start_date, String finish_date, String location, String attendee) {
		String sql = "UPDATE schedule" 
				+ " SET title=?, content=?, start_date = to_date(?,'yy.mm.dd hh24:mi:ss'), finish_date =to_date(?,'yy.mm.dd hh24:mi:ss'), locations=?, edit_date=SYSDATE" 
				+ " WHERE schedule_id = ?";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, summary); 
			pstmt.setString(3, start_date);
			pstmt.setString(4, finish_date); 
			pstmt.setString(5, location);
			pstmt.setInt(6, schedule_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//참석자 update
	public void updateScheduleAttnedee(int schedule_id, String attendee) {
		Connection conn = DBConnection.getConnection();
		
		String sql1 = "DELETE FROM schedule_attendee WHERE schedule_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1, schedule_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		String sql2 = "INSERT INTO schedule_attendee VALUES (attendee_id.nextval, ?, ?)";
		try {
			String[] list = attendee.split("_");
			System.out.println("split list = "+list);
			for(int i = 0; i <= list.length-1; i++) {
				PreparedStatement pstmt = conn.prepareStatement(sql2);
				pstmt.setInt(1, schedule_id);
				pstmt.setInt(2, Integer.parseInt(list[i]));
				pstmt.executeUpdate();
				DBConnection.pstmtClose(pstmt);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
