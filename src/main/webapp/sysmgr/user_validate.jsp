<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.bjpowernode.drp.sysmgr.manager.*"%>
<% 
	String userId = request.getParameter("userId");
	if(UserManager.getInstance().findUserById(userId) != null){
		out.println("用户代码已经存在!");
	}
%>