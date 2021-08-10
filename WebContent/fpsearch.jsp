<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table,tr,th,td{
		border: 1px solid;
		border-collapse: collapse;
		padding : 10px;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<!-- 상단 메뉴바 -->
<c:import url="./view/topmenu.jsp"/>
	<!-- 내용시작 -->
   <h2 style="text-align: center">검색어 목록</h2>

 <table style="width: 800px; margin-left: auto; margin-right: auto;">
      <tr>
       <th> 번호</th>
      <th> 내용</th>
      <th>해시태그</th>
      </tr>
      <c:if test="${hashtaglist eq null || hashtaglist eq ''}">
       <tr><td colspan="5">해당 데이터가 존재하지 않습니다.</td></tr>
    </c:if>
   
   <c:forEach items="${hashtaglist}" var="hashtag" >
   <tr>
      <%-- <td>${footprint.boardNO}</td> --%>
      <td>${hashtag.footPrintNO}</td>
      <td><a href="fpdetail?footPrintNO=${hashtag.footPrintNO}">${hashtag.footprintText}</a></td>
      <td>${hashtag.hashTag}</td>
   </tr>
   </c:forEach>
   </table>

  <form action="fpsearch" method="post"  enctype="multipart/form-data">  
     
  

  
   
  </form>
</body>


</html>