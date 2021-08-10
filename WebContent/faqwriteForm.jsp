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
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
	<form action="faqwrite" method="POST">
		<table class="table" style="width: 500px; margin-left: auto; margin-right: auto;">
			<tr>
				<th style="text-align: center">문의 항목</th>
				<td>
					<input type="radio" name="categoryNo" value="90">공지 게시판
					&nbsp;&nbsp;
					<input type="radio" name="categoryNo" value="89">FAQ 게시판
				</td>
			</tr>
			<tr>
				<th style="text-align: center">제목</th>
				<td><input type="text" name="title" size=40 maxlength=15/></td>
			</tr>
			<tr>
			<th style="text-align: center">작성자</th>
					<td>
					${loginemail}
					<input type="hidden" name="email" value="${loginemail}"/>
					</td>
			</tr>
			<tr>
				<th style="text-align: center">내용</th>
				<td><textarea name="content" style="width:300px; height:450px; resize: none;"></textarea></td>
			</tr>		
		</table>
		<div class="text-center" >
				<input class="btn btn-primary" type="button" onclick="location.href='./faqlist'" value="리스트" />
				<button class="btn btn-primary">글작성 완료</button>
		</div>
	</form>
</body>
<script>
	var msg = "${msg}";
	if (msg != "") {
		alert(msg);
	}
</script>
</html>