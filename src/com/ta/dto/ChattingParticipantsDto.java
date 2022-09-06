package com.ta.dto;

public class ChattingParticipantsDto {
	private int memberId;
	private String name;
	private String picture;
	public ChattingParticipantsDto() {}
	public ChattingParticipantsDto(int memberId, String name, String picture) {
		this.memberId = memberId;
		this.name = name;
		this.picture = picture;
	}
	public int getMemberId() {
		return memberId;
	}
	public void setMemberId(int memberId) {
		this.memberId = memberId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}
	
}
