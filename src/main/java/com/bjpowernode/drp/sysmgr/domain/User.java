package com.bjpowernode.drp.sysmgr.domain;

import java.util.Date;
 
/**
 * 用户实体类
 * @author ddh
 *
 */
public class User {
	
	//用户ID
	private String userId;
	
	//用户名
	private String userName;
	
	//密码
	private String password;
	
	//电话
	private String contactTel;
	
	//邮箱
	private String email;
	
	//创建日期
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
