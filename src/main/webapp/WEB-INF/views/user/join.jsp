<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>스터디허브</title>
	
	<!-- BootStrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<!-- multiselect -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag/dist/css/multi-select-tag.css">
	 <!-- jQuery library -->
	 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<!-- toastr -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" integrity="sha512-3pIirOrwegjM6erE5gPSwkUzO+3cTjpnV9lexlNZqvupR64iZBnOOTiiLPb9M36zpMScbmUNIcHUqKD47M719g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<!-- 부트스트랩 js -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
	<!-- toastr js -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js" integrity="sha512-VEd+nq25CkR676O+pLBnDW09R7VQX9Mdiij052gVCp5yVH3jGtH70Ho/UUv4mJDsEdTvqRCFZg0NKGiojGnUCw==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>	
	<!-- 멀티셀렉트 -->
	<script src="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag/dist/js/multi-select-tag.js"></script>
	
	<!-- css -->
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
		
		.join {
		  width: 100%;
		  max-width: 500px;
		  padding: 15px;
		  margin: auto;
		}
		
		#join{		
   		  text-decoration: none;
   		  color:black;
		}
		
		#join:hover {
   	 		cursor: pointer;
  		}
  		
  		a{
			text-decoration: none;
			color:black;
		}
		
		a:hover{
			color:black;
		}
		
		#google-login{		
			border: rgba(100, 100, 111, 0.2) solid;
			border-width: 1px;
			box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;		
		}
		
		#naver-login{
			background-color:#03C75A; 			
		}
		
		#kakao-login{
			background-color:#FAE100;
		}
		
		.icon{
			margin-right: 30px;
		}
		
		.gicon{
			margin-right: 40px;
		}
		
		/* 아이디 */
		.id_input_re, .id_input_none {
			display : none;
			color: #e06034;
			font-weight : bold;
			font-size:15px;
		}
		
		/* 비밀번호 */
		.pwck_input_re, .pw_input_none {
			display : none;
			color: #e06034;
			font-weight : bold;
			font-size: 15px;
		}
		
		/* 닉네임 */
		.nickname_input_re, .nickname_input_none {
			display : none;
			color: #e06034;
			font-weight : bold;
			font-size:15px;		
		}
		
		/* 이메일 */ 
		.email_input_re {
			display : none;
			color: #e06034;
			font-weight : bold;
			font-size:15px;	
		}
		
		#uploadResult {
			padding: 0px;
		}
		
		.uploadResult {
			width: 100%;
			background-color: sky;
			padding: 0px;
		}
		
		.uploadResult ul {
			display: initial !important;
		}
		
		.uploadResult ul li {
			list-style: none;
		}
		
		#photo {
			border-radius: 50%;
			border: rgba(100, 100, 111, 0.2) solid;
			border-width: 3px;
			box-shadow: rgba(99, 99, 99, 0.2) 0px 2px 8px 0px;
		}
		
		.uploadResult ul li img {
			width: 120px;
			height: 120px;
			padding: 0px;
			
		}	
		
		/* 실제 파일 업로드를 수행하는 버튼입니다. */				
		.form-group.uploadDiv.mb-1 {
		    display: flex; 
		    align-items: center; 
		  }
		  
		.custom-file-input {
		  width: 112px !important;
		  height: 40px !important;
		  font-size: 100px;
		  text-align: right;
		  min-width: 0 !important;
		  outline: none;
		  background: rgb(0, 0, 0);
		  cursor: inherit;
		  display: block !important;
		  border-radius: 5px !important;
		  cursor: pointer;
		  position: absolute;
		  margin: 0 !important;
		  z-index: -1;
		}
	
		.custom-file-input-label {
		  position: absolute;
		  top: 0;
		  left: 0;
		  width: 100%;
		  height: 100%;
		  font-size: 16px;
		  background-color: #ff914d;
		  color: #fff;
		  text-align: center;
		  line-height: 40px;
		  cursor: pointer;
		  z-index: 1;
		}
	
		.custom-file-input-wrapper {
		  position: relative;
		  width: 112px !important;
		  height: 40px !important;
		  border-radius: 5px !important;
		  overflow: hidden;
		  margin-right: 10px;
		  
		}
		
		.custom-file-input-wrapper input[type="file"] {
		  position: absolute;
		  top: 0;
		  right: 0;
		  width: 100%;
		  height: 100%;
		  opacity: 0;
		  cursor: pointer;
		}
	</style>
	
</head>
<!-- end for head -->
<link rel="icon" href="/resources/Images/profileLogo.png">
<body>
	<div class="container text-center join">
	<!-- 부트스트랩 https://getbootstrap.kr/docs/5.2/forms/floating-labels/ -->
	<form class="form-join" action="/user/join" method="post">
	
		
			<!-- 로고 - 메인페이지 연결 -->
			<a href="/board/main">
				<img class="mb-3 rounded mx-auto d-block" src="/resources/Images/norabbitlogo.png" alt="StudyHubLogo" width="320" height=auto>				
			</a>
			<h1 class="h4 mb-3 text-center fw-bold">StudyHub에 오신 것을 환영합니다!</h1>
			
			<!-- 회원가입 정보 입력 -->						
				<div>
				  <input type="text" class="form-control id_input p-3 mt-3" name="uidKey" placeholder="사용자아이디">			  
				</div>
				
				<span class="id_input_none mt-1 text-start">사용자 아이디를 입력 해주세요!</span>
				<span class="id_input_re mt-1 text-start">아이디가 중복 되었어요!</span>
				
				
				<div class="mt-3">
				  <input type="password" class="form-control pw_input p-3 mt-1" name="inputPw" placeholder="비밀번호">
				</div>
				
				<span class="pw_input_none mt-1 text-start">비밀번호를 입력 해주세요!</span>
				
				<div class="mt-3">
				  <input type="password" class="form-control pwck_input p-3" name="inputPwCk" placeholder="비밀번호확인">
				</div>

				<span class="pwck_input_re mt-1 text-start">비밀번호가 일치하지 않아요!</span>
				
				<div class="mt-3">
				  <input type="text" class="form-control nickname_input p-3" name="unickName" placeholder="닉네임">
				</div>
				
				<span class="nickname_input_none mt-1 text-start">닉네임을 입력 해주세요!</span>
				<span class="nickname_input_re mt-1 text-start">닉네임이 중복 되었어요!</span>
				
				<div class="mt-3">
				  <input type="email" class="form-control email_input p-3" name="uemail" placeholder="이메일">
				</div>
				
				<span class="email_input_re mt-1 text-start">올바른 이메일 형식을 입력 해주세요!</span>
				
				<!-- 관심 태그 선택 시작-->
				<div class="mt-4">
					<select name="sno" id="sno" multiple>
						 <option value="1">JavaScript</option>
						 <option value="2">TypeScript</option>
						 <option value="3">React</option>
						 <option value="4">Vue</option>
						 <option value="5">Nodejs</option>
						 <option value="6">Spring</option>
						 <option value="7">Java</option>
						 <option value="8">Nextjs</option>
						 <option value="9">Nestjs</option>
						 <option value="10">Express</option>
						 <option value="11">Go</option>
						 <option value="12">C</option>
						 <option value="13">Python</option>
						 <option value="14">Django</option>
						 <option value="15">Swift</option>
						 <option value="16">Kotlin</option>
						 <option value="17">MySQL</option>
						 <option value="18">MongoDB</option>
						 <option value="19">php</option>
						 <option value="20">GraphQL</option>
						 <option value="21">Firebase</option>
						 <option value="22">ReactNative</option>
						 <option value="23">Unity</option>
						 <option value="24">Flutter</option>
						 <option value="25">AWS</option>
						 <option value="26">Kubernetes</option>
						 <option value="27">Docker</option>
						 <option value="28">Git</option>
						 <option value="29">Figma</option>
						 <option value="30">Zeplin</option>					    
					</select>
					<div>
						<p class="text-start fw-semibold text-muted mt-2">관심 태그를 기반으로 소식을 추천해드려요.</p>
					</div>
				</div> <!-- 관심태그 선택 끝 -->
				
				<!-- 프로필 이미지 선택 -->
				<div class="row">
					<div class="col-6" id="uploadResult">
						<div class='uploadResult'>
							<ul>
								<li class="text-end"><img id="photo" src="/resources/Images/profileLogo.png" width=130 alt="Profile Image"></li>
							</ul>
						</div>	
					</div>
					<div class="col-6 mt-4">
						<div class="form-group uploadDiv mb-1 mt-4">
							<label class="custom-file-input-wrapper" for="customFile">
								<span class="custom-file-input-label">이미지 선택</span> <input
								type="file" class="custom-file-input" id="customFile"
								name='uploadFile'>
							</label>
						</div>
						<div class="photoDelete">
							<button type="button" data-type="image" class="btn d-block"
								id="photoDeleteBtn" style="background-color: #ff914d; color: #fff">이미지 제거</button>
							<i class='fa fa-times'></i>
						</div>
					</div>
				</div> <!-- row 끝 -->
		<!-- 회원가입 완료 버튼 -->
			<div class="d-grid gap-2 mt-4">
				<button type="submit" class="btn btn-primary p-3 fs-6 fw-semibold" style="background-color: #ff914d;  border:none;">회원가입 하기</button>
			</div>
			
		</form> <!-- form 태그 끝 -->
		<hr><!-- 소셜 회원가입 링크 -->					
		   	<div id="google-login">
				<a class="fw-semibold" href ="${ google_url }">
				<span class="gicon">
				<img src="/resources/Images/googleIcon.png" alt="Google Login">
				</span>
				구글 아이디로 회원가입						
				</a>						
			</div>
			<div class="mt-2" id="naver-login">
				<a class="fw-semibold" style="color:#fff" href = "${ naver_url }">
				<span class="icon">
				<img width= 60px height=60px src="/resources/Images/naverIcon.png" alt="Naver Login">
				</span>
				네이버 아이디로 회원가입
				</a>
			</div>
			<div class="mt-2" id="kakao-login">
				<a class="fw-semibold" href ="${ kakao_url }">
				<span class="icon">
				<img src="/resources/Images/kakaoIcon.png" alt="Kakao Login">
				</span>
				카카오 아이디로 회원가입
				</a>
			</div>
		</div>
	<!-- 회원가입 기능 작동을 위한 jquery -->
	<script>
	
	/* 유효성 검사 통과유무 변수 */
	var idCheck = false;            // 아이디
	var idckCheck = false;          // 아이디 중복 검사
	var pwCheck = false;            // 비번
	var pwckcorCheck = false;       // 비번 확인 일치 확인
	var nameCheck = false;          // 닉네임
	var nameckCheck = false;        // 닉네임 중복 검사
	var emailCheck = false;         // 이메일 검사
	var flag=false; //이미지 파일 선택 여부
	
	// 이메일 RFC 5322 형식
	var regex = new RegExp("([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\"\(\[\]!#-[^-~ \t]|(\\[\t -~]))+\")@([!#-'*+/-9=?A-Z^-~-]+(\.[!#-'*+/-9=?A-Z^-~-]+)*|\[[\t -Z^-~]*])");
	
	$(document).ready(function(){
		
		/* 아이디 입력 여부 검사 */
		$('.id_input').focusout(function(){  // 해당 엘리먼트를 벗어나는 경우 이벤트 발생
			
			var id = $('.id_input').val(); // id 입력란
			
			if(id == "") {
				$('.id_input_none').css('display', 'block');
				idCheck = false;
			} else {
				$('.id_input_none').css('display', 'none');
				idCheck = true;
			}
			
		});
		
		/* 아이디 중복검사 */
		$('.id_input').focusout(function(){  // input 변화 실시간 감지
			console.log("keyup 테스트");
			
			var uidKey = $('.id_input').val();	// .id_input에 입력되는 값
			var data = {uidKey : uidKey};		// '컨트롤에 넘길 데이터 이름':'데이터(.id_input에 입력되는 값)'
			
			$.ajax({
				type : "post",
				url : "/user/userIdChk",
				data : data,
				success : function(result){
					console.log("성공 여부" + result);
					if(result != 'fail'){
						$('.id_input_re').css("display", "none");
						idckCheck = true;  // 아이디 중복이 없는 경우
					} else {
						$('.id_input_re').css("display","block");
						idckCheck = false;  // 아이디 중복된 경우
					}
				}
			});
		});
		
		/* 비밀번호 입력 여부 검사 */
		$('.pw_input').focusout(function(){  // 해당 엘리먼트를 벗어나는 경우 이벤트 발생
			
			var pw = $('.pw_input').val(); // 비밀번호 입력란
			
			if(pw == "") {
				$('.pw_input_none').css('display', 'block');
				pwCheck = false;
			} else {
				$('.pw_input_none').css('display', 'none');
				pwCheck = true;
			}
			
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
		
		
		/* 이메일 입력 여부 및 형식 유효성 검사 */
		$('.email_input').focusout(function(){  // 해당 엘리먼트를 벗어나는 경우 이벤트 발생

			var email = $('.email_input').val(); // 이메일 입력란
			
			if(email == "" || !(regex.test(email))) {
				$('.email_input_re').css('display', 'block');
				emailCheck = false;
			} else {
				$('.email_input_re').css('display', 'none');
				emailCheck = true;
			}
			
		});
		
		/* 닉네임 입력 여부 검사 */
		$('.nickname_input').focusout(function(){  // 해당 엘리먼트를 벗어나는 경우 이벤트 발생

			var name = $('.nickname_input').val();            // 닉네임 입력란

			if(name == "") {
				$('.nickname_input_none').css('display', 'block');
				nameCheck = false;
			} else {
				$('.nickname_input_none').css('display', 'none');
				nameCheck = true;
			}
			
		});
		
		/* 닉네임 중복 검사 */
		$('.nickname_input').focusout(function(){  // 해당 엘리먼트를 벗어나는 경우 이벤트 발생
			console.log("keyup 테스트");
			
			var unickName = $('.nickname_input').val();	// .id_input에 입력되는 값
			var data = {unickName : unickName};		// '컨트롤에 넘길 데이터 이름':'데이터(.id_input에 입력되는 값)'
			
			$.ajax({
				type : "post",
				url : "/user/unickNameCheck",
				data : data,
				success : function(result){
					console.log("성공 여부" + result);
					if(result != 'fail'){
						$('.nickname_input_re').css("display", "none");
						nameckCheck = true;  // 닉네임 중복이 없는 경우
					} else {
						$('.nickname_input_re').css("display","block");
						nameckCheck = false;  // 닉네임 중복된 경우
					}
				}
			});

		});
		
	});
	
	//회원가입 버튼(회원가입 기능 작동)
	$("button[type='submit']").on("click", function(e){					
  		
		e.preventDefault();
		
		console.log("submit clicked");
		
		var istr = "";
	    
		/* 선택한 프로필 이미지 form에 저장 */
		if(flag) {		    		      
			var jobj = $(".uploadResult ul li");		      
			      
			istr += "<input type='hidden' name='attach.fileName' value='"+jobj.data("filename")+"'>";
			istr += "<input type='hidden' name='attach.uuid' value='"+jobj.data("uuid")+"'>";
			istr += "<input type='hidden' name='attach.uploadPath' value='"+jobj.data("path")+"'>";
			istr += "<input type='hidden' name='attach.fileType' value='"+ jobj.data("type")+"'>";		      
		 }
		
		$(".form-join").append(istr);
		
		/* 관심 스택 정보 form에 저장 */			
	    var str = "";
	    
		$('#sno option').filter(':selected').each(function(index) {
	    	str += "<input type='hidden' name='snoList["+index+"].sno' value='"+$(this).val()+"'>";	        
	    });
	        
	    $(".form-join").append(str);
	    
	    /* 회원가입 최종 유효성 검사 후 전송 */
	    if(idCheck && idckCheck && pwCheck && pwckcorCheck && nameCheck && nameckCheck && emailCheck){
	    	$(".form-join").submit();
	    } else {
	    	alert("모든 항목을 올바르게 입력해주세요.");
	    }

	});		
  

  /* 파일 크기 확인 함수 */
  function checkExtension(fileName, fileSize){
    
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880; //5MB
	
    if(fileSize >= maxSize){
      alert("파일 사이즈 초과");
      return false;
    }
    
    if(regex.test(fileName)){
      alert("해당 종류의 파일은 업로드할 수 없습니다.");
      return false;
    }
    return true;
  }
  
  /* 파일 선택이 완료되면 발생하는 이벤트 */
  $("input[type='file']").change(function(e){

    var formData = new FormData();
    
    var inputFile = $("input[name='uploadFile']");
    
    console.log(inputFile);
    
    var files = inputFile.prop("files");
    
    if(!checkExtension(files[0].name, files[0].size) ){
        return false;
    }
    
    formData.append("uploadFile", files[0]);
    
    $.ajax({
      url: '/uploadAjaxAction',
      processData: false, 
      contentType: false,
      data: formData,
      type: 'POST',
      dataType:'json',
        success: function(result){
          console.log(result); 
		  showUploadResult(result); //업로드 결과 처리 함수 

      }
    }); //$.ajax
    flag=true;
  });  
  
  function showUploadResult(uploadResult){
	
	/* 업로드된 파일이 없으면 함수를 실행하지 않고 종료 */
	if(uploadResult == null){ return; }
    
	/* 업로드된 파일이 있으면, 스터디허브 이미지 삭제 */
	$(".uploadResult ul li #photo").remove();
	$(".uploadResult ul li").remove();
	
    var uploadUL = $(".uploadResult ul");
    
    var ustr ="";
    
    var deleteBtn = $("#photoDeleteBtn");
    
    var obj = uploadResult;            
		
	if(obj.image){
		var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
		ustr += "<li class='text-end' data-path='"+obj.uploadPath+"'";
		ustr +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
		ustr +" ><div>";
		ustr += "<span></span>";
		ustr += "<img id='photo' src='/display?fileName="+fileCallPath+"' >";
		ustr += "</div>";
		ustr +"</li>";
		deleteBtn.attr("data-file",fileCallPath);
	}		    
    
    uploadUL.append(ustr);	
	
  }
  
/* x 아이콘을 클릭하면 서버에서 삭제 */
  $(".photoDelete").on("click", "button", function(e){
	/* photoDelete 클래스를 가진 요소 내부에서 button 요소를 클릭할 때 이벤트 핸들러 등록 */
	flag=false;
	
    console.log("delete file");
    
	/* 클릭된 삭제 버튼에 설정된 data-file, data-type 속성 값을 읽어 변수에 저장	 */
    var targetFile = $(this).data("file"); 
    var type = $(this).data("type");
    
    /* img 요소를 찾아 변수에 저장    */ 
    var targetLi = $(".uploadResult ul li img");
    
    /* 제이쿼리의 함수를 호출해 ajax 요청을 전송 */
    $.ajax({
      url: '/deleteFile',
      data: {fileName: targetFile, type:type},
      dataType:'text',
      type: 'POST',
        success: function(result){
           
           /* 업로드된 파일이 삭제되면 기본 이미지로 바꾸기 */
           targetLi.attr("src", "/resources/Images/profileLogo.png");
         }
    }); //$.ajax
    
   });

	</script>
	
	<script>
		new MultiSelectTag('sno', {
	        rounded: true,    // default true
	       
	    })
	</script>
	
</body>
</html>