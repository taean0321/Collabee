package com.ta.dto;

public class CommentDto {
	private int comment_id;
	private String picture;
	private String name;
	private String creation_date;
	private String content;
	private int file_id;
	private int link_id;
	public CommentDto() {}
	public CommentDto(int comment_id, String picture, String name, String creation_date, String content, int file_id, int link_id) {
		super();
		this.comment_id = comment_id;
		this.picture = picture;
		this.name = name;
		this.creation_date = creation_date;
		this.content = content;
		this.file_id = file_id;
		this.link_id = link_id;
	}
	public int getFile_id() {
		return file_id;
	}
	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}
	public int getLink_id() {
		return link_id;
	}
	public void setLink_id(int link_id) {
		this.link_id = link_id;
	}
	public int getComment_id() {
		return comment_id;
	}
	public void setComment_id(int comment_id) {
		this.comment_id = comment_id;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getCreation_date() {
		return creation_date;
	}
	public void setCreation_date(String creation_date) {
		this.creation_date = creation_date;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
}
