<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Board Update **</title>
</head>
<body>
<h2>** Board Update **</h2>
<form action="bupdate" method="post">
	<table width=100%>
		<tr height="40">
			<td bgcolor="#54a0ff">번호</td>
			<td bgcolor="#54a0ff"><input type="text" name="seq" value="${apple.seq}" readonly></input></td>
		</tr>
		<tr height="40">
			<td bgcolor="#54a0ff">아이디</td>
			<td bgcolor="#54a0ff">${apple.id}</td>
		</tr>
		<tr height="40">
			<td bgcolor="#54a0ff">제목</td>
			<td bgcolor="#54a0ff"><input type="text" name="title" value="${apple.title}"></input></td>
		</tr>
		<tr height="40">
			<td bgcolor="#54a0ff">글 목록</td>
			<td bgcolor="#54a0ff">
				<textarea rows="5" cols="50" name="content">${apple.content}</textarea>
			</td>
		</tr>
		<tr height="40">
			<td bgcolor="#54a0ff">작성 시간</td>
			<td bgcolor="#54a0ff">${apple.regdate}</td>
		</tr>
		<tr height="40">
			<td bgcolor="#54a0ff">조회수</td>
			<td bgcolor="#54a0ff">${apple.cnt}</td>
		</tr>
		<tr height="40">
			<td bgcolor="#54a0ff" colspan="1"><button type="submit">전송하기</button>
			<button type="submit">취소하기</button></td>
		</tr>
	</table>
</form>
<hr>
<!-- 로그인 했으면 글 등록 -->
<c:if test="${not empty LoginID}">
	&nbsp;&nbsp;<a href="/Web02/board/insertForm.jsp">새글작성</a>
</c:if>
<!-- 내 글이면 글 수정, 글 삭제 가능 -->
<hr>
<a href="home">HOME</a>
<c:if test="${not empty message }">
	<h3>${message}</h3>
</c:if>
</body>
</html>