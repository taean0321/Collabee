package com.one.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.yr.dao.HomeDao;
import com.yr.dto.NoneFolderDto;

public class WorkspaceSearchDao {
	public ArrayList<NoneFolderDto> searchWorkspace_Name(int member_id, String input) {
		HomeDao dao = new HomeDao();
		ArrayList<NoneFolderDto> list = new ArrayList<NoneFolderDto>();
		
		String sqlPart = input.equals("")? "" : "and REGEXP_LIKE(workspace_name, ?, 'i')"; //
		String sql = "select w.workspace_id, w.workspace_name, w.color, wo.order_id from workspace w, workspace_order wo " + 
					"where w.workspace_id = wo.workspace_id and wo.member_id = ? "+sqlPart+" order by wo.order_id";
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,member_id);
			if(input.equals("")==false) {
				pstmt.setString(2, input);
			}
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int workspace_id = rs.getInt(1);
				String workspace_name = rs.getString(2);
				if(workspace_name.equals("프라이빗 공간")) {
					continue;
				}
				String color = rs.getString(3);
				int order = rs.getInt(4);
				int count = dao.countMember(workspace_id);
				NoneFolderDto dto = new NoneFolderDto(workspace_id, workspace_name, color, count, order);
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