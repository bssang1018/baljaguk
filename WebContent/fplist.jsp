<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=af37bb113fb5c630dd1cdf63348a1073&libraries=services"></script>
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
<!-- 지도를 표시할 div 입니다 -->
				<div id="map"	style="width: 100%; height: 450px; position: relative; overflow: hidden;"></div>
<form class="d-inline-flex justify-content-end"  action="fpsearch" method="post">
	 
   <div class="form-group">
   <input type="button" onclick="location.href='fpwrite.jsp'" value="발자국 남기기"/>
   <input class="form-control me-1" type="search" placeholder="검색어를 입력해주세요" aria-label="Search" name="hashtag"/>
			<button class="btn btn-outline-secondary" type="submit">search</button>
   </div>
   
   
       
	<!-- 내용시작 -->
<div class="row row-cols-1 row-cols-md-4 g-4 mt-4" id="card">
  
   
      <c:if test="${fplist eq null || fplist eq ''}">
       <tr><td colspan="5">해당 데이터가 존재하지 않습니다.</td></tr>
       
    
    </c:if>
   
   <c:forEach items="${fplist}" var="footprint" varStatus = "no">
   <div class="gogo col text-center" id="frame" style="opacity:0;">
					<p style="display : none;">${footprint.footPrintNO}</p>
					<div id="size">
					<img src="/photo/${footprint.newFileName}" 	onerror="this.src='view/test.jpg'"/>
					</div>
					<div class="card-body">
						<p class="card-title">작성자 : ${footprint.email} </p>
						
						
					</div>
					<div class="card-footer text-center">
						<td><a href="fpdetail?footPrintNO=${footprint.footPrintNO}">${footprint.footprintText}</a></td>
					</div>
					
					</div>
					
   </c:forEach>
  </div>
   </form>
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
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(33.38453042646361, 126.56120892927193), // 지도의 중심좌표 (위도,경도)
		level : 10
	// 지도의 확대 레벨
	};
	map = new kakao.maps.Map(mapContainer, mapOption);		

	// 지도를 클릭한 위치에 표출할 마커입니다
	var marker = new kakao.maps.Marker({ 
	    // 지도 중심좌표에 마커를 생성합니다 
	    position: map.getCenter() 
	}); 
	// 지도에 마커를 표시합니다
	marker.setMap(map);

	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
	    
	    // 클릭한 위도, 경도 정보를 가져옵니다 
	    var latlng = mouseEvent.latLng; 
	    
	    // 마커 위치를 클릭한 위치로 옮깁니다
	    marker.setPosition(latlng);
	    
	    var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
	    message += '경도는 ' + latlng.getLng() + ' 입니다';
	    
	    var resultDiv = document.getElementById('clickLatlng'); 
	    resultDiv.innerHTML = message;
	    
	});

 
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script> -->
</html>



