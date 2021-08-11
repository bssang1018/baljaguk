<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>
	<!-- 상단 메뉴바 -->
	
	
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
	<h2 style="text-align: center">공지사항 상세보기</h2>	
<table class="table table-striped" style="width: 600px; margin-left: auto; margin-right:auto; word-break:break-all; ">
		<tr>
			<th style="text-align: center;">글번호</th>
			<td width="400px">${noticefaq.idx}</td>
		</tr>
		<tr>
			<th style="text-align: center">제목</th>
			<td width="400px">${noticefaq.title}</td>
		</tr>
		<tr>
			<th style="text-align: center">작성자</th>
			<td width="400px">${noticefaq.email}</td>
		</tr>
		<tr>
			<th style="text-align: center">작성일</th>
			<td width="400px">${noticefaq.reg_date}</td>
		</tr>
		<tr>
			<th style="text-align: center">내용</th>
			<td width="400px">${noticefaq.content}</td>
		</tr>		
	</table>
			<div class="text-center" >
				<button class="btn btn-primary" onclick="location.href='./noticelist'">리스트</button>
				<c:if test="${loginemail eq noticefaq.email}">
				<button class="btn btn-primary" onclick="location.href='./noticeupdateForm?idx=${noticefaq.idx}'">수정</button>
				<button class="btn btn-primary" onclick="location.href='./noticedel?idx=${noticefaq.idx}'">삭제</button>			
			</c:if>
			</div>
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
</script>
</html>