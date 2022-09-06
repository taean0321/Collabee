package com.one.dto;

public class JHDto {
	//field 
	private String kanban_icon_p, title, workspace_name, date, content, creation_date, start_date, finish_date;
	
	//constructor
	public JHDto() {}
	public JHDto(String kanban_icon_p, String title, String workspace_name, String date) {
		this.kanban_icon_p = kanban_icon_p;
		this.title = title;
		this.workspace_name = workspace_name;
		this.date = date;
	}
	public JHDto(String start_date, String finish_date, String title) {
		this.start_date = start_date;
		this.finish_date = finish_date;
		this.title = title;
	}
	
	
	//setter getter
	public String getKanban_icon_p() {
		return kanban_icon_p;
	}
	public void setKanban_icon_p(String kanban_icon_p) {
		this.kanban_icon_p = kanban_icon_p;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWorkspace_name() {
		return workspace_name;
	}
	public void setWorkspace_name(String workspace_name) {
		this.workspace_name = workspace_name;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	
	
	
	
}

