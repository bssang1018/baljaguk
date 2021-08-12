<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/common.css" type="text/css">
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=af37bb113fb5c630dd1cdf63348a1073&libraries=services"></script>
<style type="text/css">
body, head {
	top: 0;
	bottom: 0;
	margin: 0;
	padding: 0;
}

#size {
	max-width: 100%;
	height: 210px;
	overflow: hidden;
}

img {
	margin: auto;
	max-width: 100%;
	display: flex;
	align-items: center;
	justify-content: center;
	height: auto;
}

#text {
	display: inline-block;
	width: 200px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

/*커스텀 오버레이를 위한 css*/
.wrap {
	position: absolute;
	left: 0;
	bottom: 40px;
	width: 288px;
	height: 132px;
	margin-left: -144px;
	text-align: left;
	overflow: hidden;
	font-size: 12px;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	line-height: 1.5;
}

.wrap * {
	padding: 0;
	margin: 0;
}

.wrap .info {
	width: 286px;
	height: 120px;
	border-radius: 5px;
	border-bottom: 2px solid #ccc;
	border-right: 1px solid #ccc;
	overflow: hidden;
	background: #fff;
}

.wrap .info:nth-child(1) {
	border: 0;
	box-shadow: 0px 1px 2px #888;
}

.info .title {
	padding: 5px 0 0 10px;
	height: 30px;
	background: #eee;
	border-bottom: 1px solid #ddd;
	font-size: 18px;
	font-weight: bold;
}

.info .close {
	position: absolute;
	top: 10px;
	right: 10px;
	color: #888;
	width: 17px;
	height: 17px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');
}

.info .close:hover {
	cursor: pointer;
}

.info .body {
	position: relative;
	overflow: hidden;
}

.info .desc {
	position: relative;
	margin: 13px 0 0 90px;
	height: 75px;
}

.desc .ellipsis {
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.desc .jibun {
	font-size: 11px;
	color: #888;
	margin-top: -2px;
}

.info .img {
	position: absolute;
	top: 6px;
	left: 5px;
	width: 73px;
	height: 71px;
	border: 1px solid #ddd;
	color: #888;
	overflow: hidden;
}

.info:after {
	content: '';
	position: absolute;
	margin-left: -12px;
	left: 50%;
	bottom: 0;
	width: 22px;
	height: 12px;
	background:
		url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')
}

.info .link {
	color: #5085BB;
}

#detail {
	width: 800px;
	height: 400px;
	float: left;
	position: fixed;
	left: 400px;
	top: 150px;
	z-index: 2;
	background-color: white;
	display: none;
	overflow-y: auto;
}
</style>

</head>
<body>
	<!-- 상단 메뉴바 -->
	<c:import url="./view/topmenu.jsp" />
	<!-- 지도를 표시할 div 입니다 -->
	<div id="map"
		style="width: 100%; height: 450px; position: relative; overflow: hidden;"></div>

	<!-- 내용시작 -->
	<div class="container px-4 my-4 text-center">
		<div class="row row-cols-1 row-cols-md-4 g-4 mt-4" id="card">

			<c:if test="${fplist eq null || fplist eq ''}">
				<tr>
					<td colspan="5">해당 데이터가 존재하지 않습니다.</td>
				</tr>
			</c:if>
			<c:forEach items="${fplist}" var="footprint" varStatus="no">
				<div class="gogo col text-center" id="frame" style="opacity: 0;">
					<p style="display: none;">${footprint.footPrintNO}</p>
					<div id="size">
						<img src="/photo/${footprint.newFileName}"
							onerror="this.src='view/test.jpg'" />
					</div>
					<div class="card-body">
						<p class="card-title">작성자 : ${footprint.email}</p>
					</div>
					<div class="card-footer text-center">
						<a
							style="display: inline-block; max-width: 100%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
							href="fpdetail?footPrintNO=${footprint.footPrintNO}">${footprint.footprintText}</a>

					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<div class="row">
		<form class="d-inline-flex justify-content-end" action="fpsearch"
			method="post">

			<div class="col-4"></div>
			<div class="col-4 text-center mb-3">
				<div class="input-group">
					<input class="form-control me-1" type="search"
						placeholder="검색어를 입력해주세요" aria-label="Search" name="hashtag"
						required />
					<button class="btn btn-outline-secondary" type="submit">search</button>
				</div>
			</div>
			<div class="col-4 text-center">
				<input type="button" class="btn btn-primary" onclick="sendlatLng()"
					value="발자국 남기기" />
			</div>
		</form>
		<div class="text-center">
			<button id="plusBtn" class="btn btn-primary"
				style="margin-bottom: 100px">더보기</button>
		</div>

	</div>


</body>
<script>
	$('.gogo').animate({
		opacity : 1
	})

	var page = 1;
	$(document)
			.on(
					'click',
					'#plusBtn',
					function() {
						page++;
						$
								.ajax({
									type : 'GET',
									url : 'plusMain',
									data : {
										'page' : page
									},
									dataType : 'JSON',
									success : function(data) {
										console.log(data);
										content = '';
										$
												.each(
														data.list,
														function(i, item) {
															content += '<div class="col text-center " id="frame" >'
															content += '<p style="display : none;">'
																	+ item.footPrintNO
																	+ '</p>'
															content += '<div id="size">'
															content += '<img src="/photo/'+item.newFileName+'" />'
															content += '</div>'
															content += '<div class="card-body">'
															content += '<p class="card-title">작성자 : '
																	+ item.email
																	+ ' </p>'
															content += '<hr/>'
																content +=   '<a style=" display: inline-block; max-width:100% ; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;" href="fpdetail?footPrintNO='+item.footPrintNO+'">자세히 보기</a>'
															content += '</div>'
															content += '<div class="card-footer text-center">'
																   '<a class="btn btn-primary" href="fpdetail?footPrintNO='+item.footPrintNO+'">자세히 보기</p>'
																	
															content += '</div>'
															content += '</div>'
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
		position : map.getCenter()
	});
	
	// 지도에 마커를 표시합니다
	marker.setMap(map);
	// 클릭한 위도, 경도 정보를 저장할 변수 
	var latlng;
	
	// 지도에 클릭 이벤트를 등록합니다
	// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {

		// 클릭한 위도, 경도 정보를 가져옵니다 
		latlng = mouseEvent.latLng;

		// 마커 위치를 클릭한 위치로 옮깁니다
		marker.setPosition(latlng);
		
	});
	
	function sendlatLng() {//좌표 보냄
		try{
			localStorage.setItem('lat', latlng.getLat());
			localStorage.setItem('lng', latlng.getLng());		
			window.location = './fpwrite.jsp';
		}catch(err){
			alert("등록할 위치를 선택해 주세요");
		}
	}
	
	//////////////////////////////////////////////////////////////////////////////
	var overlay = new Array();
	var fpMarkers = [];
	let fp = readDb();
	/* console.log(fpMarker);
	console.log(fpMarker[0]);
	console.log(fpMarker[1]);
	console.log(fpMarker[2]); */
	
	markerCall(fp)
	
	function readDb() {		
		//data = '<c:out value="${fplist}"/>';		
		//console.log(data);
			
		
		let arr = new Array();
		<c:forEach items="${fplist}" var="item">
			arr.push({lat:"${item.lat}"
					,lng:"${item.lng}"
					,img:"${item.newFileName}"
					,no:"${item.footPrintNO}"
					,date:"${item.reg_date}"});
			</c:forEach>
		
		return arr;
	}
	
	
	// 지도에 마커를 표시하는 함수입니다	
	function markerCall(item) {
		console.log("markerCall");

		// 마커 이미지의 이미지 주소입니다
		let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new kakao.maps.Size(24, 35);
		// 마커 이미지를 생성합니다    
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);
		
		let content = new Array();
		$
				.each(
						item,
						function(idx, items) {//item은 자바 스크립트 객체
							
							//console.log("items.latitude : " + items.lat);
							//console.log("items.longitude : " + items.lng);
							//console.log("thumbnail : "	+ items.repPhoto.photoid.thumbnailpath);
/* 
							// 마커를 표시할 위치와 title 객체 배열입니다 
							let positions = [ {
								title : items.title,
								latlng : new kakao.maps.LatLng(items.latitude,
										items.longitude)
							} ]; */

							// LatLngBounds 객체에 좌표를 추가합니다
							//bounds.extend(position);						

							// 마커를 생성합니다
							fpMarker = new kakao.maps.Marker({
								map : map, // 마커를 표시할 지도
								position : new kakao.maps.LatLng(	items.lat, items.lng), // 마커를 표시할 위치
								//title : items.title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
								image : markerImage
							// 마커 이미지 
							});
							fpMarkers.push(fpMarker);

							// LatLngBounds 객체에 좌표를 추가합니다
							//bounds.extend(new kakao.maps.LatLng(items.latitude,	items.longitude));

												

							// 커스텀 오버레이에 표시할 컨텐츠 입니다
							// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
							// 별도의 이벤트 메소드를 제공하지 않습니다 
							content[idx] = '<div class="wrap">'
									+ '    <div class="info">'
									+ '        <div class="title">'																				
									+ items.no
									+ '</a>'
									+ '            <div class="close" onclick="closeOverlay('
									+ idx
									+ ')" title="닫기"></div>'
									+ '        </div>'
									+ '        <div class="body">'
									+ '            <div class="img">'
									+ '                <img src="'+items.img+'" width="73" height="70">'
									+ '           </div>'
									+ '            <div class="desc">'
									+ '                <div class="ellipsis">'
									+ items.date
									+ '</div>'									
									+ '            </div>'
									+ '        </div>'
									+ '    </div>' + '</div>';

							// 마커 위에 커스텀오버레이를 표시합니다
							// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
							overlay[idx] = new kakao.maps.CustomOverlay({
								content : content[idx],
								//map : map,
								position : new kakao.maps.LatLng(
										items.lat, items.lng)
							});

							// 마커를 클릭했을 때 커스텀 오버레이를 등록합니다
							kakao.maps.event.addListener(fpMarker, 'click',
									function() {
										//console.log(item.length);
										for (let i = 0; i < item.length; i++) {
											closeOverlay(i);
										}
										overlay[idx].setMap(map);
									});
						});

		// LatLngBounds 객체에 추가된 좌표들을 기준으로 지도의 범위를 재설정합니다
		// 이때 지도의 중심좌표와 레벨이 변경될 수 있습니다
		//map.setBounds(bounds);

	}
	
	function closeOverlay(idx) {
		overlay[idx].setMap(null);
	}
</script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script> -->
</html>



