<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Member List **</title>
</head>
<body>
<table width=100%>
	<tr bgcolor="pink">
		<th>I D</th><th>Password</th><th>Name</th><th>Level</th>
		<th>Birthday</th><th>Point</th><th>Weight</th>
	</tr>
	<c:if test="${not empty banana}">
		<c:forEach var="member" items="${banana}" >
			<tr><td>${member.id}</td><td>${member.password}</td><td>${member.name}</td>
				<td>${member.lev}</td><td>${member.birthd}</td><td>${member.point}</td>
				<td>${member.weight}</td><td>${member.rid}</td><td><img src="${member.uploadfile}" width=50 height="60"></td>	
			</tr>
		</c:forEach>
	</c:if>
	<c:if test="${empty banana}">
			<tr><td colspan=7>** 출력할 자료가 1건도 없습니다 **</td></tr>
	</c:if>
</table>
<a href="home">홈으로</a>
</body>
</html>