<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring MVC2 BoardList **</title>
</head>
<body>
<h2>** Spring MVC2 Board PageList **</h2>
<c:if test="${not empty message}">
	<h3>${message}</h3>
</c:if>
<table width=100%>
	<tr bgcolor="yellow" height="30">
		<th>Seq</th>
		<th>Title</th>
		<th>I D</th>
		<th>RegDate</th>
		<th>조회수</th>
	<tr>
	<c:forEach var="board" items="${banana}">
		<tr height="30" align="center">	
			<td>${board.seq}</td>
			
			<td align="left">
			<!-- 답글 등록후 indent 에 따른 들여쓰기 
             => 답글인 경우에만 적용  -->
            	<c:if test="${board.indent > 0}">
            		<c:forEach begin="1" end="${board.indent }">
            			<span>&nbsp;&nbsp;</span>
            		</c:forEach>
            		<span style="color:red">RE__</span>
             	</c:if>
				<a href="bdetail?seq=${board.seq }">${board.title}</a>
			</td>
			
			<td>${board.id}</td>
			<td>${board.regdate}</td>
			<td>${board.cnt}</td>
		</tr>
	</c:forEach>
</table>
<br><hr>
<div align="center">
	<!-- Paging 1. : 모든페이지 출력, 현재Page 강조 / 나머지 페이지는 링크 -->
	<c:forEach var="i" begin="1" end="${totalPageNo}">
		<c:if test="${i==currPage}">
			<font size="5" color="orange">${i}</font>&nbsp;
		</c:if>
		<c:if test="${i != currPage}">
			<a href="bpagelist?currPage=${i}">${i}</a>&nbsp;
		</c:if>
	</c:forEach>
	
</div>
<c:if test="${not empty LoginID }">
&nbsp;&nbsp;<a href="binsertf">새글작성</a>
</c:if>
&nbsp;&nbsp;<a href="home">홈으로</a>
</body>
</html>