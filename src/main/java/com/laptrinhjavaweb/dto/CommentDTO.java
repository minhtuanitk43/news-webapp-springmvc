package com.laptrinhjavaweb.dto;

public class CommentDTO extends AbstractDTO<CommentDTO>{
	private String userName;
	private String content;
	private long userId;
	private long newId;
	private Integer status;
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public long getUserId() {
		return userId;
	}
	public void setUserId(long userId) {
		this.userId = userId;
	}
	public long getNewId() {
		return newId;
	}
	public void setNewId(long newId) {
		this.newId = newId;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}	
}
