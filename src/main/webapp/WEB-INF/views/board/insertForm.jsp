<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Board Insert **</title>
</head>
<body>
<h2>** Board Insert **</h2>
<form action="binsert" method="post">
	<table>
		<tr>
			<td height="40" bgcolor="#feca57">I D</td>
			<td><input type="text" name="id" id="id" value="${LoginID}" readonly></td>
		</tr>
		<tr>
			<td height="40" bgcolor="#feca57">Title</td>
			<td><input type="text" name="title" id="title"></td>
		</tr>
		<tr>
			<td height="40" bgcolor="#feca57">Content</td>
			<td><textarea rows="5" cols="50" name="content"></textarea></td>
		</tr>
		<tr>
			<td></td>
			<td>
				<button type="submit">등록하기</button>&nbsp;&nbsp;
				<button type="reset">취소</button>&nbsp;&nbsp;
			</td>
		</tr>
	</table>
</form>
<c:if test="${not empty message }">
	<h3>${message }</h3>
</c:if>
<hr>
&nbsp;&nbsp;<a href="home">홈으로</a>
&nbsp;&nbsp;<a href="blist">리스트</a>
</body>
</html>