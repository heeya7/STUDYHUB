<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!doctype html>
<html lang="ko">
	<head>
		<meta charset="utf-8">
		 <meta name="viewport" content="width=device-width, initial-scale=1">
		<title>StudyHub</title>
		 
		<!-- BootStrap -->
    	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	    <!-- multiselect -->
	    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag/dist/css/multi-select-tag.css">
	    <!-- jQuery library -->
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>	    
	    
	    <link rel="stylesheet" href="../../../resources/css/userRegister.css" type="text/css"/>			
    	
	</head>
	<!-- end head -->
<link rel="icon" href="/resources/Images/profileLogo.png">	
	<body>									
		
		<!-- 네비게이션&탭  -->
		<form class="form-signin" role="form" action="/user/join"  method="post">				
			<input type='hidden' name='uidKey' value='<c:out value="${newbie.uidKey}"/>'>
			<input type='hidden' name='usnsType' value='<c:out value="${newbie.usnsType}"/>'>
			<!-- 로고 - 메인페이지 연결 -->
			<a href="/board/main">
				<img class="mb-3 rounded mx-auto d-block" src="/resources/Images/norabbitlogo.png" alt="StudyHubLogo" width="320" height=auto>
			</a>
	    	<h1 class="h4 mb-3 text-center fw-bold">StudyHub에 오신 것을 환영합니다!</h1>
			
			<!-- 입력시작 -->
			<div class="form-group">
			
				<div class="mt-3">
				  <input class="form-control form-control-lg p-3 mb-1" type="text" id="unickName" onchange="checkNickname()" name="unickName" placeholder="닉네임" aria-label=".form-control-lg example">
				  <!-- nickName ajax 체크 -->
				  <p id="checkNickname" class="fw-bold fs-5" style="color:#ff914d"></p>
				</div>												  						  	

				<!-- 관심 스택 선택 -->
				 
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

					<!-- 프로필 이미지 선택 -->
		  			<div class="container text-center">
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
											<span class="custom-file-input-label">이미지 선택</span>
											<input type="file" class="custom-file-input" id="customFile" name='uploadFile'>
										</label>								 
									</div>						
								 <div class="photoDelete">
								 	<button type="button" data-type="image"  class="btn d-block" id="photoDeleteBtn" style="background-color:#ff914d; color:#fff">이미지 제거</button><i class='fa fa-times'></i>
								 </div>
							</div>
						</div>
					</div>
				  	<div class="text-center">		
					  	<button type="submit" class="btn me-2 mt-4" style="background-color:#ff914d; color:#fff">가입완료</button>
						<button type="button" id="back2step" class="btn btn-outline-secondary mt-4">돌아가기</button>
					</div>				 
				  </div>			  							
			
		</form>	
			
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>			
	<script src="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag/dist/js/multi-select-tag.js"></script>
	<script>
	 var flag = false;
	    
	    // 닉네임 빈칸 확인
	    function checkNickNull(){
			var unickName = $('#unickName').val();
	    	
	    	if(unickName == null || unickName.trim() == ''){
	    		$('#checkNickname').css('color','#ff914d');	
	    		$('#checkNickname').html('닉네임을 입력해주세요.');
	    		return false;
	    	} else {
	    		$('#checkNickname').html('');
	    	}
	    	
	    }
	    // 닉네임 중복 확인
	    function checkNickname(){
	    	
	    	var unickName = $('#unickName').val();    	    	
	    	
	    	$.ajax({    		
	    		url: '/user/unickNameCheck',
	    		data: {unickName : unickName},
	    		type: 'POST',
	    		dataType:'text',
	    		success : function(result){
	 						
	    			if(result == 'success'){ // 사용 가능한 아이디
	    				$('#checkNickname').css('color','#ff914d');				
	    				$('#checkNickname').html('사용 가능한 닉네임입니다.'); 			   				
	    			} else { // 이미 존재하는 닉네임
	    				$('#checkNickname').css('color','red');
	    				$('#checkNickname').html('이미 존재하는 닉네임입니다.');  				
	    				
	    				$('#unickName').val('');
	    			} 
	    		},
	    		error:function(request,error){
	    			alert("message:" + request.responseText);
	    		}
	    	}); //$.ajax
	    };
	    
		// 프로필 이미지 선택 관련 함수
		$(document).ready(function(e){
	  
	  	var formObj = $("form[role='form']");
	  
	 	 $("button[type='submit']").on("click", function(e){
	    
		    e.preventDefault();
		    
		 	console.log("submit clicked");	    	 		 	
		 	
		    var str = "";
		     if(flag) {		     		      
			      	var jobj = $(".uploadResult ul li");
			      
				      console.dir(jobj);
				      console.log("-------------------------");
				      console.log(jobj.data("filename"));
				      
				      
				      str += "<input type='hidden' name='attach.fileName' value='"+jobj.data("filename")+"'>";
				      str += "<input type='hidden' name='attach.uuid' value='"+jobj.data("uuid")+"'>";
				      str += "<input type='hidden' name='attach.uploadPath' value='"+jobj.data("path")+"'>";
				      str += "<input type='hidden' name='attach.fileType' value='"+ jobj.data("type")+"'>";		      	   
			 }
		    
		    console.log(str);      		   
		  
		    $('#sno option').filter(':selected').each(function(index) {
		    	str += "<input type='hidden' name='snoList["+index+"].sno' value='"+$(this).val()+"'>";
		    
		    });
		    
		    formObj.append(str).submit();
	  });

	  
	  var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	  var maxSize = 5242880; //5MB
	  
	  function checkExtension(fileName, fileSize){
	    
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
	    
	    var inputFile = $("input[name='uploadFile']"); // JQuery 객체
	    
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
	    
	    var str ="";
	    
	    var deleteBtn = $("#photoDeleteBtn");
	    
	    var obj = uploadResult;       
			
			if(obj.image){
				var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
				str += "<li class='text-end' data-path='"+obj.uploadPath+"'";
				str +=" data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'"
				str +" ><div>";
				str += "<span></span>";
				str += "<img id='photo' src='/display?fileName="+fileCallPath+"' >";
				str += "</div>";
				str +"</li>";
				deleteBtn.attr("data-file",fileCallPath);
			}
	    
	    uploadUL.append(str);		
		
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

	  $("#back2step").click(function() {
	    window.location.href = "/board/main";
	  });
	  
	});
	
	</script>

	<script>
		new MultiSelectTag('sno', {
	        rounded: true,    // default true
	       
	    })
	</script>	
	</body>
</html>