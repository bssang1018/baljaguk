<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table,tr,th,td{
		border: 1px solid;
		border-collapse: collapse;
		padding : 10px;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
   <h2 style="text-align: center">상세보기</h2>

   <table style="width: 800px; margin-left: auto; margin-right: auto;">
   <tr>
      <th>발자국 번호</th>
      <td>${footprint.footPrintNO}</td>
   </tr>
   <tr>
      <th>마커 번호</th>
      <td>${footprint.markerNO}</td>
   </tr>
   <tr>
      <th>작성자</th>
      <td>${footprint.email}</td>
   </tr>
   <tr>
      <th>작성일</th>
      <td>${footprint.reg_date}</td>
   </tr>
   <tr>
      <th>발자국 내용</th>
      <td>${footprint.footprintText}</td>
   </tr>
  
   <tr>
      <th>사진</th>
      <td><img src="/photo/${footprint.newFileName}" width="300px" height="auto"></td>
   </tr>
   
   <tr>
		<td colspan="2">
      <c:if test='${sessionScope.loginemail eq footprint.email}'>
      <button onclick="location.href='./fplist'">발자국</button>
      <button onclick="location.href='./fpupdateForm?footPrintNO=${footprint.footPrintNO}'" >발자국 수정</button>
      <button onclick="location.href='./fpdel?footPrintNO=${footprint.footPrintNO}'">발자국 삭제</button>
     

		</c:if>
  		</td>
   	</tr>
</table>
   
   <!-- <h3 style="text-align: center">댓글</h3>  -->
   <table class="table table-striped" style="width: 800px; margin-left: auto; margin-right: auto;">
   	<tr>
   		<th class="col-2" style="text-align: center">이메일</th>
   		<th class="col-6" style="text-align: center">댓글내용</th>
   		<th class="col-3" style="text-align: center">등록일</th>
   		<th class="col-1" style="text-align: center">삭제</th>
   	</tr>
   	<c:if test="${empty map.commentList}">
			<tr>
				<td style="text-align: center" colspan="4"> 등록된 댓글이 없네요! 첫 댓글을 달아보세요! </td>
			</tr>
		</c:if>
	<c:forEach items="${map.commentList}" var="comment">
			<tr>
				<td style="text-align: center">${comment.email}</td>
				<td>${comment.commentText}</td>
				<td style="text-align: center">${comment.regDate}</td>
				<c:if test="${comment.email eq loginemail}">
					<td style="text-align: center"><input type="button" onclick="location.href='./commentDel?footPrintNO=${comment.footPrintNO}&commentNO=${comment.commentNo}'" value="삭제"/></td>
				</c:if>
				<c:if test="${comment.email ne loginemail}">
					<td></td>
				</c:if>			
			</tr>
		</c:forEach>
   </table>
   
   
   
   <nav>
			<ul class="pagination justify-content-center">
				<c:if test="${map.startPage ne 1}">
				<li class="page-item">
				<a class="page-link" href="./commentList?page=${map.startPage-1}&footPrintNO=${footPrintNO}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
				</li>
				</c:if>
				<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
				<c:if test="${i ne map.currPage}">
				<li class="page-item"><a class="page-link" href="./commentList?page=${i}&footPrintNO=${footPrintNO}">${i}</a></li>
				</c:if>
				<c:if test="${i eq map.currPage}">
				<li class="page-item active"><a class="page-link" href="./commentList?page=${i}&footPrintNO=${footPrintNO}">${i}</a></li>
				</c:if>
				</c:forEach>
				<c:if test="${map.totalPage ne map.endPage}">
				<li class="page-item"><a class="page-link" href="./commentList?page=${map.endPage+1}&footPrintNO=${footPrintNO}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
				</c:if>
			</ul>
			</nav>
   
   <form action="commentWriteForm" method="post">
   <div class="text-center">
   			<span>  댓글입력  </span><input type="text" name="commentText"/><button>등록</button>
			<input type="hidden" name="footPrintNO" value="${footPrintNO}"/>   				
   </div>
   </form>
 
</body>
<script>
	var footPrintNO = "${comment.footPrintNO}";
	var loginemail = "${session.getAttribute('loginemail')}"

	
</script>
</html>