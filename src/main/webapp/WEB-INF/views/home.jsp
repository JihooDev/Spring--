<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>Home</title>
	<meta charset="UTF-8">
	<link rel ="stylesheet" type = "text/css" href="resources/myLib/myStyle1.css">
	<script src="resources/myLib/jquery-3.2.1.min.js"></script>
	<script src="resources/myLib/axTest01.js"></script>
</head>
<body>
	<h1>안녕하세요</h1>
	<h3> 
	<c:if test="${empty LoginID}" >
		<h3>로그인 후 이용하세요~</h3>
	</c:if>
	
	<c:if test="${not empty LoginID}"> 
		<b>${LoginID} ${LoginName} 님 안녕하세요</b>
	</c:if>
	</h3>
	
	<hr>
	<img src="resources/image/tulips.png" width="400" height="300">
	<div id="resultArea"></div>
	<hr>
	<c:if test="${not empty LoginID}">
		&nbsp;&nbsp;<a href="mdetail">MyInfo</a>
		&nbsp;&nbsp;<a href="mdetail?jcode=U">Update</a>
		&nbsp;&nbsp;<a href="logout">Logout</a>
		&nbsp;&nbsp;<a href="mdelete">회원탈퇴</a>	
	</c:if>
	<c:if test="${empty LoginID}">
		&nbsp;&nbsp;<a href="loginf">Login</a>
		&nbsp;&nbsp;<span id="axloginf" class="text_link">Ajax Logins</span>
		&nbsp;&nbsp;<a href="joinf">Join</a>
	</c:if>
	<hr>
	&nbsp;&nbsp;<a href="mlist">MemberList</a>
	&nbsp;&nbsp;<a href="blist">리스트</a>
	&nbsp;&nbsp;<a href="axtest">AxTest</a>
	<hr>
	<c:if test="${not empty message}">
		<b>${message}</b>
	</c:if>
</body>
</html>
