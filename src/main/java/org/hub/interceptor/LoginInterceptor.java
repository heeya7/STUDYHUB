package org.hub.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.lang.Nullable;
import org.springframework.util.StringUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter implements SessionNames{
// 자바는 다중 상속이 안되니, SessionNames는 Interface로 만들어 implements 해 사용한다.
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("LoginInterceptor.pre > > >");
		
		HttpSession session = request.getSession(); //세션은 브라우저(크롬,IE 등) 단위로 생긴다
		if(session.getAttribute(LOGIN) != null) {
			session.removeAttribute(LOGIN);
		}
		return true;
	}

	// post에서는 로그인 한 결과를 반영해줄 것이다.
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			@Nullable ModelAndView modelAndView) throws Exception {
		System.out.println("LoginInterceptor.post > > >");
		
		HttpSession session = request.getSession();
		
		Object user = modelAndView.getModelMap().get("user");
		
		// 로그인 성공
		if(user!=null) {
			// 1. 로그인 성공한 유저vo를 이름이 "loginUser"인 세션에 저장
			session.setAttribute(LOGIN, user); 
			
			// 1-1. '로그인 상태 유지' 체크 한 사람만 쿠키 굽는다
			if(request.getParameter("useCookie") != null) {			
				Cookie loginCookie = new Cookie(LOGIN_COOKIE, session.getId());
				loginCookie.setPath("/"); //도메인 별로 쿠키가 생긴다
				loginCookie.setMaxAge(7 * 24 * 60 * 60); // 일주일
				
				response.addCookie(loginCookie); // cookie를 담은 상태로 reponse가 응답나간다					
			}
			// 2. 로그인 전 가려던 페이지(attempted)가 있는 사람은, 해당 페이지로 보내준다
			String attempted = (String)session.getAttribute(ATTEMPTED);
			
			if(!(StringUtils.isEmpty(attempted))) {
				response.sendRedirect(attempted);
				// 3. 저장되어있던 페이지는, 사용완료했으니 세션에서 지워준다
				session.removeAttribute(ATTEMPTED);
			} else {
				// 4. 로그인 성공 후 가려던 곳이 없는 사람은 main으로 보내준다
				response.sendRedirect("/board/main");
			}
		} else { } // 로그인 실패 -> loginPost.jsp에서 alert("아이디 또는 비번 불일치") 후 로그인 페이지로 재이동
	}
}
