<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=af37bb113fb5c630dd1cdf63348a1073&libraries=services"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
	<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=af37bb113fb5c630dd1cdf63348a1073&libraries=services"></script>
<style type="text/css">
body, head {
	top: 0;
	bottom: 0;
	margin: 0;
	padding: 0;
}
</style>
</head>
<body>
	<!-- 상단 메뉴바 -->
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="./main.jsp">발자국</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div
				class="collapse navbar-collapse nav justify-content-end bg-light"
				id="navbarNavDropdown">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="./main.jsp">홈</a></li>
					<li class="nav-item"><a class="nav-link" href="./main.jsp">지도</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="./main.jsp">피드</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="./main.jsp">발자국</a>
					</li>
					<li class="nav-item"><a class="nav-link" href="./main.jsp">메시지</a>
					</li>
					<li class="nav-item dropdown"><a class="nav-link"
						href="./main.jsp" id="login"> 프로필 </a>
				</ul>
				</li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- 내용시작 -->
	<div class="container px-4 my-4">
		<div class="row">
			<div class="col-6 text-center">
				
			<a href="map" class="nav-link" ><h2>지도</h2></a>
				
				<hr />
				<!-- 지도를 표시할 div 입니다 -->
				<div id="map"	style="width: 100%; height: 350px; position: relative; overflow: hidden;"></div>
			</div>
			<div class="col-6 text-center" >
				<a class="nav-link" href="./main.jsp"><h2>플래너시작</h2></a>
				<hr />
				<div class="card text-dark bg-light mb-3" style="max-width: 100%; height:350px;">
  <div class="card-body">
    <h5 class="card-title">발자국에 오신 것을 환영합니다!!</h5>
    <p class="card-text"><br/>제주도에서의 즐거운 여행을 남겨주세요!</p>
  </div>
			</div>
		</div>
		<div class="row row-cols-1 row-cols-md-4 g-4 mt-4">
			<div class="col">
				<div class="gogo col text-center" id="frame">
					<div id="size">
						<img src= "view/test.jpg" />
					</div>
					<div class="card-body">
						<p class="card-title">작성자 </p>
						<hr />
						<p class="card-text" id="text">내용이 </p>
					</div>
					<div class="card-footer text-center">
						<button class="btn btn-primary">자세히
							보기</button>
					</div>
				</div>
		</div>
					<div class="col">
				<div class="gogo col text-center" id="frame">
					<div id="size">
						<img src= "view/test.jpg" />
					</div>
					<div class="card-body">
						<p class="card-title">작성자 </p>
						<hr />
						<p class="card-text" id="text">보고싶으면 </p>
					</div>
					<div class="card-footer text-center">
						<button class="btn btn-primary">자세히
							보기</button>
					</div>
				</div>
		</div>
					<div class="col">
				<div class="gogo col text-center" id="frame">
					<div id="size">
						<img src= "view/test.jpg" />
					</div>
					<div class="card-body">
						<p class="card-title">작성자 </p>
						<hr />
						<p class="card-text" id="text">로그인 </p>
					</div>
					<div class="card-footer text-center">
						<button class="btn btn-primary">자세히
							보기</button>
					</div>
				</div>
		</div>
					<div class="col">
				<div class="gogo col text-center" id="frame">
					<div id="size">
						<img src= "view/test.jpg" />
					</div>
					<div class="card-body">
						<p class="card-title">작성자 </p>
						<hr />
						<p class="card-text" id="text">해주세요 </p>
					</div>
					<div class="card-footer text-center">
						<button class="btn btn-primary">자세히
							보기</button>
					</div>
				</div>
		</div>
		</div>

					<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
					<script
						src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
						integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
						crossorigin="anonymous"></script>
					<script>
						var loginE = "${sessionScope.loginemail}";
						if (loginE != "") {
							location.href = "main.jsp";
						}
						
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						mapOption = {
							center : new kakao.maps.LatLng(33.38453042646361, 126.56120892927193), // 지도의 중심좌표 (위도,경도)
							level : 10
						// 지도의 확대 레벨
						};
						map = new kakao.maps.Map(mapContainer, mapOption);
					</script>
</body>
</html>