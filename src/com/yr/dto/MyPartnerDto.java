package com.yr.dto;

public class MyPartnerDto {
	private int my_partner;
	private String picture;
	private String name;
	public MyPartnerDto(int my_partner, String picture, String name) {
		super();
		this.my_partner = my_partner;
		this.picture = picture;
		this.name = name;
	}
	public int getMy_partner() {
		return my_partner;
	}
	public void setMy_partner(int my_partner) {
		this.my_partner = my_partner;
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
	
}
