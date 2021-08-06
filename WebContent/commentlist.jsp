<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="css/common.css" type="text/css">
</head>
<body>

<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
	
     
	
		
   <table>
   <h2>댓글 리스트입니다~~</h2>
      <tr>
       <th>발자국 번호</th>
      <th>댓글 번호</th>
       <th>댓글 내용</th>
      </tr>
      <c:if test="${commentlist eq null || commentlist eq ''}">
       <tr><td colspan="5">해당 데이터가 존재하지 않습니다.</td></tr>
    </c:if>
   
   <c:forEach items="${commentlist}" var="fpcomment" >
   <tr>
      <%-- <td>${footprint.boardNO}</td> --%>
      <td>${commentlist.footPrintNO}</td>
      <td>${commentlist.commentNo}</td>
      <td><a href="fpdetail?footPrintNO=${commentlist.footPrintNO}">${commentlist.connentTest}</a></td>
   </tr>
   </c:forEach>
   </table>
  <div>
  
  <button onclick="location.href='./cmDel'">삭제</button>
  <button onclick="location.href='./fpcomment'">댓글 쓰기</button>
  </div>
   
</body>

</html>

