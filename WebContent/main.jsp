<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
body, head {
	top: 0;
	bottom: 0;
	margin: 0;
	padding: 0;
}
#size{
max-width: 100%;
  height: 210px;;
}

 img{
  max-width: 100%;
  height: auto;
}
#frame{
height :400px;
}
#text{
  display: inline-block; width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
</style>
</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
	<div class="container px-4 my-4">
		<div class="row">
			<div class="col-6">
				<h2>지도</h2>
				<hr />
				내용 들어감
			</div>
			<div class="col-6">
				<h2><a href="fplist">플래너시작</a></h2>
				<hr />
				내용 들어감
			</div>
		</div>
		<div class="row row-cols-1 row-cols-md-4 g-4 mt-4">
		 <c:if test="${M eq null || M eq ''}">
     <h1>해당 데이터가 존재하지 않습니다.</h1>
   	 </c:if>	
   	 
   	 <c:forEach items="${M}" var="M" >

			<div class="col text-center" id="frame">
				<div class="card text-center ">
					<p style="display : none;">${M.boardNO}</p>
					<div id="size">
					<img src="/photo/${M.newFileName}" />
					</div>
					<div class="card-body">
						<p class="card-title">작성자 : ${M.email} </p>
						<hr/>
						<p class="card-text" id="text">${M.footprintText }</p>
					</div>
					<div class="card-footer text-center">
						<button class="btn btn-primary" onclick="location.href='fpdetail?footPrintNO=${M.footPrintNO}'">자세히 보기</button>
					</div>
				</div>
			</div>
   </c:forEach>
		</div>
	</div>
<!-- 하단단 메뉴바 -->
<c:import url="./view/bottom.jsp"/>
</body>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
var success = "${success}";
if(success == "true") {
	alert("로그인 성공");
	location.href="main";
}
if(success == "false") {
	alert("이메일 및 비밀번호를 확인해주세요");
	location.href="login.jsp";
}
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</html>