package com.ta.dto;

public class RecentlyLinkDto {
	private int link_id;
	private String link_title;
	private String link_name;
	public RecentlyLinkDto() {}
	public RecentlyLinkDto(int link_id, String link_title, String link_name) {
		this.link_id = link_id;
		this.link_title = link_title;
		this.link_name = link_name;
	}
	public String getLink_name() {
		return link_name;
	}
	public void setLink_name(String link_name) {
		this.link_name = link_name;
	}
	public int getLink_id() {
		return link_id;
	}
	public void setLink_id(int link_id) {
		this.link_id = link_id;
	}
	public String getLink_title() {
		return link_title;
	}
	public void setLink_title(String link_title) {
		this.link_title = link_title;
	}
	
}
