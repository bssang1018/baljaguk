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
		<div class="row row-cols-1 row-cols-md-4 g-4 mt-4" id="card">
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

$(document).ready(function() { 
    var page = 2; //처음 보여준 페이지 다음부터 시작
    var list = 8; //한 페이지에 보여지는 게시글 수             
    var max = $('#max').val(); // db에서 가져온 데이터 총 개수
    var total_page = Math.ceil(max/list); 
    var page_start = (page-1)* list; // db에서 몇번째 자료부터 보여줄지 정합니다

$(window).scroll(function() {

 if ($('body').height() <= ($(window).height() + $(window).scrollTop())) { //스크롤바가 윈도우창 아래쪽에 닿았을때
  if(page<=total_page){ //페이지가 페이지 총합보다 적으면
     $.ajax({ // ajax 사용
       url: "main", //ajax 데이터 보내서 처리 할 곳
                       data: { // 보낼 데이터
                              'list' : list, 
                              'page_start' : page_start
                       },
       type:"post" //보낼 방식
     }).done(function(data) { //데이터 전송에 성공하면 
       page += 1; //페이지를 1 올립니다.
       page_start = (page-1)* list; //db에서 보여줄 자료 순번을 갱신합니다
       
       $('#card').append(data); //원하는곳에 받은 데이터를 추가합니다
     });
 }
}
});

});
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
</html>