<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
			<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
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
    <a class="navbar-brand" href="./index.jsp">발자국</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse nav justify-content-end bg-light" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="./index.jsp">홈</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">지도</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">피드</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">발자국</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">메시지</a>
        </li>
        <li class="nav-item dropdown">
          <a class="nav-link" href="#" >
            프로필
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>
<div class="container row ">
<div class="col-4 text-center" style="margin:100 auto;">
	<form action="findE" method="post">
        <table id="login" class="table table-bordered text-center" style="margin-left: auto; margin-right: auto;" >
            <tr>
                <td>이름</td>
                <td><input type="text" name="name" minlength="1" required/></td>
            </tr>
             <tr>
                <td>생년월일</td>
                <td><input  type="text" name="birth"  minlength="8" maxlength="8" placeholder="생년월일 8자로 입력해주세요." required/></td>
            </tr>
            <tr>
                <td colspan="2">
                <button class="btn btn-secondary">찾기</button><!-- onclick="opener.top.location='./main.jsp';self.close();" -->
                </td>
            </tr>
        </table>
        	</form>
        	<c:if test="${suc == true}">
            <div id="redalert"
               class=" alert alert-danger d-flex align-items-center"
               role="alert">
               <div>${info.email }</div>
            </div>
         </c:if>
         <c:if test="${suc == false}">
            <div id="redalert"
               class=" alert alert-danger d-flex align-items-center"
               role="alert">
               <div>이름과 생년월일을 확인해주세요.</div>
            </div>
         </c:if>
	<span class="text-center">
        <a href="./login.jsp">로그인</a><span> | </span> <a>비밀번호 초기화</a><span> | </span><a href="./joinForm.jsp" >회원가입</a>
	</span>
</div>
</div>
</body>
</html>