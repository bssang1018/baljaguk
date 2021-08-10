<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
 	String email = request.getParameter("email");
 	System.out.println(email);
 	String reportno = request.getParameter("reportno");
 	System.out.println(reportno);
%>
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

<h3> 신고 답변 </h3>
	
<form action="repWrite" method="post">
<table class="table" style="width: 500px; margin-left: auto; margin-right: auto;">	
				<tr>
					<th style="text-align: center">신고번호</th>
					<td><%=reportno %><input type="hidden" name="reportno" value="<%=reportno %>"/></td>
				</tr>			
				<tr>
					<th style="text-align: center">보내는 사람</th>
					<td>
					${loginemail}
					<input type="hidden" name="sender" value="${loginemail}"/>
					</td>			
				</tr>
				<tr>
					<th style="text-align: center">받는 사람</th>
					<td><%=email %><input type="hidden" name="reciever" value="<%=email %>"/></td>
				</tr>
				<tr>
					<th style="text-align: center">메세지 내용</th>
					<td><textarea name="content" style="height: 300px; width: 300px;"></textarea></td>
				</tr>
		</table>
		<div class="text-center" >
		<button class="btn btn-primary">메세지 전송</button>
		<input class="btn btn-primary" type="button" onclick="location.href='reportlist.jsp'" value="이전으로" />
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