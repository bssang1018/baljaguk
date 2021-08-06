<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	table,tr,th,td{
		border: 1px solid;
		border-collapse: collapse;
		padding : 10px;
		text-align: center;
	}
	
	li{
   	   	list-style:none;
   		float: left;
   		margin-left: 10px;
   }
   
</style>
</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
 	
 	
 		<form action="./friendsAddOverlay">
 			<input type="text" name="friends_email" required/>
 			<button>친구 추가</button>
 		</form>
 		
 		<br/>
 		
 		<!-- 
 		<form action="./friendsDel">
 			<input type="text" name="friends_email" />
 			<button>친구 삭제</button>
 		</form>
 		 -->
 		 
 		<table>
 			<tr>
 				<th>친구</th>
 				<th>친구 삭제</th>
 				<th>친구 차단</th>
 				
 			</tr>
 			<c:if test="${empty map.friendsList}">
 				<tr><td colspan="3">친구가 없어요ㅠㅠ</td></tr>
 			</c:if>
 			<c:forEach items="${map.friendsList}" var="friend">
 				<tr>
 					<td>${friend.friends_email}</td>
 					<td><input type="button" onclick="location.href='./friendsDel?friends_email=${friend.friends_email}'" value="삭제"/></td>
 					<td><input type="button" onclick="location.href='./friendsBlock?friends_email=${friend.friends_email}'" value="차단"/></td>
 				</tr>
 			</c:forEach>
 		</table>
 		
 <nav>
			<ul class="pagination">
				<c:if test="${map.startPage ne 1}">
				<li class="page-item"><a class="page-link" href="./friendsList?page=${map.startPage-1}"
					aria-label="Previous"> <span aria-hidden="true">&laquo;</span>		
				</a></li>
				</c:if>
				<c:forEach var="i" begin="${map.startPage}" end="${map.endPage}">
				<c:if test="${i ne map.currPage}">
				<li class="page-item"><a class="page-link" href="./friendsList?page=${i}">${i}</a></li>
				</c:if>
				<c:if test="${i eq map.currPage}">
				<li class="page-item active"><a class="page-link" href="./friendsList?page=${i}">${i}</a></li>
				</c:if>
				</c:forEach>
				<c:if test="${map.totalPage ne map.endPage}">
				<li class="page-item"><a class="page-link" href="./friendsList?page=${map.endPage+1}"
					aria-label="Next"> <span aria-hidden="true">&raquo;</span>
				</a></li>
				</c:if>
			</ul>
</nav>
 		<br/>
		<br/>
		<form action="./friendsBlockList">
 			<button>차단 리스트 보기</button>
 		</form>
 		<!-- 
 		<form action="./friendsBlock">
 			<input type="text" name="friends_email" />
 			<button>친구 차단</button>
 		</form>
 		 -->
 		 
 		 <!-- 
 		<form action="./friendsBlockCancle">
 			<input type="text" name="friends_email" />
 			<button>친구 차단 해제</button>
 		</form>
 		 -->
 		<br/>
 		
 		<!-- 
 		<form action="./friendsRecomend">
 			<button>추천 친구 보기</button>
 		</form>
 		 -->
 		 
 		<br/>
 		
 		<table>
 			<tr>
 				<th>추천 친구</th>
 				<th></th>
 			</tr>
 			<c:if test="${empty recomendList}">
 				<tr><td>여행스타일을 등록해주세요!(또는 새로운 추천친구가 존재하지 않습니다!)</td></tr>
 			</c:if>
 			<c:forEach items="${recomendList}" var="friend">
 				<tr>
 					<td>${friend.email}</td>
 					<td><input type="button" onclick="location.href='./friendsAdd?friends_email=${friend.email}'" value="친구추가"/></td>
 				</tr>
 			</c:forEach>
 		</table>
 		
 		
</body>
<script>
var msgMsg = "${msgMsg}";
if(msgMsg != ""){
	alert(msgMsg);
}

var email = $('#email').val();
if(email.length == 0){
	alert("이메일을 입력해주세요!");
	$('#email').focus();
}



</script>
</html>