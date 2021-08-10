<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">

</head>
<body>
<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
<h2 style="text-align: center">Q&A검색 결과</h2>
<h3 style="text-align: center">검색명 :${searchlist}</h3>
 <table class="table" style="width: 800px; margin-left: auto; margin-right: auto;">
		<tr>
			<th class="col-1" style="text-align: center">번호</th>
			<th class="col-1" style="text-align: center">제목</th>
			<th class="col-1" style="text-align: center">작성자</th>
			<th class="col-1" style="text-align: center">작성일</th>
		</tr>
		
		<c:if test="${empty srmap.searchlist}">
			<tr>
				<td colspan="5" style="text-align: center"> 검색 결과가 없어요</td>
			</tr>
		</c:if>
		
		<c:forEach items="${srmap.searchlist}" var="qnas">
			<tr>				
				<td style="text-align: center">${qnas.qnano}</td>
				<td style="text-align: center"><a href="qnadetail?qnano=${qnas.qnano}">${qnas.title}</a></td>
				<td style="text-align: center">${qnas.email}</td>
				<td style="text-align: center">${qnas.reg_date}</td>									
			</tr>
		</c:forEach>
	</table>
	
	<br />
		<ul class="pagination justify-content-center">
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
	<div class="text-center" >
				<input class="btn btn-primary" type="button" onclick="location.href='./qnalist'" value="리스트 돌아가기"/>
				
			</div>
</body>
</html>