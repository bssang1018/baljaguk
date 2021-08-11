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
<%-- <h3>${loginemail}</h3>
	<h3>${qna.email}</h3> --%>
	<h2  style="text-align: center">Q&A 상세보기</h2>	
	<table class="table table-striped" style="width: 600px; margin-left: auto; margin-right: auto; word-break:break-all;">
		<tr>
			<th style="text-align: center">글번호</th>
			<td width="400px">${qna.qnano}</td>
		</tr>
		<tr>
			<th style="text-align: center">제목</th>
			<td width="400px">${qna.title}</td>
		</tr>
		<tr>
			<th style="text-align: center">작성자</th>
			<td width="400px">${qna.email}</td>
		</tr>
		<tr>
			<th style="text-align: center">작성일</th>
			<td width="400px">${qna.reg_date}</td>
		</tr>
		<tr>
			<th style="text-align: center">내용</th>
			<td width="400px">${qna.content}</td>
		</tr>	
	</table>
	
				<div class="text-center" >
				<button class="btn btn-primary" class="btn btn-primary"onclick="location.href='./qnalist'">리스트</button>
				<c:if test="${loginemail eq qna.email}">
				<button class="btn btn-primary" onclick="location.href='./qnaupdateForm?qnano=${qna.qnano}'">수정</button>
				<button class="btn btn-primary" onclick="location.href='./qnadel?qnano=${qna.qnano}'">삭제</button>			
				</c:if>
				</div>
	<br/>
	<br/>
	
   <h3 style="text-align: center">답변</h3>
   
   <table class="table table-striped" style="width: 500px; margin-left: auto; margin-right: auto;">
   	<tr>
   		<th>QNA번호</th>
   		<th>관리자</th>
   		<th>내용</th>
   		<th>삭제</th>
   	</tr>
   	<c:if test="${empty map.qnacommentList}">
			<tr>
				<td colspan="4"> 등록된 답변이 없네요!</td>
			</tr>
		</c:if>
	<c:forEach items="${map.qnacommentList}" var="comment">
			<tr>
				<td>${comment.qnano}</td>
				<td>${comment.admin_email}</td>
				<td>${comment.answer}</td>
				<c:if test="${comment.admin_email eq loginemail}">
					<td><input class="btn btn-primary" type="button" onclick="location.href='./qnacommentDel?qnano=${comment.qnano}&answerno=${comment.answerno}'" value="삭제"  /></td>
				</c:if>
				<c:if test="${comment.admin_email ne loginemail}">
					<td></td>
				</c:if>			
			</tr>
		</c:forEach>

   </table>
   <c:if test="${sessionScope.admin eq '1'.charAt(0)}">
     <form action="qnacommentWriteForm" method="post">
   	<table class="table table-striped" style="width: 500px; margin-left: auto; margin-right: auto;">
   			<tr>
   				<td>답변입력</td>
   				<td>
   					<input type="text" name="commentText1" required/><button>등록</button>
					<input type="hidden" name="qnano" value="${qnano}"/>   				
   				</td>
   			</tr>
   		</table>
   </form>
   </c:if>
</body>
<script>
	var msg = "${msg}";
	var qnano = "${comment.qnano}";
	var loginemail = "${session.getAttribute('loginemail')}"
	
	if(msg != ""){
		alert(msg);
	}
	
	var commentMsg = "${commentMsg}";
	if(commentMsg != ""){
		alert(commentMsg);
	}
</script>
</html>