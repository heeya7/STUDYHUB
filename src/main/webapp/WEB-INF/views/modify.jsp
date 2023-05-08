<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		
<!-- BootStrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">	          
<!-- multi-select(관심기술태그) -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag/dist/css/multi-select-tag.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- custom css -->
<link rel="stylesheet" href="/resources/css/main.css" type="text/css" />
<script>
	var uidkey;
</script>

<title>스터디허브</title>
	<style>
		.navbar_navbar {
			margin: auto;
			max-width: 1180px;
			display: flex;
			justify-content: space-between;
			align-items: center;
			height: 85px;
			padding: 0 10px;
		}
		
		.navbar_logo {
			width: 105px;
			height: 32px;
		}
		
		.navbar_loginElementWrapper {
			display: flex;
			grid-gap: 30px;
			gap: 30px;
			align-items: center;
		}
		
		.navbar_login, .navbar_postRegister {
			font-weight: 600;
			font-size: 1.125rem;
		}
		
		button {
			outline: none;
			border: none;
			background-color: #fff;
			cursor: pointer;
		}
		
		.notice_notificationWrapper {
			position: relative;
			cursor: pointer;
		}
		
		.notice_imageWrapper {
			position: relative;
		}
		
		.notice_notification {
			display: block;
		}
		
		.loginUser_userWrapper {
			cursor: pointer;
			display: flex;
			align-items: center;
			position: relative;
		}
		
		.loginUser_userImg {
			display: block;
			height: 2.5rem;
			width: 2.5rem;
			border-radius: 50%;
			object-fit: cover;
			transition: all .125s ease-in 0s;
		}
		
		.postRegister_postWrapper {
			max-width: 1040px;
			display: flex;
			flex-direction: column;
			padding: 60px 16px;
			width: 1024px;
			margin: 0 auto;
			color: #333;
			grid-gap: 50px;
			gap: 50px;
			position: relative;
		}
		
		.postRegister_postContentWrapper {
			display: flex;
			align-items: center;
			padding: 16px;
			margin-bottom: 36px;
			border-bottom: 3px solid #f2f2f2;
		}
		
		.postRegister_sequence {
			margin-right: 8px;
			width: 28px;
			height: 28px;
			display: flex;
			justify-content: center;
			align-items: center;
			border-radius: 50%;
			background: #ff914d;
			font-size: 16px;
			font-weight: 700;
			line-height: 19px;
			color: #fff;
		}
		
		.postRegister_text {
			font-weight: 700;
			font-size: 24px;
			line-height: 40px;
			letter-spacing: -.05em;
			margin: 0;
		}
		
		.postinfo_inputList {
			margin-top: 40px;
			display: flex;
			grid-gap: 15px;
			gap: 15px;
			list-style: none;
		}
		
		.postinfo_listItem {
			flex: 1 1;
		}
		
		li {
			padding: 0;
		}
		
		li, p {
			margin: 0;
		}
		
		.selectbox_labelText {
			display: inline-block;
			margin-bottom: 5px;
			color: #333;
			font-weight: 500;
		}
		
		.css-2b097c-container {
			position: relative;
			box-sizing: border-box;
		}
		
		.css-7pg0cj-a11yText {
			z-index: 9999;
			border: 0px;
			clip: rect(1px, 1px, 1px, 1px);
			height: 1px;
			width: 1px;
			position: absolute;
			overflow: hidden;
			padding: 0px;
			white-space: nowrap;
		}
		
		.css-1iewm1a-control {
			-webkit-box-align: center;
			align-items: center;
			background-color: rgb(255, 255, 255);
			border-color: rgb(204, 204, 204);
			border-radius: 4px;
			border-style: solid;
			border-width: 1px;
			cursor: default;
			display: flex;
			flex-wrap: wrap;
			-webkit-box-pack: justify;
			justify-content: space-between;
			min-height: 56px;
			position: relative;
			transition: all 100ms ease 0s;
			box-sizing: border-box;
			width: 100%;
			outline: 0px !important;
		}
		
		.css-1hwfws3 {
			-webkit-box-align: center;
			align-items: center;
			display: flex;
			flex: 1 1 0%;
			flex-wrap: wrap;
			padding: 2px 8px;
			position: relative;
			overflow: hidden;
			box-sizing: border-box;
		}
		
		.css-1wa3eu0-placeholder {
			color: rgb(128, 128, 128);
			margin-left: 2px;
			margin-right: 2px;
			position: absolute;
			top: 50%;
			transform: translateY(-50%);
			box-sizing: border-box;
		}
		
		.css-1g6gooi {
			margin: 2px;
			padding-bottom: 2px;
			padding-top: 2px;
			visibility: visible;
			color: rgb(51, 51, 51);
			box-sizing: border-box;
		}
		
		.css-1iewm1a-control {
			-webkit-box-align: center;
			align-items: center;
			background-color: rgb(255, 255, 255);
			border-color: rgb(204, 204, 204);
			border-radius: 4px;
			border-style: solid;
			border-width: 1px;
			cursor: default;
			display: flex;
			flex-wrap: wrap;
			-webkit-box-pack: justify;
			justify-content: space-between;
			min-height: 56px;
			position: relative;
			transition: all 100ms ease 0s;
			box-sizing: border-box;
			width: 100%;
			outline: 0px !important;
		}
		
		ul {
			list-style: none;
			margin: 0;
			padding: 0;
		}
		
		label {
			cursor: default;
		}
		
		.form-select {
			background-image:
				url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16'%3e%3cpath fill='none' stroke='%232596be' stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='m2 5 6 6 6-6'/%3e%3c/svg%3e");
			color: rgb(0, 0, 0);
		}
		
		.css-hdw1oc {
			float: unset;
			overflow: hidden;
			padding: 0px;
			line-height: 11px;
			transition: width 150ms cubic-bezier(0, 0, 0.2, 1) 0ms;
		}
		
		.css-igs3ac {
			text-align: left;
			position: absolute;
			inset: -5px 0px 0px;
			margin: 0px;
			padding: 0px 8px;
			pointer-events: none;
			border-radius: inherit;
			border-style: solid;
			border-width: 1px;
			overflow: hidden;
			min-width: 0%;
			border-color: rgba(0, 0, 0, 0.23);
		}
		
		.postRegister_postWrapper {
			max-width: 1040px;
			display: flex;
			flex-direction: column;
			padding: 60px 16px;
			width: 1024px;
			margin: 0 auto;
			color: #333;
			grid-gap: 50px;
			gap: 50px;
			position: relative;
		}
		
		.writebutton_buttons {
			display: flex;
			justify-content: flex-end;
			align-items: center;
			margin-top: 1rem;
		}
		
		.writebutton_cancelButton, .writebutton_registerButton {
			cursor: pointer;
			outline: none;
			border: none;
			border-radius: 4px;
			padding: 0 1.25rem;
			height: 2rem;
			font-size: 1rem;
		}
		
		.writebutton_cancelButton {
			background: #e9ecef;
			color: #495057;
			margin-right: 1rem;
		}
		
		button {
			outline: none;
			border: none;
			background-color: #fff;
			cursor: pointer;
		}
		
		.writebutton_registerButton {
			font-weight: 700;
			background-color: #ff914d;
			color: #fff;
		}
		
		.css-12jo7m5 {
			border-radius: 2px;
			color: rgb(51, 51, 51);
			font-size: 85%;
			overflow: hidden;
			padding: 3px 3px 3px 6px;
			text-overflow: ellipsis;
			white-space: nowrap;
			box-sizing: border-box;
		}
		
		.css-xb97g8 {
			-webkit-box-align: center;
			align-items: center;
			border-radius: 2px;
			display: flex;
			padding-left: 4px;
			padding-right: 4px;
			box-sizing: border-box;
		}
		</style>

</head>
<link rel="icon" href="/resources/Images/profileLogo.png">
<body>
	<!--헤더-->
	<!--  nav 태그 -->
	<%@include file="../includes/header.jsp"%>
	<!--헤더 끝-->

	<!-- 본문 바디시작 -->
	<div class="postRegister_postWrapper">
		<section>
			<div class="postRegister_postContentWrapper">
				<span class="postRegister_sequence">1</span>
				<h2 class="postRegister_text">스터디 기본 정보를 입력해주세요.</h2>
			</div>

			<form role="form" action="/board/modify" method="post">		
			<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum}"/>'>			
			<input type='hidden' name='amount' value='<c:out value="${cri.amount}"/>'>
			<input type='hidden' name='type' value='<c:out value="${cri.type}"/>'>
			<input	type='hidden' name='keyword' value='<c:out value="${cri.keyword}"/>'>
				<ul class="postinfo_inputList">
					<li class="postinfo_listItem"><label
						class="selectbox_labelText" for="onoffline">모집 인원</label>
						<div class=" css-2b097c-container">
							<span aria-live="polite" aria-atomic="false"
								aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
							<select class="css-1iewm1a-control" name="memberNum" id=memberNum>
								<option value="members choice">선택하세요</option>
								<option value="1명">1명</option>
								<option value="2명">2명</option>
								<option value="3명">3명</option>
								<option value="4명">4명</option>
								<option value="5명">5명</option>
								<option value="6명">6명</option>
								<option value="7명">7명</option>
								<option value="8명">8명</option>
								<option value="9명">9명</option>
								<option value="10명 이상">10명이상</option>
							</select>
						</div></li>

					<li class="postinfo_listItem"><label
						class="selectbox_labelText" for="onoffline">진행 방식</label>
						<div class=" css-2b097c-container">
							<span aria-live="polite" aria-atomic="false"
								aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
							<select class="css-1iewm1a-control" name="meet" id="meet">
								<option value="way choice">선택하세요</option>
								<option value="온라인">온라인</option>
								<option value="오프라인">오프라인</option>
							</select>
						</div></li>
				</ul>
				<ul class="postinfo_inputList">
				
				
				
					<li class="postinfo_listItem"><label
						class="selectbox_labelText" for="onoffline">모집 포지션</label>
						<div class=" css-2b097c-container">
							<span aria-live="polite" aria-atomic="false"
								aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
							<select name="fnames" id="fnames" multiple>
								<option id="1" value="전체">전체</option>
								<option id="2" value="디자이너">디자이너</option>
								<option id="3" value="프론트엔드">프론트엔드</option>
								<option id="4" value="백엔드">백엔드</option>
								<option id="5" value="ios">IOS</option>
								<option id="6" value="안드로이드">안드로이드</option>
								<option id="7" value="데브옵스">데브옵스</option>
								<option id="8" value="pm">PM</option>
								
							</select>
						</div>
					</li>

					<li class="postinfo_listItem"><label
						class="selectbox_labelText" for="onoffline">기술 스택</label>
						<div class=" css-2b097c-container">
							<span aria-live="polite" aria-atomic="false"
								aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
							<select name="snames" id="snames" multiple>
								<option id="1" value="javascript">JavaScript</option>
								<option id="2" value="typescript">TypeScript</option>
								<option id="3" value="vue">Vue</option>
								<option id="4" value="nodejs">Nodejs</option>
								<option id="5" value="spring">Spring</option>
								<option id="6" value="java">Java</option>
								<option id="7" value="nextjs">Nextjs</option>
								<option id="8" value="nexsjs">Nexsjs</option>
								<option id="9" value="express">Express</option>
								<option id="10" value="go">Go</option>
								<option id="11" value="c">C</option>
								<option id="12" value="python">Python</option>
								<option id="13" value="django">Django</option>
								<option id="14" value="swift">Swift</option>
								<option id="15" value="mysql">MySQL</option>
								<option id="16" value="kotlin">Kotlin</option>
								<option id="17" value="mongodb">MongoDB</option>
								<option id="18" value="php">php</option>
								<option id="19" value="graphql">GraphQL</option>
								<option id="20" value="firebase">Firebase</option>
								<option id="21" value="reactNative">ReactNative</option>
								<option id="22" value="unity">Unity</option>
								<option id="23" value="figma">Figma</option>
								<option id="24" value="flutter">Flutter</option>
								<option id="25" value="aws">AWS</option>
								<option id="26" value="kubernetes">Kubernetes</option>
								<option id="27" value="docker">Docker</option>
								<option id="28" value="git">Git</option>
								<option id="29" value="zeplin">Zeplin</option>
							</select>
						</div>
					</li>
				</ul>

				<ul class="postinfo_inputList">
					<li class="postinfo_listItem"><label
						class="selectbox_labelText" for="onoffline">마감일</label>
						<div class=" css-2b097c-container">
							<span aria-live="polite" aria-atomic="false"
								aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
							<input type="date" name="deadline" class="css-1iewm1a-control"
								id="deadline">
						</div>
					</li>
					
					<li class="postinfo_listItem"><label
						class="selectbox_labelText" for="onoffline">진행 기간</label>
						<div class=" css-2b097c-container">
							<span aria-live="polite" aria-atomic="false"
								aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
							<select class="css-1iewm1a-control" name="period" id="period">
								<option value="기간미정">기간미정</option>
								<option value="1개월">1개월</option>
								<option value="2개월">2개월</option>
								<option value="3개월">3개월</option>
								<option value="4개월">4개월</option>
								<option value="5개월">5개월</option>
								<option value="6개월">6개월</option>
								<option value="장기">장기</option>
							</select>
						</div></li>
				</ul>

				<ul class="postinfo_inputList">
					<li class="postinfo_listItem"><label
						class="selectbox_labelText" for="onoffline">연락 방법</label>
						<div class=" css-2b097c-container">
							<span aria-live="polite" aria-atomic="false"
								aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
							<select class="css-1iewm1a-control" id="contact" name="contact">
								<option value="call choice">선택하세요</option>
								<option value="kakao">카카오톡 오픈채팅</option>
								<option value="google">구글폼</option>
								<option value="email">이메일</option>
							</select> <input type="text" class="css-1iewm1a-control"
								name="contactaddress" id="contactaddress" placeholder="링크 주소를 입력해주세요">
						</div>
					</li>
					<li class="postinfo_listItem"></li>
				</ul>


				<br>
				<div class="postRegister_postContentWrapper">
					<span class="postRegister_sequence">2</span>
					<h2 class="postRegister_text">스터디에 대해 소개해주세요.</h2>
				</div>

				<!-- /.row -->
				<div class="row">
					<div class="col-lg-12">
						<div class="panel panel-default">
							<div class="panel-heading"></div>

							<!-- /.panel-heading -->
							<div class="panel-body">

								<div class="form-group">
									<label>제목</label> <input class="form-control" id="title" name='title'>
								</div>
								<br>
								<div class="form-group">
									<label>프로젝트 내용</label>
									<textarea class="form-control" rows="15" id="content" name='content'><c:out value="${board.content}" /></textarea>
								</div>
								<section class="writebutton_buttons">
									<button type="submit" data-oper='reset' class="writebutton_cancelButton">취소</button>
									<button type="submit" data-oper='modify' class="writebutton_registerButton">수정완료</button>
								</section>
							</div>
							<!-- /.panel-body -->
						</div>
						<!-- /.panel -->
					</div>
				</div>
			</form>
		</section>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
		crossorigin="anonymous">
	</script>
	<!-- 관심 기술 태그용 -->
	<script src="https://cdn.jsdelivr.net/gh/habibmhamadi/multi-select-tag/dist/js/multi-select-tag.js"></script>
	<script src="../../../resources/js/userRegister.js"></script>	
<script>
	$(document).ready(function() {
		
		// jsh <nav> 태그 사용자 이미지 불러오기
		(function(){
			
			var uidKey = '<c:out value="${ loginUser.uidKey }"/>';
			console.log(uidKey);
			var targetA = $("#dropImage");
			
			$.getJSON("/user/getAttach", {uidKey:uidKey}, function(attach){
				console.log(attach);
				if(attach == null){				
					 targetA.html("<img width='30px' height='30px' style='border-radius: 50%' src='/resources/Images/profileLogo.png'>");
				} else {
						var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
						targetA.html("<img width='40px' height='40px' style='border-radius: 50%' width='40px' src='/display?fileName="+fileCallPath+"'>");
				}			 
			}); //end getjson
		});
		
		/* 초기값 변수에 담기 */
		var memberNum = "<c:out value="${board.memberNum}"/>"; //모집인원
		var meet = "<c:out value="${board.meet}"/>"; // 진행방식	
		var deadline = "<c:out value="${board.deadline}"/>"; //마감일
		var period = "<c:out value="${board.period}" />"; //진행(예상)기간
		var contact = "<c:out value="${board.contact}"/>"; //연락 방법
		var contactaddress ="<c:out value="${board.contactaddress}"/>"; //연락 방법주소
		var title = "<c:out value="${board.title}" />"; //제목
		
		// 사용 언어
		var snames = "<c:out value="${board.snames}" />"; // board.snames 변수의 값
		var snamesArr = snames.split(","); // ,를 구분자로 나눈 배열 생성
		console.log(snamesArr);
		// 모집 분야
		var fnames = "<c:out value="${board.fnames}" />"; // board.fnames 변수의 값
		var fnamesArr = fnames.split(","); // ,를 구분자로 나눈 배열 생성
		
		
		/* 초기화 */
		$("#memberNum").val(memberNum); // 모집인원 초기화		
		$("#meet").val(meet);// 진행방식 초기화
		// 모집분야 초기화
		$("#fnames").val(meet);
		(function(){					
			console.log(fnamesArr);
				
			$(fnamesArr).each(function(i, fname){					
				console.log(fname);
				var n = $("option[value='"+fname+"']").attr("id"); //인덱스(option 태그의 id)
				var label = $("#fnames option[value='"+fname+"']").text();
				
				var target = $("#fnames"); // <select> 선택자
				
				$("#fnames option[value='"+fname+"']").remove();
				
				target.children().eq(n-1).before("<option id='"+n+"' value='"+fname+"' selected>"+label+"</option>");
			
			});
			
			new MultiSelectTag('fnames', {
				rounded : true, // default true

			})
			
		})(); // end 기술 스택 function
		
		// 기술스택 초기화
		(function(){					
				console.log(snamesArr);
					
				$(snamesArr).each(function(i, sname){					
					console.log(sname);
					var n = $("option[value='"+sname+"']").attr("id"); //인덱스(option 태그의 id)
					var label = $("#snames option[value='"+sname+"']").text();
					
					var target = $("#snames"); // <select> 선택자
					
					$("#snames option[value='"+sname+"']").remove();
					
					target.children().eq(n-1).before("<option id='"+n+"' value='"+sname+"' selected>"+label+"</option>");
				
				});
				
				new MultiSelectTag('snames', {
					rounded : true, // default true

				})
				
		})(); // end 기술 스택 function	
		
		$("#deadline").val(deadline); // 마감일 초기화
		$("#period").val(period); // 진행기간 초기화
		$("#contact").val(contact);// 연락방법 초기화
		$("#contactaddress").val(contactaddress); // 연락방법 주소초기화
		$("#title").val(title);// 제목 초기화
		
		/* (페이징 정보 넘어오는지 cri 확인) */
		var pn = '<c:out value="${cri.pageNum}"/>';
		console.log(pn);
		
		/* 글 수정한 것 form 보내기 */
		var formObj = $("form[role='form']");
		var bno = "<c:out value="${board.bno}" />";  //게시물 BNO
		
		$("button[type='submit']").on("click", function(e){ //submit 버튼 눌렸을 때
			    
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log("submit clicked");       
			console.log(operation);
			if(operation === 'reset'){
				formObj.attr("action", "/board/get").attr("method", "get");
			} else if(operation === 'modify'){
				// 제목 빈칸인지 확인
				var titleck = $('#title').val();
				if(titleck == null || titleck.trim() == ''){
					alert('제목을 입력해주세요.');
					return;
				}
			}
			
		
		/* 페이징 정보 */
		var pageNumTag = $("input[name='pageNum']").clone();
		var amountTag = $("input[name='amount']").clone();
		var keywordTag = $("input[name='keyword']").clone();
		var typeTag = $("input[name='type']").clone();
		
		formObj.append(pageNumTag);
		formObj.append(amountTag);
		formObj.append(keywordTag);
		formObj.append(typeTag);
		/* 페이징 정보 담기 끝 */
		
		formObj.append("<input type='hidden' name='bno' value='"+bno+"'>");
		formObj.submit();
		
		}); //submit 버튼 눌렸을 때	
		
	}); // end ready
	
	
</script>
<script>
	//uidkey.push('${board.uidkey}');
</script>
</body>
</html>
