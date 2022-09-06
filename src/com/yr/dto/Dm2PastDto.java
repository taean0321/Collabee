package com.yr.dto;

public class Dm2PastDto {
	private String decision_icon_p;
	private String decision_making_cur;
	private String name;
	private String picture;
	private String edit_date;
	private int decision;
	public Dm2PastDto(String decision_icon_p, String decision_making_cur, String name, String picture, String edit_date,
			int decision) {
		super();
		this.decision_icon_p = decision_icon_p;
		this.decision_making_cur = decision_making_cur;
		this.name = name;
		this.picture = picture;
		this.edit_date = edit_date;
		this.decision = decision;
	}
	public String getDecision_icon_p() {
		return decision_icon_p;
	}
	public void setDecision_icon_p(String decision_icon_p) {
		this.decision_icon_p = decision_icon_p;
	}
	public String getDecision_making_cur() {
		return decision_making_cur;
	}
	public void setDecision_making_cur(String decision_making_cur) {
		this.decision_making_cur = decision_making_cur;
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
	public String getEdit_date() {
		return edit_date;
	}
	public void setEdit_date(String edit_date) {
		this.edit_date = edit_date;
	}
	public int getDecision() {
		return decision;
	}
	public void setDecision(int decision) {
		this.decision = decision;
	}
	
}
