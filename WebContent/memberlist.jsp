<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
	crossorigin="anonymous">
</script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
</head>
<body>
<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
<div class="container px-4 my-4 text-center">
<h2>회원목록</h2>
	<table class='table'>
		<thead>
			<tr>
				<th>이메일</th>
				<th>이름</th>
				<th>상세보기</th>
				<th>정지하기</th>
				<th>블랙리스트 등록하기</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>
	<!-- 페이지를 몇부터 몇까지 보여줄건지 (이전/다음)  -->
	<div class="pageArea">
	
	</div>
	<div style="float: right;">
	<table>
			<thead>
				<tr>
					<td><input class='search' type="text" name='email'/></td>
					<td><button class="btn" style="">검색</button></td>
					<td><input type='button' onclick='location.href="/tree/index1.jsp"' value="목록으로" class="btn btn-outline-primary"/></td>
				</tr>
			</thead>
		</table>
	</div>
	<!-- 하단단 메뉴바 -->
	<c:import url="./view/bottom.jsp" />
	 </div> 
</body>
<script>
var page = 1;
listCall(page);
function listCall(page) {
	var param = {};
	param.page = page;
	$.ajax({
		type : 'get',
		url : 'memberlist',
		data : param,
		dataType : 'JSON',
		success : function(data) {
			console.log(data);
			drawList(data.list);
			pageList(data);
		},
		error : function(e) {
			console.log(e);
		}
	});
}

	//회원 리스트 출력 함수
	function drawList(list) {
		var content = "";
		list.forEach(function(item, idx) {
			console.log(item, idx);
			content += "<tr>";
			content += "<td>" + item.email + "</td>";
			content += "<td>" + item.name + "</td>";
			content += "<td><a href='memberdetail?email="+item.email+"'>상세보기</a></td>";
			content += "<td><a href='stopwriteform?email="+item.email+"'>정지하기</a></td>";
			content += "<td><a href='blackwriteform?email="+item.email+"'>블랙리스트 등록하기</a></td>";
			content += "</tr>";
		});
		$("tbody").empty();
		$("tbody").append(content);
	}

// 검색 함수
console.log($('.btn'));
 $('.btn').click(function(){
	 var param = {};
	 param.email = $("input[class='search']").val();
	 console.log(param);
	 $.ajax({
			type:'POST',
			url:'membersearch',
			data:param,
			dataType:'JSON',
			success:function(data){
				console.log(data);
					console.log(data);
					searchList(data.list);
			},
			error:function(e){
				console.log(e);
			}
		});
 });
 // 검색 뿌리기 함수
 function searchList(list) {
		console.log(list);
		var content = "";
		console.log("머야")
		list.forEach(function(item, idx) {
			console.log(item, idx);
			content += "<tr>";
			content += "<td>" + item.email + "</td>";
			content += "<td>" + item.name + "</td>";
			content += "<td><a href='memberdetail?email="+item.email+"'>상세보기</a></td>";
			content += "<td><a href='stopwriteform?email="+item.email+"'>정지하기</a></td>";
			content += "<td><a href='blackwriteform?email="+item.email+"'>블랙리스트 등록하기</a></td>";
			content += "</tr>";
		});
		$("tbody").empty();
		$("tbody").append(content);
		$("div.pageArea").empty();
	}
//페이징 처리 함수
	function pageList(list){
		var content = "";
		console.log("페이징처리 함수옴")
			for(i = 1; i<= list.totalPage; i++){
				content += "<span class='page'>";
				if(i != list.currPage){
					content += "<button onclick='listCall("+i+");'>"+i+"</button>";
				}else{
					content += "<b>"+i+"</b>";
				}
				content += "</span>";
			};
			$("div.pageArea").empty();
			$("div.pageArea").append(content);
	}
</script>
</html>