<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	table,tr,th,td{
		border: 1px solid;
		border-collapse: collapse;
		padding : 10px;
	}
</style>
</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>

	<!-- 내용시작 -->
	<form action="fdReport" method="post">

<table class="table" style="width: 500px; margin-left: auto; margin-right: auto;">				
				<tr>
					<th style="text-align: center">신고할 피드 번호</th>
					<td>
					${fpdetail.footPrintNO}
					<input type="hidden" name="contentNO" value="${fpdetail.footPrintNO}"/>
					</td>
				</tr>
				<tr>
					<th style="text-align: center">이메일</th>
					<td>
					${fpdetail.email}
					<input type="hidden" name="email" value="${fpdetail.email}"/>
					</td>
				</tr>
				<tr>
					<th style="text-align: center">신고 사유</th>
					<td><textarea name="reportContent" style="height: 300px; width: 300px;"required></textarea></td>
				</tr>	
		</table>
		
		<div class="text-center" >
			<button class="btn btn-primary">피드 신고</button>
			<input class="btn btn-primary" type="button" onclick="location.href='./feedlist'" value="이전으로" />
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