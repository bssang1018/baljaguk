<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<style type="text/css">
body, head {
	top: 0;
	bottom: 0;
	margin: 0;
	padding: 0;
}
#size{
max-width: 100%;
  height: 210px;
}

 img{
  max-width: 100%;
  object-fit : cover;
}
#text{
  display: inline-block; width: 200px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
</style>
</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
<form class="d-inline-flex justify-content-end"  action="fpsearch" method="post">

	<!-- 내용시작 -->
<div class="row row-cols-1 row-cols-md-4 g-4 mt-4" id="card">
	
		 <c:if test="${feedlist eq null || feedlist eq ''}">
     <h1>해당 데이터가 존재하지 않습니다.</h1>
   	 </c:if>	
   	 
   	 <c:forEach items="${feedlist}" var="footprint" >
			<div class="gogo col text-center" id="frame" style="opacity:0;">
					<p style="display : none;">${footprint.footPrintNO}</p>
					<div id="size">
					<img src="/photo/${footprint.newFileName}" />
					</div>
					<div class="card-body">
						<p class="card-title">작성자 : ${footprint.email} </p>
						<hr/>
						<a href="fpdetail?footPrintNO=${footprint.footPrintNO}">${footprint.footprintText}</a>
					</div>
				<div class="card-footer text-center">
			<div class="btn-group">
  <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
    더보기
  </button>
  <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
    <li><a class="dropdown-item" href="#">피드 신고</a></li>
    <li><a class="dropdown-item" href="#">피드 삭제</a></li>
  </ul>
</div>
			</div>
			</div>
   </c:forEach>
</div>
	
   </form>
   
 <div class="form-group">
   <input type="button" onclick="location.href='fpwrite.jsp'" value="발자국 남기기"/>
   <input class="form-control me-1" type="search" placeholder="검색어를 입력해주세요" aria-label="Search" name="hashtag"/>
			<button class="btn btn-outline-secondary" type="submit">search</button>
   </div>
   <div class="text-center">
   <button id="plusBtn" class="btn btn-primary" style="margin-bottom:100px">더보기</button>
   </div>
</body>
<script>

$('.gogo').animate({
	opacity :1
})

var page = 1;
$(document).on('click','#plusBtn',function(){
	page++;
	$.ajax({
		 type : 'GET',
		    url : 'plusMain',
		    data : { 'page' : page },
		    dataType : 'JSON',
		    success : function(data) {
		       console.log(data);		
		        content='';
		        $.each(data.list,function(i,item){
		       content += 	'<div class="col text-center " id="frame" >'
		       content += 	'<p style="display : none;">'+item.footPrintNO+'</p>'
		       content += 		'<div id="size">'
		       content += 		'<img src="/photo/'+item.newFileName+'" />'
		    	   content += 		'</div>'
		    	   content += 		'<div class="card-body">'
		    	   content += 			'<p class="card-title">작성자 : '+item.email+' </p>'
		    	   content += 			'<hr/>'
		    	   content += 			'<p class="card-text" id="text">'+item.footprintText+'</p>'
		    	   content += 		'</div>'
		    	   content += 		'<div class="card-footer text-center">'
		    	   content += 			'<a class="btn btn-primary" href="fpdetail?footPrintNO='+item.footPrintNO+'">자세히 보기</a>'
		    	   content += 		'</div>'
		    	   content += 	'</div>' 	  
		        })
		        $('#card').append(content);
		    },
		    error : function(e) {
		       console.log(e);
		    }
	})
	
})
		
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script> -->
</html>
