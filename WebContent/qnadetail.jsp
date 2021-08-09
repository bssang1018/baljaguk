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

	<!-- 내용시작 -->

	<h2>Q&A 상세보기</h2>	
	<table>
		<tr>
			<th>글번호</th>
			<td>${qna.qnano}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${qna.title}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${qna.email}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${qna.reg_date}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${qna.content}</td>
		</tr>
		<tr>
			<td colspan="2">
				<button onclick="location.href='./qnalist'">리스트</button>
				<button onclick="location.href='./qnaupdateForm?qnano=${qna.qnano}'">수정</button>
				<button onclick="location.href='./qnadel?qnano=${qna.qnano}'">삭제</button>			
			</td>
		</tr>
	</table>
	
   <h3>댓글 창</h3>
   
   <table>
   	<tr>
   		<th>이메일</th>
   		<th>댓글내용</th>
   		<th>등록일</th>
   		<th>삭제</th>
   	</tr>
   	<c:if test="${empty map.commentList}">
			<tr>
				<td colspan="4"> 등록된 댓글이 없네요! 첫 댓글을 달아보세요! </td>
			</tr>
		</c:if>
	<c:forEach items="${map.commentList}" var="comment">
			<tr>
				<td>${comment.email}</td>
				<td>${comment.commentText}</td>
				<td>${comment.regDate}</td>
				<c:if test="${comment.email eq loginemail}">
					<td><input type="button" onclick="location.href='./commentDel?qnano=${comment.qnano}&commentNO=${comment.commentNo}'" value="삭제"/></td>
				</c:if>
				<c:if test="${comment.email ne loginemail}">
					<td></td>
				</c:if>			
			</tr>
		</c:forEach>

   </table>
   <form action="qnacommentWriteForm" method="post">
   		<table>
   			<tr>
   				<td>댓글입력</td>
   				<td>
   					<input type="text" name="commentText"/><button>등록</button>
					<input type="hidden" name="qnano" value="${qnano}"/>   				
   				</td>
   			</tr>
   		</table>
   </form>
   
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