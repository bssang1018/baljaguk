<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style>
table, tr, th, td {
	border: 1px solid;
	border-collapse: collapse;
	padding: 10px;
	text-align: center;
}
</style>
</head>
<body>

<h3>"${searchlist}"</h3>

	<table>
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>

		<c:if test="${map eq null || map eq ''}">
			<tr>
				<td colspan="5">검색 결과가 없어요ㅠ</td>
			</tr>
		</c:if>

		<c:forEach items="${map.searchlist}" var="notice">
			<tr>
				<td>${notice.idx}</td>
				<td><a href="noticedetail?idx=${notice.idx}">${notice.title}</a></td>
				<td>${notice.email}</td>
				<td>${notice.reg_date}</td>

			</tr>
		</c:forEach>
	</table>

	<br />
			<ul class="pagination">
				<c:if test="${map.startPage ne 1}">
				<li class="page-item"><a class="page-link" href="./noticesearch?page=${map.startPage-1}&searchKey=${searchlist}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>		
				</a></li>
				</c:if>
				<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
				<c:if test="${i ne map.currPage}">
				<li class="page-item"><a class="page-link" href="./noticesearch?page=${i}&searchKey=${searchlist}">${i}</a></li>
				</c:if>
				<c:if test="${i eq map.currPage}">
				<li class="page-item active"><a class="page-link" href="./noticesearch?page=${i}&searchKey=${searchlist}">${i}</a></li>
				</c:if>
				</c:forEach>
				<c:if test="${map.totalPage ne map.endPage}">
				<li class="page-item"><a class="page-link" href="./noticesearch?page=${map.endPage+1}&	=${searchlist}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
				</c:if>
			</ul>
</body>
<script>
</script>
</html>