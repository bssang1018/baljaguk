<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
tabel,tr,th,td{
    border:1px solid;
    border-collapse: collapse;
    padding:10px;
}
</style>

</head>
<body>
	<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
	<form action="fdReport" method="post">
	<table>
	   <tr>
	      <th>신고할 피드 번호</th>
	      <td>
	      ${fpdetail.contentNO}
	      <input type="hidden" name ="contentNO" value ="${fpdetail.contentNO}"/>
	      </td>
	      </tr>
	      <tr>
	        <th>신고할 이메일</th>
	      <td>
	      ${fpdetail.email}
	      <input type="hidden" name ="email" value ="${fpdetail.email}"/>
	      </td>
	      </tr>
	      <tr>
	       <th>피드 신고 사유</th>
	      <td><textarea name ="reportContent"></textarea>
	      </td>
	      </tr>
	    <tr>
	    <td colspan ="2">
	    <button>피드 신고</button>
	    &nbsp;&nbsp;&nbsp;&nbsp;
	    <input type = "button" onclick ="location.href='./feedlist'" value ="피드 리스트"/>
	    </tr>
	</table>
</form>
	
	<script>
	var fdmsg = "${fdmsg}";
	if(fdmsg != ""){
		alert(fdmsg);
	}
</script>
</body>
</html>