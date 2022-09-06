package com.ta.dto;

public class PartnerHiddenListDto {
	private int member_id;
	private String name;
	private String email;
	private String picture;
	public PartnerHiddenListDto() {}
	public PartnerHiddenListDto(int member_id, String name, String email, String picture) {
		this.member_id = member_id;
		this.name = name;
		this.email = email;
		this.picture = picture;
	}
	
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
