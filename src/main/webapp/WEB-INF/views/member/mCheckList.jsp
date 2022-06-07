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
<hr>
<div id="searchBar">
	<form action="mchecklist" method="get">
		<b>Level : </b>
		<input type="checkbox" name="check" value="A">관리자&nbsp; 
		<input type="checkbox" name="check" value="B">나무&nbsp; 
		<input type="checkbox" name="check" value="C">잎새&nbsp; 
		<input type="checkbox" name="check" value="D">새싹&nbsp;
		<button>검색</button>
		<button type="reset"]>취소</button> 
	</form>
</div>
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
			<tr><td colspan=7>출력 할 자료 없음</td></tr>
	</c:if>
</table>
<a href='javascript:history.go(-1)'>이전으로</a>&nbsp;&nbsp;
<a href="home">홈으로</a>
</body>
</html>