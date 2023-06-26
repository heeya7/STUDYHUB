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
			padding-top: 60px;
			padding-bottom: 40px;
			background-color: white;
		}
		
		.form-join {
			max-width: 410px;
			margin: 0 auto;
		}
		
		/* 중복아이디 존재하는 경우 */
		.id_input_re {
			display : none;
			color: #e06034;
			font-weight : bold;
			font-size:15px;
		}
		
		/* 비밀번호 확인 일치하지 않는 경우 */
		.pwck_input_re {
			display : none;
			color: #e06034;
			font-weight : bold;
			font-size: 15px;
		}
		
	</style>
	<!-- jquery -->
	<script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
	<!-- toastr -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
</head>
<link rel="icon" href="/resources/Images/profileLogo.png">
<body>
	
	<!-- 부트스트랩 https://getbootstrap.kr/docs/5.2/forms/floating-labels/ -->
	<div class="container">
		<form class="form-join" method="post">
			<!-- 로고 - 메인페이지 연결 -->
			<a href="/board/main">
				<img class="mb-5 rounded mx-auto d-block" src="/resources/Images/norabbitlogo.png" alt="StudyHubLogo" width="320" height=auto>
			</a>
			
			<!-- 회원가입 정보 입력 -->
			<div class="form-floating mt-5">
			  <input type="text" class="form-control id_input" name="adminId" id="floatingId" placeholder="관리자아이디">
			  <label for="floatingPassword">관리자아이디</label>
			</div>
			
			<span class="id_input_re mt-1">아이디가 중복 되었어요!</span>
			
			<div class="form-floating mt-3">
			  <input type="password" class="form-control pw_input" name="adminPw" id="floatingPassword" placeholder="비밀번호">
			  <label for="floatingPassword">비밀번호</label>
			</div>
			
			<div class="form-floating mt-3">
			  <input type="password" class="form-control pwck_input" id="floatingPassword" placeholder="비밀번호">
			  <label for="floatingPassword">비밀번호 확인</label>
			</div>
			
			<span class="pwck_input_re mt-1">비밀번호가 일치하지 않아요!</span>
			
			<div class="form-floating mt-3">
			  <input type="text" class="form-control name_input" name="aname" id="floatingName" placeholder="이룸">
			  <label for="floatingPassword">이름</label>
			</div>
			
			<div class="form-floating mt-3">
			  <input type="email" class="form-control email_input" name="email" id="floatingInput" placeholder="name@example.com">
			  <label for="floatingInput">이메일</label>
			</div>

			<div class="d-grid gap-2 mt-4">
				<button type="submit" class="btn btn-primary p-3 fs-6 fw-semibold" style="background-color: #ff914d;  border:none;">회원가입 하기</button>
			</div>
			
		</form>
	</div>

	<!-- 회원가입 기능 작동을 위한 jquery -->
	<script>
	
	/* 유효성 검사 통과유무 변수 */
	var idCheck = false;            // 아이디
	var idckCheck = false;          // 아이디 중복 검사
	var pwCheck = false;            // 비번
	var pwckCheck = false;          // 비번 확인
	var pwckcorCheck = false;       // 비번 확인 일치 확인
	var nameCheck = false;          // 이름
	var emailCheck = false;         // 이메일
	 
	$(document).ready(function(){
		//회원가입 버튼(회원가입 기능 작동)
		$(".btn-primary").click(function(){
			
			/* 입력값 변수 */
			var id = $('.id_input').val();                // id 입력란
			var pw = $('.pw_input').val();                // 비밀번호 입력란
			var pwck = $('.pwck_input').val();            // 비밀번호 확인 입력란
			var name = $('.name_input').val();            // 이름 입력란
			var email = $('.email_input').val();           // 이메일 입력란
			
			/* 이메일 유효성 검사 */
	        if(email == ""){
	        	toastr.options = {
	        			closeButton: true,
		    			"progressBar": true,
		    			"timeOut": 4000
		    			};
	        	toastr.warning('이메일을 입력해 주세요!');
	            emailCheck = false;
	        }else{
	            emailCheck = true;
	        }
			
	        /* 이름 유효성 검사 */
	        if(name == ""){
	        	toastr.options = {
	        			closeButton: true,
		    			"progressBar": true,
			    		"timeOut": 4000
			    		};
	        	toastr.warning('이름을 입력해 주세요!');
	            nameCheck = false;
	        }else{
	            nameCheck = true;
	        }
	        
	        /* 비밀번호 확인 유효성 검사 */
	        if(pwck == ""){
	        	toastr.options = {
	        			closeButton: true,
		    			"progressBar": true,
		    			"timeOut": 4000
		    			};
	        	toastr.warning('비밀번호 확인을 입력해 주세요!');
	            pwckCheck = false;
	        }else{
	            pwckCheck = true;
	        }
			
	        /* 비밀번호 유효성 검사 */
	        if(pw == ""){
	        	toastr.options = {
	        			closeButton: true,
		    			"progressBar": true,
		    			"timeOut": 4000
		    			};
	        	toastr.warning('비밀번호를 입력해 주세요!');
	            pwCheck = false;
	        }else{
	            pwCheck = true;
	        }
	        
	        /* 아이디 유효성검사 */
	        if(id == ""){
	        	toastr.options = {
	        			closeButton: true,
		    			"progressBar": true,
		    			"timeOut": 4000
		    			};
	        	toastr.warning('관리자아이디를 입력해 주세요!');
	            idCheck = false;
	        }else{
	            idCheck = true;
	        }
 
	        /* 최종 유효성 검사 */
	        if (idCheck && idckCheck && pwCheck && pwckCheck && pwckcorCheck && nameCheck && emailCheck) {
	            $("#form-join").attr("action", "/admin/createAccount");
	            $("#form-join").submit();
	        } else {
	        	return false;
	        }
		});
	});
	
	/* 아이디 중복검사 */
	$('.id_input').on("propertychange change keyup paste input", function(){  // input 변화 실시간 감지
		console.log("keyup 테스트");
		
		var adminId = $('.id_input').val();	// .id_input에 입력되는 값
		var data = {adminId : adminId};		// '컨트롤에 넘길 데이터 이름':'데이터(.id_input에 입력되는 값)'
		
		$.ajax({
			type : "post",
			url : "/admin/adminIdChk",
			data : data,
			success : function(result){
				console.log("성공 여부" + result);
				if(result != 'fail'){
					$('.id_input_re').css("display", "none");
					idckCheck = true;  // 아이디 중복이 없는 경우
				} else {
					$('.id_input_re').css("display","inline-block");
					idckCheck = false;  // 아이디 중복된 경우
				}
			}
		});
	});
	
	/* 비밀번호 확인 일치 검사 */
	$('.pwck_input').focusout(function(){  // 해당 엘리먼트를 벗어나는 경우 이벤트 발생
		
		var pw = $('.pw_input').val();
		var pwck = $('.pwck_input').val();
		
		if(pw == pwck){
			$('.pwck_input_re').css('display','none');
			pwckcorCheck = true;
		}else{
			$('.pwck_input_re').css('display','block');
			pwckcorCheck = false;
		}
		
	});
	
	</script>
	
	<!-- 부트스트랩 js -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>

	<!-- toastr js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

</body>
</html>