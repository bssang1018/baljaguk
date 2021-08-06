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
		text-align: center;
	}
	
	li{
   	   	list-style:none;
   		float: left;
   		margin-left: 10px;
   }
</style>
</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
<table>
 			<tr>
 				<th>차단한 이메일</th>
 				<th>차단 해제</th>
 			</tr>
 			<c:if test="${empty map.friendsBlockList}">
 				<tr><td colspan="2">차단한 친구가 없네요!</td></tr>
 			</c:if>
 			
 			<c:forEach items="${map.friendsBlockList}" var="blockList">
			<tr>
				<td>${blockList.friends_email}</td>
				<td><input type="button" onclick="location.href='./friendsBlockCancle?friends_email=${blockList.friends_email}'" value="해제"/></td>
			</tr>
		</c:forEach>			
</table>

<nav>
			<ul class="pagination">
				<c:if test="${map.startPage ne 1}">
				<li class="page-item"><a class="page-link" href="./friendsBlockList?page=${map.startPage-1}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>		
				</a></li>
				</c:if>
				<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
				<c:if test="${i ne map.currPage}">
				<li class="page-item"><a class="page-link" href="./friendsBlockList?page=${i}">${i}</a></li>
				</c:if>
				<c:if test="${i eq map.currPage}">
				<li class="page-item active"><a class="page-link" href="./friendsBlockList?page=${i}">${i}</a></li>
				</c:if>
				</c:forEach>
				<c:if test="${map.totalPage ne map.endPage}">
				<li class="page-item"><a class="page-link" href="./friendsBlockList?page=${map.endPage+1}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
				</c:if>
			</ul>
</nav>

</body>
</html>