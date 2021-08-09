<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<form action="msgReport" method="post">
<table class="table" style="width: 500px; margin-left: auto; margin-right: auto;">				
				<tr>
					<th style="text-align: center">신고할 메세지 번호</th>
					<td>
					${msgDetail.msgNo}
					<input type="hidden" name="msgNo" value="${msgDetail.msgNo}"/>
					</td>
				</tr>
				<tr>
					<th style="text-align: center">신고할 이메일</th>
					<td>
					${msgDetail.sender_email}
					<input type="hidden" name="sender_email" value="${msgDetail.sender_email}"/>
					</td>
				</tr>
				<tr>
					<th style="text-align: center">신고 사유</th>
					<td><textarea name="reportContent" style="height: 300px; width: 300px;"></textarea></td>
				</tr>	
		</table>
		
		<div class="text-center" >
			<button class="btn btn-primary">메세지 신고</button>
			<input class="btn btn-primary" type="button" onclick="location.href='./msgMain'" value="이전으로" />
		</div>
	
	</form>
</body>
<script>
	var msgMsg = "${msgMsg}";
	if(msgMsg != ""){
		alert(msgMsg);
	}
</script>
</html>