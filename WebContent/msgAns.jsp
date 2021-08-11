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


	<form action="msgAnsWrite" method="post">
	
<div class="row m-2">

<div class="list-group col-md-2 m-1 text-center">
	<button class="list-group-item list-group-item-action list-group-item-light">답장 전송</button>
	<input class="list-group-item list-group-item-action list-group-item-light" type="button" onclick="location.href='./msgMain'" value="이전으로" />
</div>
	
<div class="col-6 center-block" style="margin:100 auto;">

	<h3> 답장 보내기 </h3>
<table class="table">				
				<tr>
					<th style="text-align: center">보내는 사람</th>
					<td>
					${loginemail}
					<input type="hidden" name="sender" value='${loginemail}'/>
					</td>
				</tr>
				<tr>
					<th style="text-align: center">받는 사람</th>
					<td>
					${sender_email}
					<input type="hidden" name="reciever" value='${sender_email}'/>
					</td>
				</tr>
				<tr>
					<th style="text-align: center">메세지 내용</th>
					<td><textarea name="content" style="height: 300px; width: 500px;"></textarea></td>
				</tr>
		</table>
	</form>
</div>

</div>

</body>
<script>
	$('#reciever').val('${sender_email}');

	var msgMsg = "${msgMsg}";
	if(msgMsg != ""){
		alert(msgMsg);
	}
</script>
</html>