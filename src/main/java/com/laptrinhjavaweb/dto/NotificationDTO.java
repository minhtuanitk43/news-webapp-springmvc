package com.laptrinhjavaweb.dto;

import java.util.Date;

public class NotificationDTO {
	private String userName;
	private Long userId;
	private Long newId;
	private String newTitile;
	private Date createdDate;
	private Long commentId;
	private int status;
	
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public Long getCommentId() {
		return commentId;
	}
	public void setCommentId(Long commentId) {
		this.commentId = commentId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public Long getUserId() {
		return userId;
	}
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	public Long getNewId() {
		return newId;
	}
	public void setNewId(Long newId) {
		this.newId = newId;
	}
	public String getNewTitile() {
		return newTitile;
	}
	public void setNewTitile(String newTitile) {
		this.newTitile = newTitile;
	}
	
}
