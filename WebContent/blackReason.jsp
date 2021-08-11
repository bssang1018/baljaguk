<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
</head>
<body>
<div class="container px-4 my-4 text-center">
	<table class='table'>
		<tr>
			<th style="text-align: center">관리자 이메일</th>
			<td>${dto.adminEmail}</td>
		</tr>
		<tr>
			<th style="text-align: center">정지된 이메일</th>
			<td>${dto.banedEmail}</td>
		</tr>
		<tr>
			<th style="text-align: center">카테고리 넘버</th>
			<td>${dto.categoryNo}</td>
		</tr>
		<tr>
			<th style="text-align: center">정지사유</th>
			<td>${dto.reason}</td>
		</tr>
		<tr>
			<th style="text-align: center">정지시킨 날짜</th>
			<td>${dto.reg_date}</td>
		</tr>
		<tr>
			<td colspan="2">
				<button onclick="history.back()">뒤로가기</button>
			</td>
		</tr>
	</table>
</div>
</body>
</html>