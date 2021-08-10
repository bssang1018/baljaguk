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
<%-- 	<h3>${loginemail}</h3>
	<h3>${noticefaq.email}</h3> --%>
	
	<h2 style="text-align: center">faq 상세보기</h2>	
	<table class="table table-striped" style="width: 500px; margin-left: auto; margin-right: auto;">
		<tr>
			<th style="text-align: center">글번호</th>
			<td>${noticefaq.idx}</td>
		</tr>
		<tr>
			<th style="text-align: center">제목</th>
			<td>${noticefaq.title}</td>
		</tr>
		<tr>
			<th style="text-align: center">작성자</th>
			<td>${noticefaq.email}</td>
		</tr>
		<tr>
			<th style="text-align: center">작성일</th>
			<td>${noticefaq.reg_date}</td>
		</tr>
		<tr>
			<th style="text-align: center">내용</th>
			<td>${noticefaq.content}</td>
		</tr>			
	</table>
				<div class="text-center" >
				<button class="btn btn-primary" onclick="location.href='./faqlist'">리스트</button>				   
				<c:if test="${loginemail eq noticefaq.email}">
				<button class="btn btn-primary" onclick="location.href='./faqupdateForm?idx=${noticefaq.idx}'">수정</button>
				<button class="btn btn-primary" onclick="location.href='./faqdel?idx=${noticefaq.idx}'">삭제</button>			
			</c:if> 
			</div>
</body>
<script>
	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}
	//console.log(loginemail);
	//console.log("${noticefaq.email}");
</script>
</html>