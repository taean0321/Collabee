package com.yr.dto;

import java.util.ArrayList;


public class ArticleDto {
	private String title;
	private String picture;
	private String kanban;
	private String wname;
	private int w_id;
	private String edit_date;
	private int id;
	private int sort;
	private int docu;
//	public int getpicture;
//	public int getkanban;
//	public int getwname;
	ArrayList<ArticleCommentDto> listComment;
	public ArticleDto() {}
	public ArticleDto(String title, String picture, String kanban, String wname, int w_id, String edit_date, int id, int sort,
			int docu, ArrayList<ArticleCommentDto> listComment) {
		this.setTitle(title);
		this.setPicture(picture);
		this.setKanban(kanban);
		this.setWname(wname);
		this.setW_id(w_id);
		this.setEdit_date(edit_date);
		this.setId(id);
		this.setSort(sort);
		this.setDocu(docu);
		this.listComment = listComment;
	}

	/*
	 * public YGDTO(String title, String picture, String kanban, String wname,
	 * String edit_date, int id, int sort, int docu) { super();
	 * this.setTitle(title); this.setPicture(picture); this.setKanban(kanban);
	 * this.setWname(wname); this.setEdit_date(edit_date); this.setId(id);
	 * this.setSort(sort); this.setDocu(docu); }
	 */
	
//	@Override
//	public String toString() {
//		return "[title=" + title + ", picture=" + picture + ", kanban=" + kanban + ", wname=" + wname
//				+ ", edit_date=" + edit_date + ", id=" + id + ", sort=" + sort + ", docu=" + docu + "]";
//	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getKanban() {
		return kanban;
	}

	public void setKanban(String kanban) {
		this.kanban = kanban;
	}

	public String getWname() {
		return wname;
	}

	public void setWname(String wname) {
		this.wname = wname;
	}

	public int getW_id() {
		return w_id;
	}

	public void setW_id(int w_id) {
		this.w_id = w_id;
	}
	
	public String getEdit_date() {
		return edit_date;
	}

	public void setEdit_date(String edit_date) {
		this.edit_date = edit_date;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getSort() {
		return sort;
	}

	public void setSort(int sort) {
		this.sort = sort;
	}

	public int getDocu() {
		return docu;
	}

	public void setDocu(int docu) {
		this.docu = docu;
	}

//	public int getGetpicture() {
//		return getpicture;
//	}
//
//	public void setGetpicture(int getpicture) {
//		this.getpicture = getpicture;
//	}
//
//	public int getGetkanban() {
//		return getkanban;
//	}
//
//	public void setGetkanban(int getkanban) {
//		this.getkanban = getkanban;
//	}
//
//	public int getGetwname() {
//		return getwname;
//	}
//
//	public void setGetwname(int getwname) {
//		this.getwname = getwname;
//	}

	public ArrayList<ArticleCommentDto> getListComment() {
		return listComment;
	}

	public void setListComment(ArrayList<ArticleCommentDto> listComment) {
		this.listComment = listComment;
	}
}
