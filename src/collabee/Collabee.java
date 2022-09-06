package collabee;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Scanner;
import java.util.StringTokenizer;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;


class sql {
	static Scanner sc = new Scanner(System.in);
	static ArrayList<String> mail = new ArrayList<String>();
	static ArrayList<Integer> memberIdList = new ArrayList<Integer>();
	static ArrayList<Integer> chattingRoomIdList = new ArrayList<Integer>();
	static ArrayList<Integer> userChattingAlarm = new ArrayList<Integer>();
	String driver = "oracle.jdbc.driver.OracleDriver";
	String url = "jdbc:oracle:thin:@192.168.1.7:1521:xe";
	String dbID = "oraclePort";
	String dbPW = "369369";	
	static int loginid = 1;
	static Connection conn = null;
	public Connection conn() {
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, dbID, dbPW);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}
	public void connClose() {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// 파트너 관련 기능
	public static void partnerList(int loginId) { // 파트너 목록 조회
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		try {
			String sql = "SELECT picture, email, name " + 
			"FROM member m " + 
			"WHERE email IN (SELECT invite_mail FROM partner WHERE member_id = ? AND invite_mail IS NOT NULL)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			while(rs.next()) { // 초대한 파트너 메일 목록 (회원인 사람)
				String picture = rs.getString("picture");
				String email = rs.getString("email");
				String name = rs.getString("name");
				System.out.println(email+"\t"+picture+"\t"+name);
			}
			rs.close();
			pstmt.close();
			sql = "SELECT partner_id, invite_mail FROM partner WHERE member_id = ? AND invite_mail IS NOT NULL " + 
			"AND invite_mail NOT IN (" + 
			"SELECT email " + 
			"FROM member m " + 
			"WHERE email IN (SELECT invite_mail FROM partner WHERE member_id = ? AND invite_mail IS NOT NULL)) " + 
			"ORDER BY partner_id DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, loginId);
			rs = pstmt.executeQuery();
			while(rs.next()) { // 초대한 파트너 메일 목록 (회원이 아닌사람)
				int partner_id = rs.getInt("partner_id");
				String invite_mail = rs.getString("invite_mail");
				System.out.println(partner_id + "\t" +invite_mail);
			}
			rs.close();
			pstmt.close();
			sql = "SELECT picture, email, name " + 
					"FROM member " + 
					"WHERE member_id IN (SELECT member_id FROM partner WHERE invite_mail = (SELECT email FROM member WHERE member_id = ?))";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			while(rs.next()) { // 나를 초대한 사람정보
				String picture = rs.getString("picture");
				String email = rs.getString("email");
				String name = rs.getString("name");
				System.out.println(email+"\t"+picture+"\t"+name);
				System.out.println("------------------------------------------");
			}
			sql = "SELECT COUNT(email) " + 
					"FROM member " + 
					"WHERE member_id IN (SELECT member_id FROM partner WHERE invite_mail = (SELECT email FROM member WHERE member_id = ?))";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			int invite_me_count=0;
			if(rs.next()) { //  나를 초대한 사람 수
				invite_me_count = rs.getInt(1);
			}
			rs.close();
			pstmt.close();
			sql = "SELECT COUNT(invite_mail) FROM partner WHERE member_id = ? AND invite_mail IS NOT NULL ORDER BY partner_id DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			int invite_mail_count=0;
			if(rs.next()) {// 초대한 메일 수
				invite_mail_count = rs.getInt(1);
			}
			System.out.println("알림 : "+((int)invite_mail_count+(int)invite_me_count));
			rs.close();
			pstmt.close();
			
			companyColleague(loginId);
			externalPartner(loginId);
			
			
			sql = "SELECT COUNT(email) FROM member WHERE corporation_id = (SELECT corporation_id FROM member WHERE member_id = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 회사동료수
				int countCorporationMember = rs.getInt(1);
				System.out.println("회사동료수 : "+countCorporationMember);
			}
			rs.close();
			pstmt.close();
			sql = "SELECT COUNT(email) FROM member WHERE member_id IN (SELECT my_partner FROM partner WHERE member_id = ? AND hide_partner = 'N') AND corporation_id != (SELECT corporation_id FROM member WHERE member_id = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, loginId);
			rs = pstmt.executeQuery();
			if(rs.next()) { // 외부협력자/ 파트너 수
				int countPartner = rs.getInt(1);
				System.out.println("외부협력자/파트너 수 : "+countPartner);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e){
			e.printStackTrace();
		}
	}	
	public void inviteListPlus(int loginId) { // 초대 리스트 추가
		while(true) {
			System.out.print("추가하실건가요?");
			String s = sc.next();
			char ch = s.charAt(0);
			if(ch=='n' || ch=='N')
				break;
			switch(ch){
				case'Y':
				case'y':
					while(true) {
						System.out.print("이메일 주소를 입력하고 Enter키를 눌러주세요");
						String s1 = sc.next();
						boolean b = false;
						for(int i=0; i<=mail.size()-1; i++) {
							if(mail.get(i).equals(s1)) {
								b = true;
								break;
							}
						}
						if(b) {
							System.out.println("이미 입력한 초대자");
							continue;
						}	
						if(s1.equals("n")||s1.equals("N")) {
							break;
						}
						mail.add(s1);
					}
					break;	
				case'N':
				case'n':
				default:
					break;
			}
		}
	}
	public static void companyColleague(int loginId) { // 회사동료 
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		try {
			String sql = "SELECT email, name, picture FROM member WHERE corporation_id = (SELECT corporation_id FROM member WHERE member_id = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			while(rs.next()) { // 회사동료    // 웹소켓 이용해서 서버에 들어있는 여부 확인
				String email = rs.getString("email");
				String name = rs.getString("name");
				String picture = rs.getString("picture");
				System.out.println(email+"\t"+name+"\t"+picture);
				System.out.println("------------------------------------------");
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public static void externalPartner(int loginId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {	
			String sql = "SELECT email, name, picture " + 
					"FROM member " + 
					"WHERE member_id " + 
					"IN (SELECT my_partner FROM partner WHERE member_id = ? AND hide_partner = 'N' AND my_partner IS NOT NULL) " + 
					"AND (corporation_id " + 
					"NOT IN (SELECT corporation_id FROM member WHERE member_id = ?) " + 
					"OR corporation_id IS NULL)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, loginId);
			rs = pstmt.executeQuery();
			while(rs.next()) { // 외부협력자/ 파트너  // 웹소켓 이용해서 서버에 들어있는 여부 확인
				String email = rs.getString("email");
				String name = rs.getString("name");
				String picture = rs.getString("picture");
				System.out.println(email+"\t"+name+"\t"+picture);
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
		e.printStackTrace();
		}

	}
	
	
	public static void invitePartner (int loginId, String inviteMail ) { // 파트너 초대 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {	
			String sql = "INSERT INTO partner(partner_id, member_id, invite_mail) VALUES(partner_id.nextval, ?, ?)";
			pstmt = conn.prepareStatement(sql); // 초대한사람 insert
			pstmt.setInt(1, loginId); 
			pstmt.setString(2, inviteMail);
			pstmt.executeUpdate();
			pstmt.close();
			sql = "SELECT member_id, email, name, picture FROM member WHERE member_id = ?"; // 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			while(rs.next()) { // 초대한사람에게 초대보낸사람의 정보 출력
				int member_id = rs.getInt("member_id");
				String email = rs.getString("email");
				String name = rs.getString("name");
				String picture = rs.getString("picture");
				System.out.println(email+"\t"+name+"\t"+picture);
				}
			partnerList(loginId);	
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void onclickInvite(int loginId) { // 초대하기 클릭했을때
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		for(int i=0; i<= mail.size()-1; i++) {
			try {
				String sql = "SELECT invite_mail FROM partner WHERE member_id = ? AND invite_mail = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, loginId);
				pstmt.setString(2, mail.get(i));
				rs = pstmt.executeQuery();
				while(rs.next()) {  // 파트너 초대시 이미 초대된 사람 insert 금지
					boolean b1 = false;
					String invite_mail = rs.getString("invite_mail");
					if(invite_mail.equals(mail.get(i))) { 
						b1 = true;
						mail.remove(mail.get(i));
						break;
					}
					if(b1) {
						System.out.println("이미 테이블에 초대된 파트너");
						continue;
					}	
				}
				System.out.println(mail.size()+"명을 초대하시겠습니까?");
				rs.close();
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			invitePartner(loginId,mail.get(i));
		}	
}
	public void inviteAgree (int loginId, int inviteId) { // 파트너 초대 수락
		PreparedStatement pstmt = null;
		try {
			String sql = "UPDATE partner SET my_partner = ?, invite_mail = null, agree = 'Y' WHERE member_id = ? AND invite_mail = (SELECT email FROM member WHERE member_id = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, inviteId);
			pstmt.setInt(3, loginId);
			pstmt.executeUpdate(); 			
			pstmt.close();
			partnerList(loginId);
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	public void inviteRefuse (int loginId, int inviteId) { // 파트너 초대 거절
		PreparedStatement pstmt = null;
		try {
			String sql = "DELETE FROM partner WHERE member_id = ? AND invite_mail = (SELECT email FROM member WHERE member_id = ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inviteId);
			pstmt.setInt(2, loginId);
			pstmt.executeUpdate(); 			
			pstmt.close();
			partnerList(loginId);
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	public void insertInvite (int loginId, int partner_id) { // 파트너 초대 취소
		PreparedStatement pstmt = null;
		try {
			String sql = "DELETE FROM partner WHERE partner_id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, partner_id);
			pstmt.executeUpdate(); 			
			pstmt.close();
			partnerList(loginId);
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	public void invitePartnerGroups(int loginId, String inviteGroupMails) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {	
			String sql = "";
			StringTokenizer inviteMail = new StringTokenizer(inviteGroupMails,"\n");
			while(inviteMail.hasMoreTokens()) {	
				sql = "INSERT INTO partner(partner_id, member_id, invite_mail) VALUES(partner_id.nextval, ?, ?)";
				pstmt = conn.prepareStatement(sql); // 초대한사람 insert
				pstmt.setInt(1, loginId); 
				pstmt.setString(2, inviteMail.nextToken());
				pstmt.executeUpdate();
				pstmt.close();
			}
			sql = "SELECT member_id, email, name, picture FROM member WHERE member_id = ?";  
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			while(rs.next()) { // 초대한사람에게 초대보낸사람의 정보 출력
				int member_id = rs.getInt("member_id");
				String email = rs.getString("email");
				String name = rs.getString("name");
				String picture = rs.getString("picture");
				System.out.println(email+"\t"+name+"\t"+picture);
				}
			partnerList(loginId);	
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 파일기능 -> 필터 기능 삭제
	public String choose() { // 파일, 링크에서  선택
		System.out.println("보기 : 내 파일, 전체 파일, 선택한 공간에서 내 파일, 선택한 공간에서 전체 파일");
		String choose = sc.next();
		return choose;
	}
	public String fileType() { // 파일에서 list or grid
		System.out.println("형식을 고르시오 \n 보기 : list, grid");
		String filetype = sc.next();
		return filetype;
	}
	public String search() { // 검색할 내용
		System.out.println("검색할 내용을 적으시오.(없다 입력시 검색안댐)");
		String search = sc.next();
		if(search.equals("없다")) {
			return "";
		}
		return search;
	}
	public static String picture(String file_name) { // 파일 이미지
		String pictureType = file_name.substring(file_name.length()-4,file_name.length());
		if(pictureType.equals(".jpg")) {
			return "jpg.jpg";
		} else if(pictureType.equals(".png")) {
			return "png.jpg";
		} else if(pictureType.equals("pptx")) {
			return "ppt.jpg";
		} else if(pictureType.equals("xlsx")) {
			return "xls.jpg";
		} else if(pictureType.equals(".zip")) {
			return "zip.jpg";
		} else if(pictureType.equals("docx")) {
			return "doc.jpg";
		} else if(pictureType.equals(".pdf")) {
			return "pdf.jpg";
		} else
			return "etc.jpg";
	}
	public void insertFileChatting(int loginId, int chattingRoomId, String file_name) { // 채팅에 파일추가
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO file(file_id.nextval, document_id, post, chatting_room_id, file_name, file_date, picture) " + 
					"VALUES(file_id.nextval, null, ?, ?, ?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, chattingRoomId);
			pstmt.setString(3, file_name);
			pstmt.setString(4, picture(file_name));
			pstmt.executeUpdate(); 			
			pstmt.close();
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	public void insertFileDocument(int loginId, int documentId, String file_name) { // 문서에 파일추가
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO files(file_id, document_id, post, chatting_room_id, file_name, file_date, picture) " + 
					"VALUES(file_id.nextval, ?, ?, null, ?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, documentId);
			pstmt.setString(3, file_name);
			pstmt.setString(4, picture(file_name));
			pstmt.executeUpdate(); 			
			pstmt.close();
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	public void insertFileComment(int loginId, int documentId, String file_name) { // 댓글에서 파일추가
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO files (file_id, document_id, post, chatting_room_id, file_name, file_date, picture) " + 
					"VALUES(file_id.nextval, ?, ?, null, ?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, documentId);
			pstmt.setInt(2, loginId);
			pstmt.setString(3, file_name);
			pstmt.setString(4, picture(file_name));
			pstmt.executeUpdate(); 			
			pstmt.close();
		} catch (Exception e){
			e.printStackTrace();
		}	
	}
	public void totalRecentlyFiles(int loginId) { // 최근 올린 파일/이미지(전체파일)
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("최근 올린 파일");
		try {
			String sql = "SELECT f.file_id,  f.file_name " + 
					"FROM files f, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND f.document_id = d.document_id " +
					"AND f.document_id IN (SELECT document_id " + 
					"FROM document " + 
					"WHERE workspace_id IN (SELECT workspace_id FROM workspace_mb WHERE member_id = ?)) " + 
					"AND (f.file_name NOT LIKE '%.jpg%' "+
					"AND f.file_name NOT LIKE '%.png%' "+
					"AND f.file_name NOT LIKE '%.svg%') "+
					"ORDER BY f.file_date DESC";	
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) { // 파일명 
				if(rs.next()==false) {
					System.out.println("최근 올린 링크가 없습니다.");
					break;
				}
				if(rs.next()) {
					int file_id = rs.getInt("file_id");
					String file_name = rs.getString("file_name");
					System.out.println(file_id + "\t" +file_name);
				}
			}
			rs.close();
			pstmt.close();
			System.out.println("-----------------------------------------------");
			System.out.println("최근 올린 이미지");
			sql = "SELECT f.file_id, f.file_name " + 
					"FROM files f, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND f.document_id = d.document_id " +
					"AND f.document_id IN (SELECT document_id " + 
					"FROM document " + 
					"WHERE workspace_id IN (SELECT workspace_id FROM workspace_mb WHERE member_id = ?)) " + 
					"AND (f.file_name LIKE '%.jpg%' "+
					"OR f.file_name LIKE '%.png%' "+
					"OR f.file_name LIKE '%.svg%') "+
					"ORDER BY f.file_date DESC";				
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) { // 이미지명 
				if(rs.next()) {
					int file_id = rs.getInt("file_id");
					String file_name = rs.getString("file_name");
					System.out.println(file_id + "\t" +file_name);
				}
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void myRecentlyFiles(int loginId) { // 최근 올린 파일/이미지(내파일)
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("최근 올린 파일");
		try {
			String sql = "SELECT f.file_id, f.file_name " + 
					"FROM files f, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND f.document_id = d.document_id " +
					"AND f.post = ? " + 
					"AND (f.file_name NOT LIKE '%.jpg%' "+
					"AND f.file_name NOT LIKE '%.png%' "+
					"AND f.file_name NOT LIKE '%.svg%') "+
					"ORDER BY f.file_id DESC";	
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) { // 파일명 
				if(rs.next()==false) {
					System.out.println("최근 올린 링크가 없습니다.");
					break;
				}
				if(rs.next()) {
					int file_id = rs.getInt("file_id");
					String file_name = rs.getString("file_name");
					System.out.println(file_id + "\t" +file_name);	
				}
			}
			rs.close();
			pstmt.close();
			System.out.println("-----------------------------------------------");
			System.out.println("최근 올린 이미지");
			sql = "SELECT f.file_id, f.file_name " + 
					"FROM files f, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND f.document_id = d.document_id " +
					"AND f.post = ? " + 
					"AND (f.file_name LIKE '%.jpg%' "+
					"OR f.file_name LIKE '%.png%' "+
					"OR f.file_name LIKE '%.svg%') "+
					"ORDER BY f.file_id DESC";			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) { // 이미지명 
				if(rs.next()) {
					int file_id = rs.getInt("file_id");
					String file_name = rs.getString("file_name");
					System.out.println(file_id + "\t" +file_name);
				}
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void myRecentlyFilesFromChooseWorkspace(int loginId, int workspaceId) { // 최근 올린 파일/이미지(선택한공간에서 내파일)
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("최근 올린 파일");
		try {
			String sql = "SELECT f.file_id, f.file_name " + 
					"FROM files f, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND f.document_id = d.document_id " +
					"AND f.document_id IN (SELECT document_id FROM document WHERE workspace_id = ?) " + 
					"AND f.post = ? " + 
					"AND (f.file_name NOT LIKE '%.jpg%' "+
					"AND f.file_name NOT LIKE '%.png%' "+
					"AND f.file_name NOT LIKE '%.svg%') "+
					"ORDER BY f.file_id DESC";	
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workspaceId);
			pstmt.setInt(2, loginId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) { // 파일명 
				if(rs.next()==false) {
					System.out.println("최근 올린 링크가 없습니다.");
					break;
				}
				if(rs.next()) {
					int file_id = rs.getInt("file_id");
					String file_name = rs.getString("file_name");
					System.out.println(file_id + "\t" +file_name);
				}
			}
			rs.close();
			pstmt.close();
			System.out.println("-----------------------------------------------");
			System.out.println("최근 올린 이미지");
			sql = "SELECT f.file_id, f.file_name " + 
					"FROM files f, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND f.document_id = d.document_id " +
					"AND f.document_id IN (SELECT document_id FROM document WHERE workspace_id = ?) " + 
					"AND f.post = ? " + 
					"AND (f.file_name LIKE '%.jpg%' "+
					"OR f.file_name LIKE '%.png%' "+
					"OR f.file_name LIKE '%.svg%') "+
					"ORDER BY f.file_id DESC";		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workspaceId);
			pstmt.setInt(2, loginId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) { // 이미지명 
				if(rs.next()) {
					int file_id = rs.getInt("file_id");
					String file_name = rs.getString("file_name");
					System.out.println(file_id + "\t" +file_name);
				}
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void totalRecentlyFilesFromWorkpsace(int workspaceId) { // 최근 올린 파일/이미지(선택한공간에서 전체파일)
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("최근 올린 파일");
		try {
			String sql = "SELECT f.file_id, f.file_name " + 
					"FROM files f, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND f.document_id = d.document_id " +
					"AND f.document_id IN (SELECT document_id FROM document WHERE workspace_id = ?) " + 
					"AND (f.file_name NOT LIKE '%.jpg%' "+
					"AND f.file_name NOT LIKE '%.png%' "+
					"AND f.file_name NOT LIKE '%.svg%') "+
					"ORDER BY f.file_date DESC";	
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workspaceId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) { // 파일명 
				if(rs.next()==false) {
					System.out.println("최근 올린 링크가 없습니다.");
					break;
				}
				if(rs.next()) {
					int file_id = rs.getInt("file_id");
					String file_name = rs.getString("file_name");
					System.out.println(file_id + "\t" +file_name);
				}
			}
			rs.close();
			pstmt.close();
			System.out.println("-----------------------------------------------");
			System.out.println("최근 올린 이미지");
			sql = "SELECT f.file_id, f.file_name " + 
					"FROM files f, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND f.document_id = d.document_id " +
					"AND f.document_id IN (SELECT document_id FROM document WHERE workspace_id = ?) " + 
					"AND (f.file_name LIKE '%.jpg%' "+
					"OR f.file_name LIKE '%.png%' "+
					"OR f.file_name LIKE '%.svg%') "+
					"ORDER BY f.file_date DESC";		
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workspaceId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) { // 이미지명 
				if(rs.next()) {
					int file_id = rs.getInt("file_id");
					String file_name = rs.getString("file_name");
					System.out.println(file_id + "\t" +file_name);
				}	
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void files(int loginId, int workspaceId, String choose, String search, String filetype) { // 파일 조회
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if(filetype.equals("grid")) {
			String sql = "SELECT f.picture, f.file_id, w.workspace_name, f.file_name " + 
					"FROM files f, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND f.document_id = d.document_id ";
			if(choose.equals("전체파일")) { // 전체 파일 보기
				try {
					sql +=  "AND f.document_id IN (SELECT document_id " + 
							"FROM document " + 
							"WHERE workspace_id IN (SELECT workspace_id FROM workspace_mb WHERE member_id = ?)) " + 
							"AND f.file_name LIKE ? " +
							"ORDER BY f.file_date DESC";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, loginId);
					pstmt.setString(2, "%"+search+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) { 
						String picture = rs.getString("picture");
						int file_id = rs.getInt("file_id");
						String workspace_name = rs.getString("workspace_name");
						String file_name = rs.getString("file_name");
						System.out.println(picture + "\t" + file_id + "\t" + workspace_name + "\t" + file_name );
						}
					rs.close();
					pstmt.close();
					totalRecentlyFiles(loginId);
				} catch(SQLException e) {
					e.printStackTrace();
				} 
			} else if(choose.equals("내파일")) { // 내파일 보기
				try {
					sql +=  "AND f.post = ? " + 
							"AND f.file_name LIKE ? " +
							"ORDER BY f.file_date DESC";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, loginId);
					pstmt.setString(2, "%"+search+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) { 
						String picture = rs.getString("picture");
						int file_id = rs.getInt("file_id");
						String workspace_name = rs.getString("workspace_name");
						String file_name = rs.getString("file_name");
						System.out.println(picture + "\t" + file_id + "\t" + workspace_name + "\t" + file_name );
						}
					rs.close();
					pstmt.close();
					myRecentlyFiles(loginId);
				} catch(SQLException e) {
					e.printStackTrace();
				} 
			} else if (choose.equals("선택한공간에서내파일")) { // 선택한 공간에서 내파일보기
				try {
					sql +=  "AND f.document_id IN (SELECT document_id FROM document WHERE workspace_id = ?) " + 
							"AND f.post = ? " + 
							"AND f.file_name LIKE ? " +
							"ORDER BY f.file_date DESC";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, workspaceId);
					pstmt.setInt(2, loginId);
					pstmt.setString(3, "%"+search+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) { 
						String picture = rs.getString("picture");
						int file_id = rs.getInt("file_id");
						String workspace_name = rs.getString("workspace_name");
						String file_name = rs.getString("file_name");
						System.out.println(picture + "\t" + file_id + "\t" +workspace_name + "\t" + file_name );
						}
					rs.close();
					pstmt.close();
					myRecentlyFilesFromChooseWorkspace(loginId, workspaceId);
				} catch(SQLException e) {
					e.printStackTrace();
				}	
			} else if (choose.equals("선택한공간에서전체파일")) { // 선택한 공간에서 전체파일보기
				try {
					sql +=  "AND f.document_id IN (SELECT document_id FROM document WHERE workspace_id = ?) " + 
							"AND f.file_name LIKE ? " +
							"ORDER BY f.file_date DESC";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, workspaceId);
					pstmt.setString(2, "%"+search+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) { 
						String picture = rs.getString("picture");
						int file_id = rs.getInt("file_id");
						String workspace_name = rs.getString("workspace_name");
						String file_name = rs.getString("file_name");
						System.out.println(picture + "\t" + file_id + "\t" + workspace_name + "\t" + file_name );
						}
					rs.close();
					pstmt.close();
					totalRecentlyFilesFromWorkpsace(workspaceId);
				} catch(SQLException e) {
					e.printStackTrace();
				}	
			} 
		} else if(filetype.equals("list")) {
			String sql = "SELECT f.picture, f.file_id, w.workspace_name, f.file_name, d.title , m.picture " + 
						"FROM files f, workspace w, document d, member m " + 
						"WHERE w.workspace_id = d.workspace_id " + 
						"AND f.document_id = d.document_id " +
						"AND m.member_id = f.post ";
			if(choose.equals("전체파일")) { // 모든 공간에서 전체 파일 보기
				try {
					sql +=  "AND f.document_id IN (SELECT document_id " + 
							"FROM document " + 
							"WHERE workspace_id IN (SELECT workspace_id FROM workspace_mb WHERE member_id = ?)) " +
							"AND f.file_name LIKE ? " +
							"ORDER BY f.file_date DESC";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, loginId);
					pstmt.setString(2, "%"+search+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) { 
						String filePicture = rs.getString("picture");
						int file_id = rs.getInt("file_id");
						String workspace_name = rs.getString("workspace_name");
						String file_name = rs.getString("file_name");
						String title = rs.getString("title");
						String picture = rs.getString("picture");
						System.out.println(filePicture + "\t" + file_id + "\t" +workspace_name + "\t" + file_name + "\t"  + title + "\t"  +picture);
					}
					rs.close();
					pstmt.close();
					totalRecentlyFiles(loginId);
				} catch(SQLException e) {
					e.printStackTrace();
				}		
			} else if(choose.equals("내파일")) { // 모든공간에서 내파일 보기
				try {
					sql +=  "AND f.post = ? " + 
							"AND f.file_name LIKE ? " +
							"ORDER BY f.file_date DESC";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, loginId);
					pstmt.setString(2, "%"+search+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) { 
						String filePicture = rs.getString("picture");
						int file_id = rs.getInt("file_id");
						String workspace_name = rs.getString("workspace_name");
						String file_name = rs.getString("file_name");
						String title = rs.getString("title");
						String picture = rs.getString("picture");
						System.out.println(filePicture + "\t" + file_id + "\t" +workspace_name + "\t" + file_name + "\t"  + title + "\t"  +picture);
					}
					rs.close();
					pstmt.close();
					myRecentlyFiles(loginId);
				} catch(SQLException e) {
					e.printStackTrace();
				}
			} else if (choose.equals("선택한공간에서내파일")) { // 선택한 공간에서 내파일보기
				try {
					sql +=  "AND f.document_id IN (SELECT document_id FROM document WHERE workspace_id = ?) " + 
							"AND f.post = ? " + 
							"AND f.file_name LIKE ? " +
							"ORDER BY f.file_date DESC";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, workspaceId);
					pstmt.setInt(2, loginId);
					pstmt.setString(3, "%"+search+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) { 
						String filePicture = rs.getString("picture");
						int file_id = rs.getInt("file_id");
						String workspace_name = rs.getString("workspace_name");
						String file_name = rs.getString("file_name");
						String title = rs.getString("title");
						String picture = rs.getString("picture");
						System.out.println(filePicture + "\t" + file_id + "\t" +workspace_name + "\t" + file_name + "\t"  + title + "\t"  +picture);
					}
					rs.close();
					pstmt.close();
					myRecentlyFilesFromChooseWorkspace(loginId, workspaceId);
				} catch(SQLException e) {
					e.printStackTrace();
				}
			} else if (choose.equals("선택한공간에서전체파일")) { // 선택한 공간에서 전체파일보기
				try {
					sql +=  "AND f.document_id IN (SELECT document_id FROM document WHERE workspace_id = ?) " + 
							"AND f.file_name LIKE ? " +
							"ORDER BY f.file_date DESC";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, workspaceId);
					pstmt.setString(2, "%"+search+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) { 
						String filePicture = rs.getString("picture");
						int file_id = rs.getInt("file_id");
						String workspace_name = rs.getString("workspace_name");
						String file_name = rs.getString("file_name");
						String title = rs.getString("title");
						String picture = rs.getString("picture");
						System.out.println(filePicture + "\t" + file_id + "\t" +workspace_name + "\t" + file_name + "\t"  + title + "\t"  +picture);
					}
					rs.close();
					pstmt.close();
					totalRecentlyFilesFromWorkpsace(workspaceId);
				} catch(SQLException e) {
					e.printStackTrace();
				}
			} 
		}	
	}
	
	// 링크기능 -> 필터 기능 삭제  // 로고 이미지랑, url 긁어오는법
	public String linkTitle(String link_name) { // link_title
		Document doc = null;
		try {
			doc = Jsoup.connect(link_name).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		String title = doc.title();
		return title;
	}
	public String linkExplanation(String link_name) { // link_explanation
		Document doc = null;
		try {
			doc = Jsoup.connect(link_name).get();
		} catch(IOException e){
			e.printStackTrace();
		}
		Elements elm = doc.select("[name="+"description"+"]"); 
		String explanation = elm.toString();
		String linkExplanation = explanation.substring(explanation.indexOf("content=")+9,explanation.length()-2);
		return linkExplanation;
	}
	public String linkPicture(String link_name) {
		Document doc = null;
		try {
			doc = Jsoup.connect(link_name).get();
		} catch(IOException e){
			e.printStackTrace();
		}
		Elements elm = doc.select("[property=\"og:image\"]"); 
		String picture = elm.toString();
		String linkPicture = picture.substring(picture.indexOf("content=")+9,picture.length()-2);
		return linkPicture;
	}
	public void insertLinkDocument(int loginId, int workspaceId, String link) { // 문서에서 링크 올릴때 --> 수정필요
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO links(link_id, document_id, post, chatting_room_id, link_name, link_title, link_explanation, link_date, picture) " + 
					"VALUES (link_id.nextval, ?, ?, null, ?, ?, ?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workspaceId);
			pstmt.setInt(2, loginId);
			pstmt.setString(3, link);
			pstmt.setString(4, linkTitle(link) ); 
			pstmt.setString(5, linkExplanation(link) );
			pstmt.setString(6, linkPicture(link));
			pstmt.executeUpdate(); 			
			pstmt.close();
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	public void insertLinkChatting(int loginId, int chattingRoomId, String link) { // 채팅에서 링크 올릴때  --> 수정필요
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO links(link_id, document_id, post, chatting_room_id, link_name, link_title, link_explanation, link_date, picture) " + 
					"VALUES (link_id.nextval, null, ?, ?, ?, ?, ?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chattingRoomId);
			pstmt.setInt(2, loginId);
			pstmt.setString(3, link);
			pstmt.setString(4, linkTitle(link) ); 
			pstmt.setString(5, linkExplanation(link) );
			pstmt.setString(6, linkPicture(link));
			pstmt.executeUpdate(); 			
			pstmt.close();
			partnerList(loginId);
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	public void myRecentlyLinks(int loginId) { // 모든공간 내가 최근에 올린 링크
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("최근 올린 링크");
		try {
			String sql = "SELECT DISTINCT l.link_id, l.link_title  " + 
					"FROM links l, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND l.document_id = d.document_id " + 
					"AND l.chatting_room_id IS NULL " +
					"AND l.post = ?  " + 
					"ORDER BY l.link_id DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) {
				if(rs.next()==false) {
					System.out.println("최근 올린 링크가 없습니다.");
					break;
				}
				if(rs.next()) {
					int link_id = rs.getInt("link_id");
					String link_title = rs.getString("link_title");
					System.out.println(link_id +"\t"+ link_title);
				}
			}	
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void totalRecentlyLinks() { // 모든공간 최근에 올린 링크 (전체)
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("최근 올린 링크");
		try {
			String sql = "SELECT DISTINCT l.link_id, l.link_title " + 
					"FROM links l, workspace w, document d " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND l.document_id = d.document_id " + 
					"AND l.chatting_room_id IS NULL " +
					"ORDER BY l.link_id DESC";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) {
				if(rs.next()==false) {
					System.out.println("최근 올린 링크가 없습니다.");
					break;
				}
				if(rs.next()) {
					int link_id = rs.getInt("link_id");
					String link_title = rs.getString("link_title");
					System.out.println(link_id +"\t"+ link_title);
				}
			}	
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void myRecentlyLinksFromChooseWorkspace(int loginId, int workspaceId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("최근 올린 링크");
		try {
			String sql = "SELECT DISTINCT l.link_id, l.link_title " + 
					"FROM links l, workspace w, document d  " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND l.document_id = d.document_id " + 
					"AND l.chatting_room_id IS NULL " +
					"AND l.document_id IN (SELECT document_id FROM document WHERE workspace_id = ?) " + 
					"AND l.post = ? " + 
					"ORDER BY l.link_id DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workspaceId);
			pstmt.setInt(2, loginId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) {
				if(rs.next()==false) {
					System.out.println("최근 올린 링크가 없습니다.");
					break;
				}
				if(rs.next()) {
					int link_id = rs.getInt("link_id");
					String link_title = rs.getString("link_title");
					System.out.println(link_id +"\t"+ link_title);
				}
			}	
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void totalRecentlyLinksFromChooseWorkspace(int workspaceId) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		System.out.println("최근 올린 링크");
		try {
			String sql = "SELECT DISTINCT l.link_id, l.link_title " + 
					"FROM links l, workspace w, document d  " + 
					"WHERE w.workspace_id = d.workspace_id " + 
					"AND l.document_id = d.document_id " + 
					"AND l.chatting_room_id IS NULL " +
					"AND l.document_id IN (SELECT document_id FROM document WHERE workspace_id = ?) " + 
					"ORDER BY l.link_id DESC";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, workspaceId);
			rs = pstmt.executeQuery();
			for(int i=1; i<=3; i++) {
				if(rs.next()==false) {
					System.out.println("최근 올린 링크가 없습니다.");
					break;
				}
				if(rs.next()) {
					int link_id = rs.getInt("link_id");
					String link_title = rs.getString("link_title");
					System.out.println(link_id +"\t"+ link_title);
				}
			}	
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void links(int loginId, int workspaceId, String choose, String search) { // 링크 조회
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "SELECT l.picture, l.link_id, w.workspace_name, d.title, l.link_name, l.link_title, l.link_explanation, m.picture AS profile " + 
				"FROM links l, workspace w, document d, member m " + 
				"WHERE w.workspace_id = d.workspace_id " + 
				"AND l.document_id = d.document_id " + 
				"AND m.member_id = l.post " ;
		if(choose.equals("내링크")) {  // 모든 공간에서 내링크
			try {
				sql += "AND l.post = ? " + 
						"AND l.chatting_room_id IS NULL " +
						"AND (link_name LIKE ? " +
						"OR link_title LIKE ?) " +
						"ORDER BY l.link_date DESC";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, loginId);
				pstmt.setString(2, "%"+search+"%");
				pstmt.setString(3, "%"+search+"%");
				rs = pstmt.executeQuery();
				while(rs.next()) {
					String linkPicture = rs.getString("picture");
					int link_id = rs.getInt("link_id");
					String workspace_name = rs.getString("workspace_name");
					String title = rs.getString("title");
					String link_name = rs.getString("link_name");
					String link_title = rs.getString("link_title");
					String link_explanation = rs.getString("link_explanation");
					String picture = rs.getString("profile");
					System.out.println(linkPicture + "\t" + link_id +"\t"+ workspace_name +"\t"+ title +"\t"+ link_name +"\t"+ link_title +"\t"+ link_explanation +"\t"+ picture);
				}	
				rs.close();
				pstmt.close();
				myRecentlyLinks(loginId);
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
		} else if(choose.equals("전체링크")) {
			try {
				sql += "AND l.document_id IN (SELECT document_id " + 
						"FROM document " + 
						"WHERE workspace_id IN (SELECT workspace_id FROM workspace_mb WHERE member_id = ?)) " + 
						"AND l.chatting_room_id IS NULL " +
						"AND (link_name LIKE ? " +
						"OR link_title Like ?) " +
						"ORDER BY l.link_date DESC ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, loginId);
				pstmt.setString(2, "%"+search+"%");
				pstmt.setString(3, "%"+search+"%");
				rs = pstmt.executeQuery();
				while(rs.next()) {
					String linkPicture = rs.getString("picture");
					int link_id = rs.getInt("link_id");
					String workspace_name = rs.getString("workspace_name");
					String title = rs.getString("title");
					String link_name = rs.getString("link_name");
					String link_title = rs.getString("link_title");
					String link_explanation = rs.getString("link_explanation");
					String picture = rs.getString("picture");
					System.out.println(linkPicture + "\t" + link_id +"\t"+ workspace_name +"\t"+ title +"\t"+ link_name +"\t"+ link_title +"\t"+ link_explanation +"\t"+ picture);
				}	
				rs.close();
				pstmt.close();
				totalRecentlyLinks();
			} catch(SQLException e) {
				e.printStackTrace();
			}
			
		} else if(choose.equals("선택한공간에서내링크")) {
			try {
				sql += "AND l.document_id IN (SELECT document_id " + 
						"FROM document " + 
						"WHERE workspace_id = ?) " + 
						"AND l.post = ? " +		
						"AND l.chatting_room_id IS NULL " +
						"AND (link_name LIKE ? " +
						"OR link_title Like ?) " +
						"ORDER BY l.link_date DESC ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, workspaceId);
				pstmt.setInt(2, loginId);
				pstmt.setString(3, "%"+search+"%");
				pstmt.setString(4, "%"+search+"%");
				rs = pstmt.executeQuery();
				while(rs.next()) {
					String linkPicture = rs.getString("picture");
					int link_id = rs.getInt("link_id");
					String workspace_name = rs.getString("workspace_name");
					String title = rs.getString("title");
					String link_name = rs.getString("link_name");
					String link_title = rs.getString("link_title");
					String link_explanation = rs.getString("link_explanation");
					String picture = rs.getString("picture");
					System.out.println(linkPicture + "\t" + link_id +"\t"+ workspace_name +"\t"+ title +"\t"+ link_name +"\t"+ link_title +"\t"+ link_explanation +"\t"+ picture);
				}	
				rs.close();
				pstmt.close();
				myRecentlyLinksFromChooseWorkspace(loginId, workspaceId);
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}else if(choose.equals("선택한공간에서전체링크")) {
			try {
				sql += " AND l.document_id IN (SELECT document_id " + 
						"FROM document " + 
						"WHERE workspace_id = ?) " + 
						"AND l.chatting_room_id IS NULL " +
						"AND (link_name LIKE ? " +
						"OR link_title Like ?) " +
						"ORDER BY l.link_date DESC ";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, workspaceId);
				pstmt.setString(2, "%"+search+"%");
				pstmt.setString(3, "%"+search+"%");
				rs = pstmt.executeQuery();
				while(rs.next()) {
					String linkPicture = rs.getString("picture");
					int link_id = rs.getInt("link_id");
					String workspace_name = rs.getString("workspace_name");
					String title = rs.getString("title");
					String link_name = rs.getString("link_name");
					String link_title = rs.getString("link_title");
					String link_explanation = rs.getString("link_explanation");
					String picture = rs.getString("picture");
					System.out.println(linkPicture + "\t" + link_id +"\t"+ workspace_name +"\t"+ title +"\t"+ link_name +"\t"+ link_title +"\t"+ link_explanation +"\t"+ picture);
				}	
				rs.close();
				pstmt.close();
				totalRecentlyLinksFromChooseWorkspace(workspaceId);
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}	
	}

	// 설정 -> 파트너 관리
	public static String inviteSearch() {
		String search = sc.next();
		return search;
	}
	public static int inviteMember(int loginId) { // 초대할 멤버들(회사동료 + 외부협력자)
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int id=0;
		try {
			String sql = "SELECT member_id, email, name, picture " + 
					"FROM member " + 
					"WHERE (member_id " + 
					"IN (SELECT my_partner FROM partner WHERE member_id = ? AND hide_partner = 'N' AND my_partner IS NOT NULL ) " + 
					"OR corporation_id " + 
					"IN (SELECT corporation_id FROM member WHERE member_id = ?)) " + 
					"AND member_id != ? " +
					"AND name LIKE '%?%' " +
					"OR email LIKE '%?%' ";
			pstmt = conn.prepareStatement(sql);
			for(int i=1; i<=5; i++) {
				pstmt.setInt(i, loginId);
				if(i>=4) {
					pstmt.setString(i, inviteSearch());
				}
			}
			rs = pstmt.executeQuery();
			while(rs.next()) { // 초대한 파트너 메일 목록 (회원인 사람)
				int member_id = rs.getInt("member_id");
				String email = rs.getString("email");
				String name = rs.getString("name");
				String picture = rs.getString("picture");
				System.out.println(email+"\t"+name+"\t"+picture);
				id = member_id;
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return id;
	}
	
	
	//댓글
	public void commentAndReplyShow(int documentId) { 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try { // 댓글 내용 출력 
		String sql = "SELECT c.comment_id ,m.picture, m.name, TO_CHAR(c.creation_date,'mm\"월\" dd\"일\" am hh:mi') AS creation_date, c.content " + 
				"FROM comments c, member m " + 
				"WHERE m.member_id = c.comment_writer " + 
				"AND c.document_id = ? " + 
				"ORDER BY c.creation_date ASC";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, documentId);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			int comment_id = rs.getInt("comment_id");
			String picture = rs.getString("picture");
			String name = rs.getString("name");
			String creation_date = rs.getString("creation_date");
			String content = rs.getString("content");
			System.out.print(picture + "\t" + name + "\t" + creation_date + "\t" + content + "\t");
			PreparedStatement pstmt2 = null;
			ResultSet rs2 = null;
			sql = "SELECT COUNT(reply_comment_id) " +   // 대댓글 수
					"FROM reply_comment " + 
					"WHERE comment_id = ? " ;
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, comment_id);
			rs2 = pstmt2.executeQuery();
			while(rs2.next()) {
				int reply_comments = rs2.getInt("COUNT(reply_comment_id)");
				System.out.println(reply_comments);
			}
			rs2.close();
			pstmt2.close();
			System.out.println("대댓글");      ///          대댓글
			PreparedStatement pstmt3 = null;
			ResultSet rs3 = null;
			sql = "SELECT rc.reply_comment_id ,c.content, m.picture, m.name, TO_CHAR(rc.reply_creation_date,'mm\"월\" dd\"일\" am hh:mi') AS creation_date, rc.reply_content " + 
					"FROM comments c, reply_comment rc, member m " + 
					"WHERE m.member_id = c.comment_writer " + 
					"AND c.comment_id = rc.comment_id " + 
					"AND c.document_id = ? " + 
					"AND c.comment_id = ? " + 
					"ORDER BY c.creation_date ASC";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1, documentId);
			pstmt3.setInt(2, comment_id);
			rs3 = pstmt3.executeQuery();
			while(rs3.next()) {
				int reply_comment_id = rs3.getInt("reply_comment_id");
				String parentContent = rs3.getString("content");
				String writerPicture = rs3.getString("picture");
				String writerName = rs3.getString("name");
				String replyCreationDate = rs3.getString("creation_date");
				String replyContent = rs3.getString("reply_content");
				System.out.println(reply_comment_id + "\t" + parentContent + "\t" + writerPicture + "\t" + writerName + "\t" + replyCreationDate + "\t" + replyContent);
			}
			rs3.close();
			pstmt3.close();
		}
		rs.close();
		pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void onlyCommentShow(int documentId) { // 댓글만보기 클릭시
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
		String sql = "SELECT c.comment_id, m.picture, m.name, TO_CHAR(c.creation_date,'mm\"월\" dd\"일\" am hh:mi') AS creation_date, c.content " + 
				"FROM comments c, member m " + 
				"WHERE m.member_id = c.comment_writer " + 
				"AND c.document_id = ? " + 
				"AND c.fixed_comment = 0 " + 
				"ORDER BY c.creation_date ASC ";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, documentId);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			int comment_id = rs.getInt("comment_id");
			String picture = rs.getString("picture");
			String name = rs.getString("name");
			String creation_date = rs.getString("creation_date");
			String content = rs.getString("content");
			System.out.print(picture + "\t" + name + "\t" + creation_date + "\t" + content + "\t");
			PreparedStatement pstmt2 = null;
			ResultSet rs2 = null;
			sql = "SELECT COUNT(reply_comment_id) " +   // 대댓글 수
					"FROM reply_comment " + 
					"WHERE comment_id = ? " ;
			pstmt2 = conn.prepareStatement(sql);
			pstmt2.setInt(1, comment_id);
			rs2 = pstmt2.executeQuery();
			while(rs2.next()) {
				int reply_comments = rs2.getInt("COUNT(reply_comment_id)");
				System.out.println(reply_comments);
			}
			rs2.close();
			pstmt2.close();
			PreparedStatement pstmt3 = null;
			ResultSet rs3 = null;
			System.out.println("대댓글");      ///          대댓글 TO_CHAR(send_time,'mm/dd am hh:mi')
			sql = "SELECT c.content, m.picture, m.name, TO_CHAR(rc.reply_creation_date,'mm\"월\" dd\"일\" am hh:mi') AS creation_date, rc.reply_content " + 
					"FROM comments c, reply_comment rc, member m " + 
					"WHERE m.member_id = c.comment_writer " + 
					"AND c.comment_id = rc.comment_id " + 
					"AND c.document_id = ? " + 
					"AND c.comment_id = ? " + 
					"ORDER BY c.creation_date ASC";
			pstmt3 = conn.prepareStatement(sql);
			pstmt3.setInt(1, documentId);
			pstmt3.setInt(2, comment_id);
			rs3 = pstmt3.executeQuery();
			while(rs3.next()) {
				String coment_content = rs3.getString("content");
				String reply_picture = rs3.getString("picture");
				String reply_name = rs3.getString("name");
				String reply_creation_date = rs3.getString("creation_date");
				String reply_content = rs3.getString("reply_content");
				System.out.print(coment_content + "\t" + reply_picture + "\t" + reply_name + "\t" + reply_creation_date + "\t" + reply_content);
			}
			rs3.close();
			pstmt3.close();
		}
		rs.close();
		pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void insertComments(int loginId, int documentId, String content) { // 파일이 없는 댓글 저장  
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO comments VALUES (comment_id.nextval, ?, ?, sysdate, ? , null, 0)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, documentId);
			pstmt.setString(3, content);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void insertReplyComments(int commentId, String replyContent, int loginId) { // 파일이 없는 대댓글 저장 
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO reply_comment VALUES (reply_comment_id.nextval, ?, ?, sysdate, ?, null )";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentId);
			pstmt.setString(2, replyContent);
			pstmt.setInt(3, loginId);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void deleteComment(int commentId) { // 댓글 삭제
		PreparedStatement pstmt = null;
		try {
			String sql = "UPDATE comments SET content = '댓글이 삭제되었습니다.' " + 
					"WHERE comment_id = ?"; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, commentId);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void deleteReplyComment(int replyCommentId) {
		PreparedStatement pstmt = null;
		try {
			String sql = "DELETE FROM reply_comment " + 
					"WHERE reply_comment_id = ? "; 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyCommentId);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 채팅
	public void chattingBigName(int loginId, int chattingRoomId) { // 메신저 대문짝만한 이름 뽑기
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		try { // 회사가 있는지 없는지 여부에 따라 대문짝만한 이름이 두경우
			for(int i=0; i<=chattingRoomIdList.size()-1; i++) chattingRoomIdList.remove(i);
			String sql = "SELECT corporation_id FROM member WHERE member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			boolean b = false;
			if(rs.next()) { 
				int corporation_id = rs.getInt(1);
				if(corporation_id == 0)
					b = true;
			}
			rs.close();
			pstmt.close();
			if(b) { // 회사가 없는사람 채팅 대문짝만한 본인 이름
				sql = "SELECT name FROM member WHERE member_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, loginId);
				rs = pstmt.executeQuery();
				if(rs.next()) { 
					String name = rs.getString("name");
					System.out.println(name);
				} 
				rs.close();
				pstmt.close();
			} else if(b == false){ // 회사가 있는사람 채팅 대문짝만한 회사 이름
				sql = "SELECT c.corporation_name FROM member m, corporations c WHERE m.corporation_id = c.corporation_id AND m.member_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, loginId);
				rs = pstmt.executeQuery();
				if(rs.next()) { 
					String corporation_name = rs.getString("corporation_name");
					System.out.println(corporation_name);
				}
				rs.close();
				pstmt.close();
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
		public void RecentConversationsList(int loginId) { // 최근 대화 목록
			PreparedStatement pstmt = null;
			ResultSet rs = null; 
			try {
				String sql =  "SELECT chatting_room_id, max(to_char(send_time,'yy/mm/dd hh24/mi/ss')) " + 
						"FROM chatting_message cm " + 
						"WHERE chatting_room_id IN (SELECT chatting_room_id FROM chatting_room_member WHERE chatting_member_id = ?) " + 
						"GROUP BY chatting_room_id " + 
						"ORDER BY max(to_char(send_time,'yy/mm/dd hh24/mi/ss')) DESC";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, loginId);
				rs = pstmt.executeQuery();
				for(int i=0;i<=7; i++) {
					rs.next();
					int chatting_room_id = rs.getInt("chatting_room_id");
					chattingRoomIdList.add(chatting_room_id);
				}
				rs.close();
				pstmt.close();
				for(int i=0; i<=7; i++) {
					sql = "SELECT chatting_room_id, chatting_name FROM chatting_room WHERE chatting_room_id = ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, chattingRoomIdList.get(i));
					rs = pstmt.executeQuery();
					while(rs.next()) {
						int chatting_room_id = rs.getInt("chatting_room_id");
						String chatting_name = rs.getString("chatting_name");
						System.out.println(chatting_name);
					}
					rs.close();
					pstmt.close();
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}	
		public void workSpaceChattingNameList(int loginId) { // 협업공간 대화목록
			PreparedStatement pstmt= null;
			ResultSet rs = null;
			try {
				System.out.println("협업공간 대화방 목록");
				String sql = "SELECT cr.chatting_room_id, chatting_name FROM chatting_room cr, chatting_room_member crm WHERE cr.chatting_room_id = crm.chatting_room_id AND cr.workspace_id IS NOT NULL AND crm.chatting_member_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, loginId);
				rs = pstmt.executeQuery();
				while(rs.next()) { // 협업공간 대화방 목록
					String chatting_name = rs.getString("chatting_name");
					System.out.println(chatting_name);
				}
				rs.close();
				pstmt.close();	
			} catch(Exception e) {
				e.printStackTrace();
			}	
			
		}	
//		public void groupChattingList(int loginId) {
//			PreparedStatement pstmt= null;
//			ResultSet rs = null;
//			try {
//				System.out.println("그룹 대화방 목록");
//				String sql = "SELECT cr.chatting_room_id, chatting_name FROM chatting_room cr, chatting_room_member crm WHERE cr.chatting_room_id = crm.chatting_room_id AND cr.workspace_id IS NULL AND crm.chatting_member_id = ?";
//				pstmt = conn.prepareStatement(sql);
//				pstmt.setInt(1, loginId);
//				rs = pstmt.executeQuery();
//				while(rs.next()) {  // 그룹 대화방 목록
//					String chatting_name = rs.getString("chatting_name");
//					System.out.println(chatting_name);
//				}
//				rs.close();
//				pstmt.close();		
//
//			} catch(Exception e) {
//				e.printStackTrace();
//			}
//		}
		public ArrayList<String> getGroupChattingList(int loginId) {
			ArrayList<String> listRet = new ArrayList<String>();
			PreparedStatement pstmt= null;
			ResultSet rs = null;
			try {
				System.out.println("그룹 대화방 목록");
				String sql = "SELECT cr.chatting_room_id, chatting_name FROM chatting_room cr, chatting_room_member crm WHERE cr.chatting_room_id = crm.chatting_room_id AND cr.workspace_id IS NULL AND crm.chatting_member_id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, loginId);
				rs = pstmt.executeQuery();
				while(rs.next()) {  // 그룹 대화방 목록
					String chatting_name = rs.getString("chatting_name");
					//System.out.println(chatting_name);
					listRet.add(chatting_name);
				}
				rs.close();
				pstmt.close();		

			} catch(Exception e) {
				e.printStackTrace();
			}
			return listRet;
		}
			
	
	public String chattingSearch() {
		String search = sc.next();
		return search;
	}
	public void chattingRoomSearch(int loginId, int chattingRoomId) { // 채팅방 검색
		for(int i=0; i<=chattingRoomIdList.size()-1; i++) chattingRoomIdList.remove(i);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT DISTINCT cr.chatting_room_id, chatting_name " + 
					"FROM chatting_room cr, chatting_room_member crm " + 
					"WHERE crm.chatting_member_id = ? " + 
					"AND chatting_name LIKE '%?%'";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setString(2, chattingSearch());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int chatting_room_id = rs.getInt("chatting_room_id");
				String chatting_name = rs.getNString("chatting_name");
				System.out.println(chatting_name);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void chattingRoomClickName(int chattingRoomId) { 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			System.out.println("채팅방 제목");
			String sql = "SELECT chatting_room_id, chatting_name FROM chatting_room WHERE chatting_room_id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chattingRoomId);
			rs = pstmt.executeQuery();
			while(rs.next()) {  
				int chatting_room_id = rs.getInt("chatting_room_id");
				String chatting_name = rs.getString("chatting_name");
				System.out.println(chatting_name);
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void chattingContents(int chattingRoomId) { // 채팅 내용
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			String sql = "SELECT message_id, m.picture, m.name, message, TO_CHAR(send_time,'mm/dd am hh:mi') AS send_time " + 
					"FROM chatting_message cm, member m " + 
					"WHERE m.member_id = cm.talking_member_id " + 
					"AND CHATTING_ROOM_ID = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chattingRoomId);
			rs = pstmt.executeQuery();
			while(rs.next()) {  
				String message_id = rs.getString("message_id");
				String picture = rs.getString("picture");
				String name = rs.getString("name");
				String message = rs.getString("message");
				String send_time = rs.getNString("send_time");
				System.out.println(message_id + "\t" + picture + "\t" + name + "\t" + message + "\t" + send_time );	
			}
			rs.close();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void insertChattingMessage(int loginId, int chattingRoomId, String content) { // 채팅 메세지 insert
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO chatting_message(message_id, chatting_room_id, talking_member_id, message_emoticon, send_time, reader) VALUES(message_id.nextval, ?, ?, ?, sysdate, ?);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chattingRoomId);
			pstmt.setInt(2, loginId);
			pstmt.setString(3, content);
			pstmt.setInt(4, loginId);
			pstmt.executeUpdate(); 			
			pstmt.close();
			
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	public void insertChattingLink(int loginId, int chattingRoomId, int linkId) { // 채팅 링크 insert
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO chatting_message(message_id, chatting_room_id, talking_member_id, link_id, send_time, reader) VALUES(message_id.nextval, ?, ?, ?, sysdate, ?);";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chattingRoomId);
			pstmt.setInt(2, loginId);
			pstmt.setInt(3, linkId);
			pstmt.setInt(4, loginId);
			pstmt.executeUpdate(); 			
			pstmt.close();
		} catch (Exception e){
		e.printStackTrace();
		}
	}
//	public void insertChattingFile(int loginId, int chattingRoomId, int fileId) { // 채팅 파일 insert
//		PreparedStatement pstmt = null;
//		try {
//			String sql = "INSERT INTO chatting_message(message_id, chatting_room_id, talking_member_id, file_id, send_time, reader) VALUES(message_id.nextval, ?, ?, ?, sysdate, ?);";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, chattingRoomId);
//			pstmt.setInt(2, loginId);
//			pstmt.setInt(3, fileId);
//			pstmt.setInt(4, loginId);
//			pstmt.executeUpdate(); 			
//			pstmt.close();
//			
//		} catch (Exception e){
//			e.printStackTrace();
//		}
//	}
	
	public void chattingRoomInformation(int loginId, int chattingRoomId) { // 채팅방 펼쳐지고 방명 클릭시 나오는 알람,사람수,사람들 이름 사진
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			boolean alarmState = false;
			String sql = "SELECT alarm FROM chatting_room_member WHERE chatting_member_id = ? AND chatting_room_id =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, chattingRoomId);
			rs = pstmt.executeQuery();
			while(rs.next()) {  
				int alarm = rs.getInt("alarm");
				if(alarm == 1) alarmState = true;
			}
			if(alarmState) {
				System.out.println("모든 알람 받기");
			} else
				System.out.println("알람 없음");
			rs.close();
			pstmt.close();
			System.out.print("참여자");
			sql = "SELECT COUNT(m.name) " + 
					"FROM chatting_room_member crm,chatting_room cr,member m " + 
					"WHERE crm.chatting_room_id = cr.chatting_room_id " + 
					"AND crm.chatting_member_id = m.member_id " + 
					"AND crm.chatting_room_id =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chattingRoomId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int countPeople = rs.getInt("COUNT(m.name)");
				System.out.println(countPeople);
			}
			rs.close();
			pstmt.close();
			sql = "SELECT m.name, m.picture " + 
					"FROM chatting_room_member crm,chatting_room cr,member m " + 
					"WHERE crm.chatting_room_id = cr.chatting_room_id " + 
					"AND crm.chatting_member_id = m.member_id " + 
					"AND crm.chatting_room_id =?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chattingRoomId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				String name = rs.getString("name");
				String picture = rs.getString("picture");
				System.out.println(picture + "\t" + name);
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void inviteChattingRoom(int loginId, int chattingRoomId) { // 채팅창에 회사동료+외부협업자들 중에 초대
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
		String sql = "SELECT m.picture, m.name FROM chatting_room_member crm, member m WHERE crm.chatting_member_id = m.member_id AND chatting_room_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, chattingRoomId);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			String picture = rs.getString("picture");
			String name = rs.getString("name");
			System.out.println(picture+ "\t" + name);
		}
		rs.close();
		pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		try { // 초대한 멤버 초대
			String sql = "INSERT INTO chatting_room_member VALUES(?,?) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, chattingRoomId);
			pstmt.setInt(2, inviteMember(loginId));
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void oneHour(int loginId) { // 방해금지모드 1시간
		String date = "sysdate+1/24";
		notDisturbMode(loginId,date);
	}
	public void twoHour(int loginId) { // 방해금지모드 2시간
		String date = "sysdate+2/24";
		notDisturbMode(loginId,date);
	}
	public void fourHour(int loginId) { // 방해금지모드 4시간
		String date = "sysdate+4/24";
		notDisturbMode(loginId,date);
	}
	public void oneDay(int loginId) { // 방해금지모드 다음날 그시간까지
		String date = "sysdate+1";
		notDisturbMode(loginId,date);
	}
	public static void notDisturbMode(int loginId, String date) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		for(int i=0; i<=userChattingAlarm.size()-1; i++) userChattingAlarm.remove(i);
		try {
			String sql = "SELECT chatting_room_id FROM chatting_room_member WHERE alarm = '0' AND chatting_member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int chatting_room_id = rs.getInt("chatting_room_id");
				userChattingAlarm.add(chatting_room_id);
			}
			String offAlarm = userChattingAlarm.toString().substring(1,userChattingAlarm.toString().length()-1);
			sql = "UPDATE message_alarm SET chatting_room_alarm = ?, clear_date = ? WHERE member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, date);
			pstmt.setString(2, offAlarm);
			pstmt.setInt(3, loginId);
			pstmt.executeUpdate(); 			
			pstmt.close();
			sql = "UPDATE chatting_room_member SET alarm = 0 WHERE chatting_member_id = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.executeUpdate(); 			
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public static void notDisturbModeDone(int loginId) { // 방해금지 모드가 끝나고 다시 알람을 켜줌
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String chatting_room_alarm = userChattingAlarm.toString().substring(1,userChattingAlarm.toString().length()-1);
		try {
			String sql = "UPDATE chatting_room_member SET alarm = 1 " + 
					  "WHERE chatting_member_id =? AND chatting_room_id NOT IN (?)"; 
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, loginId);
				pstmt.setString(2, chatting_room_alarm);
				pstmt.executeUpdate();
				pstmt.close();
		} catch(SQLException e) {
				e.printStackTrace();
		}
	}
	public void chattingFiles(int loginId, int chattingRoomId) { // 채팅에 있는 파일들
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		for(int i=0; i<=chattingRoomIdList.size()-1; i++) chattingRoomIdList.remove(i);
		try {
			String sql = "SELECT DISTINCT cr.chatting_room_id, chatting_name " + 
					"FROM chatting_room cr, chatting_room_member crm " + 
					"WHERE crm.chatting_member_id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int chatting_room_id = rs.getInt("chatting_room_id");
				chattingRoomIdList.add(chatting_room_id);
				String chatting_name = rs.getString("chatting_name");
				System.out.println(chatting_name);
			}
			System.out.println(chattingRoomIdList);
			rs.close();
			pstmt.close();
			for(int chatting_room_id : chattingRoomIdList) {
				if(chattingRoomId==0) { // 모든 대화방에 있는 파일들
					sql = "SELECT f.file_id, f.file_name, TO_CHAR(f.file_date,'mm\"월\" dd\"일\" am hh:mi') AS file_date, cr.chatting_name, m.picture " + 
							"FROM files f, member m, chatting_room cr , chatting_room_member crm " + 
							"WHERE f.chatting_room_id = cr.chatting_room_id " + 
							"AND f.post = m.member_id " + 
							"AND cr.chatting_room_id = crm.chatting_room_id " + 
							"AND cr.chatting_room_id IS NOT NULL " + 
							"AND crm.chatting_member_id = ? " +
							"AND f.file_name LIKE ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, loginId);
					pstmt.setString(2, "%"+search()+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) {
						int file_id = rs.getInt("file_id");
						String file_name = rs.getString("file_name");
						String file_date = rs.getString("file_date");
						String chatting_name = rs.getString("chatting_name");
						String picture = rs.getString("picture");
						System.out.println(file_id + "\t" + file_name + "\t" + file_date + "\t" + chatting_name + "\t" + picture);
					}
					rs.close();
					pstmt.close();
				} else if(chatting_room_id == chattingRoomId) { // 선택한 방에 있는 파일들
					sql = "SELECT file_id, file_name, TO_CHAR(file_date,'mm\"월\" dd\"일\" am hh:mi') AS file_date, cr.chatting_name, m.picture " + 
							"FROM files f, member m, chatting_room cr " + 
							"WHERE f.chatting_room_id = cr.chatting_room_id " + 
							"AND f.post = m.member_id " + 
							"AND cr.chatting_room_id = ? " +
							"AND f.file_name LIKE ?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, chattingRoomId);
					pstmt.setString(2, "%"+search()+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) {
						int file_id = rs.getInt("file_id");
						String file_name = rs.getString("file_name");
						String file_date = rs.getString("file_date");
						String chatting_name = rs.getString("chatting_name");
						String picture = rs.getString("picture");
						System.out.println(file_id + "\t" + file_name + "\t" + file_date + "\t" + chatting_name + "\t" + picture);
					}
					rs.close();
					pstmt.close();
				}
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	public void chattingLinks(int loginId, int chattingRoomId) { // 채팅에 있는 링크들
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		for(int i=0; i<=chattingRoomIdList.size()-1; i++) chattingRoomIdList.remove(i);
		try {
			String sql = "SELECT DISTINCT cr.chatting_room_id, chatting_name " + 
					"FROM chatting_room cr, chatting_room_member crm " + 
					"WHERE crm.chatting_member_id = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				int chatting_room_id = rs.getInt("chatting_room_id");
				chattingRoomIdList.add(chatting_room_id);
				String chatting_name = rs.getString("chatting_name");
				System.out.println(chatting_name);
			}
			System.out.println(chattingRoomIdList);
			rs.close();
			pstmt.close();
			String content = "";
			for(int chatting_room_id : chattingRoomIdList) {
				if(chattingRoomId==0) { // 모든 대화방에 있는 링크들
					content = search();
					sql = "SELECT l.link_id, l.link_title, l.link_explanation, l.link_name, TO_CHAR(l.link_date,'mm\"월\" dd\"일\" am hh:mi') AS link_date, cr.chatting_name, m.picture " + 
							"FROM links l, member m, chatting_room cr , chatting_room_member crm " + 
							"WHERE l.chatting_room_id = cr.chatting_room_id " + 
							"AND l.post = m.member_id " + 
							"AND cr.chatting_room_id = crm.chatting_room_id " + 
							"AND cr.chatting_room_id IS NOT NULL " + 
							"AND crm.chatting_member_id = ? " +
							"AND (l.link_title LIKE ? " +
							"OR l.link_name LIKE ?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, loginId);
					pstmt.setString(2, "%"+content+"%");
					pstmt.setString(3, "%"+content+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) {
						int link_id = rs.getInt("link_id");
						String link_title = rs.getString("link_title");
						String link_explanation = rs.getString("link_explanation");
						String link_name = rs.getString("link_name");
						String link_date = rs.getString("link_date");
						String chatting_name = rs.getString("chatting_name");
						String picture = rs.getString("picture");
						System.out.println(link_id + "\t" + link_title + "\t" + link_explanation+ "\t" + link_name + "\t" +link_date + "\t" + chatting_name + "\t" + picture);
					}
					rs.close();
					pstmt.close();
				} else if(chatting_room_id == chattingRoomId) { // 선택한 방에 있는 링크들
					content = search();
					sql = "SELECT l.link_id, l.link_title, l.link_explanation, l.link_name, TO_CHAR(l.link_date,'mm\"월\" dd\"일\" am hh:mi') AS link_date, cr.chatting_name, m.picture " + 
							"FROM links l, member m, chatting_room cr " + 
							"WHERE l.chatting_room_id = cr.chatting_room_id " + 
							"AND l.post = m.member_id " + 
							"AND cr.chatting_room_id = ? " +
							"AND (l.link_title LIKE ? " +
							"OR l.link_name LIKE ?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, chatting_room_id);
					pstmt.setString(2, "%"+content+"%");
					pstmt.setString(3, "%"+content+"%");
					rs = pstmt.executeQuery();
					while(rs.next()) {
						int link_id = rs.getInt("link_id");
						String link_title = rs.getString("link_title");
						String link_explanation = rs.getString("link_explanation");
						String link_name = rs.getString("link_name");
						String link_date = rs.getString("link_date");
						String chatting_name = rs.getString("chatting_name");
						String picture = rs.getString("picture");
						System.out.println(link_id + "\t" + link_title + "\t" + link_explanation+ "\t" + link_name + "\t" +link_date + "\t" + chatting_name + "\t" + picture);
					}
					rs.close();
					pstmt.close();
				}
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
}
public class Collabee {
	public static void main(String[] args) {
		sql obj = new sql();
		int loginId = 3; // 로그인한 id
		int workspaceId = 8;
		int documentId = 3;
		obj.conn(); // Connection 접속
//		int inviteId = 3; // 초대한 수락한 id
//		sql.partnerList(loginId); // 파트너 목록 조회
//		obj.inviteListPlus(loginId); // 초대할 아이디 추가
//		obj.onclickInvite(loginId); // 초대
//		obj.inviteAgree(loginId, inviteId); // 초대 수락시
//		obj.inviteRefuse(loginId, inviteId); // 초대 거절시
// 콤마 줄바꿈시 이메일 주소 구분 (스트링 토크나이저)
//		obj.totalRecentlyFiles(loginId);
//		obj.myRecentlyFiles( loginId);
//		obj.myRecentlyFilesFromChooseWorkspace(loginId,  workspaceId);
//		obj.totalRecentlyFilesFromWorkpsace( loginId,  workspaceId);
//		obj.totalRecentlyFilesFromWorkpsace(workspaceId);
//		obj.files(loginId, workspaceId, obj.choose(), obj.search(), obj.fileType());
		String file_name = "기린.pptx";
//		obj.insertFileDocument(loginId, documentId, file_name);
		
//		obj.links(loginId, workspaceId,  obj.choose(),  obj.search());
		String linkName = "https://www.koreaisacademy.com/";
//		obj.linkTitle(linkName);
//		obj.insertLinkDocument(loginId, workspaceId, linkName);
//		System.out.println(obj.linkPicture(linkName));
		
		String content = "asd";
		String replyContent = "sd";
		int commentId = 1;
		//obj.insertReplyComments(commentId, replyContent, loginId);
		//obj.insertComments(loginId, documentId,content);
//		obj.onlyCommentShow(documentId);
		//obj.commentAndReplyShow(documentId);
	
		int chattingRoomId = 4;
		//obj.oneHour(loginId);
		//obj.notDisturbModeDone(loginId);
		//obj.chattingFiles(loginId, chattingRoomId);
		obj.chattingLinks(loginId, chattingRoomId);
		//obj.chattingRoomInformation(loginId, chattingRoomId);
		//obj.chattingRoomClick(loginId, 1);	
		//obj.chattingList(loginId, chattingRoomId);		
		obj.connClose(); // conn.close();
		
	}
}
