<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
	
</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>

<div class="row m-2">
<div class="list-group col-md-2 m-1 text-center" id="noticecenter">
<a class="list-group-item list-group-item-action list-group-item-light" onclick="del()">삭제</a>
<a class="list-group-item list-group-item-action list-group-item-light" href='./msgMain'>이전으로</a>
</div>

<div class="col-6 center-block" style="margin:100 auto;">
	<h3>내가 보낸 메세지</h3>
 <table class="table" style="word-break:break-all; width: 800px;">
		<tr>
			<th class="col-1" style="text-align: center"></th>
			<th class="col-2" style="text-align: center">받는 사람</th>
			<th class="col-6" style="text-align: center">메세지 내용</th>
			<th class="col-2" style="text-align: center">받은날짜</th>
		</tr>

<tbody>
		<c:if test="${empty map.msgList}">
		<tr style="text-align: center"><td colspan="4">온 메세지가 없어요!</td></tr>
		</c:if>
		<c:forEach items="${map.msgList}" var="msges">
			<tr>
				<td style="text-align: center"><input type="checkbox" value='${msges.msgNo}'/></td>
				<td style="text-align: center">${msges.receiver_email}</td>
				<td style="text-align: center; width:550px;"><a style="display: inline-block;
  										width: 200px;
  										white-space: nowrap;
  										overflow: hidden;
   										text-overflow: ellipsis;
  										text-decoration:none"
				href="msgMyMsgDetail?msgNo=${msges.msgNo}">${msges.msgContent}</a></td>
				<td style="text-align: center">${msges.reg_date}</td>
			</tr>
		</c:forEach>
  </tbody>
</table>
	
	<nav aria-label="Page navigation example text-center">
		<ul class="pagination div col-md-3" style="float: none; margin:0 auto;">
				<c:if test="${map.startPage ne 1}">
				<li class="page-item"><a class="page-link" href="./msgMyMsg?page=${map.startPage-1}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>		
				</a></li>
				</c:if>
				<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
				<c:if test="${i ne map.currPage}">
				<li class="page-item"><a class="page-link" href="./msgMyMsg?page=${i}">${i}</a></li>
				</c:if>
				<c:if test="${i eq map.currPage}">
				<li class="page-item active"><a class="page-link" href="./msgMyMsg?page=${i}">${i}</a></li>
				</c:if>
				</c:forEach>
				<c:if test="${map.totalPage ne map.endPage}">
				<li class="page-item"><a class="page-link" href="./msgMyMsg?page=${map.endPage+1}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
				</c:if>
			</ul>
	</nav>
	
</div>
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