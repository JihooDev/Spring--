<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring MVC2 BoardList **</title>
<link rel="stylesheet" type="text/css"
	href="resources/myLib/myStyle1.css">
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script>
$(function() {   
   // SearchType 이 '---' 면 keyword 클리어
   $('#searchType').change(function() {
      if ($(this).val()=='n') $('#keyword').val('');
   }); //change
   // 검색후 요청
   // => 검색조건 입력 후 첫 Page 요청
   //	이때는 서버에 searchType, keyword 가 전달되기 이전이므로 makeQuery 메서드 사용
   $('#searchBtn').on("click", function() {
      self.location="bcrilist"
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
<h2>** Spring MVC2 Board Cri_PageList **</h2>
<c:if test="${not empty message}">
	<h3>${message}</h3>
</c:if>
<!-- Paging2 : SearchCriteria 적용 -->
 <div id="searchBar">
   <select name="searchType" id="searchType">
      <option value="n" <c:out value="${pageMaker.cri.searchType==null ? 'selected':''}"/> >---</option>
      <option value="t" <c:out value="${pageMaker.cri.searchType=='t' ? 'selected':''}"/> >Title</option>
      <option value="c" <c:out value="${pageMaker.cri.searchType=='c' ? 'selected':''}"/> >Content</option>
      <option value="i" <c:out value="${pageMaker.cri.searchType=='i' ? 'selected':''}"/> >글쓴이ID</option>
      <option value="tc" <c:out value="${pageMaker.cri.searchType=='tc' ? 'selected':''}"/> >Title or Content</option>
      <option value="ti" <c:out value="${pageMaker.cri.searchType=='ti' ? 'selected':''}"/> >Title or ID</option>
      <option value="tci" <c:out value="${pageMaker.cri.searchType=='tci' ? 'selected':''}"/> >Title or Content or ID</option>
   </select>
   <input type="text" name="keyword" id="keyword" value="${pageMaker.cri.keyword}">
   <button id="searchBtn">Search</button>
</div>
<br><hr>
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
	<!-- 
		** Cri_Paging
		=> ver01 : Criteria 적용 -> pageMaker.makeQuery()
		=> ver02 : SearchCriteria -> pageMaker.searchQuery()
	 -->
	<c:choose>
		<c:when test="${ pageMaker.prev && pageMaker.spageNo > 1}">
			<a href="bcrilist${pageMaker.searchQuery(1)}">FF</a>&nbsp;&nbsp;
			<a href="bcrilist${pageMaker.searchQuery(pageMaker.spageNo -1 )}">&lt;</a>&nbsp;&nbsp;&nbsp;
		</c:when>
		<c:otherwise>
			<font color="gray">FF&nbsp;&nbsp;</font>
		</c:otherwise>
	</c:choose>
	<c:forEach var="i" begin="${pageMaker.spageNo}" end="${pageMaker.epageNo}">
		<c:if test="${i==pageMaker.cri.currPage}">
			<font size="5" color="orange">${i}</font>&nbsp;
		</c:if>
		<c:if test="${i != pageMaker.cri.currPage}">
			<a href="bcrilist${pageMaker.searchQuery(i)}">${i}</a>&nbsp;
		</c:if>
	</c:forEach>&nbsp;&nbsp;
	<c:choose>
		<c:when test="${pageMaker.next && pageMaker.epageNo > 0}">
			<a href="bcrilist${pageMaker.searchQuery(pageMaker.spageNo + 1)}">&gt;</a>
			<a href="bcrilist?currPage=${pageMaker.searchQuery(pageMaker.lastPageNo)}">LL</a>
		</c:when>
		<c:otherwise>
			<font color="gray">&nbsp;&nbsp;LL</font>
		</c:otherwise>
	</c:choose>
</div>
<c:if test="${not empty LoginID }">
&nbsp;&nbsp;<a href="binsertf">새글작성</a>
</c:if>
&nbsp;&nbsp;<a href="home">홈으로</a>
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
</body>
</html>