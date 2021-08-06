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
</style>
</head>
<body>

<h2>공지공지공지</h2>

<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		
		<c:if test="${empty srmap}">
			<tr>
				<td colspan="5"> 검색 결과가 없어요ㅠ </td>
			</tr>
		</c:if>
		
		<c:forEach items="${srmap.searchlist}" var="qnas">
			<tr>
				
					<td>${qnas.qnano}</td>
				<td><a href="qnadetail?qnano=${qnas.qnano}">${qnas.title}</a></td>
				<td>${qnas.email}</td>
				<td>${qnas.reg_date}</td>									
			</tr>
		</c:forEach>
	</table>
	
	<br />
			<ul class="pagination">
				<c:if test="${srmap.startPage ne 1}">
				<li class="page-item"><a class="page-link" href="./qnasearch?page=${srmap.startPage-1}&searchKey=${searchlist}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>		
				</a></li>
				</c:if>
				<c:forEach var="i" begin="${srmap.startPage}" end="${srmap.endPage}">
				<c:if test="${i ne srmap.currPage}">
				<li class="page-item"><a class="page-link" href="./qnasearch?page=${i}&searchKey=${searchlist}">${i}</a></li>
				</c:if>
				<c:if test="${i eq srmap.currPage}">
				<li class="page-item active"><a class="page-link" href="./qnasearch?page=${i}&searchKey=${searchlist}">${i}</a></li>
				</c:if>
				</c:forEach>
				<c:if test="${srmap.totalPage ne srmap.endPage}">
				<li class="page-item"><a class="page-link" href="./qnasearch?page=${srmap.endPage+1}&searchKey=${searchlist}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
				</c:if>
			</ul>

</body>
</html>