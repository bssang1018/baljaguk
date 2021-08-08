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
		
	<form action="commentWrite" method="post">
		<table>
				<tr>
					<th>댓글 작성</th>
					<td><textarea name="commentText"></textarea></td>
					<td><input type="hidden" name="footPrintNO" value="${footPrintNO}"/></td>
				</tr>
				<tr>
					<td colspan="3">
					<button>등록</button>
				<tr>	
		</table>				
	</form>	
</body>
<script>
	var msgMsg = "${msgMsg}";
	if(msgMsg != ""){
		alert(msgMsg);
	}
	
</script>
</html>