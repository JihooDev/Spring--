<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring MVC2 BoardList **</title>
<style>
	* {
	scroll-behavior: smooth;
	}
	span {
		cursor : pointer;
	}
	
	.content {
		color:grey;
		background : Lavender;
	}
	
	#row {
		position: relative;
	}
	
	#contentBox{
		position : absolute;
		z-index : 999;
		width: 300px;
		height: 70px;
		background-color: yellow;
	}
	
	.textlink {
		color: blue;
	}
</style>
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/axTest01.js"></script>
<script src="resources/myLib/axTest02.js"></script>
<script src="resources/myLib/axTest03.js"></script>
</head>
<body>
<!-- ** 반복문에 이벤트 적용 
   => 매개변수처리에 varStatus 활용, ajax, json Test  
   => Login 여부에 무관하게 처리함.
// Test 1. 타이틀 클릭하면, 하단(resultArea2)에 글 내용 출력하기  -> aTag, JS, jsBDetail1(  ) 
// Test 2. 타이틀 클릭하면, 글목록의 아랫쪽(span result)에 글 내용 출력하기 -> aTag, JS, jsBDetail2( , ) 
// Test 3. seq 에 마우스 오버시에 별도의 DIV에 글내용 표시 되도록 하기 
//         -> jQuery : id, class, this
//          -> seq 의 <td> 에 마우스오버 이벤트
//         -> content 를 표시할 div (table 바깥쪽에) : 표시/사라짐  
//         -> 마우스 포인터의 위치를 이용해서 div의 표시위치 지정
-->


   <!-- ** File DownLoad 추가 
   ** 기본과정 ****************
   1) 요청시 컨트롤러에게 파일패스(path) 와 이름을 제공  (axMemberList.jsp)
   2) 요청받은 컨트롤러에서는 그 파일패스와 이름으로 File 객체를 만들어 뷰로 전달
      (MemberController.java , 매핑 메서드 dnload ) 
   3) 뷰에서는 받은 file 정보를 이용해서 실제 파일을 읽어들인 다음 원하는 위치에 쓰는 작업을 한다.
       -> DownloadView.java
            일반적인 경우에는 컨트롤러에서 작업을 한 후, JSP뷰 페이지로 결과값을 뿌려주는데
          다운로드에 사용될 뷰는 JSP가 아니라 파일정보 임 
      -> 그래서 일반적으로 사용하던 viewResolver 가 처리하는 것이 아니라
          download 만을 처리하는 viewResolver 가 따로 존재해야 함.    
   4) 위 사항이 실행 가능하도록 xml 설정  (servlet-context.xml) 
   ***************************
   
   1) class="dnload" 를 이용하여  jQuery Ajax 로 처리 
      => 안됨 (java 클래스인 서버의 response가 웹브러우져로 전달되지 못하고 resultArea에 담겨질 뿐 )  
      <img src="${list.uploadfile}" width="50" height="60" class="dnload textLink"> 
   2) aTag 로 직접 요청함 
      => java 클래스인  서버의 response가  웹브러우져로 전달되어 download 잘됨. 
   -->
<h2>** Spring MVC2 BoardList **</h2>
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
	<c:forEach var="board" items="${banana}" varStatus="vs">
		<tr height="30" id="row">	
			<td id="${board.seq}" class="sss2 textlink" align="center">${board.seq}</td>
			<!-- Test 1. 타이틀 클릭하면, 하단(resultArea2)에 글 내용 출력하기  -> aTag, JS, jsBDetail1(  )  -->
			<td><a href="javascript:;" onclick="jsBDetail2(event,${board.seq},${vs.count})">${board.title}</a></td>
			<td>${board.id}</td>
			<td>${board.regdate}</td>
			<td>${board.cnt}</td>
		</tr>
		<tr>
			<td></td>
			<td colspan="4"><span id="${vs.count}" class="content"></span></td>
		</tr>
	</c:forEach>
</table>
<hr>
<div id="contentBox">

</div>
<c:if test="${not empty LoginID }">
&nbsp;&nbsp;<a href="binsertf">새글작성</a>
</c:if>
&nbsp;&nbsp;<a href="home">홈으로</a>
</body>
</html>