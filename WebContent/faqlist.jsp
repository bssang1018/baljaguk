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
</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
		<div class="row m-2">
	<div class="list-group col-md-2 m-1 text-center" id="noticecenter">
  <a href="./qnalist" class="list-group-item list-group-item-action list-group-item-light" >문의사항</a>
  <a href="./noticelist" class="list-group-item list-group-item-action list-group-item-light">공지사항</a>
  <a href="./faqlist"  class="list-group-item list-group-item-action list-group-item-light">FAQ</a>
      <c:if test="${sessionScope.admin eq '1'.charAt(0)}">
  <a href="./faqwriteForm.jsp" class="list-group-item list-group-item-action list-group-item-light" >글쓰기</a>
      </c:if>
</div>
      
<div class="col-6 center-block" style="margin:100 auto;">
	<h2>faq 목록</h2>

	<table class="table">
		<tr>
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일</th>
		</tr>
		<c:if test="${map eq null || map eq ''}">
			<tr>
				<td colspan="5">해당 데이터가 존재하지 않습니다.</td>
			</tr>
		</c:if>
		<c:forEach items="${map.list}" var="noticefaq">
			<tr>
				<td>${noticefaq.idx}</td>
				<td><a href="faqdetail?idx=${noticefaq.idx}">${noticefaq.title}</a></td>
				<td>${noticefaq.email}</td>
				<td>${noticefaq.reg_date}</td>
			</tr>
		</c:forEach>
	</table>
	<div class="col-md-6 mb-2" style="float: none; margin:0 auto;">
		<form class="d-inline-flex justify-content-end" style="height: 25px;" action="faqsearch" method="post">
	<input class="form-control me-1" type="search" placeholder="검색어 입력" aria-label="Search" name="searchKey" required/>
			<button class="btn btn-outline-secondary" type="submit">Serch</button>
</form>
</div>

<nav aria-label="Page navigation example text-center">
		<ul class="pagination div col-md-3" style="float: none; margin:0 auto;">
	
		<c:if test="${map.startPage ne 1}">
			<li class="page-item"><a class="page-link"
				href="./faqlist?page=${map.startPage-1}" aria-label="Previous">
					<span aria-hidden="true">&laquo;</span>
			</a></li>
		</c:if>
		<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
			<c:if test="${i ne map.currPage}">
				<li class="page-item"><a class="page-link"
					href="./faqlist?page=${i}">${i}</a></li>
			</c:if>
			<c:if test="${i eq map.currPage}">
				<li class="page-item active"><a class="page-link"
					href="./faqlist?page=${i}">${i}</a></li>
			</c:if>
		</c:forEach>
		<c:if test="${map.totalPage ne map.endPage}">
			<li class="page-item"><a class="page-link"
				href="./faqlist?page=${map.endPage+1}" aria-label="Next"> <span
					aria-hidden="true">&raquo;</span>
			</a></li>
		</c:if>
		</div>
	</ul>
	<br/>
	
	<!-- <form class="d-inline-flex justify-content-end" style="height: 21px;"
		action="faqsearch" method="post">
	 <input class="form-control me-1" type="search"
			placeholder="검색어를 입력해주세요" aria-label="Search" name="searchKey" />
		<button class="btn btn-outline-secondary" type="submit">search</button>
	</form> -->
</body>
<script>
	var msg = "${msg}";
	if (msg != "") {
		alert(msg);
		window.location.href = "./faqlist";
	}
</script>
</html>