package com.ta.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.ta.dto.CommentDto;
import com.ta.dto.ReplyCommentDto;

public class CommentDao {
	public ArrayList<CommentDto> getComment(int documentId){
		ArrayList<CommentDto> list = new ArrayList<CommentDto>(); 
		try {
			String sql = "SELECT c.comment_id ,m.picture, m.name,file_id,link_id, TO_CHAR(c.creation_date,'mm\"월\" dd\"일\" am hh:mi') AS creation_date, c.content " + 
					"FROM comments c, member m " + 
					"WHERE m.member_id = c.comment_writer " + 
					"AND c.document_id = ? " + 
					"ORDER BY c.creation_date ASC";
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, documentId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int comment_id = rs.getInt("comment_id");
				String picture = rs.getString("picture");
				String name = rs.getString("name");
				String creation_date = rs.getString("creation_date");
				String content = rs.getString("content");
				int file_id = rs.getInt("file_id");
				int link_id = rs.getInt("link_id");
				list.add(new CommentDto(comment_id,picture,name,creation_date,content,file_id,link_id));
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}	
	public int getCountReplyComment(int comment_id) {
		int countReplyComment=0;
		try {
			String sql = "SELECT COUNT(reply_comment_id) " +   
					"FROM reply_comment " + 
					"WHERE comment_id = ? " ;
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, comment_id);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				countReplyComment = rs.getInt("COUNT(reply_comment_id)");
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return countReplyComment;
	}
	public ArrayList<ReplyCommentDto> getReplyComment(int documentId, int commentId){
		ArrayList<ReplyCommentDto> list = new ArrayList<ReplyCommentDto>();
		try {
			String sql = "SELECT rc.reply_comment_id ,c.content, m.picture, m.name, TO_CHAR(rc.reply_creation_date,'mm\"월\" dd\"일\" am hh:mi') AS creation_date, rc.reply_content " + 
					"FROM comments c, reply_comment rc, member m " + 
					"WHERE m.member_id = c.comment_writer " + 
					"AND c.comment_id = rc.comment_id " + 
					"AND c.document_id = ? " + 
					"AND c.comment_id = ? " + 
					"ORDER BY c.creation_date ASC";
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, documentId);
			pstmt.setInt(2, commentId);
			ResultSet rs = pstmt.executeQuery();
			while(rs.next()) {
				int reply_comment_id = rs.getInt("reply_comment_id");
				String parentContent = rs.getString("content");
				String writerPicture = rs.getString("picture");
				String writerName = rs.getString("name");
				String replyCreationDate = rs.getString("creation_date");
				String replyContent = rs.getString("reply_content");
				list.add(new ReplyCommentDto(reply_comment_id,parentContent,writerPicture,writerName,replyCreationDate,replyContent));
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
//	public ArrayList<CommentDto> getClickCommentView(int documentId){
//		ArrayList<CommentDto> list = new ArrayList<CommentDto>();
//		try {
//			String sql = "SELECT c.comment_id, m.picture, m.name, TO_CHAR(c.creation_date,'mm\"월\" dd\"일\" am hh:mi') AS creation_date, c.content " + 
//					"FROM comments c, member m " + 
//					"WHERE m.member_id = c.comment_writer " + 
//					"AND c.document_id = ? " + 
//					"AND c.fixed_comment = 0 " + 
//					"ORDER BY c.creation_date ASC ";
//			Connection conn = DBConnection.getConnection();
//			PreparedStatement pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(1, documentId);
//			ResultSet rs = pstmt.executeQuery();
//			while(rs.next()) {
//				int comment_id = rs.getInt("comment_id");
//				String picture = rs.getString("picture");
//				String name = rs.getString("name");
//				String creation_date = rs.getString("creation_date");
//				String content = rs.getString("content");
//				list.add(new CommentDto(comment_id, picture, name, creation_date, content));
//			}
//			rs.close();
//			pstmt.close();
//		} catch(Exception e) {
//			e.printStackTrace();
//		}
//		return list;
//	}
	public static String picture(String file_name) { // 파일 이미지
		String pictureType = file_name.substring(file_name.length()-4,file_name.length());
		if(pictureType.equals(".jpg")) {
			return "img";
		} else if(pictureType.equals(".png")) {
			return "img";
		} else if(pictureType.equals(".svg")) {
			return "img";
		} else if(pictureType.equals("pptx")) {
			return "pptx";
		} else if(pictureType.equals("xlsx")) {
			return "xlsx";
		} else if(pictureType.equals(".zip")) {
			return "zip";
		} else if(pictureType.equals("docx")) {
			return "docx";
		} else if(pictureType.equals(".pdf")) {
			return "pdf";
		} else
			return "etc";
	}
	public static int returnCommentFileId(int loginId, int documentId, String fileName) {
		int fileId = 0;
		try {
			String sql ="SELECT file_id FROM files WHERE post=? AND document_id=? AND file_name=?";
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, documentId);
			pstmt.setString(3,fileName);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				fileId = rs.getInt("file_id");
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return fileId;
	}
	public void InsertCommentFile(int loginId,int documentId, String fileName) {
		try {
			String sql = "INSERT INTO files(file_id, document_id, post, chatting_room_id, file_name, file_date, picture) VALUES (file_id.nextval,?,?,0,?,sysdate,?)";
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, documentId);
			pstmt.setInt(2, loginId);
			pstmt.setString(3, fileName);
			pstmt.setString(4, picture(fileName));
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public void insertCommentFileContent(int loginId, int documentId, String fileName) {
		try {
			String sql = "INSERT INTO comments VALUES (comment_id.nextval,?,?,sysdate,null,?,0)";
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, documentId);
			pstmt.setInt(3, returnCommentFileId(loginId, documentId, fileName));
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public String getFileInformation(int fileId){
		String file_name="";
		try {
			Connection conn = DBConnection.getConnection();
			String sql = "SELECT file_name FROM files WHERE file_id =?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,fileId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				file_name = rs.getString("file_name");
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return file_name;
	}
	public String getLinkInformation(int linkId){
		String link_name="";
		try {
			Connection conn = DBConnection.getConnection();
			String sql = "SELECT link_name FROM links WHERE link_id =?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,linkId);
			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				link_name = rs.getString("link_name");
			}
			rs.close();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return link_name;
	}
	public void insertCommentLinkContent(int loginId, int documentId, int linkId) {
		try {
			String sql = "INSERT INTO comments VALUES (comment_id.nextval,?,?,sysdate,null,0,?)";
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, loginId);
			pstmt.setInt(2, documentId);
			pstmt.setInt(3, linkId);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	public void insertComments(int loginId, int documentId, String content) { // 파일이 없는 댓글 저장  
		PreparedStatement pstmt = null;
		try {
			String sql = "INSERT INTO comments VALUES (comment_id.nextval, ?, ?, sysdate, ? , 0, 0)";
			Connection conn = DBConnection.getConnection();
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
			Connection conn = DBConnection.getConnection();
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
			Connection conn = DBConnection.getConnection();
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
			Connection conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, replyCommentId);
			pstmt.executeUpdate();
			pstmt.close();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
