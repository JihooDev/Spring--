<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>** Spring Member Detail **</title>
</head>
<body>
<h2>** Spring Member Detail **</h2>
<table>
	<tr height="40"><td bgcolor="yellow">I  D</td><td>${apple.id}</td></tr>
	<tr height="40"><td bgcolor="yellow">Password</td><td>${apple.password}</td></tr>
	<tr height="40"><td bgcolor="yellow">Name</td><td>${apple.name}</td></tr>
	<tr height="40"><td bgcolor="yellow">Level</td><td>${apple.lev}</td></tr>
	<tr height="40"><td bgcolor="yellow">Birthday</td><td>${apple.birthd}</td></tr>
	<tr height="40"><td bgcolor="yellow">Point</td><td>${apple.point}</td></tr>
	<tr height="40"><td bgcolor="yellow">Weight</td><td>${apple.weight}</td></tr>
	<tr height="40"><td bgcolor="yellow">RID</td><td>${apple.rid}</td></tr>
	<tr height="40"><td bgcolor="yellow">Image</td><td><img src="${apple.uploadfile}" width="100" height="120"></td></tr>
</table>
<hr>
<a href="home">HOME</a>
</body>
</html>