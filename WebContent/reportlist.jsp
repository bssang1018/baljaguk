<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	table, th, td{
		border: 1px solid black;
		border-collapse: collapse;
	}
</style>
</head>
<body>
	<!-- 상단 메뉴바 -->
	<c:import url="./view/topmenu.jsp" />
	<!-- 내용시작 -->
	<h2>신고 페이지</h2>
	<input class='btn1' type="button" value="신고글보기" />
	<input class='btn2' type="button" value="신고메세지보기" />
	<br>
	<table>
		<thead>
			<tr>
				<th>전체 선택상자</th>
				<th>신고 번호</th>
				<th>신고 카테고리</th>
				<th>신고 내용</th>
				<th>원문 보기</th>
				<th>작성이메일</th>
				<th>작성일</th>
				<th>답변하기</th>
				<th>답변여부</th>
			</tr>
		</thead>
		<tbody></tbody>
	</table>

<!-- 검색부분 -->
	<table>
		<thead>
			<tr>
				<td><input class='search' type="text" name='email' /></td>
				<td><button class="btn">검색</button></td>
				<td><input type='button'
					onclick='location.href="/tree/index1.jsp"' value="목록으로" /></td>
			</tr>
		</thead>
	</table>
	<!-- 페이지를 몇부터 몇까지 보여줄건지 (이전/다음)  -->
	<div class="pageArea"></div>
</body>
<script>
var page = 1;
var stx = 'rcontload';
listCall(page,stx);
	$(".btn1").click(function() {
		var page = 1;
		stx = 'rcontload';
		listCall(page,stx);
	});
	
	$(".btn2").click(function() {
			page = 1;
			stx = 'rmessload';
			listCall(page,stx);
	});
	
	function listCall(page,stx) {
		console.log("리스트콜: "+stx);
		var param = {};
		param.page = page;
		$.ajax({
			type : 'get',
			url : stx,
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
			//console.log(list);
			var content = "";
			list.forEach(function(item, idx) {
				console.log(item, idx);
				content += "<tr>";
				content += "<td>" + item.email + "</td>";
				content += "<td>" + item.reportNo + "</td>";
				content += "<td>" + item.categoryNo + "</td>";
				content += "<td>" + item.reportText + "</td>";
				content += "<td><a href='detail?stx="+stx+"&reportno="+item.reportNo+"'>상세보기</a></td>";
				content += "<td>" + item.email + "</td>";
				content += "<td>" + item.reportDate + "</td>";
				content += "<td><a href='reportAnswer.jsp?email="+item.email+"&reportno="+item.reportNo+"'>답변하기</a></td>";
				content += "<td>" + item.state + "</td>";
				content += "</tr>";
				console.log(list);
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
				url:'reportsearch',
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
			list.forEach(function(item, idx) {
				console.log(item, idx);
				content += "<tr>";
				content += "<td>" + item.email + "</td>";
				content += "<td>" + item.name + "</td>";
				content += "</tr>";
			});
			$("tbody").empty();
			$("tbody").append(content);
			$("div").empty();
		}
	//페이징 처리 함수
		function pageList(list){
			var content = "";
			console.log("페이징처리 함수옴")
				for(i = 1; i<= list.totalPage; i++){
					content += "<span class='page'>";
					if(i != list.currPage){
						console.log(i+stx);
						content += "<button onclick='listCall("+i+",stx);'>"+i+"</button>";
						console.log("리스트콜");
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