package com.yr.dto;

public class DmWorkspaceMemberDto {
	private int member_id;
	private String picture;
	private String name;
	public DmWorkspaceMemberDto() {}
	public DmWorkspaceMemberDto(int member_id, String picture, String name) {
		super();
		this.member_id = member_id;
		this.picture = picture;
		this.name = name;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
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
	};
	
}
