<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=af37bb113fb5c630dd1cdf63348a1073&libraries=services"></script>
<style>
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
	/* text-overflow: scroll; */
	white-space: pre-wrap;
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

.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 500px;
}

#menu_wrap {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	width: 350px;
	margin: 10px 0 30px 10px;
	padding: 5px;
	overflow-y: auto;
	background: rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size: 12px;
	border-radius: 10px;
}

.bg_white {
	background: #fff;
}

#menu_wrap hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 2px solid #5F5F5F;
	margin: 3px 0;
}

#menu_wrap .option {
	text-align: center;
}

#menu_wrap .option p {
	margin: 10px 0;
}

#menu_wrap .option button {
	margin-left: 5px;
}

#placesList li {
	list-style: none;
}

#placesList .item {
	position: relative;
	border-bottom: 1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}

#placesList .item span {
	display: block;
	margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#placesList .item .info {
	padding: 10px 0 10px 55px;
}

#placesList .info .gray {
	color: #8a8a8a;
}

#placesList .info .jibun {
	padding-left: 26px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
		no-repeat;
}

#placesList .info .tel {
	color: #009900;
}

#placesList .item .markerbg {
	float: left;
	position: absolute;
	width: 36px;
	height: 37px;
	margin: 10px 0 0 10px;
	background:
		url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
		no-repeat;
}

#placesList .item .marker_1 {
	background-position: 0 -10px;
}

#placesList .item .marker_2 {
	background-position: 0 -56px;
}

#placesList .item .marker_3 {
	background-position: 0 -102px
}

#placesList .item .marker_4 {
	background-position: 0 -148px;
}

#placesList .item .marker_5 {
	background-position: 0 -194px;
}

#placesList .item .marker_6 {
	background-position: 0 -240px;
}

#placesList .item .marker_7 {
	background-position: 0 -286px;
}

#placesList .item .marker_8 {
	background-position: 0 -332px;
}

#placesList .item .marker_9 {
	background-position: 0 -378px;
}

#placesList .item .marker_10 {
	background-position: 0 -423px;
}

#placesList .item .marker_11 {
	background-position: 0 -470px;
}

#placesList .item .marker_12 {
	background-position: 0 -516px;
}

#placesList .item .marker_13 {
	background-position: 0 -562px;
}

#placesList .item .marker_14 {
	background-position: 0 -608px;
}

#placesList .item .marker_15 {
	background-position: 0 -654px;
}

#pagination {
	margin: 10px auto;
	text-align: center;
}

#pagination a {
	display: inline-block;
	margin-right: 10px;
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
	<a href="javascript:void(0);" id="0" class="region">추자도</a>
	<a href="javascript:void(0);" id="1" class="region">비양도</a>
	<a href="javascript:void(0);" id="2" class="region">차귀도</a>
	<a href="javascript:void(0);" id="3" class="region">가파도</a>
	<a href="javascript:void(0);" id="4" class="region">마라도</a>
	<a href="javascript:void(0);" id="5" class="region">우도</a>
	<a href="javascript:void(0);" id="6" class="region">한림읍</a>
	<a href="javascript:void(0);" id="7" class="region">애월읍</a>
	<a href="javascript:void(0);" id="8" class="region">제주시내</a>
	<a href="javascript:void(0);" id="9" class="region">조천읍</a>
	<a href="javascript:void(0);" id="10" class="region">구좌읍</a>
	<a href="javascript:void(0);" id="11" class="region">성산읍</a>
	<a href="javascript:void(0);" id="12" class="region">표선면</a>
	<a href="javascript:void(0);" id="13" class="region">남원읍</a>
	<a href="javascript:void(0);" id="14" class="region">서귀포시내</a>
	<a href="javascript:void(0);" id="15" class="region">중문동</a>
	<a href="javascript:void(0);" id="16" class="region">안덕면</a>
	<a href="javascript:void(0);" id="17" class="region">대정읍</a>
	<a href="javascript:void(0);" id="18" class="region">한경면</a>

	<div id='divid' style="display: none;">
		<!-- <div id='divid' style="visibility: hidden;"> -->
		<!-- <a href="javascript:void(0);" id="전체">전체</a> -->
		<a href="javascript:void(0);" class="class" id="관광지">관광지</a> <a
			href="javascript:void(0);" class="class" id="음식점">음식점</a> <a
			href="javascript:void(0);" class="class" id="숙박">숙박</a> <a
			href="javascript:void(0);" class="class" id="쇼핑">쇼핑</a>
	</div>
	<div id='detail' style=""></div>
	<!-- 지도를 표시할 div 입니다 -->
	<div class="map_wrap">
		<div id="map"
			style="width: 100%; height: 100%; position: relative; overflow: hidden;"></div>

		<div id="menu_wrap" class="bg_white">
			<div class="option">
				<div>
					<form onsubmit="searchPlaces(); return false;">
						키워드 : <input type="text" value="" id="keyword" size="15">
						<button type="submit">검색하기</button>
					</form>
				</div>
			</div>
			<hr>
			<ul id="placesList"></ul>
			<div id="pagination"></div>
		</div>
	</div>
	<button onclick="location.href='fplist'">발자국 전환</button>
	<!-- <script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=af37bb113fb5c630dd1cdf63348a1073"></script> -->
	<table>
		<thead>
			<tr>
				<th>관광지명</th>				
				<th>관광지 주소</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
</body>
<script type="text/javascript">
	var jsonLocation = [ './VisitJeju_API/추차도.json',
			'./VisitJeju_API/비양도.json', './VisitJeju_API/차귀도.json',
			'./VisitJeju_API/가파도.json', './VisitJeju_API/마라도.json',
			'./VisitJeju_API/우도.json', './VisitJeju_API/한림.json',
			'./VisitJeju_API/애월.json', './VisitJeju_API/제주시내.json',
			'./VisitJeju_API/조천.json', './VisitJeju_API/구좌.json',
			'./VisitJeju_API/성산.json', './VisitJeju_API/표선.json',
			'./VisitJeju_API/남원.json', './VisitJeju_API/서귀포시내.json',
			'./VisitJeju_API/중문.json', './VisitJeju_API/안덕.json',
			'./VisitJeju_API/대정.json', './VisitJeju_API/한경.json' ];
	//var $latitude = 0;
	//var $longitude = 0;
	let items;//json file에서 읽어온 data를 저장할 변수
	var overlay = new Array();
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	mapOption = {
		center : new kakao.maps.LatLng(33.38453042646361, 126.56120892927193), // 지도의 중심좌표 (위도,경도)
		level : 11
	// 지도의 확대 레벨
	};
	// 마커를 담을 배열입니다
	var markers = [];
	var region;
	//placesSearchCB option
	/* var options = {
		page : 45
	}; */

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	//지도를 생성하고 나서 마커를 찍어야 에러가 안생김.
	var map = new kakao.maps.Map(mapContainer, mapOption);

	// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
	var infowindow = new kakao.maps.InfoWindow({
		zIndex : 1
	});

	$(".class").click(function() {
		//console.log("a태그 클릭 : " +$(this).attr("id"));
		$("div.wrap").css({
			"display" : "none"
		});
		$('#menu_wrap').show();
		selectOpt(this);
	});

	$('.region').click(function() {
		region = $(this).attr('id');
		console.log(region);
		$('#divid').show();
	});

	// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();

	function selectOpt(obj) {
		//console.log("a의 id값 : "+$(obj).attr('id'));
		var $chk = $(obj).attr('id');
		//console.log("a의 id값 : "+$chk);		

		removeMarker();
		switch ($chk) {
		/* case "전체":
			ps.keywordSearch('제주도 관광지', placesSearchCB);
			break; */
		case "관광지":
			$('#menu_wrap').hide();
			//console.log("관광지 선택");
			/* let items;//json file에서 읽어온 data를 저장할 변수 */
			items = readAPI();
			//console.log(items);
			//console.log("items : "+items[0].alltag);
			markerCall(items);
			break;
		case "음식점":
			// 키워드로 장소를 검색합니다
			//console.log(document.getElementById(region).text);
			ps.keywordSearch(document.getElementById(region).text + ' 음식점',
					placesSearchCB);
			break;
		case "숙박":
			// 키워드로 장소를 검색합니다
			ps.keywordSearch(document.getElementById(region).text + ' 숙박',
					placesSearchCB);
			break;
		case "쇼핑":
			// 키워드로 장소를 검색합니다
			ps.keywordSearch(document.getElementById(region).text + ' 쇼핑',
					placesSearchCB);
			break;
		default:
			break;
		}
	}

	// 지도에 마커를 표시하는 함수입니다
	function displayMarker(place) {

		// 마커를 생성하고 지도에 표시합니다
		var marker = new kakao.maps.Marker({
			map : map,
			position : new kakao.maps.LatLng(place.y, place.x)
		});

		// 마커에 클릭이벤트를 등록합니다
		kakao.maps.event.addListener(marker, 'click', function() {
			// 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
			infowindow.setContent('<div style="padding:5px;font-size:12px;">'
					+ place.place_name + '</div>');
			infowindow.open(map, marker);
		});

		markers.push(marker);
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
		for (var i = 0; i < markers.length; i++) {
			infowindow.close();
			markers[i].setMap(null);
		}
		markers = [];
	}

	//API json file 읽어오기
	function readAPI() {
		let items;
		//console.log(jsonLocation[region]);
		$.ajax({
			url : jsonLocation[region],
			dataType : "json",
			type : "POST",
			async : false,
			success : function(data) {
				//console.log("ajax : " + data.items[0].alltag);
				console.log(data);
				console.log(data[0].alltag);
				items = data;
			},
			error : function(e) {
				console.log(e);
			}
		});
		return items;
	}

	//마커 찍기
	function markerCall(item) {
		console.log("markerCall");

		// 마커 이미지의 이미지 주소입니다
		let imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new kakao.maps.Size(24, 35);

		// 마커 이미지를 생성합니다    
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

		// 지도를 재설정할 범위정보를 가지고 있을 LatLngBounds 객체를 생성합니다
		let bounds = new kakao.maps.LatLngBounds();

		/* // 마커를 생성합니다
		marker = new kakao.maps.Marker({
			map : map, // 마커를 표시할 지도
			position : new kakao.maps.LatLng(items.latitude, items.longitude), // 마커를 표시할 위치
			title : items.title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
			image : markerImage
		// 마커 이미지 
		}); */
		let content = new Array();
		let content2 = new Array();
		$
				.each(
						item,
						function(idx, items) {//item은 자바 스크립트 객체
							//console.log("idx: "+idx);
							//console.log("items: "+items);
							//console.log(items);
							//console.log("items.title : "+ items.title);
							console.log("items.latitude : " + items.latitude);
							console.log("items.longitude : " + items.longitude);
							//console.log("thumbnail : "	+ items.repPhoto.photoid.thumbnailpath);

							// 마커를 표시할 위치와 title 객체 배열입니다 
							let positions = [ {
								title : items.title,
								latlng : new kakao.maps.LatLng(items.latitude,
										items.longitude)
							} ];

							// LatLngBounds 객체에 좌표를 추가합니다
							//bounds.extend(position);

							// 마커 이미지의 이미지 주소입니다
							var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

							//for (let i = 0; i < positions.length; i++) {

							// 마커 이미지의 이미지 크기 입니다
							var imageSize = new kakao.maps.Size(24, 35);

							// 마커 이미지를 생성합니다    
							var markerImage = new kakao.maps.MarkerImage(
									imageSrc, imageSize);

							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
								map : map, // 마커를 표시할 지도
								position : new kakao.maps.LatLng(
										items.latitude, items.longitude), // 마커를 표시할 위치
								title : items.title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
								image : markerImage
							// 마커 이미지 
							});
							markers.push(marker);

							// LatLngBounds 객체에 좌표를 추가합니다
							bounds.extend(new kakao.maps.LatLng(items.latitude,
									items.longitude));

							//}						

							// 커스텀 오버레이에 표시할 컨텐츠 입니다
							// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
							// 별도의 이벤트 메소드를 제공하지 않습니다 
							content[idx] = '<div class="wrap">'
									+ '    <div class="info">'
									+ '        <div class="title">'
									+ '<a href="javascript:void(0);" onclick="detail('
									+ idx
									+ ')">'
									+ items.title
									+ '</a>'
									+ '            <div class="close" onclick="closeOverlay('
									+ idx
									+ ')" title="닫기"></div>'
									+ '        </div>'
									+ '        <div class="body">'
									+ '            <div class="img">'
									+ '                <img src="'+items.repPhoto.photoid.thumbnailpath+'" width="73" height="70">'
									+ '           </div>'
									+ '            <div class="desc">'
									+ '                <div class="ellipsis">'
									+ items.address
									+ '</div>'
									+ '                <button name="'
									+ idx
									+ '" class="btn_selected_place" data-contentsid="'
									+ items.contentsid
									+ '" onclick="fav('
									+ idx
									+ ');">찜하기</button>'
									+ '            </div>'
									+ '        </div>'
									+ '    </div>' + '</div>';

									content2[idx] = '<tr><td><a href="javascript:void(0);" onclick="markerTrg('
										+ idx
										+ ')">'
										+ items.title
										+ '</a></td>'										
										+ '<td>'
										+ items.address
										+ '</td>';
							// 마커 위에 커스텀오버레이를 표시합니다
							// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
							
							overlay[idx] = new kakao.maps.CustomOverlay({
								content : content[idx],
								//map : map,
								position : new kakao.maps.LatLng(
										items.latitude, items.longitude)
							});

							// 마커를 클릭했을 때 커스텀 오버레이를 등록합니다
							kakao.maps.event.addListener(marker, 'click',
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
		map.setBounds(bounds);
		$("tbody").empty();//비워줘야 다른 내용을 부르거나 같은 내용을 부를때 덧붙여서 나오지 않는다
		$("tbody").append(content2);
	}

	function markerTrg(idx){
		kakao.maps.event.trigger(markers[idx], 'click'); 
		console.log(markers[idx]);
	}
	
	// 키워드 검색을 요청하는 함수입니다
	function searchPlaces() {

		var keyword = document.getElementById('keyword').value;

		if (!keyword.replace(/^\s+|\s+$/g, '')) {
			alert('키워드를 입력해주세요!');
			return false;
		}

		// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
		ps.keywordSearch(keyword, placesSearchCB);
	}

	// 키워드 검색 완료 시 호출되는 콜백함수 입니다
	/* function placesSearchCB(data, status, pagination) {
		if (status === kakao.maps.services.Status.OK) {

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			// LatLngBounds 객체에 좌표를 추가합니다
			var bounds = new kakao.maps.LatLngBounds();

			for (var i = 0; i < data.length; i++) {
				displayMarker(data[i]);
				bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
			}

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
			//map.setBounds(bounds);
		}
	} */

	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
		if (status === kakao.maps.services.Status.OK) {

			// 정상적으로 검색이 완료됐으면
			// 검색 목록과 마커를 표출합니다
			displayPlaces(data);

			// 페이지 번호를 표출합니다			
			displayPagination(pagination);

		} else if (status === kakao.maps.services.Status.ZERO_RESULT) {

			alert('검색 결과가 존재하지 않습니다.');
			return;

		} else if (status === kakao.maps.services.Status.ERROR) {

			alert('검색 결과 중 오류가 발생했습니다.');
			return;

		}
	}

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {

		var listEl = document.getElementById('placesList'), menuEl = document
				.getElementById('menu_wrap'), fragment = document
				.createDocumentFragment(), bounds = new kakao.maps.LatLngBounds(), listStr = '';

		// 검색 결과 목록에 추가된 항목들을 제거합니다
		removeAllChildNods(listEl);

		// 지도에 표시되고 있는 마커를 제거합니다
		removeMarker();

		for (var i = 0; i < places.length; i++) {

			// 마커를 생성하고 지도에 표시합니다
			var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x), marker = addMarker(
					placePosition, i), itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			// LatLngBounds 객체에 좌표를 추가합니다
			bounds.extend(placePosition);

			// 마커와 검색결과 항목에 mouseover 했을때
			// 해당 장소에 인포윈도우에 장소명을 표시합니다
			// mouseout 했을 때는 인포윈도우를 닫습니다
			(function(marker, title) {
				kakao.maps.event.addListener(marker, 'mouseover', function() {
					displayInfowindow(marker, title);
				});

				kakao.maps.event.addListener(marker, 'mouseout', function() {
					infowindow.close();
				});

				itemEl.onmouseover = function() {
					displayInfowindow(marker, title);
				};

				itemEl.onmouseout = function() {
					infowindow.close();
				};
			})(marker, places[i].place_name);

			fragment.appendChild(itemEl);
		}

		// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		listEl.appendChild(fragment);
		menuEl.scrollTop = 0;

		// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		//map.setBounds(bounds);
	}

	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {

		var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
				+ (index + 1)
				+ '"></span>'
				+ '<div class="info">'
				+ '   <h5>'
				+ places.place_name + '</h5>';

		if (places.road_address_name) {
			itemStr += '    <span>' + places.road_address_name + '</span>'
					+ '   <span class="jibun gray">' + places.address_name
					+ '</span>';
		} else {
			itemStr += '    <span>' + places.address_name + '</span>';
		}

		itemStr += '  <span class="tel">' + places.phone + '</span>' + '</div>';

		el.innerHTML = itemStr;
		el.className = 'item';

		return el;
	}

	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
		var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
		imgOptions = {
			spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
			spriteOrigin : new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
			offset : new kakao.maps.Point(13, 37)
		// 마커 좌표에 일치시킬 이미지 내에서의 좌표
		}, markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize,
				imgOptions), marker = new kakao.maps.Marker({
			position : position, // 마커의 위치
			image : markerImage
		});

		marker.setMap(map); // 지도 위에 마커를 표출합니다
		markers.push(marker); // 배열에 생성된 마커를 추가합니다

		return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	/* function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	} */

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
		var paginationEl = document.getElementById('pagination'), fragment = document
				.createDocumentFragment(), i;

		// 기존에 추가된 페이지번호를 삭제합니다
		while (paginationEl.hasChildNodes()) {
			paginationEl.removeChild(paginationEl.lastChild);
		}

		for (i = 1; i <= pagination.last; i++) {
			var el = document.createElement('a');
			el.href = "#";
			el.innerHTML = i;

			if (i === pagination.current) {
				el.className = 'on';
			} else {
				el.onclick = (function(i) {
					return function() {
						pagination.gotoPage(i);
					}
				})(i);
			}

			fragment.appendChild(el);
		}
		paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
		var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

		infowindow.setContent(content);
		infowindow.open(map, marker);
	}

	// 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {
		while (el.hasChildNodes()) {
			el.removeChild(el.lastChild);
		}
	}

	// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
	function closeOverlay(idx) {
		overlay[idx].setMap(null);
	}

	//찜하기를 눌렀을 때 호출되는 함수
	function fav(idx) {

		//console.log("찜하기 클릭 contents ID: " +$("button").attr("data-contentsid"));
		let conID = $("button[name='" + idx + "']").attr("data-contentsid");
		if (conID != null) {
			$.ajax({
				type : 'GET',
				url : 'favorite',
				data : {
					'contentsid' : conID
				},
				dataType : 'JSON',
				success : function(data) {
					console.log(data);
					if (data.success) {
						alert('찜하기에 성공 했습니다.');
						//location.href='main.jsp';
					} else {
						alert('이미 찜한 관광지입니다.');
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
		} else {

		}

	}

	//title을 눌렀을 때 호출되는 함수
	function detail(idx) {
		$('#detail').show();
		console.log(items[idx]);
		 $("#detail").html(""); // 태그 초기화   
	     
		 $("#detail").append('<p>');	
	     $("#detail").append(items[idx].title);
	     $("#detail").append('<button onclick="hideDetail()">닫기</button>');
	     $("#detail").append('</p>');
	     $("#detail").append('<img src="'+items[idx].repPhoto.photoid.imgpath+'" width="780px">');
	     $("#detail").append('<br>');
	     //$("#detail").append(items[idx].alltag);
	     $("#detail").append('<p>');
	     $("#detail").append(items[idx].introduction);
	     $("#detail").append('</p>');
	     $("#detail").append('연락처 : '+items[idx].phoneno);
	     $("#detail").append('<p>');
	     $("#detail").append('주소');
	     $("#detail").append('<br>');
	     $("#detail").append(items[idx].address);
	     $("#detail").append('<br>');
	     $("#detail").append(items[idx].roadaddress);
	     $("#detail").append('</p>');
	     //$("#detail").append(contents);
	}
	
	function hideDetail(){
		$('#detail').hide();
	}
</script>
</html>