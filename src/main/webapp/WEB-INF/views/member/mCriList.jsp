<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring_Mybatis Member PageList **</title>
<link rel="stylesheet" type="text/css" href="resources/myLib/myStyle.css" >
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script>
$(function() {	
	// SearchType 이 '---' 면 keyword 클리어
	$('#searchType').change(function() {
		if ($(this).val()=='n') $('#keyword').val('');
	}); //change
	
	// 검색후 요청
	// => 검색조건 입력 후 첫 Page 요청
	//	  이때는 서버에 searchType, keyword 가 전달되기 이전이므로 makeQuery 메서드사용
	$('#searchBtn').on("click", function() {
		self.location="mcrilist"
			+"${pageMaker.makeQuery(1)}"
			+"&searchType="
			+$('#searchType').val()
			+'&keyword='
			+$('#keyword').val()
	}); //on_click
	
}) //ready
</script>
</head>
<body>
<h2>** Spring_Mybatis Member PageList **</h2>
<br>
<c:if test="${message!=null}">
 => ${message}<br> 
</c:if>
<!-- Paging2 : SearchCriteria 적용 -->
 <div id="searchBar">
	<select name="searchType" id="searchType">
		<!-- <option value="n" selected> 을 조건(cri.searchType 의 값)별로 따라 작성하기 위한 삼항식 -->
		<option value="n" <c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/> >---</option>
		<option value="i" <c:out value="${pageMaker.cri.searchType=='i' ? 'selected':''}"/> >ID</option>
		<option value="a" <c:out value="${pageMaker.cri.searchType=='a' ? 'selected':''}"/> >Name</option>
		<option value="l" <c:out value="${pageMaker.cri.searchType=='l' ? 'selected':''}"/> >Level</option>
		<option value="r" <c:out value="${pageMaker.cri.searchType=='r' ? 'selected':''}"/> >추천인</option>
		<option value="b" <c:out value="${pageMaker.cri.searchType=='b' ? 'selected':''}"/> >Birthday</option>
		<option value="ia" <c:out value="${pageMaker.cri.searchType=='ia' ? 'selected':''}"/> >ID or Name</option>
	</select>
	<input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
	<button id="searchBtn">Search</button>
</div>
<br><hr>
<table width=100%>
<tr height="30" bgcolor="Azure">
	<th>ID</th><th>Password</th><th>Name</th><th>Level</th>
	<th>BirthDay</th><th>Point</th><th>Weight</th><th>추천인</th><th>Image</th>
</tr>
<c:forEach var="list" items="${banana}">
<tr height="30" align="center">
	<td>${list.id}</td><td>${list.password}</td><td>${list.name}</td>
	<td>${list.lev}</td><td>${list.birthd}</td><td>${list.point}</td>
	<td>${list.weight}</td><td>${list.rid}</td>
	<td><img src="${list.uploadfile}" width="50" height="60"></td>
</tr>
</c:forEach>
</table>
<br><hr>

<div align="center">
	<!-- *** Cri_Paging 
		=> ver01 : Criteria 적용 -> pageMaker.makeQuery(?)
		=> ver02 : SearchCriteria 적용 -> pageMaker.searchQuery(?)
				예) id = banana 를 검색하는 경우의 쿼리스트링
				mcrilist?currPage=2&rowsPerPage=5&searchType=i&keyword=banana
	-->
	<!-- First Page & < -->
	<c:choose>
		<c:when test="${pageMaker.prev && pageMaker.spageNo>1}">
			<a href="mcrilist${pageMaker.searchQuery(1)}">FF</a>&nbsp;
			<a href="mcrilist${pageMaker.searchQuery(pageMaker.spageNo-1)}">&lt;</a>&nbsp;&nbsp;
		</c:when>	
		<c:otherwise>
			<font color="gray">FF&nbsp;&lt;&nbsp;&nbsp;</font>
		</c:otherwise>
	</c:choose>
	<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
		<c:if test="${i==pageMaker.cri.currPage}">
			<font size="5" color="Orange">${i}</font>&nbsp;
		</c:if>
		<c:if test="${i!=pageMaker.cri.currPage}">
			<a href="mcrilist${pageMaker.searchQuery(i)}">${i}</a>&nbsp;
		</c:if>
	</c:forEach>
	&nbsp;
	<!-- Last Page & > -->
	<c:choose>
		<c:when test="${pageMaker.next && pageMaker.epageNo>0 }">
			<a href="mcrilist${pageMaker.searchQuery(pageMaker.epageNo+1)}">&gt;</a>&nbsp;
			<a href="mcrilist${pageMaker.searchQuery(pageMaker.lastPageNo)}">LL</a>		
		</c:when>	
		<c:otherwise>
			<font color="gray">&gt;&nbsp;LL</font>
		</c:otherwise>
	</c:choose>
</div>

<br><hr>
<c:if test="${LoginID!=null}"> 	
	<a href="binsertf">새글등록</a>&nbsp;&nbsp;
	<a href="logout">Logout</a>&nbsp;&nbsp;
</c:if>  
<c:if test="${LoginID==null}"> 
	<a href="loginf">로그인</a>&nbsp;&nbsp;
	<a href="joinf">회원가입</a>&nbsp;&nbsp;
</c:if>
<a href="home">HOME</a>
</body>
</html>