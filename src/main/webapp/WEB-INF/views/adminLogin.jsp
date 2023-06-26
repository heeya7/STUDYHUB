<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- JSTL -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>스터디허브 관리자 로그인</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- css -->
	<style>
	body {
		padding-top: 90px;
		padding-bottom: 40px;
		background-color: white;
	}
	
	.form-login {
		max-width: 400px;
		margin: 0 auto;
	}
	
	.welcome {
		margin-top: 30px;
		margin-bottom: 50px;
	}
	
	.login-warn {
	    text-align: center;
	    color: red;
	    font-size: 15px;
	    font-weight: bold;
	}
	</style>
<!-- jquery -->
<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
</head>
<link rel="icon" href="/resources/Images/profileLogo.png">
<body>
	
	<!-- 부트스트랩 https://getbootstrap.kr/docs/5.2/getting-started/introduction/ -->
	<div class="container">
		<form class="form-login" action="/admin/login" method="post">
			<a href="/board/main">
				<img class="mb-5 rounded mx-auto d-block" src="/resources/Images/SHLogo.png" alt="StudyHybLogo" width="350" height=auto>
			</a>
			<!-- <h3 class="welcome text-center fs-4 fw-bold">StudyHub에 오신 것을 환영합니다!</h3> -->
			
			<input type="text" id="inputId" class="form-control p-3 mt-5" name="adminId" placeholder="관리자아이디"/> 
			<input type="password" id="inputPassword" class="form-control p-3 mt-1" name="adminPw" placeholder="비밀번호"/>

			<div class="form-check mt-3 mb-2">
			  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
			  <label class="form-check-label" for="flexCheckDefault">로그인 상태 유지</label>
			</div>
			
			<c:if test = "${result == 0}">
                <div class = "login-warn">아이디 또는 비밀번호를 잘못 입력하셨습니다.</div>
            </c:if>
			 
			<div class="d-grid gap-2 mt-4">
				<button type="submit" class="btn btn-primary p-3 fw-semibold" style="background-color: #ff914d;  border:none;">관리자 로그인</button>
			</div>
			
			<!-- <div class="text-center mt-4" style="color:#b4b4b4; font-size:15px;">
				<a href="#" class="text-decoration-none" style="color:#3c3c3c; font-weight:semibold">아이디찾기</a><a> | </a>
				<a href="#" class="text-decoration-none" style="color:#3c3c3c;">비밀번호 찾기</a><a> | </a>
				<a href="#" class="text-decoration-none" style="color:#3c3c3c;">회원가입</a>
			</div> -->
			
		</form>
	</div>
	
	<script>
 
	    /* 로그인 버튼 클릭 메서드 */
	    $(".btn-primary").click(function(){	    	
	    	$("#form-login").attr("action", "/admin/login");
	        $("#form-login").submit();
	    });
	    
	</script>
	
    <!-- 부트스트랩 js -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

 </body>
</html>