package com.yr.dto;

public class MyWorkspaceDto {
	private int workspace_id;
	private String workspace_name;
	public MyWorkspaceDto() {}
	public MyWorkspaceDto(int workspace_id, String workspace_name) {
		super();
		this.workspace_id = workspace_id;
		this.workspace_name = workspace_name;
	}
	public int getWorkspace_id() {
		return workspace_id;
	}
	public void setWorkspace_id(int workspace_id) {
		this.workspace_id = workspace_id;
	}
	public String getWorkspace_name() {
		return workspace_name;
	}
	public void setWorkspace_name(String workspace_name) {
		this.workspace_name = workspace_name;
	}
	
}
