package com.yr.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ta.dao.DBConnection;
import com.yr.dto.Dm2PastDto;
import com.yr.dto.DmBarDto;
import com.yr.dto.DmWidgetDto;
import com.yr.dto.MyPartnerDto;
import com.yr.dto.MyWorkspaceDto;
import com.yr.dto.DmWorkspaceMemberDto;

public class DmDao {
	public ArrayList<MyWorkspaceDto> getWorkspace(int member_id) throws SQLException {
		ArrayList<MyWorkspaceDto> list1 = new ArrayList<MyWorkspaceDto>();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = DBConnection.getConnection();
		try{
			String sql = "select wm.workspace_id, w.workspace_name from workspace_mb wm, workspace w where wm.workspace_id = w.workspace_id and wm.member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,member_id);
			rs = pstmt.executeQuery();
			while (rs.next()){
				int workspace_id = rs.getInt(1);
				String workspace_name = rs.getString(2);
				MyWorkspaceDto dto = new MyWorkspaceDto(workspace_id, workspace_name);
				list1.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			rs.close();
			pstmt.close();
		}
		return list1;
	}
	public ArrayList<MyPartnerDto> getPartners(int member_id) throws SQLException {
		ArrayList<MyPartnerDto> list1 = new ArrayList<MyPartnerDto>();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = DBConnection.getConnection();
		try{
			String sql = "select p.my_partner, m.picture, m.name from member m, partner p where m.member_id = p.my_partner and p.member_id = ? and p.agree = 'Y'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,member_id);
			rs = pstmt.executeQuery();
			while (rs.next()){
				int my_partner = rs.getInt(1);
				String picture = rs.getString(2);
				String name = rs.getString(3);
				MyPartnerDto dto = new MyPartnerDto(my_partner, picture, name);
				list1.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			rs.close();
			pstmt.close();
		}
		return list1;
	}
	public ArrayList<DmWorkspaceMemberDto> getWorkspaceMember(int workspace_id) throws SQLException {
		ArrayList<DmWorkspaceMemberDto> list1 = new ArrayList<DmWorkspaceMemberDto>();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = DBConnection.getConnection();
		try{
			String sql = "select wm.member_id, m.picture, m.name from member m, workspace_mb wm where m.member_id = wm.member_id and wm.workspace_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,workspace_id);
			rs = pstmt.executeQuery();
			while (rs.next()){
				int member_id = rs.getInt(1);
				String picture = rs.getString(2);
				String name = rs.getString(3);
				DmWorkspaceMemberDto dto = new DmWorkspaceMemberDto(member_id, picture, name);
				list1.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			rs.close();
			pstmt.close();
		}
		return list1;
	}
	/*	public void setDecision(DmSetDto dmset){
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		try { //document_id.nextval
			String sql = "insert into document(document_id, writer_id, workspace_id, title, content, edit_date, drafts, kanban_icon_id, reader) "
					+ "values(60, ?, ?, ?, ?, to_date(sysdate, 'YYYY/MM/DD HH24:MI:SS'), "
					+ "0, 1, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dmset.getMember_id());
			pstmt.setInt(2, dmset.getWorkspace_id());
			pstmt.setString(3, dmset.getTitle());
			pstmt.setString(4, dmset.getContent());
			//pstmt.setString(5, dmset.getEdit_date());
			// pstmt.setInt(5, dmset.getDrafts());
			pstmt.setInt(5, dmset.getMember_id());
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//문서id받기
		ResultSet rs5 = null;
		PreparedStatement pstmt5 = null;
		int document_id = 0;
		try{
			String sql5 = "select max(document_id) from document where writer_id = ? "
					+ "and workspace_id = ?";
			pstmt5 = conn.prepareStatement(sql5);
			pstmt5.setInt(1,dmset.getMember_id());
			pstmt5.setInt(2,dmset.getWorkspace_id());
			rs5 = pstmt5.executeQuery();
			if (rs5.next()){
				document_id = rs5.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} 
		//decision_making table에 넣기
		/*PreparedStatement pstmt2 = null;
		try { //decision_making_id.nextval
		String sql2 = "insert into decision_making values (?, 60, ?)";
		pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setInt(1, document_id);
		pstmt2.setString(2, dmset.getTitle());
		pstmt2.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		//decision_making_id받기
			ResultSet rs6 = null;
			PreparedStatement pstmt6 = null;
			int decision_making_id = 0;
			try{
				String sql6 = "select max(decision_making_id) from decision_making "
						+ "where document_id = ?";
				pstmt6 = conn.prepareStatement(sql6);
				pstmt6.setInt(1,document_id);
				rs6 = pstmt6.executeQuery();
				while (rs6.next()){
					decision_making_id = rs6.getInt(1);
				}
			} catch(Exception e) {
				e.printStackTrace();
			} 
		//approval_line에 넣기 
		PreparedStatement pstmt3 = null;
		try {
			String sql3 = "insert into approval_line values (?, 1, ?, 2)";
			pstmt3 = conn.prepareStatement(sql3);
			pstmt3.setInt(1, decision_making_id);
			pstmt3.setInt(2, dmset.getDecision_maker());
			pstmt3.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		// 댓글에 새문서 작성
		PreparedStatement pstmt4 = null;
		try { //comment_id.nextval
			String sql4 = "insert into comments values (1004, ?, ?, "
				+ "to_date(sysdate, 'YYYY/MM/DD HH24:MI:SS'), '새 문서 작성', null, 1, 0)";
			pstmt4 = conn.prepareStatement(sql4);
			pstmt4.setInt(1, dmset.getMember_id());
			pstmt4.setInt(2, document_id);
			pstmt4.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		//의사결정등록 comments에 넣기
		PreparedStatement pstmt8 = null;
		try { //comment_id.nextval
			String sql8 = "insert into comments values (1005, ?, ?, "
				+ "to_date(sysdate, 'YYYY/MM/DD HH24:MI:SS'), '의사결정등록', null, 1, 0)";
			pstmt8 = conn.prepareStatement(sql8);
			pstmt8.setInt(1, dmset.getMember_id());
			pstmt8.setInt(2, document_id);
			pstmt8.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}*/
		//만약 파일이 있다면..
/*		if(dmset.getFile_name() != null) {
			PreparedStatement pstmt7 = null;
			try{ //file_id.nextval
				String sql7 = "insert into files values(1004, ?, ?, "
						+ "null, ?, to_date(sysdate, 'YYYY.MM.DD HH24:MI:SS'))";
				pstmt7 = conn.prepareStatement(sql7);
				pstmt7.setInt(1,document_id);
				pstmt7.setInt(2, dmset.getMember_id());
				pstmt7.setString(3, dmset.getFile_name());
				pstmt7.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	}*/
	//의사결정 승인과 반려
	public void setDecision(int decision_making_id, int max, int decision) throws SQLException, ClassNotFoundException {
		PreparedStatement pstmt2 = null;
		Connection conn = DBConnection.getConnection();
		try{
			String sql2 ="update approval_line set decision = ? "
					+ "where decision_making_id = ? and sequence = ?";
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1,decision);
			pstmt2.setInt(2,decision_making_id);
			pstmt2.setInt(3,max);
			pstmt2.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt2.close();
		}
		PreparedStatement pstmt4 = null;
		try{
			String sql4 ="update approval_line set edit_date = to_date(sysdate, 'YYYY.MM.DD HH24:MI:SS') where decision_making_id = ? and sequence = ?";
			pstmt4 = conn.prepareStatement(sql4);
			pstmt4.setInt(1,decision_making_id);
			pstmt4.setInt(2,max);
			pstmt4.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt4.close();
		}
		//문서id뽑기
		ResultSet rs5 = null;
		PreparedStatement pstmt5 = null;
		int document_id = 0;
		try{
			String sql5 = "select document_id from decision_making where decision_making_id = ?";
			pstmt5 = conn.prepareStatement(sql5);
			pstmt5.setInt(1,decision_making_id);
			rs5 = pstmt5.executeQuery();
			while (rs5.next()){
				document_id = rs5.getInt("document_id");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			rs5.close();
			pstmt5.close();
		}
		//문서 수정시간 업뎃
		PreparedStatement pstmt3 = null;
		try{
			String sql3 ="update document set edit_date = to_date(sysdate, 'YYYY.MM.DD HH24:MI:SS') "
					+ "where document_id = ?";
			pstmt3 = conn.prepareStatement(sql3);
			pstmt3.setInt(1,document_id);
			pstmt3.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt3.close();
		}
		//댓글에 의사결정 승인 넣기
		/*PreparedStatement pstmt4 = null;
		try{ //comment_id.nextval
			String sql4 ="insert into comments values(94, ?, ?, "
					+ "to_date(sysdate, 'YYYY.MM.DD HH24:MI:SS'), '의사결정 승인', null, 1, 0)";
			pstmt4 = conn.prepareStatement(sql4);
			pstmt4.setInt(1,member_id);
			pstmt4.setInt(2,document_id);
			pstmt4.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt4.close();
		}*/
	}	
	
	//결정자 변경 // 내가 결정 안 하고 다음사람으로 넘길때 decision 3으로 설정
	public void changeDecisionMaker1(int decision_making_id, int max, int member_id) throws SQLException, ClassNotFoundException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		try{
			String sql ="update approval_line set decision = 3, edit_date = to_date(sysdate, 'YYYY.MM.DD HH24:MI:SS') where decision_making_id = ? and sequence = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,decision_making_id);
			pstmt.setInt(2,max);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt.close();
		}
		PreparedStatement pstmt2 = null;
		try{
			String sql2 ="insert into approval_line values(?, ?, ?, 2, sysdate)";
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1,decision_making_id);
			pstmt2.setInt(2,max+1);
			pstmt2.setInt(3,member_id);
			pstmt2.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt2.close();
		}
		//문서id뽑기
		ResultSet rs5 = null;
		PreparedStatement pstmt5 = null;
		int document_id = 0;
		try{
			String sql5 = "select document_id from decision_making where decision_making_id = ?";
			pstmt5 = conn.prepareStatement(sql5);
			pstmt5.setInt(1,decision_making_id);
			rs5 = pstmt5.executeQuery();
			while (rs5.next()){
				document_id = rs5.getInt("document_id");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			rs5.close();
			pstmt5.close();
		}
		// 결정자 이름뽑기
		/*ResultSet rs6 = null;
		PreparedStatement pstmt6 = null;
		String name = "";
		try{
			String sql6 = "select m.name from approval_line a, member m "
					+ "where a.decision_maker = m.member_id and a.decision_making_id = ? "
					+ "and a.sequence = ?";
			pstmt6 = conn.prepareStatement(sql6);
			pstmt6.setInt(1,decision_making_id);
			pstmt6.setInt(2,sequence+1);
			rs6 = pstmt6.executeQuery();
			while (rs6.next()){
				name = rs6.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			rs6.close();
			pstmt6.close();
		}*/
		//문서 수정시간 업뎃
		PreparedStatement pstmt3 = null;
		try{
			String sql3 ="update document set edit_date = to_date(sysdate, 'YYYY.MM.DD HH24:MI:SS') "
					+ "where document_id = ?";
			pstmt3 = conn.prepareStatement(sql3);
			pstmt3.setInt(1,document_id);
			pstmt3.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt3.close();
		}
		//댓글에 결정자 변경 넣기
		/*PreparedStatement pstmt4 = null;
		String content = "결정자 변경 " + name;
		try{ //comment_id.nextval
			String sql4 ="insert into comments values(105, ?, ?, "
					+ "to_date(sysdate, 'YYYY.MM.DD HH24:MI:SS'), ?, null, 1, 0)";
			pstmt4 = conn.prepareStatement(sql4);
			pstmt4.setInt(1,member_id);
			pstmt4.setInt(2,document_id);
			pstmt4.setString(3, content);
			pstmt4.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt4.close();
		}*/
	}
	// 맥스의 디시젼 뽑기
	public int showDecision(int decision_making_id, int max) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		int decision = 0;
		Connection conn = DBConnection.getConnection();
		try{
			String sql = "select decision from approval_line where decision_making_id = ? and sequence = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,decision_making_id);
			pstmt.setInt(2, max);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				decision = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return decision;
	}
	//결정자 변경 // 내가 결정한거 다음사람으로 넘길때
	public void changeDecisionMaker2(int decision_making_id, int max, int member_id) throws SQLException, ClassNotFoundException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt2 = null;
		try{
			String sql2 ="insert into approval_line values(?, ?, ?, 2, sysdate)";
			pstmt2 = conn.prepareStatement(sql2);
			pstmt2.setInt(1,decision_making_id);
			pstmt2.setInt(2,max+1);
			pstmt2.setInt(3,member_id);
			pstmt2.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt2.close();
		}
		//문서id뽑기
		ResultSet rs5 = null;
		PreparedStatement pstmt5 = null;
		int document_id = 0;
		try{
			String sql5 = "select document_id from decision_making where decision_making_id = ?";
			pstmt5 = conn.prepareStatement(sql5);
			pstmt5.setInt(1,decision_making_id);
			rs5 = pstmt5.executeQuery();
			while (rs5.next()){
				document_id = rs5.getInt("document_id");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			rs5.close();
			pstmt5.close();
		}
		//문서 수정시간 업뎃
		PreparedStatement pstmt3 = null;
		try{
			String sql3 ="update document set edit_date = to_date(sysdate, 'YYYY.MM.DD HH24:MI:SS') "
					+ "where document_id = ?";
			pstmt3 = conn.prepareStatement(sql3);
			pstmt3.setInt(1,document_id);
			pstmt3.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt3.close();
		}
	}
	//의사결정 요청 내용 수정
	public void changeTitle(int decision_making_id, String decision_making_title) throws SQLException, ClassNotFoundException {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		try {
			String sql = "update decision_making set decision_making_title = ? "
					+ "where decision_making_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, decision_making_title);
			pstmt.setInt(2, decision_making_id);
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt.close();
		}
		//문서id뽑기
		ResultSet rs5 = null;
		PreparedStatement pstmt5 = null;
		int document_id = 0;
		try{
			String sql5 = "select document_id from decision_making where decision_making_id = ?";
			pstmt5 = conn.prepareStatement(sql5);
			pstmt5.setInt(1,decision_making_id);
			rs5 = pstmt5.executeQuery();
			while (rs5.next()){
				document_id = rs5.getInt("document_id");
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			rs5.close();
			pstmt5.close();
		}
		//문서 수정시간 업뎃
		PreparedStatement pstmt3 = null;
		try{
			String sql3 ="update document set edit_date = to_date(sysdate, 'YYYY.MM.DD HH24:MI:SS') "
					+ "where document_id = ?";
			pstmt3 = conn.prepareStatement(sql3);
			pstmt3.setInt(1,document_id);
			pstmt3.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt3.close();
		}
		//댓글에 의사결정 요청 내용 수정 넣기
		/*PreparedStatement pstmt4 = null;
		String content = "의사결정 요청 내용 수정 " + decision_making_title;
		try{
			String sql4 ="insert into comments values(comment_id.nextval, ?, ?, "
					+ "to_date(sysdate, 'YYYY.MM.DD HH24:MI:SS'), ?, null, 1, 0)";
			pstmt4 = conn.prepareStatement(sql4);
			pstmt4.setInt(1,member_id);
			pstmt4.setInt(2,document_id);
			pstmt4.setString(3, content);
			pstmt4.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			pstmt4.close();
		}*/
	}
	//의사결정삭제
	public void deldm(int decision_making_id) {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		try {
			String sql = "delete from approval_line where decision_making_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, decision_making_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void delapp(int decision_making_id) {
		Connection conn = DBConnection.getConnection();
		PreparedStatement pstmt = null;
		try {
			String sql = "delete from decision_making where decision_making_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, decision_making_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	//위젯뽑기
	public ArrayList<DmWidgetDto> getWidget(int member_id) throws SQLException {
		ArrayList<DmWidgetDto> list1 = new ArrayList<DmWidgetDto>();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = DBConnection.getConnection();
		try{
			String sql = "select di.decision_icon_p, dm.decision_making_title, m.name, dm.document_id "
					+ "from approval_line a, decision_icon di, decision_making dm, member m, document d "
					+ "where a.decision = di.decision_icon_id and dm.decision_making_id = a.decision_making_id "
					+ "and dm.document_id = d.document_id and a.decision_maker = m.member_id "
					+ "and a.decision = 2 and rownum <= 3 and a.decision_maker = ? order by d.edit_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,member_id);
			rs = pstmt.executeQuery();
			while (rs.next()){
				String decision_icon_p = rs.getString(1);
				String decision_making_title = rs.getString(2);
				String name = rs.getString(3);
				int document_id = rs.getInt(4);
				DmWidgetDto dto = new DmWidgetDto(decision_icon_p, decision_making_title, name, document_id);
				list1.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			rs.close();
			pstmt.close();
		}
		return list1;
	}
	// 시퀀스 맥스 뽑기
	public int maxSequence(int decision_making_id) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = DBConnection.getConnection();
		int max = 1;
		try{
			String sql = "select max(sequence) from approval_line where decision_making_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,decision_making_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				max = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return max;
	}
	//내가 받은 의사결정 모두출력 // 의사결정사진, 의사결정타이틀, 상태이름, 의사결정받은사람, 협업공간이름, 문서이름, 준사람프사-->받은사람프사
	// 결정자가 나인지 --> 의사결정id에서 마지막 순서의 결정자가 나인지
	public ArrayList<Integer> decisionMakingBar(int member_id) throws ClassNotFoundException, SQLException {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = DBConnection.getConnection();
		ArrayList<Integer> arr = new ArrayList<Integer>();
		int decision_making_id;
		try{
			String sql = "select distinct decision_making_id from approval_line where decision_maker = ? and decision = 2";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,member_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				decision_making_id = rs.getInt(1);
				arr.add(decision_making_id);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return arr;
	}
	// 그 문서 몇번이야
	public int whowrote1(int decision_making_id) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = DBConnection.getConnection();
		int document_id = 0;
		try{
			String sql = "select document_id from decision_making where decision_making_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,decision_making_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				document_id = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return document_id;
	}
	public int whowrote2(int document_id) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = DBConnection.getConnection();
		int writer_id = 0;
		try{
			String sql = "select writer_id from document where document_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,document_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				writer_id = rs.getInt(1);   // return int 
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return writer_id;
	}
	public String showWriterName(int member_id) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = DBConnection.getConnection();
		String name = "";
		try{
			String sql = "select name from member where member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,member_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				name = rs.getString(1);   
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return name;
	}
	public String myPicture(int member_id) {
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		Connection conn = DBConnection.getConnection();
		String picture = null;
		try{
			String sql = "select picture from member where member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,member_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				picture = rs.getString(1);   
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return picture;
	}
	public ArrayList<DmBarDto> getDecisionList(int decision_making_id){
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<DmBarDto> list1 = new ArrayList<DmBarDto>();
		Connection conn = DBConnection.getConnection();
		try{
			String sql = "select di.decision_icon_p, dm.decision_making_title, di.decision_making_cur, m.picture,"
					+ " w.workspace_name, d.title, a.decision, d.document_id, m.name, d.edit_date, w.workspace_id"
					+ " from decision_icon di, approval_line a, decision_making dm, member m, workspace w, document d"
					+ " where di.decision_icon_id = a.decision"
					+ " and dm.document_id = d.document_id"
					+ " and d.workspace_id = w.workspace_id"
					+ " and dm.decision_making_id = a.decision_making_id and a.decision = 2"
					+ " and m.member_id = a.decision_maker and dm.decision_making_id = ? order by d.edit_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,decision_making_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String decision_icon_p = rs.getString(1);
				String decision_making_title = rs.getString(2);
				String decision_making_cur = rs.getString(3);
				String picture1 = rs.getString(4);
				String workspace_name = rs.getString(5);
				String title = rs.getString(6);
				int decision = rs.getInt(7);
				int document_id = rs.getInt(8);
				String name = rs.getString(9);
				String edit_date = rs.getString(10);
				int workspace_id = rs.getInt(11);
				DmBarDto dto = new DmBarDto(decision_icon_p, decision_making_title, decision_making_cur, picture1, workspace_name, title, decision, document_id, name, edit_date, workspace_id, decision_making_id);
				list1.add(dto);
			}
			rs.close();
			pstmt.close();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return list1;
	}
	public ArrayList<Dm2PastDto> pastDecision(int decision_making_id){
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		ArrayList<Dm2PastDto> list1 = new ArrayList<Dm2PastDto>();
		Connection conn = DBConnection.getConnection();
		try{
			String sql = "select w2.* from (select rownum rnum, w1.* from (select di.decision_icon_p, di.decision_making_cur, a.decision_maker, a.edit_date, a.decision" + 
					" from decision_icon di, approval_line a" + 
					" where di.decision_icon_id = a.decision and decision_making_id = ? order by a.edit_date desc) w1) w2 where rnum not in (1)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,decision_making_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String decision_icon_p = rs.getString(2);
				String decision_making_cur = rs.getString(3);
				int decision_maker = rs.getInt(4);
				String name = showWriterName(decision_maker);
				String picture = myPicture(decision_maker);
				String edit_date = rs.getString(5);
				int decision = rs.getInt(6);
				Dm2PastDto dto = new Dm2PastDto(decision_icon_p, decision_making_cur, name, picture, edit_date, decision);
				list1.add(dto);
			}
			rs.close();
			pstmt.close();
		}catch (SQLException e) {
			e.printStackTrace();
		}
		return list1;
	}
	

}
