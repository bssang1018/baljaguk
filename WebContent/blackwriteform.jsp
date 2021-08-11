<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous">
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
	<div class="container px-4 my-4 text-center">
	<h2>블랙리스트FORM</h2>
	<form method="POST" action="blackregister">
	<table class='table'>
		<tr>
			<th>이메일</th>
			<td><input type='hidden' name="email" value='${member.email}' />${member.email}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${member.name}</td>
		</tr>
		<tr>
			<th>사유</th>
			<td><textarea name="reason" style="width:300px; height:300px; resize: none;" required></textarea></td>
		</tr>
		<tr>
			<td colspan="2">
			<button class="btn btn-outline-danger btn-sm">등록</button>
			<a href='/tree/memberlist.jsp' class="btn btn-outline-primary btn-sm">뒤로가기</a>
			</td>
		</tr>
	</table>
	</form>
</body>
<script>

</script>
</html>