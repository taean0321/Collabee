package com.yr.dto;

public class MemberPictureDto {
	private String picture1;
	private String picture2;
	private String picture3;
	public MemberPictureDto() {}
	public MemberPictureDto(String picture1, String picture2, String picture3) {
		super();
		this.picture1 = picture1;
		this.picture2 = picture2;
		this.picture3 = picture3;
	}
	public String getPicture1() {
		return picture1;
	}
	public void setPicture1(String picture1) {
		this.picture1 = picture1;
	}
	public String getPicture2() {
		return picture2;
	}
	public void setPicture2(String picture2) {
		this.picture2 = picture2;
	}
	public String getPicture3() {
		return picture3;
	}
	public void setPicture3(String picture3) {
		this.picture3 = picture3;
	}
	
}
