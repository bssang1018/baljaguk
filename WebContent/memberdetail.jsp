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
	<h2>상세보기</h2>
	<table class='table'>
		<tr>
			<th>이메일</th>
			<td>${member.email}</td>
		</tr>
		<tr>
			<th>닉네임</th>
			<td>${member.nickname}</td>
		</tr>
		<tr>
			<th>이름</th>
			<td>${member.name}</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>${member.gender}</td>
		</tr>
		<tr>
			<th>생년월일</th>
			<td>${member.birth}</td>
		</tr>
		<tr>
			<th>연락처</th>
			<td>${member.phone}</td>
		</tr>
		<tr>
			<th>블랙리스트</th>
			<td>${member.blackList}</td>
		</tr>
		<tr>
			<th>회원정지여부</th>
			<td>${member.accountBan}<input type="button" onclick="location.href='./stopReason?email=${member.email}'" value="정지사유보기"/></td>
		</tr>
		<tr>
			<th>회원탈퇴여부</th>
			<td>${member.cancelMember}</td>
		</tr>
		<tr>
			<td colspan="2">
			<button onclick="location.href='../'">뒤로가기</button>
			</td>
		</tr>
	</table>
	</div>
</body>
<script>
</script>
</html>