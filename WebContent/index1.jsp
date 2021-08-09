<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
<h2>회원보기</h2>
<div class="btn-group " role="group">
	<input class='btn1' type="button" value="전체회원보기"/>
	<input class='btn2' type="button" value="신고글보기"/>
	<input class='btn3' type="button" value="정지회원보기"/>
	<input class='btn4' type="button" value="블랙리스트회원보기"/>
	<input class='btn5' type="button" value="탈퇴회원보기"/>
	</div>
</body>
<script>
$(".btn1").click(function(){
	 $.ajax({
			type:'POST',
			url:'memberlist',
			data: {},
			dataType: 'JSON',
			success:function(data){
				console.log(data);
				location.href='memberlist.jsp';
			}
			
	 });
});
$(".btn2").click(function(){
	 $.ajax({
			type:'POST',
			url:'rcontload',
			data: {},
			dataType: 'JSON',
			success:function(data){
				console.log(data);
				location.href='reportlist.jsp';
			}
			
	 });
});
$(".btn3").click(function(){
	 $.ajax({
			type:'POST',
			url:'stoplist',
			data: {},
			dataType: 'JSON',
			success:function(data){
				console.log(data);
				location.href='stoplist.jsp';
			}
			
	 });
});
$(".btn4").click(function(){
	 $.ajax({
			type:'POST',
			url:'blacklist',
			data: {},
			dataType: 'JSON',
			success:function(data){
				console.log(data);
				location.href='blacklist.jsp';
			}
			
	 });
});
$(".btn5").click(function(){
	 $.ajax({
			type:'POST',
			url:'withdrawlist',
			data: {},
			dataType: 'JSON',
			success:function(data){
				console.log(data);
				location.href='withdrawlist.jsp';
			}
			
	 });
});
</script>
</html>