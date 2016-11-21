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
			out.println("����û��ɹ�!");
		}else{
			userId = request.getParameter("userId");
			userName = request.getParameter("userName");
			contactTel = request.getParameter("contactTel");
			email = request.getParameter("email");
			out.println("�û������Ѿ�����,����=[" + userId + ']');
		}
	}
%>


<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=GB18030">
		<title>����û�</title>
		<link rel="stylesheet" href="../style/drp.css">
		<script src="../script/client_validate.js"></script>
		<script type="text/javascript">
	function goBack() {
		window.self.location="user_maint.jsp"
	}
	
	function addUser() {
		var userIdField = document.getElementById("userId");
		//�û����벻��Ϊ��
		if(trim(userIdField.value) == ""){
			alert("�û����벻��Ϊ��");
			userIdField.focus();
			return;
		}else if(trim(userIdField.value).length < 4){
			alert("�û���������4���ַ�!");
			userIdField.firstChild;
			return;
		}else if(! (trim(userIdField.value).charAt(0) >= 'a' 
				&& trim(userIdField.value).charAt(0) <= 'z')){
			alert("�û���������ĸ�������ַ�");
			userIdField.focus();
			return;
		}
		//ʹ��������ʽ�ж��û������Ƿ����Ҫ��
		var re = new RegExp(/^[a-zA-Z0-9]{4,6}$/)
		if (!re.test(trim(userIdField.value))){
			alert("�û��������Ϊ���ֻ���ĸ,ֻ��Ϊ4-6λ!");
			userIdField.focus();
			return;
		}
		
		//�û����Ʊ�������
		if(trim(document.getElementById("userName").value).length == 0){
			alert("�û����Ʋ���Ϊ��");
			document.getElementById("userName").focus();
			return;
		}else if(!re.test(document.getElementById("userName").value)){
			alert("�û����Ʊ���Ϊ���ֻ���ĸ,ֻ��Ϊ4-6λ!");
			document.getElementById("userName").focus();
			return;
		}
		
		//�绰�������Ϊ��,�����Ϊ����,�жϹ���: ��Ϊ����
		var contactTelField = document.getElementById("contactTel");
		if(trim(contactTelField.value).length > 0){
			re.compile(/^\d{11}$/);       //ǰ���ѽ�new re,������°�ģʽ 
			if(!re.test(trim(contactTelField.value))){
				alert("�绰����Ϸ�,����������");
				contactTelField.focus();
				return;
			}
		}
		
		//email����Ϊ��,�����Ϊ��ʱ,�жϹ���:xxxx@xxxx.xxx.xxx
		var emailField = document.getElementById("email");
		if(trim(emailField.value).length > 0){
			re.compile(/[a-zA-Z0-9]+@[a-zA-Z]+\.[a-zA-Z]+/);
			if(!re.test(trim(emailField.value))){
				alert("Email��ַ���Ϸ�");
				emailField.focus();
				return;
			}
		}
		/*
		document.getElementById("userForm").action="user_add.jsp";
		document.getElementById("userForm").method="post";
		document.getElementById("userForm").submit();
		*/
		//��ͬ�����д��
		with(document.getElementById("userForm")){
			action="user_add.jsp";
			method="post";
			submit();
		}
	}
	//��ҳ�������ɺ��궨λ��userId
	function init(){
		document.getElementById("userId").focus();
	}
	
	function userIdOnKeyPress(){
		//alert(window.event.keyCode);
		if(!(event.keyCode >= 48 && event.keyCode <=122)){
			event.keyCode = 0;  //0��ʾ������
		}
	}
	
	//�����¼�,ֻҪ�м��̰����ͻᴥ���ĺ���
	document.onkeydown = function(){
		if(event.keyCode == 13 && event.srcElement.type != "button"){
			event.keyCode = 9;
		}
	}
	
	var xmlHttp;
	function createXMLHttpRequest(){
		//��ʾ��ǰ���������ie,��ns,firefox
		if(window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();
		} else if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	
 	function validate(field){
		if(trim(field.value).length != 0){
			//����Ajax���Ķ���XMLHttpRequest
			createXMLHttpRequest();
			
			var url = "user_validate.jsp?userId=" + trim(field.value) + "&time=" + new Date().getTime();
			//��������ʽΪGet,��������url,����Ϊ�첽�ύ
			xmlHttp.open("GET", url, true);
			
			//��������ַ���Ƹ�onreadystatechange����
			//xmlHttp.onreadystatechange=callback;
			//ʹ������������ʽ
			xmlHttp.onreadystatechange=function(){
				//Ajax����״̬Ϊ�ɹ�
				if(xmlHttp.readyState == 4){
					if(xmlHttp.status == 200){
						if(trim(xmlHttp.responseText) != ""){
							document.getElementById("spanUserId").innerHTML = "<font color='red'>" + xmlHttp.responseText + "</font>"
						}else{
							document.getElementById("spanUserId").innerHTML = "";
						}
					}else{
						alert("����ʧ�ܣ�������=" + xmlHttp.status);
					}
				}
			}
			
			xmlHttp.send(null);
		}else{
			document.getElementById("spanUserId").innerHTML = "";
		}
	}
	
/* 	function callback(){
		//Ajax����״̬Ϊ�ɹ�
		if(xmlHttp.readyState == 4){
			if(xmlHttp.status == 200){
				if(trim(xmlHttp.responseText) != ""){
					document.getElementById("spanUserId").innerHTML = "<font color='red'>" + xmlHttp.responseText + "</font>"
				}else{
					document.getElementById("spanUserId").innerHTML = "";
				}
			}else{
				alert("����ʧ�ܣ�������=" + xmlHttp.status);
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
							<b>ϵͳ����&gt;&gt;�û�ά��&gt;&gt;���</b>
						</td>
					</tr>
				</table>
				<hr width="97%" align="center" size=0>
				<table width="95%" border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td width="22%" height="29">
							<div align="right">
								<font color="#FF0000">*</font>�û�����:&nbsp;
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
								<font color="#FF0000">*</font>�û�����:&nbsp;
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
								<font color="#FF0000">*</font>����:&nbsp;
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
								��ϵ�绰:&nbsp;
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
						value="���" onClick="addUser()">
					&nbsp;&nbsp;&nbsp;&nbsp;
					<input name="btnBack" class="button1" type="button" id="btnBack"
						value="����" onClick="goBack()" />
				</div>
			</div>
		</form>
	</body>
</html>
