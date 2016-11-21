<%@ page language="java" contentType="text/html; charset=GB18030"
    pageEncoding="GB18030"%>
   
<%@ page import="com.bjpowernode.drp.sysmgr.domain.*" %> 
<%@ page import="com.bjpowernode.drp.sysmgr.manager.*" %>
<%
	request.setCharacterEncoding("GB18030");
	String command = request.getParameter("command");
	String userId = null;
	String userName = null;
	String contactTel = null;
	String email = null;
	if("add".equals(command)){
		if(UserManager.getInstance().findUserById(request.getParameter("userId")) == null){
			User user = new User();
			user.setUserId(request.getParameter("userId"));
			user.setUserName(request.getParameter("userName"));
			user.setPassword(request.getParameter("password"));
			user.setContactTel(request.getParameter("contactTel"));
			user.setEmail(request.getParameter("email"));
			
	 		UserManager.getInstance().addUser(user);
			out.println("添加用户成功!");
		}else{
			userId = request.getParameter("userId");
			userName = request.getParameter("userName");
			contactTel = request.getParameter("contactTel");
			email = request.getParameter("email");
			out.println("用户代码已经存在,代码=[" + userId + ']');
		}
	}
%>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>添加用户</title>
		<link rel="stylesheet" href="../style/drp.css">
		<script src="../script/client_validate.js"></script>
		<script type="text/javascript">
	function goBack() {
		window.self.location="user_maint.jsp"
	}
	
	function addUser() {
		var userIdField = document.getElementById("userId");
		//用户代码不能为空
		if(trim(userIdField.value) == ""){
			alert("用户代码不能为空");
			userIdField.focus();
			return;
		}else if(trim(userIdField.value).length < 4){
			alert("用户代码至少4个字符!");
			userIdField.firstChild;
			return;
		}else if(! (trim(userIdField.value).charAt(0) >= 'a' 
				&& trim(userIdField.value).charAt(0) <= 'z')){
			alert("用户代码首字母必须是字符");
			userIdField.focus();
			return;
		}
		//使用正则表达式判断用户代码是否符合要求
		var re = new RegExp(/^[a-zA-Z0-9]{4,6}$/)
		if (!re.test(trim(userIdField.value))){
			alert("用户代码必须为数字或字母,只能为4-6位!");
			userIdField.focus();
			return;
		}
		
		//用户名称必须输入
		if(trim(document.getElementById("userName").value).length == 0){
			alert("用户名称不能为空");
			document.getElementById("userName").focus();
			return;
		}else if(!re.test(document.getElementById("userName").value)){
			alert("用户名称必须为数字或字母,只能为4-6位!");
			document.getElementById("userName").focus();
			return;
		}
		
		//电话号码可以为空,如果不为空是,判断规则: 都为数字
		var contactTelField = document.getElementById("contactTel");
		if(trim(contactTelField.value).length > 0){
			re.compile(/^\d{11}$/);       //前面已将new re,这里从新绑定模式 
			if(!re.test(trim(contactTelField.value))){
				alert("电话号码合法,请重新输入");
				contactTelField.focus();
				return;
			}
		}
		
		//email可以为空,如果不为空时,判断规则:xxxx@xxxx.xxx.xxx
		var emailField = document.getElementById("email");
		if(trim(emailField.value).length > 0){
			re.compile(/[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+/);
			if(!re.test(trim(emailField.value))){
				alert("Email地址不合法");
				emailField.focus();
				return;
			}
		}
		/*
		document.getElementById("userForm").action="user_add.jsp";
		document.getElementById("userForm").method="post";
		document.getElementById("userForm").submit();
		*/
		//等同上面的写法
		with(document.getElementById("userForm")){
			action="user_add.jsp";
			method="post";
			submit();
		}
	}
	//当页面加载完成后光标定位到userId
	function init(){
		document.getElementById("userId").focus();
	}
	
	function userIdOnKeyPress(){
		//alert(window.event.keyCode);
		if(!(event.keyCode >= 48 && event.keyCode <=122)){
			event.keyCode = 0;  //0表示不输入
		}
	}
	
	//键盘事件,只要有键盘按键就会触发改函数
	document.onkeydown = function(){
		if(event.keyCode == 13 && event.srcElement.type != "button"){
			event.keyCode = 9;
		}
	}
	
	var xmlHttp;
	function createXMLHttpRequest(){
		//表示当前浏览器不是ie,如ns,firefox
		if(window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
 	function validate(field){
		if(trim(field.value).length != 0){
			//创建Ajax核心对象XMLHttpRequest
			createXMLHttpRequest();
			
			var url = "user_validate.jsp?userId=" + trim(field.value) + "&time=" + new Date().getTime();
			//设置请求方式为Get,设置请求url,设置为异步提交
			xmlHttp.open("GET", url, true);
			
			//将方法地址复制给onreadystatechange属性
			//xmlHttp.onreadystatechange=callback;
			//使用匿名函数方式
			xmlHttp.onreadystatechange=function(){
				//Ajax引擎状态为成功
				if(xmlHttp.readyState == 4){
					if(xmlHttp.status == 200){
						if(trim(xmlHttp.responseText) != ""){
							document.getElementById("spanUserId").innerHTML = "<font color='red'>" + xmlHttp.responseText + "</font>"
						}else{
							document.getElementById("spanUserId").innerHTML = "";
						}
					}else{
						alert("请求失败，错误码=" + xmlHttp.status);
					}
				}
			}
			
			xmlHttp.send(null);
		}else{
			document.getElementById("spanUserId").innerHTML = "";
		}
	}
	
/* 	function callback(){
		//Ajax引擎状态为成功
		if(xmlHttp.readyState == 4){
			if(xmlHttp.status == 200){
				if(trim(xmlHttp.responseText) != ""){
					document.getElementById("spanUserId").innerHTML = "<font color='red'>" + xmlHttp.responseText + "</font>"
				}else{
					document.getElementById("spanUserId").innerHTML = "";
				}
			}else{
				alert("请求失败，错误码=" + xmlHttp.status);
			}
		}
	} */
	
</script>
	</head>

	<body class="body1" onload="init()">
		<form name="userForm" target="_self" id="userForm">
		<input type="hidden" name="command" value="add">
			<div align="center">
				<table width="95%" border="0" cellspacing="2" cellpadding="2">
					<tr>
						<td>&nbsp;
							
						</td>
					</tr>
				</table>
				<table width="95%" border="0" cellspacing="0" cellpadding="0"
					height="25">
					<tr>
						<td width="522" class="p1" height="25" nowrap>
							<img src="../images/mark_arrow_03.gif" width="14" height="14">
							&nbsp;
							<b>系统管理&gt;&gt;用户维护&gt;&gt;添加</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>用户代码:&nbsp;
							</div>
						</td>
						<td width="78%">
							<input name="userId" type="text" class="text1" id="userId"
								size="10" maxlength="10" onkeypress="userIdOnKeyPress()" onblur="validate(this)">
								<span id="spanUserId"></span>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>用户名称:&nbsp;
							</div>
						</td>
						<td>
							<input name="userName" type="text" class="text1" id="userName"
								size="20" maxlength="20">
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								<font color="#FF0000">*</font>密码:&nbsp;
							</div>
						</td>
						<td>
							<label>
								<input name="password" type="password" class="text1"
									id="password" size="20" maxlength="20">
							</label>
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								联系电话:&nbsp;
							</div>
						</td>
						<td>
							<input name="contactTel" type="text" class="text1"
								id="contactTel" size="20" maxlength="20">
						</td>
					</tr>
					<tr>
						<td height="26">
							<div align="right">
								email:&nbsp;
							</div>
						</td>
						<td>
							<input name="email" type="text" class="text1" id="email"
								size="20" maxlength="20">
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<div align="center">
					<input name="btnAdd" class="button1" type="button" id="btnAdd"
						value="添加" onClick="addUser()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="返回" onClick="goBack()" />
				</div>
			</div>
		</form>
	</body>
</html>
