<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Board Detail **</title>
</head>
<body>
<h2>** Board Detail **</h2>

<table width=100%>
	<tr height="40">
		<td bgcolor="#54a0ff">번호</td><td bgcolor="#54a0ff">${apple.seq}</td>
	</tr>
	<tr height="40">
		<td bgcolor="#54a0ff">아이디</td><td bgcolor="#54a0ff">${apple.id}</td>
	</tr>
	<tr height="40">
		<td bgcolor="#54a0ff">제목</td><td bgcolor="#54a0ff">${apple.title}</td>
	</tr>
	<tr height="40">
		<td bgcolor="#54a0ff">글 목록</td><td bgcolor="#54a0ff"><textarea rows="5" cols="50" readonly="readonly">${apple.content}</textarea></td>
	</tr>
	<tr height="40">
		<td bgcolor="#54a0ff">작성 시간</td><td bgcolor="#54a0ff">${apple.regdate}</td>
	</tr>
	<tr height="40">
		<td bgcolor="#54a0ff">조회수</td><td bgcolor="#54a0ff">${apple.cnt}</td>
	</tr>
</table>
<hr>
<!-- 로그인 했으면 글 등록 -->
<c:if test="${not empty LoginID}">
	&nbsp;&nbsp;<a href="binsertf">새글작성</a>
	&nbsp;&nbsp;<a href="rinsertf?root=${apple.root}&step=${apple.step}&indent=${apple.indent}">답글작성</a>
</c:if>
<!-- 내 글이면 글 수정, 글 삭제 가능 -->
<c:if test="${LoginID == apple.id}">
	&nbsp;&nbsp;<a href="bupdatef?seq=${apple.seq}" onclick="alert('글을 수정합니다')">글 수정</a>
	&nbsp;&nbsp;<a href="bdelete?seq=${apple.seq}&root=${apple.root}" onclick="alert('글을 삭제합니다')">글 삭제</a>
</c:if>
<hr>
<a href="home">HOME</a>
<c:if test="${not empty message }">
	<h3>${message}</h3>
</c:if>
</body>
</html>