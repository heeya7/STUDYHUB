<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>스터디허브</title>
		
<!-- BootStrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">	          
 <!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- toastr -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<!-- toastr js -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>			
	    <style>
	    html,
		body {
		  height: 100%;
		}
		
		body {
		  display: flex;
		  align-items: center;
		  padding-top: 40px;
		  padding-bottom: 40px;
		  background-color: #ffffff;
		}
		
		.form-signin {
		  width: 100%;
		  max-width: 500px;
		  padding: 15px;
		  margin: auto;
		}
		
		/* 비밀번호 확인 일치하지 않는 경우 */
		.pwck_input_re {
			display : none;
			color: #e06034;
			font-weight : bold;
			font-size: 15px;
		}
		
	    </style>
	    </head>
<link rel="icon" href="/resources/Images/profileLogo.png">	    
<body>
		<!-- 부트스트랩 -->
		<main class="form-signin">  		
	    	<p class="text-center fs-2 fw-bold">비밀번호 변경</p>	    	
			<div class="container text-center mt-4">				
				<form action="/user/resetpwPost" role="form" method="post">
						<!-- 새로운 비밀번호 입력 -->
						<div class="mt-3">
						  <input type="password" class="form-control pw_input p-3 mt-1" name="inputPw" placeholder="비밀번호">
						</div>
						
						<div class="mt-3">
						  <input type="password" class="form-control pwck_input p-3" placeholder="비밀번호확인">
						</div>
						<!-- 비밀번호 일치 확인 -->
						<span class="pwck_input_re mt-1 text-start">비밀번호가 일치하지 않아요!</span>
						<!-- 완료버튼 -->
						<div class="d-grid gap-2 mt-4">
							<button type="submit" class="btn btn-primary p-3 fs-6 fw-semibold" style="background-color: #ff914d;  border:none;">변경하기</button>
						</div>																								    			    
	  			</form>
	  		</div>
		</main>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>	
</body>
<script>
/* 유효성 검사 통과유무 변수 */
var pwCheck = false;            // 비번
var pwckCheck = false;          // 비번 확인
var pwckcorCheck = false;       // 비번 확인 일치 확인

$(document).ready(function(e){	
	var formObj = $("form[role='form']");
	
	var uidKey = "<c:out value="${uidKey}" />";  // 이메일 인증 후 비밀번호 변경 진행중인 uidKey
	
	$("button[type='submit']").on("click", function(e){ //submit 버튼 눌렸을 때
		    
		e.preventDefault();
		
		var pw = $('.pw_input').val();                // 비밀번호 입력란
		var pwck = $('.pwck_input').val();            // 비밀번호 확인 입력란
		
        /* 비밀번호 입력 빈칸 여부 검사 */
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
		
        /* 비밀번호 확인 입력 빈칸 여부 검사 */
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
		
    	if(pwCheck && pwckCheck && pwckcorCheck){
    		formObj.append("<input type='hidden' name='uidKey' value='"+uidKey+"'>");
    		formObj.submit();
    	} else{
    		alert('비밀번호를 올바르게 입력해주세요.');
    	}
    }); //end submit btn

}); //end ready function

</script>
</html>