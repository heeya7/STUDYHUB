<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

	<nav class="navbar_navbar">
			<a href="/board/main"> <img class="navbar_logo"
				src="/resources/Images/SHLogo.png" alt="logo" width=220 height=62>
			</a>
			<div class="navbar_loginElementWrapper">
				<button class="navbar_postRegister"
					onclick="location.href='/board/register'">글쓰기</button>
			
			
			<% if (session.getAttribute("loginUser") != null) { %>
				<button class="navbar_postRegister"
					onclick="location.href='/user/recommend'">추천글</button>			
				<!-- 사용자 드롭다운 메뉴 -->
					<div class="dropdown" style="display: inline-block">
			  			<a class="btn dropdown-toggle" id="dropImage" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
			  			
						</a>						
					   <ul class="dropdown-menu dropdown-menu-end">
					   	   <li><a class="dropdown-item fs-6 fw-bold mb-2" href="/user/write">내 작성글</a></li>
					   	   <li><a class="dropdown-item fs-6 fw-bold mb-2" href="/user/mylike">내 관심글</a></li>						  
						   <li><a class="dropdown-item fs-6 fw-bold mb-2" href="/user/mypage">마이페이지</a></li>
						   <li><a class="dropdown-item fs-6 fw-bold" href="/user/logout">로그아웃</a></li>
						</ul>			  
					</div>
					
					<%-- <h1>${ loginUser.unickName }</h1> --%>
					
			<% } else if (session.getAttribute("loginAdmin") != null) { %>
				<!-- 관리자 navbar -->
				<div class="navbar_login" style="pointer-events : none;">
					<span class="fs-6">관리자</span><span class="fs-5">${ loginAdmin.aname }</span><span class="fs-6">님</span>
				</div>
				
				<!-- 관리자용 드롭다운 메뉴 -->
					<div class="dropdown" style="display: inline-block">
			  			<a class="btn dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
							<img class="rounded-circle" src="/resources/Images/adminProfileLogo.png" width=60 alt="Profile Image" >
						</a>						
						<ul class="dropdown-menu dropdown-menu-end">
						  <li><span class="dropdown-item fs-6 fw-bold mb-2">관리자페이지</span></li>
						  <li><a class="dropdown-item fs-6 fw-bold" href="/admin/logout">로그아웃</a></li>
						</ul>			  
					</div>
			<% } else { %>
				<!-- 로그인 버튼 -->
				<button class="navbar_login"
							onclick="location.href='/user/login'">로그인</button>
				<button class="navbar_login"
							onclick="location.href='/user/join_'">회원가입</button>
			<% } %>
			
					</div>    
				</nav>
													
