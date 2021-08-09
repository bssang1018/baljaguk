<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<h2>상세보기</h2>
	<table>
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
			<button onclick="location.href='memberlist.jsp'">뒤로가기</button>
			</td>
		</tr>
	</table>
</body>
<script>
</script>
</html>