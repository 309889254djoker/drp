package com.bjpowernode.drp.sysmgr.domain;

import java.util.Date;

/**
 * �û�ʵ����
 * @author ddh
 *
 */
public class User {
	
	//�û�ID
	private String userId;
	
	//�û���
	private String userName;
	
	//����
	private String password;
	
	//�绰
	private String contactTel;
	
	//����
	private String email;
	
	//��������
	private Date createDate;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getContactTel() {
		return contactTel == null ? "" : contactTel;
	}

	public void setContactTel(String contactTel) {
		this.contactTel = contactTel;
	}

	public String getEmail() {
		return email == null ? "" : email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	
}