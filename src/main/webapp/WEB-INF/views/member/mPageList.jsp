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
<br><hr>
<div align="center">
	<!-- Paging 1. : 모든페이지 출력, 현재Page 강조 / 나머지 페이지는 링크 -->
	<%-- <c:forEach var="i" begin="1" end="${totalPageNo}">
		<c:if test="${i==currPage}">
			<font size="5" color="orange">${i}</font>&nbsp;
		</c:if>
		<c:if test="${i != currPage}">
			<a href="bpagelist?currPage=${i}">${i}</a>&nbsp;
		</c:if>
	</c:forEach> --%>
	<c:choose>
		<c:when test="${sPageNo > pageNocount}">
			<a href="mpagelist?currPage=1">FF</a>&nbsp;&nbsp;
			<a href="mpagelist?currPage=${sPageNo-1}">&lt;</a>&nbsp;&nbsp;&nbsp;
		</c:when>
		<c:otherwise>
			<font color="gray">FF&nbsp;&nbsp;</font>
		</c:otherwise>
	</c:choose>
	<c:forEach var="i" begin="${sPageNo}" end="${ePageNo}">
		<c:if test="${i==currPage}">
			<font size="5" color="orange">${i}</font>&nbsp;
		</c:if>
		<c:if test="${i != currPage}">
			<a href="mpagelist?currPage=${i}">${i}</a>&nbsp;
		</c:if>
	</c:forEach>&nbsp;&nbsp;
	<c:choose>
		<c:when test="${ePageNo < totalPageNo}">
			<a href="mpagelist?currPage=${ePageNo+1}">&gt;</a>
			<a href="mpagelist?currPage=${totalPageNo}">LL</a>
		</c:when>
		<c:otherwise>
			<font color="gray">&nbsp;&nbsp;LL</font>
		</c:otherwise>
	</c:choose>
</div>
<a href="home">홈으로</a>
</body>
</html>