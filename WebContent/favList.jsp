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
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	af37bb113fb5c630dd1cdf63348a1073"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=af37bb113fb5c630dd1cdf63348a1073"></script>
<style>
table, th, td {
	border: 1px solid;
	border-collapse: collapse;
}

td {
	text-align: center;
	padding: 5px;
}

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
	<h3>찜목록</h3>
	<div id='detail' style=""></div>
	<div id="map" style="width: 100%; height: 350px;"></div>

	<table>
		<thead>
			<tr>
				<th>관광지명</th>
				<th>찜한 날짜</th>
				<th>관광지 주소</th>
				<th>삭제</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
	<script>
		var jsonLocation = './VisitJeju_API/allAPI2.json';

		var $latitude = 0;
		var $longitude = 0;
		var overlay = new Array();
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.59044474588304,
					126.54468661424805), // 지도의 중심좌표 (위도,경도)
			level : 11
		// 지도의 확대 레벨
		};

		var markers = new Array();

		let db = listCall();//db읽어옴
		//console.log(db.length);
		let api = readAPI();//JSON파일 읽어옴

		// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
		//지도를 생성하고 나서 마커를 찍어야 에러가 안생김.
		map = new kakao.maps.Map(mapContainer, mapOption);

		$("a").click(function() {
			//console.log("a태그 클릭 : " +$(this).attr("id"));
			selectOpt(this);
		});

		function selectOpt(obj) {
			//console.log("a의 id값 : "+$(obj).attr('id'));
			var $chk = $(obj).attr('id');
			//console.log("a의 id값 : "+$chk);		

			switch ($chk) {
			case "관광지":
				//console.log("관광지 선택");
				let items;//json file에서 읽어온 data를 저장할 변수
				items = readAPI();
				//console.log("items : "+items[0].alltag);
				markerCall(items);
				break;

			default:
				break;
			}
		}

		drawList();

		function drawList() {
			//let db = listCall();//db읽어옴
			//let api = readAPI();//JSON파일 읽어옴
			let link = "location.href='./favDel?apiNo=";
			let favList = new Array();//배열에 JSON그대로 push하면 됨
			//let temp = JSON.parse(api);
			//console.log(db);
			//console.log(temp);
			//console.log(api);

			let content = "";
			$
					.each(
							db,
							function(index, dbItem) {

								$
										.each(
												api,
												function(idx, apiItem) {
													//console.log(api);
													//console.log(items);
													if (dbItem.apiNo == apiItem.contentsid) {
														//console.log(apiItem);
														//console.log(items);
														favList.push(apiItem);
														link = link
																+ apiItem.contentsid
																+ "'";
														//console.log(link);
														content += '<tr><td><a href="javascript:void(0);" onclick="detail('
																+ idx
																+ ')">'
																+ apiItem.title
																+ '</a></td>'
																+ '<td>'
																+ dbItem.reg_date
																+ '</td>'
																+ '<td>'
																+ apiItem.address
																+ '</td>';
														//content+='<td><button name="' + idx + '" data-contentsid="'+ apiItem.contentsid + '" onclick="del(' + idx	+ ');">삭제</button></td></tr>';
														content += '<td><button name="'+idx+'" data-contentsid="'+ apiItem.contentsid +'" onclick="'+link+	'">삭제</button></td></tr>';
														link = "location.href='./favDel?apiNo=";
														return;//$.each에서는 break대신 return사용
													}
												});
							});
			//console.log(favList);
			markerCall(favList);
			$("tbody").empty();//비워줘야 다른 내용을 부르거나 같은 내용을 부를때 덧붙여서 나오지 않는다
			$("tbody").append(content);
		}

		//API json file 읽어오기
		function readAPI() {
			let items;
			$.ajax({
				url : jsonLocation,
				dataType : "json",
				type : "POST",
				async : false,
				success : function(data) {
					//console.log("ajax : " + data.items[0].alltag);
					console.log(data);
					items = data;
				},
				error : function(e) {
					console.log(e);
				}
			});
			return items;
		}

		function listCall() {
			console.log("찜목록 리스트");
			let items;

			//찜목록 가져옴
			$.ajax({
				url : 'favList',
				dataType : "JSON",
				type : "POST",
				async : false,
				success : function(data) {
					//console.log(data);					
					if (!data.loginYN) {
						alert('로그인이 필요한 서비스 입니다.');
					} else {
						if (data.favList != null) {
							//console.log(data.favList);
							//console.log(data.favList[0].reg_date);							
							//console.log(apiNos[0].apiNo);
							items = data.favList;
							//console.log(items);
						}
					}
				},
				error : function(e) {
					console.log(e);
				}
			});
			return items;
		}

		//삭제를 눌렀을 때 호출되는 함수
		/* function del(apiNo) {
			//console.log("삭제하기 클릭 api No : " +$("button[name='"+apiNo+"']").attr("data-contentsid"));
			//console.log(apiNo);
			let conID = $("button[name='" + apiNo + "']").attr(
					"data-contentsid");
			if (conID != null) {

				 $.ajax({
					type : 'GET',
					url : 'favDel',
					data : {
						'contentsid' : conID
					},
					dataType : 'JSON',
					success : function(data) {
						console.log(data);
						if (data.success) {
							alert(data.cnt + '삭제에 성공 했습니다.');
							//location.href='main.jsp';
						} else {
							alert('삭제에 실패 했습니다.');
						}
					},
					error : function(e) {
						console.log(e);
					}
				});
			} else {

			}

		} */

		// 마커 이미지의 이미지 주소입니다
		//var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

		// 마커 이미지의 이미지 크기 입니다
		var imageSize = new kakao.maps.Size(24, 35);

		// 마커 이미지를 생성합니다    
		var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

		//마커 찍기
		function markerCall(items) {
			console.log("markerCall");
			let content = new Array();
			var icon = new kakao.maps.MarkerImage(
					'https://i1.daumcdn.net/dmaps/apis/n_local_blit_04.png',
					new kakao.maps.Size(31, 35));
			$
					.each(
							items,
							function(idx, items) {//item은 자바 스크립트 객체
								//console.log("idx: "+idx);
								//console.log("items: "+items);					
								//console.log("items.latitude : "+ items.latitude);
								//console.log("items.latitude : "+ items.longitude);
								//console.log("thumbnail : "	+ items.repPhoto.photoid.thumbnailpath);

								// 마커를 표시할 위치와 title 객체 배열입니다 
								let positions = [ {
									title : items.title,
									latlng : new kakao.maps.LatLng(
											items.latitude, items.longitude)
								} ];

								//for (let i = 0; i < positions.length; i++) {

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
								//}

								// 커스텀 오버레이에 표시할 컨텐츠 입니다
								// 커스텀 오버레이는 아래와 같이 사용자가 자유롭게 컨텐츠를 구성하고 이벤트를 제어할 수 있기 때문에
								// 별도의 이벤트 메소드를 제공하지 않습니다 
								content[idx] = '<div class="wrap">'
										+ '    <div class="info">'
										+ '        <div class="title">'
										//	+ '<a href="javascript:void(0);" onclick="detail('
										//+ idx
										//+ ')">'
										+ items.title
										//+ '</a>'
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
										+ items.address + '</div>'
										+ '            </div>'
										+ '        </div>' + '    </div>'
										+ '</div>';

								// 마커 위에 커스텀오버레이를 표시합니다
								// 마커를 중심으로 커스텀 오버레이를 표시하기위해 CSS를 이용해 위치를 설정했습니다
								overlay[idx] = new kakao.maps.CustomOverlay({
									content : content[idx],
									//map : map,
									position : marker.getPosition()
								});

								// 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
								kakao.maps.event
										.addListener(
												marker,
												'click',
												function() {
													//closeOverlay();
													//$("div.wrap").show();
													for (let i = 0; i < db.length; i++) {//마커 클릭 시 다른 마커 모두 감춤
														markers[i]
																.setImage(markerImage);
														closeOverlay(i);
													}
													marker.setImage(icon);
													overlay[idx].setMap(map);
												});
							});
		}

		// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
		function closeOverlay(idx) {
			overlay[idx].setMap(null);
			markers[idx].setImage(markerImage);
		}

		//title을 눌렀을 때 호출되는 함수
		function detail(idx) {
			$('#detail').show();
			//console.log(db[idx].apiNo);
			//let index = 0;
			$("#detail").html(""); // 태그 초기화   

			/* $.each(api, function(j, apiItem) {
				console.log(apiItem.contentsid);
				//console.log(items);
				//console.log(j);
				if (db[idx].apiNo == apiItem.contentsid) {
					console.log(db[idx].apiNo);
					console.log(apiItem.contentsid);
					index = j;
					return index;
				}
			});
			console.log(index); */

			$("#detail").append('<p>');
			$("#detail").append(api[idx].title);
			$("#detail").append('<button onclick="hideDetail()">닫기</button>');
			$("#detail").append('</p>');
			$("#detail")
					.append(
							'<img src="'+api[idx].repPhoto.photoid.imgpath+'" width="780px">');
			$("#detail").append('<br>');
			//$("#detail").append(items[idx].alltag);
			$("#detail").append('<p>');
			$("#detail").append(api[idx].introduction);
			$("#detail").append('</p>');
			$("#detail").append('연락처 : ' + api[idx].phoneno);
			$("#detail").append('<p>');
			$("#detail").append('주소');
			$("#detail").append('<br>');
			$("#detail").append(api[idx].address);
			$("#detail").append('<br>');
			$("#detail").append(api[idx].roadaddress);
			$("#detail").append('</p>');
			//$("#detail").append(contents);
		}

		function hideDetail() {
			$('#detail').hide();
		}
		/* var msg = "${msg}";
		if (msg != "") {
			alert(msg);
		} */
	</script>
</body>
</html>