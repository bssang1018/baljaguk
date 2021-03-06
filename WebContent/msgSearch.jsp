<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	
<div class="row m-2">
<div class="list-group col-md-2 m-1 text-center" id="noticecenter">
<button class="list-group-item list-group-item-action list-group-item-light" onclick="del()">메세지 삭제</button>
<input class="list-group-item list-group-item-action list-group-item-light" type="button" onclick="location.href='./msgMain'" value="이전으로" />
</div>

<div class="col-6 center-block" style="margin:100 auto;">
<h2>"${searchKey}" 로 검색한 결과...</h2>
 <table class="table">
    <tr>
			<th class="col-1" style="text-align: center"></th>
			<th class="col-2" style="text-align: center">보낸 사람</th>
			<th class="col-5" style="text-align: center">메세지 내용</th>
			<th class="col-2" style="text-align: center">받은날짜</th>
			<th class="col-2" style="text-align: center">읽음 상태</th>
		</tr>
  
		<tbody>
			<c:if test="${empty map.emailList}">
			<tr>
				<td colspan="5"  style="text-align: center"> 검색 결과가 없어요ㅠ </td>
			</tr>
		</c:if>
		
		<c:forEach items="${map.emailList}" var="msges">
			<tr>
				<td style="text-align: center"><input type="checkbox" value='${msges.msgNo}'/></td>
				<td style="text-align: center">${msges.sender_email}</td>
				<td style="text-align: center"><a style="display: inline-block;
  										width: 200px;
  										white-space: nowrap;
  										overflow: hidden;
   										text-overflow: ellipsis;
  										text-decoration:none"
						href="msgDetail?msgNo=${msges.msgNo}">${msges.msgContent}</a></td>
				<td style="text-align: center">${msges.reg_date}</td>
				
				<c:if test="${msges.msgOpen eq  '1'}">
				<td style="text-align: center">읽음</td>	
				</c:if>
				<c:if test="${msges.msgOpen eq  '0'}">
				<td style="text-align: center">읽지 않음</td>
				</c:if>
				
			</tr>
		</c:forEach>	
	</tbody>
</table>	
	
	<nav aria-label="Page navigation example text-center">
		<ul class="pagination div col-md-3" style="float: none; margin:0 auto;">

			<ul class="pagination justify-content-center">
				<c:if test="${map.startPage ne 1}">
				<li class="page-item"><a class="page-link" href="./msgSearch?page=${map.startPage-1}&searchKey=${searchKey}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>		
				</a></li>
				</c:if>
				<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
				<c:if test="${i ne map.currPage}">
				<li class="page-item"><a class="page-link" href="./msgSearch?page=${i}&searchKey=${searchKey}">${i}</a></li>
				</c:if>
				<c:if test="${i eq map.currPage}">
				<li class="page-item active"><a class="page-link" href="./msgSearch?page=${i}&searchKey=${searchKey}">${i}</a></li>
				</c:if>
				</c:forEach>
				<c:if test="${map.totalPage ne map.endPage}">
				<li class="page-item"><a class="page-link" href="./msgSearch?page=${map.endPage+1}&searchKey=${searchKey}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
				</c:if>
			</ul>
	</nav>
	
	<div class="col-md-6 mb-2" style="float: none; margin:0 auto;">
	<form class="d-inline-flex" style="height: 30px;" action="msgSearch" method="post">
				<input class="form-control me-1" type="search" placeholder="이메일을 입력해 주세요" aria-label="Search" name="searchKey" required/>
						<button type="submit" class="btn btn-outline-secondary" style="width: 100px;">검색</button>
			</form>
				</div>
			
</body>

<script>
var msgMsg = "${msgMsg}";
if(msgMsg != ""){
	alert(msgMsg);
}

function del(){
	var $chk =$("input[type='checkbox']:checked");
	if($chk.length>0){
		
		var chkArr = [];
		
		$chk.each(function(msgNo,msges){ // msges 의 msgNo 을 꺼낸다
			chkArr.push($(this).val());
		});
		
		$.ajax({
			type:'get',
			url:'./msgArrDel', //여기로 요청을 보내서~
			data:{'delList':chkArr},
			dataType:'JSON',
			success:function(data){ // 요청을 결과 data 를 성공적으로 받았다면~
				console.log(data);
				if(data.cnt>0){
					alert(data.cnt+'개의 메세지 삭제를 성공했습니다.');
					location.href='./msgMain';
				}else{
					alert('메세지 삭제를 실패 했습니다.');
				}
			},
			error:function(e){
				console.log(e);
			}
		});		
	}else{
		alert("삭제할 메세지를 선택해 주세요~");
	}
}
</script>
</html>