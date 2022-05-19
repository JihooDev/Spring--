<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Web MVC2 UpdateForm **</title>
<style type="text/css">
	table {
		width: 100%;
		height: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
	}
</style>
<script src="resources/myLib/jquery-3.2.1.min.js"></script>
<script src="resources/myLib/axTest01.js"></script>
</head>
<body>
<h2>** Web MVC2 JoinForm **</h2>

<form action="mupdate" method="post" enctype="multipart/form-data">
<table bgcolor="#ff9ff3">
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=id>I D</label></td>
 	<td><input type="text" name=id id=id value="${apple.id}" readonly></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=password>Password</label></td>
	<td><input type="password" name=password id=password value="${apple.password }"></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=name>Name</label></td>
	<td><input type="text" name=name id=name value="${apple.name}"></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=lev>Level</label></td>
	<%-- ${apple.lev} 에 따라서 해당되는 option 을 selected 
        DAO 의 sql 구문에서 CONCAT~등을 적용했기때문에 lev 의 값은 'A 관리자' 
        -> 그러므로 이것에 대한 처리가 필요 -> EL 의 function 적용 
    --%>
	<td><select name=lev id=lev>
		<c:choose>
			<c:when test="${fn:substring(apple.lev,0,1) == 'a'}">
				<option value="a" selected="selected">관리자</option>
				<option value="b">나무</option>
				<option value="c">잎새</option>
				<option value="d">새싹</option>
			</c:when>
			<c:when test="${fn:substring(apple.lev,0,1) == 'b'}">
				<option value="a">관리자</option>
				<option value="b" selected="selected">나무</option>
				<option value="c">잎새</option>
				<option value="d">새싹</option>
			</c:when>
			<c:when test="${fn:substring(apple.lev,0,1) == 'c'}">
				<option value="a">관리자</option>
				<option value="b">나무</option>
				<option value="c" selected="selected">잎새</option>
				<option value="d">새싹</option>
			</c:when>
			<c:when test="${fn:substring(apple.lev,0,1) == 'd'}">
				<option value="a">관리자</option>
				<option value="b">나무</option>
				<option value="c">잎새</option>
				<option value="d" selected>새싹</option>
			</c:when>
		</c:choose>
	</select></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=birthd>Birthday</label></td>
	<td><input type="date" name=birthd id=birthd value="${apple.birthd }"></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=point>Point</label></td>
	<td><input type="text" name=point id=point value="${apple.point }"></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=weight>Weight</label></td>
	<td><input type="text" name=weight id=weight value="${apple.weight }"></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=rid>추천인 ID</label></td>
	<td><input type="text" name=rid id=rid value="${apple.rid }"><br></td>
</tr>
<tr height=40>
	<td bgcolor="#ff6b6b"><label for=uploadfilef>사진 업로드</label></td>
	<td><img src="${apple.uploadfile}" class="select_img">
		<input type="hidden" name="uploadfile" value="${apple.uploadfile}">
		<input type="file" name=uploadfilef id=uploadfilef>
		<script>
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
	<input type="submit" value=수정하기>&nbsp;&nbsp;
	<input type="reset" value="취소">
	</td>
</table>
</form>
<hr>
<a href="home">HOME</a>
<c:if test="${not empty message1}">
	<h3>${message1}</h3>
</c:if>
<c:if test="${empty message1 }">
	<h3>${message1}</h3>
</c:if>
</body>
</html>