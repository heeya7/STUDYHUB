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

		<link rel="stylesheet" href="/resources/css/main.css" type="text/css" />
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
			background:#e9ecef;
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

	<!--본문 바디시작-->
	<div class="postRegister_postWrapper">
		<section>
			<div class="postRegister_postContentWrapper">
				<span class="postRegister_sequence">1</span>
				<h2 class="postRegister_text">스터디 기본 정보를 입력해주세요.</h2>
			</div>

			<form role="form" action="/board/register" method="post">
				<ul class="postinfo_inputList">
					<li class="postinfo_listItem"><label
						class="selectbox_labelText" for="onoffline">모집 인원</label>
						<div class=" css-2b097c-container">
							<span aria-live="polite" aria-atomic="false"
								aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
							<select class="css-1iewm1a-control" name="memberNum" id=memberNum>
								<option value="members choice">선택하세요</option>
								<option value="인원미정">인원미정</option>
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
								<option value="전체">전체</option>
								<option value="디자이너">디자이너</option>
								<option value="프론트엔드">프론트엔드</option>
								<option value="백엔드">백엔드</option>
								<option value="ios">IOS</option>
								<option value="안드로이드">안드로이드</option>
								<option value="데브옵스">데브옵스</option>
								<option value="pm">PM</option>
								
							</select>
						</div>
					</li>

					<li class="postinfo_listItem"><label
						class="selectbox_labelText" for="onoffline">기술 스택</label>
						<div class=" css-2b097c-container">
							<span aria-live="polite" aria-atomic="false"
								aria-relevant="additions text" class="css-7pg0cj-a11yText"></span>
							<select name="snames" id="snames" multiple>
								<option value="javascript">JavaScript</option>
								<option value="typescript">TypeScript</option>
								<option value="vue">Vue</option>
								<option value="nodejs">Nodejs</option>
								<option value="spring">Spring</option>
								<option value="java">Java</option>
								<option value="nextjs">Nextjs</option>
								<option value="nexsjs">Nexsjs</option>
								<option value="express">Express</option>
								<option value="go">Go</option>
								<option value="c">C</option>
								<option value="python">Python</option>
								<option value="django">Django</option>
								<option value="swift">Swift</option>
								<option value="mysql">MySQL</option>
								<option value="kotlin">Kotlin</option>
								<option value="mongodb">MongoDB</option>
								<option value="php">php</option>
								<option value="graphql">GraphQL</option>
								<option value="firebase">Firebase</option>
								<option value="reactnative">ReactNative</option>
								<option value="unity">Unity</option>
								<option value="figma">Figma</option>
								<option value="flutter">Flutter</option>
								<option value="aws">AWS</option>
								<option value="kubernetes">Kubernetes</option>
								<option value="docker">Docker</option>
								<option value="git">Git</option>
								<option value="zeplin">Zeplin</option>
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
								<option value="Google">구글폼</option>
								<option value="email">이메일</option>
							</select> <input type="text" class="css-1iewm1a-control"
								name="contactaddress" id="calladr" placeholder="링크 주소를 입력해주세요">
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
									<label>제목</label> <input class="form-control" name='title'>
								</div>
								<br>
								<div class="form-group">
									<label>스터디 모집 내용</label>
									<textarea class="form-control" rows="15" name='content'></textarea>
								</div>
								<section class="writebutton_buttons">
									<button class="writebutton_cancelButton">취소</button>
									<button class="writebutton_registerButton">글 등록</button>
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
		new MultiSelectTag('snames', {
			rounded : true, // default true

		})
		
		new MultiSelectTag('fnames', {
			rounded : true, // default true

		})
		
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
		});	
	</script>
</body>
</html>
