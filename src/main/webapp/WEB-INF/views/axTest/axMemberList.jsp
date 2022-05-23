<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/axTest02.js"></script>
<style>
	* {
	scroll-behavior: smooth;}
</style>
<title>** Member List **</title>
</head>
<body>
<!-- ** 반복문에 이벤트 적용하기 
=> 과제 : id 클릭하면 이 id가 쓴 글목록(board)을 resultArea2 에 출력하기 
1) JS : Tag의 onclick 이벤트속성(리스너) , function 이용
=> id 전달: function 의 매개변수를 이용 -> aidBList('banana') 
=> a Tag 를 이용하여 이벤트적용
      -> href="" 의 값에 따라 scroll 위치 변경 가능.
        <a href="" onclick="aidBList('banana')" >....
      -> href="#"      .... scroll 위치 변경
          "#" 에 #id 를 주면 id의 위치로 포커스를 맞추어 이동, 	
           #만 주면 포커스가 top 으로 올라감
      -> href="javascript:;" ...... scroll 위치 변경 없음

2) JQuery : class, id, this 이용
=> 모든 row 들에게 이벤트를 적용하면서 (class 사용)
   해당되는(선택된) row 의 값을 인식 할 수 있어야 함 (id 활용) 
-->
<table width=100%>
	<tr bgcolor="pink">
		<th>I D</th><th>Password</th><th>Name</th><th>Level</th>
		<th>Birthday</th><th>Point</th><th>Weight</th><th>추천인</th><th>Image</th>
		
		<c:if test="${LoginID == 'admin'}">
		<th>Delete</th>
		</c:if>
	</tr>
	<c:if test="${not empty banana}">
		<c:forEach var="member" items="${banana}" >
			<tr><td><%-- <a href="#resultArea2" onclick="aidBList('${member.id}')">${member.id}</a> --%>
				<span id="${member.id }" class="ccc textlink">${member.id }</span>
			</td><td>${member.password}</td><td>${member.name}</td>
				<td>${member.lev}</td><td>${member.birthd}</td><td>${member.point}</td>
				<td>${member.weight}</td><td>${member.rid}</td><td><a href="dnload?dnfile=${member.uploadfile }"><img src="${member.uploadfile}" width=50 height="60"></a></td>
				<c:if test="${LoginID == 'admin'}">
				<td><span id="${member.id}" class="ddd textlink">삭제하기</span></td>	
				</c:if>
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