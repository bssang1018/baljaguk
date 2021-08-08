<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
<style>
</style>
</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>

<h3> 메세지 보내기 </h3>
	
	<form action="msgWrite" method="post">
		<table class="table table-striped">
				<tr>
					<th class="col-2">보내는 사람</th>
					<td>
					${loginemail}
					<input type="hidden" name="sender" value="${loginemail}"/>
					</td>			
				</tr>
				<tr>
					<th>받는 사람</th>
					<td><input type="text" name="reciever"/></td>
				</tr>
				<tr>
					<th>메세지 내용</th>
					<td><textarea name="content"></textarea></td>
				</tr>
		</table>
		<button class="btn btn-primary">메세지 전송</button>
	</form>
</body>
<script>
	var msgMsg = "${msgMsg}";
	if(msgMsg != ""){
		alert(msgMsg);
	}
</script>
</html>