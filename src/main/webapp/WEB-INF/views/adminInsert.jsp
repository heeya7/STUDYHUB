<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>스터디허브 관리자 회원가입</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- css -->
<style>
body {
	padding-top: 25px;
	padding-bottom: 40px;
	background-color: white;
}

.form-insert {
	max-width: 420px;
	margin: 0 auto;
}

</style>
</head>
<body>
	
	<!-- 부트스트랩 https://getbootstrap.kr/docs/5.2/forms/floating-labels/ -->
	<div class="container">
		<form class="form-insert">
			
			<img class="mb-3 rounded mx-auto d-block" src="/resources/Images/SHLogo.png" alt="StudyHybLogo" width="350" height=auto>
			
			<!-- <h3 class="text-center fw-semibold">관리자 회원가입</h3> -->
			<div class="form-floating mt-4 mb-3">
			  <input type="text" class="form-control" id="floatingId" placeholder="관리자아이디">
			  <label for="floatingPassword">관리자아이디</label>
			</div>
			<div class="form-floating mb-3">
			  <input type="password" class="form-control" id="floatingPassword" placeholder="비밀번호">
			  <label for="floatingPassword">비밀번호</label>
			</div>
			<div class="form-floating mb-3">
			  <input type="password" class="form-control" id="floatingPassword" placeholder="비밀번호">
			  <label for="floatingPassword">비밀번호 확인</label>
			</div>
			<div class="form-floating mb-3">
			  <input type="text" class="form-control" id="floatingName" placeholder="이룸">
			  <label for="floatingPassword">이름</label>
			</div>
			<div class="form-floating mb-3">
			  <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com">
			  <label for="floatingInput">이메일</label>
			</div>
			<div class="border rounded">
				<label class="p-3">이미지</label>
				<div class="row mb-3">
					<div class="col text-end" id="profile">
						<img class="rounded-circle border border-4" src="/resources/Images/profileLogo.png" width=100 alt="Profile Image" >
					</div>
					<div class="col text-center mt-2">
					  	<div><button class="btn d-block mb-2" style="background-color:#ff914d; color:#fff" type="submit">이미지 선택</button></div>
					  	<div><button class="btn d-block" style="background-color:#ff914d; color:#fff" type="submit">이미지 제거</button></div>
				  	</div>
				</div>  
				<div class="text-center m-3" style="color:#787878; font-size:13px;">미 업로드시 기본 이미지로 자동 설정됩니다.</div>
		  	</div>
		  	

			<div class="d-grid gap-2 mt-4">
				<button type="button" class="btn btn-primary p-3 fw-semibold" style="background-color: #ff914d;  border:none;">회원가입 하기</button>
			</div>
		</form>
	</div>


	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
</body>
</html>