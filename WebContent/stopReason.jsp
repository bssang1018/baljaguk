<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>

<table class="table table-striped" style="width: 500px; margin-left: auto; margin-right: auto;">
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
</table>

</body>
</html>