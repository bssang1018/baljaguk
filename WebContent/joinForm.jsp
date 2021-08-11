<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
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
<style type="text/css">
body, head {
	top: 0;
	bottom: 0;
	margin: 0;
	padding: 0;
}
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button {
    -webkit-appearance: none;
    margin: 0;
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
          <a class="nav-link" href="./login.jsp" >
            프로필
          </a>
        </li>
      </ul>
    </div>
  </div>
</nav>
<!-- 내용 시작 -->
<div class="row" >
<div class="col-4"></div>
<div class="col-4 text-center" style="float: none; margin:100 auto;">
<h2 class="mt-2 mb-2">회원가입</h2>
	<form action="join" method="post" >
		<table class="table table-bordered text-center align-middle" >
			<tr>
				<td>EMAIL</td>
				<td class="input-group mb-1"><input type="email" name="email"  id="email" class="form-control" minlength="1" required/>
				<input class="btn btn-outline-secondary" type="button"  name="overlay" id ="overlay" value="중복확인"/></td>
			</tr>
			<tr>
				<td>NICKNAME</td>
				<td><input type="text" name="nickname" minlength="1" required  class="form-control"/></td>
			</tr>
			<tr>
				<td>PW</td>
				<td><input type="password" class="form-control" minlength="6" name="pw" id="pw1" required onchange="check_pw()"/><span id="limit"></span>
					<input type="password" class="form-control mt-1" minlength="6" id="pw2" placeholder="pw를 재입력해주세요" required onchange="check_pw()"/> <span id="check"></span>
				</td>
			</tr>
			<tr>
				<td>NAME</td>
				<td><input type="text" class="form-control" name="name" minlength="1" required/></td>
			</tr>
			<tr>
				<td>GENDER</td>
				<td>
				<input type="radio" name="gender" value="남" checked/>남
				&nbsp;&nbsp;&nbsp;
				<input type="radio" name="gender" value="여"/>여
				</td>
			</tr>
			<tr>
				<td>BIRTH</td>
				<td><input type="text" class="form-control" name="birth"  minlength="8" maxlength="8" placeholder="생년월일 8자로 입력해주세요. ex)19990101" required/>  </td>
			</tr>
			<tr>
				<td>PHONE</td>
				<td><input type="number" class="form-control" name="phone" minlength="11" maxlength="12" placeholder="- 제외 입력해주세요" required/> </td>
			</tr>
			<tr>
				<td>STYLE</td>
				<td>
				<input type="radio" name="style" value="1"  checked/>식도락
				&nbsp;
				<input type="radio" name="style" value="2" />레포츠
				&nbsp;
				<br/>
				<input type="radio" name="style" value="3" />문화
				&nbsp;&nbsp;
				<input type="radio" name="style" value="4" />힐링
				&nbsp;
				<input type="radio" name="style" value="5" />호캉스
				&nbsp;
				</td>
			</tr>
			<tr>
				<td colspan="2">
				<button OnClick = "javascript:GoToEnroll()">회원가입</button>
				</td>
			</tr>
		</table>
	</form>
	</div>
</div>
</body>
<script>
var success = "${success}";
if(success == "true") {
	alert("회원 가입에 성공 했습니다.");
	location.href="index.jsp";
}
if(success == "false") {
	alert("회원 가입에 실패 했습니다.");
}
	
	
	$("#overlay").click(function(){
		console.log("클릭!")
		var email = ($("input[name='email']").val());
		console.log(email)
		$.ajax({
			type:'get',
			url:'overlay',
			data:{'email':email}, //$("input[name='id']").val()이 value
			dataType: 'JSON',
			success:function(data){
				console.log(data);			
				if(!data.success){
					alert("처리중 문제가 발생 했습니다. 다시 시도해주세요.");
				}else{
					if(email==""){
						alert("email을 입력해주세요.")
						$("input[name='email']").val("");
					}else if(data.overlay){
						alert("이미 사용 중 입니다.");
						 $("input[name='email']").val("");//입력한 아이디를 공백으로 만듬
				}else{
						alert("사용 가능합니다.")
					}
				}
			},
			error:function(e){
				console.log(e);
			}
		});
	});
	
	// 이메일이 잘못되었는지 확인하는 함수 

	function CheckEmail(str)
	{                                                 
	     var reg_email = /^([0-9a-zA-Z_\.-]+)@([0-9a-zA-Z_-]+)(\.[0-9a-zA-Z_-]+){1,2}$/;
	     if(!reg_email.test(str)) {                            
	          return false;         
	     }                            
	     else {                       
	          return true;         
	     }                            
	}                                

	function GoToEnroll()                
	{                                          
/* 		var email       = document.getElementById("email"); */
		if (!email.value) {             
			alert("이메일을 입력하세요!");
			obEmail.focus();	
			return;
		}               
		else   {          
			if(!CheckEmail(email.value))	{
				alert("이메일 형식이 잘못되었습니다");
				obEmail.focus();
				return;
			}                
		}                      
	}                           

	function check_pw() {
	      var p1 = document.getElementById('pw1').value;
	      var p2 = document.getElementById('pw2').value;
	      
	      if(p1.length < 6) {
	    	  document.getElementById('limit').innerHTML='6자 이상으로 입력해주세요!';
	          document.getElementById('limit').style.color='red';
	    	  
	    }else{
	    	document.getElementById('limit').innerHTML='6자 이상입니다!';
	    	document.getElementById('limit').style.color='blue';
	    		  if(document.getElementById('pw1').value !='' && document.getElementById('pw2').value!=''){
	    		      if(document.getElementById('pw1').value==document.getElementById('pw2').value){
	    		          document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
	    		          document.getElementById('check').style.color='blue';
	    		      }
	    		      else{
	    		          document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.';
	    		          document.getElementById('check').style.color='red';
	    		      }
	    		  }
	    }
	      }
	
</script>
</html>