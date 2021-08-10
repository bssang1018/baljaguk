<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
   <h2 style="text-align: center">발자국 남기기</h2>

 <form action="fpwriteOk" method="post"  enctype="multipart/form-data">
    
 <table style="width: 800px; margin-left: auto; margin-right: auto;">
     
  <!--   <tr>
      <th>발자국 번호</th>
      <td><input type="hidden" name="footPrintNO"></td>
   </tr>
     
   <tr>
      <th>마커번호</th>
      <td><input type="hidden" name="markerNO"></td>
   </tr>
     -->
   <tr>
      <th>발자국 내용</th>
      <td><textarea name="footprintText"></textarea></td>
   </tr>
   <tr>
       <th>사진</th>
       <td><input type="file" name="PostPic"/></td>
   </tr>
   <tr>
       <tr>
       <th>해시태그</th>
       <td><input type="text" name="hashtag"/></td>
   </tr>
   <tr>
      <td colspan="2">
      
       <input type="radio" name="ok" value="1"/>발자국 공개
       &nbsp;&nbsp;
      <input type="radio" name="ok" value="0" checked/>발자국 비공개
      <br/>
      <input type='submit' value='저장'/>
      <input type="button" onclick="location.href= 'fplist'" value="발자국 리스트"/>
      <input type="button" onclick="location.href= 'feedlist'" value="피드 리스트"/>
     </td>
   </tr>
   </table>
  </form>
</body>


</html>