<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
       
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring MVC2 LoginForm **</title>
<script src="resources/myLib/axTest01.js"></script>
<style>
	.errMessage {
		color: red;
		font-size: 11px;
	}
	
	
</style>
</head>
<body>
<h2>** Web MVC2 LoginForm **</h2>
<br><br>

<!-- *** form Tag 완성하기
	=> 아래 form 의 action 속성을 완성하세요
	   요청명은 login 입니다.			
	=> 그리고 이 요청을 처리하는 Login Controller 를 완성 하세요   
	   화일명 : controller/C01_Login.java	
-->

<form  action="login" method=get>
<table>
<tr height=30>
	<td bgcolor="aqua"><label for=id>I D</label></td>
 	<td><input type="text" name=id id=id>
 	<br><span id="iMessage" class="errMessage"></span></td>
</tr>
<tr height=30>
	<td bgcolor="aqua"><label for=password>Password</label></td>
	<td><input type="password" name=password id=password><br>
	<span id="pMessage" class="errMessage"></span></td>
</tr>
<tr><td></td>	

	<td><br>
	<input type="submit" value=로그인 onclick="return inCheck()">&nbsp;&nbsp;
	<input type="reset" value="취소">
	<span id="axlogin" class="text_link">Ajax Login</span>
	</td>
</tr>	
</table>
</form>
<hr>
<c:if test="${empty LoginID}">
	${message}
</c:if>
<br>
<a href="home">HOME</a>
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/inCheck.js"></script>
<script>
//1) 전역변수 선언
//=> 개별적 오류 확인을 위한 switch 변수
	var iCheck=false;
	var pCheck=false;
	
//2) 개별적 focusout 이벤트 핸들러 작성 : jQuery
$(function() {
	// ** ID
	$('#id').keydown(function(e) {
		if (e.which==13) {
			e.preventDefault();
			// => form 에 submit 이 있는경우
			// => enter 누르면 자동 submit 발생되므로 이를 제거함
			$('#password').focus();
		}
	}).focusout(function() {
		iCheck=idCheck();
	}); //id
	
	// ** password
	$('#password').keydown(function(e) {
		if (e.which==13) {
			e.preventDefault();
			// => form 에 submit 이 있는경우
			// => enter 누르면 자동 submit 발생되므로 이를 제거함
			$('#submit').focus();
		}
	}).focusout(function() {
		pCheck=pwCheck();
	}); //id

}); //ready
//3) submit 판단 & 실행 : JS submit
function inCheck() {
	if(iCheck==false) {
		$('#iMessage').html('ID를 확인하세요.');
	}
	if (pCheck==false) {
		$('#pMessage').html('Password를 확인하세요.');
	}
	
	if (iCheck && pCheck) return true;
	else return false;
} //inCheck
</script>
</body>
</html>