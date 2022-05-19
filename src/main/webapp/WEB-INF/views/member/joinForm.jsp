<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Web MVC2 JoinForm **</title>
<style type="text/css">
	table {
		width: 100%;
		height: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
	}
	
	.errMessage {
		color: red;
		font-size: 11px;
	}
</style>
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/axTest01.js"></script>
</head>
<body>
<!--  ** FileUpLoad Form **
=> form 과 table Tag 사용시 주의사항 : form 내부에 table 사용해야함
   -> form 단위작업시 인식안됨
   -> JQ 의 serialize, FormData 의 append all 등 
   
=> method="post" : 255 byte 이상 대용량 전송 가능 하므로 
=> enctype="multipart/form-data" : 화일 upload 를 가능하게 해줌 
   ** multipart/form-data는 파일업로드가 있는 입력양식요소에 사용되는 enctype 속성의 값중 하나이고, 
       multipart는 폼데이터가 여러 부분으로 나뉘어 서버로 전송되는 것을 의미
       이 폼이 제출될 때 이 형식을 서버에 알려주며, 
       multipart/form-data로 지정이 되어 있어야 서버에서 정상적으로 데이터를 처리할 수 있다.     
   -->
<h2>** Spring Mybatis JoinForm **</h2>

<form action="join" method="post" id="myform" enctype="multipart/form-data">
<table>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=id>I D</label></td>
 	<td><input type="text" name=id id=id>&nbsp;&nbsp;
 	<button type="button" id="idDup" onclick="idDupCheck()">아이디 중복확인</button><br>
 	<span id="iMessage" class="errMessage"></span></td><br>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=password>Password</label></td>
	<td><input type="password" name=password id=password><br>
	<span id="pMessage" class="errMessage"></span></td><br>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=name>Name</label></td>
	<td><input type="text" name=name id=name><br>
	<span id="nMessage" class="errMessage"></span></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=lev>Level</label></td>
	<td><select name=lev id=lev>
		<option value="a">관리자</option>
		<option value="b">나무</option>
		<option value="c">잎새</option>
		<option value="d">새싹</option>
	</select></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=birthd>Birthday</label></td>
	<td><input type="date" name=birthd id=birthd><br>
	<span id="bMessage" class="errMessage"></span></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=point>Point</label></td>
	<td><input type="text" name=point id=point><br>
	<span id="poMessage" class="errMessage"></span></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=weight>Weight</label></td>
	<td><input type="text" name=weight id=weight><br>
	<span id="wMessage" class="errMessage"></span></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=rid>추천인 ID</label></td>
	<td><input type="text" name=rid id=rid><br></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=uploadfilef>사진 업로드</label></td>
	<td><img src="" class="select_img">
		<input type="file" name=uploadfilef id=uploadfilef>
		<script>
		// 해당 파일의 서버상의 경로를 src로 지정하는것으로는 클라이언트 영역에서 이미지는 표시될수 없기 때문에
        // 이를 해결하기 위해 FileReader이라는 Web API를 사용
        // => 이 를 통해 url data를 얻을 수 있음.
        //    ( https://developer.mozilla.org/ko/docs/Web/API/FileReader)
        // ** FileReader
        // => 웹 애플리케이션이 비동기적으로 데이터를 읽기 위하여 읽을 파일을 가리키는File
        //    혹은 Blob 객체를 이용해 파일의 내용을(혹은 raw data버퍼로) 읽고 
        //    사용자의 컴퓨터에 저장하는 것을 가능하게 해줌.   
        // => FileReader.onload 이벤트의 핸들러.
        //    읽기 동작이 성공적으로 완료 되었을 때마다 발생.
        // => e.target : 이벤트를 유발시킨 DOM 객체
          
           $('#uploadfilef').change(function(){
              if(this.files && this.files[0]) {
                 var reader = new FileReader;
                     reader.onload = function(e) {
                     $(".select_img").attr("src", e.target.result)
                        .width(100).height(100); 
                     } // onload_function
                     reader.readAsDataURL(this.files[0]);
               } // if
           }); // change			
		</script>
	</td>
</tr>

	<td><br>
	<input type="submit" value=회원가입 id="submit" disabled onclick="return inCheck()">&nbsp;&nbsp;
	<input type="reset" value="취소">
	<span id="axjoin" class="text_link">axJoin</span>
	</td>
</tr>	
</table>
</form>
<hr>
<a href="home">HOME</a>
<c:if test="${not empty message}">
	<h3>${message}</h3>
</c:if>
<c:if test="${empty message }">
	<h3>${message }</h3>
</c:if>
<script src="resources/myLib/inCheck.js"></script>
<script>
//1) 전역변수 선언
//=> 개별적 오류 확인을 위한 switch 변수
	var iCheck=false;
	var pCheck=false;
	var nCheck=false;
	var bCheck=false;
	var poCheck=false;
	var wCheck=false;
	
// 2) 개별적 focusout 이벤트 핸들러 작성 : jQuery
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
			$('#name').focus();
		}
	}).focusout(function() {
		pCheck=pwCheck();
	}); //id
	
	// ** Name
	$('#name').keydown(function(e) {
		if (e.which==13) {
			e.preventDefault();
			$('#lev').focus();
		}
	}).focusout(function() {
		nCheck=nameCheck();
	}); //name
	
	// ** Lev : enterkey -> Next 이동
	$('#lev').keydown(function(e) {
		if(e.which==13) {
			e.preventDefault();
			$('#birthd').focus();
		}
	}); //lev
	
	// ** Birthday
	$('#birthd').keydown(function(e) {
		if (e.which==13) {
			e.preventDefault();
			$('#point').focus();
		}
	}).focusout(function() {
		bCheck=birthdCheck();
	}); //birthd
	
	// ** Point
	$('#point').keydown(function(e) {
		if (e.which==13) {
			e.preventDefault();
			$('#weight').focus();
		}
	}).focusout(function() {
		poCheck=pointCheck();
	}); //point
	
	// ** Weight
	$('#weight').keydown(function(e) {
		if (e.which==13) {
			e.preventDefault();
			$('#submit').focus();
		}
	}).focusout(function() {
		wCheck=weightCheck();
	}); //weight


}); //ready

// ** ID 중복확인
// => id 옆에 button 추가 (button type="button")
// => submit disabled 로 해줘야 함, id 확정 후 enabled
// => id 무결성 확인 후 서버로 확인 요청
// => 결과는 새창으로 처리



function idDupCheck() {
	if (iCheck == false) {
		iCheck = idCheck();
	} else {
		// 서버로 확인 요청
		var url = 'idDupCheck?id='+ $('#id').val(); // idDupCheck?id=newid 전달
		window.open( url , '_blank' , 'toolbar=no, menubar=yes, scrollbars=yes width=400, height=300')
	}
} //idDubCheck

function inCheck() {
	if (iCheck==false) {
		$('#iMessage').html('ID를 확인하세요.');
	}
	if (pCheck==false) {
		$('#pMessage').html('Password를 확인하세요.');
	}
	if (nCheck==false) {
		$('#nMessage').html('Name을 확인하세요.');
	}
	if (bCheck==false) {
		$('#bMessage').html('Birthday를 확인하세요.');
	}
	if (poCheck==false) {
		$('#poMessage').html('Point를 확인하세요.');
	}
	if (wCheck==false) {
		$('#wMessage').html('Weight를 확인하세요.');
	}

	if (iCheck && pCheck && nCheck && bCheck && poCheck && wCheck) {
		// => submit 확인
		if (confirm('회원가입 하시겠습니까?')==false) {
			alert ('회원가입이 취소되었습니다.');
			return false;
		} else return true; // submit 진행 -> 404
	} else return false;
} //inCheck
</script>
</body>
</html>