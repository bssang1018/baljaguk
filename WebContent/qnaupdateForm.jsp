<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
<form action="qnaupdate" method="POST">
	<table class="table" style="width: 500px; margin-left: auto; margin-right: auto;">
		<tr>
			<th style="text-align: center">글번호</th>
			<td>
				${qna.qnano}
				<input type="hidden" name="qnano" value="${qna.qnano}"/>
			</td>
		</tr>
		<tr>
			<th style="text-align: center">제목</th>
			<td><input type="text" name="title" size=40 maxlength=15 value="${qna.title}"/></td>
		</tr>
		<tr>
			<th style="text-align: center">작성자</th>
			<td><input type="hidden" name="email" value="${qna.email}"/>${qna.email}</td>
		</tr>
		<tr>
			<th style="text-align: center">내용</th>
			<td><textarea name="content" style="width:300px; height:450px; resize: none;">${qna.content}</textarea></td>
		</tr>		
	</table>
			<div class="text-center" >
				<input class="btn btn-primary" type="button" onclick="location.href='./qnalist'" value="리스트"/>
				<button class="btn btn-primary">저장</button>
			</div>
</form>
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>