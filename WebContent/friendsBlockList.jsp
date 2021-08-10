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
	
<div class="row m-2">
<div class="list-group col-md-2 m-1 text-center">
  <a href="memberInfo" class="list-group-item list-group-item-action list-group-item-light" >개인정보</a>
  <a href="friendsList" class="list-group-item list-group-item-action list-group-item-light">친구목록</a>
  <a href="friendsBlockList" class="list-group-item list-group-item-action list-group-item-light">차단목록</a>
  <a href="fplist" class="list-group-item list-group-item-action list-group-item-light">내가 쓴글</a>
  <a href="cancel.jsp" class="list-group-item list-group-item-action list-group-item-light" >회원탈퇴</a>
</div>

<div class="col-6 center-block" style="margin:100 auto;">
<h3>차단 목록</h3>
<table class="table">
 			<thead class="table-dark" style="text-align: center">
 			<tr>
 				<th style="text-align: center">차단한 이메일</th>
 				<th style="text-align: center">차단 해제</th>
 			</tr>
 			</thead>
 			<c:if test="${empty map.friendsBlockList}">
 				<tr><td colspan="2" style="text-align: center">차단한 친구가 없네요!</td></tr>
 			</c:if>
 			
 			<c:forEach items="${map.friendsBlockList}" var="blockList">
			<tr>
				<td style="text-align: center">${blockList.friends_email}</td>
				<td style="text-align: center"><input type="button" onclick="location.href='./friendsBlockCancle?friends_email=${blockList.friends_email}'" value="해제"/></td>
			</tr>
		</c:forEach>			
</table>

<nav>
			<ul class="pagination justify-content-center" style="margin-left: auto; margin-right: auto;">
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
</div>
</div>
</body>
</html>