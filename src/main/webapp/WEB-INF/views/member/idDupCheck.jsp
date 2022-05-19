<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** ID 중복확인 **</title>
<style>
	.errMessage {
		color: red;
		font-size: 11px;
	}
	
	body {
		background-color : #5f27cd;
		font-family: 맑은고딕;	
	}
	
	#wrap {
		margin-left : 0;
		text-align: center;
	}
	
	h3 {
		color: #fff;
	}
	
</style>
</head>
<body>
	<div id="wrap">
		<h3>** ID 중복 확인 **</h3>
		<form action="idDupCheck" method="get">
			USER_ID : 
			<input type="text" id="id" name="id">&nbsp;&nbsp;
			<button onclick="return idCheck()">아이디 중복확인</button><br>
			<!-- inCheck.js 의  idCheck() 의 결과에 따라 sumit 결정-->
			<span id="iMessage" class="errMessage"></span>
		</form>
		<br><br><hr><br>
		<!-- 서버의 확인 결과에 따른 처리 영역 
			=> jstl 필요
			=> idUse : 'T' 가능 / 'F' 불가능
		-->
		<div id="msgBlock">
			<c:if test="${idUse=='T'}">
				${newId} 는 사용 가능 합니다.
				<button onclick="idOK()">ID 사용하기</button>
			</c:if>
			<c:if test="${idUse == 'F' }">
				<span class="errMessage">${newId} 는 이미 사용 중 입니다.</span>
				<!-- 부모창 (joinForm, opener)에 남아있는 사용자 입력 아이디는 지워주고,
				현재 창(this) 에서는 id에 focus를 준다. (재입력 유도) -> script -->
				<script>
					$('#id').focus();
					opener.$('id').val('');
				</script>
			</c:if>
		</div>
	</div>
	<script src="resources/myLib/jquery-3.2.1.min.js"></script>
	<script src="resources/myLib/inCheck.js"></script>
	<script>
		function idOK(){
			//** 사용자가 입력한 id 를 사용가능하도록 해주고, 현재(this)창은 close
			// 1) this 창의 id 를 부모창의 id 로
			// 2) 부모창의 ID중복확인 버튼은 disable & submit 은 enable
			// 3) 부모창의 id 는 수정불가 (readonly) , password 에 focus
			// 4) 현재(this)창은 close
			
			//1)
			
			opener.document.getElementById('id').value='${newId}';
			//2)
			
			//=> <script> 에서 EL은 문자열Type 내부에서 사용 가능함.
			//opener.document.getElementById('idDup').disabled='disabled';
			//opener.document.getElementById('submit').disabled=null;
			
			
			// JQ
			// ** JQ 방식으로 속성 접근
   			// => attr, prop 비교
   			// => attr()는 HTML의 속성(Attribute), 기능, 입력된 값을 취급 
   			// => prop()는 JavaScript DOM 객체의 프로퍼티(Property), 실제값, property가 가지는 본연의 값
   
			opener.$('#submit').attr('disabled', null);
			opener.$('#idDup').attr('disabled','disabled');
			// id가 확정 되었음으로 수정불가 해줘야됨 -> readonly
			
			// 3)			
			opener.$('#id').prop('readonly',true);
			opener.$('#password').focus();
			
			// 4)
			window.close(); // self.close(); close(); this.close();
			
			
/* 			opener.$('#idDup').prop('disabled', true);
			opener.$('#idDup').prop('disabled', false); */
			
			
			
		} // idOK
	</script>
</body>
</html>