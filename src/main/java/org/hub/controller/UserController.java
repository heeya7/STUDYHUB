package org.hub.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hub.auth.SNSLogin;
import org.hub.auth.SnsValue;
import org.hub.domain.BoardVO;
import org.hub.domain.Criteria;
import org.hub.domain.PageDTO;
import org.hub.domain.UserAttachVO;
import org.hub.domain.UserStackVO;
import org.hub.domain.UserVO;
import org.hub.interceptor.SessionNames;
import org.hub.service.BoardService;
import org.hub.service.MailCheckService;
import org.hub.service.UserSerivce;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.lang.NonNull;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import lombok.RequiredArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
@RequiredArgsConstructor
public class UserController {
	
	@NonNull
	@Inject
	private UserSerivce userService;	        	
	 	
	@Inject
	private SnsValue naverSns;	
	
	@Inject
	private SnsValue googleSns;
	
	@Inject
	private SnsValue kakaoSns;
	
	@Inject
	private GoogleConnectionFactory googleConnectionFactory;	
	
	@Inject
	private OAuth2Parameters googleOAuth2Parameters;
	
	@Inject
	private MailCheckService mailService;
	
    @Autowired
    private BoardService boardService;
	
	private UserVO user;
	 
	// 비밀번호 찾기 화면으로 이동
	@GetMapping(value="/findpw")
	public String findId() {
		log.info("pw 찾기(화면) controller 진입");
		return "/user/findpw";
	}
	
	//이메일 인증 ajax 받음
	@GetMapping(value="/mailcheck")
	@ResponseBody
	public String mailCheck(String email) {
		log.info("이메일 인증 요청 들어옴!");
		log.info("이메일 인증 요청 이메일: " + email);
		return mailService.formEmail(email); //사용자가 입력한 메일주소로 메일을 보내고, 생성한 인증번호 반환
	}
	
	// 비밀번호 변경 페이지로 이동
	@GetMapping(value="/resetpw")
	public String resetPw(String uidKey, Model model) {
		log.info("pw 변경 페이지로 이동하는 controller 진입");
		model.addAttribute("uidKey", uidKey);
		return "user/resetpw";
	}
	
	// 비밀번호 변경 POST
	@PostMapping(value="/resetpwPost")
	public String resetpwPost(String uidKey, String inputPw) {
		log.info("pw 변경 POST controller 진입");
		
		// 비밀번호 변경 후 로그인페이지 이동
		userService.modify(uidKey, inputPw);		
		return "redirect:/user/login";		
	}
	
	// 입력한 아이디 및 이메일 존재 여부 확인
	@PostMapping("/userEmailChk")
	@ResponseBody
	public String memberEmailChkPOST(String uidKey, String uemail) throws Exception {
		String findEmail=null;
		boolean idEmailCheck=false;
		
		log.info("userEmailChk() 진입" + uidKey + ":" + uemail);
		UserVO user = userService.get(uidKey);
		log.info("비밀번호 찾기 get(uidKey) = " + user);
		
		// 1. 입력한 아이디와 일치하는 사용자가 존재하는지
		if(user!=null) { // 아이디 일치하는 사용자 존재 O
			findEmail = user.getUemail();
			log.info("비밀번호 찾기 get(uemail) = " + findEmail);
		} else { // 아이디 일치하는 사용자 존재X
			return "fail";
		}
		
		// 2. 입력한 아이디와 연결된 이메일이, 입력한 이메일과 일치하는지
		idEmailCheck = findEmail.equals(uemail);
		if (idEmailCheck) {
			log.info("findEmail==uemail 확인 : " + (idEmailCheck));
			return "success"; // 일치O => 입력한 아이디, 이메일이 일치하는 사용자 존재
		} else {
			return "fail"; // 일치X => 일치하는 사용자 없음
		}						
	}
	
	// 로그아웃 그리고 메인화면으로
	@GetMapping(value = "/logout")
	public String logout(HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception {
		log.info("logout GET");
		session.removeAttribute(SessionNames.LOGIN);
		session.invalidate(); // 세션에 담아둔 모든 것을 비워 버리겠다
		
		Cookie loginCookie = WebUtils.getCookie(request, SessionNames.LOGIN_COOKIE);
		if(loginCookie !=null ) {
			// 쿠키 유효기간을 7일로 지정했는데, 없애려면 지금 시간으로 바꾸면 된다
			loginCookie.setPath("/");
			loginCookie.setMaxAge(0);
			
			response.addCookie(loginCookie);
		}
		return "redirect:/board/main";
	}

	// 로그인 화면으로
	// login() = => 로그인에서 네이버 로그인의 링크를 내려보내줘야 한다.
	@GetMapping(value = "/login")
	public String login(Model model) throws Exception {
		log.info("= = user social login = = ");

		// = => servlet-context.xml에서 설정한 빈 naverSns를 SNSLogin이 주입 받아야, 어디로 가고 어떻게
		// access token 받야야하고 등을 로그인이 알 수 있음
		// 네이버
		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getAuthURL());

		// 카카오 테스트
		SNSLogin kakaoLogin = new SNSLogin(kakaoSns);
		model.addAttribute("kakao_url", kakaoLogin.getAuthURL());
		// 카카오 테스트

		/* 구글code 발행을 위한 URL 생성 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);

		model.addAttribute("google_url", url);

		return "/user/userLogin";
	}

	// 로그인 POST
	@PostMapping(value = "/loginPost")
	public void loginPOST(HttpServletRequest request, UserVO user, Model model) throws Exception {
		log.info("loginPost 메서드 진입");
		log.info("jsh 로그인 시도 유저 = = = = = " + user);
		
		boolean loginResult = userService.login(user);	
		
		// 로그인 성공
		if (loginResult) {
			model.addAttribute("user", user);			
		} else { // 로그인 실패
			model.addAttribute("loginResult", "아이디 또는 비밀번호가 일치하지 않습니다.");
		}
	}

	// 회원가입 화면 뿌리기
	@GetMapping(value = "/join_")
	public String join(Model model) {
		log.info("join 회원가입 선택 진입");

		// = => servlet-context.xml에서 설정한 빈 naverSns를 SNSLogin이 주입 받아야, 어디로 가고 어떻게
		// access token 받야야하고 등을 로그인이 알 수 있음
		// 네이버
		SNSLogin snsLogin = new SNSLogin(naverSns);
		model.addAttribute("naver_url", snsLogin.getAuthURL());

		// 카카오 테스트
		SNSLogin kakaoLogin = new SNSLogin(kakaoSns);
		model.addAttribute("kakao_url", kakaoLogin.getAuthURL());

		/* 구글code 발행을 위한 URL 생성 */
		OAuth2Operations oauthOperations = googleConnectionFactory.getOAuthOperations();
		String url = oauthOperations.buildAuthorizeUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameters);
		model.addAttribute("google_url", url);

		return "/user/join";
	}

	// 소셜 로그인 콜백
	@RequestMapping(value = "/auth/{snsService}/callback")
	public String snsLoginCallback(@PathVariable String snsService, Model model, @RequestParam String code,
			HttpSession session) throws Exception {

		log.info("snsLoginCallback: {service} = " + snsService);

		SnsValue sns = null;

		UserVO snsUser = null;

		boolean flag = snsService.equalsIgnoreCase("kakao");

		if (!flag) { // 카카오가 아니면
			if (snsService.equalsIgnoreCase("naver")) {
				sns = naverSns;
			}
			if (snsService.equalsIgnoreCase("google")) {
				sns = googleSns;
			}
			// 1. code 이용해서 access_token 받기
			// 2. access_token 이용해서 사용자 profile 정보 가져오기
			SNSLogin snsLogin = new SNSLogin(sns);
			log.info("code: " + code + " = = = = =");

			snsUser = snsLogin.getUserProfile(code);

		} else { // 카카오면
			sns = kakaoSns;
			// 1. code 이용해서 access_token 받기
			// 2. access_token 이용해서 사용자 profile 정보 가져오기
			SNSLogin snsLogin = new SNSLogin(sns);
			log.info("code: " + code + " = = = = =");

			snsUser = snsLogin.getKakaoUserProfile(code);
		}

		System.out.println(" Profile > > " + snsUser);

		snsUser.setUsnsType(snsService); // 네이버,구글,카카오 구분해 담기

		// 3. DB에 해당 유저가 존재하는지 체크
		String uidKey = snsUser.getUidKey();

		user = userService.get(uidKey); // 식별키로 DB에서 해당하는 사용자 불러와서 user에 저장

		if (user == null) { // 참조변수 user가 null이면 해당하는 사용자가 없다는 것. 즉, 미가입자

			log.info(" = = = = =신규 유저 정보 담기= = = = = " + snsUser);

			model.addAttribute("newbie", snsUser);

			// 4.1. 존재하지 않으면 회원가입 페이지로
			return "/user/snsJoin";
		} else {
			// 4.2. 존재시 유저정보 세션에 강제로 담기 및 메인페이지 이동
			session.setAttribute(SessionNames.LOGIN, user);
			return "redirect:/board/main";
		}

	}

	// 회원가입 POST
	@PostMapping(value = "/join")
	public void joinPost(UserVO user, Model model) throws Exception {
		log.info("= = Post user join = = ");
		log.info("join: " + user);

		if (user.getAttach() != null) {
			log.info(user.getAttach());
		}

		if (user.getSnoList() != null) {
			user.getSnoList().forEach(sno -> log.info(sno));
		}		
		
		// service.reigster 가면 소셜 회원가입/일반 회원가입 나눠서 처리해줌
		userService.register(user);

		// 세션에 가입한 user 객체 담고 메인화면으로
		model.addAttribute("user", user);
	}

	// 아이디 중복 검사
	@PostMapping("/userIdChk")
	@ResponseBody
	public String memberIdChkPOST(String uidKey) throws Exception {
		log.info("userIdChk() 진입");
		UserVO user = userService.get(uidKey);
		log.info("아이디 중복 검사 결과값 = " + user);
		if (user != null) {
			return "fail"; // 중복 아이디가 존재
		} else {
			return "success"; // 중복 아이디 x
		}
	}

	// 닉네임 중복 검사
	@PostMapping(value = "/unickNameCheck")
	@ResponseBody
	public String unickNameCheck(String unickName) {
		UserVO user = userService.getByNickname(unickName);
		log.info("닉네임 user : " + user);
		if (user != null) {
			return "fail"; // 중복 닉네임가 존재
		} else {
			return "success"; // 중복 닉네임 x
		}
	}

	// 마이페이지 화면 이동
	@GetMapping(value = "/mypage")
	public String mypageSet(HttpSession session, Model model) {
		log.info("= = user mypage = = ");

		UserVO user = (UserVO) session.getAttribute(SessionNames.LOGIN);
		String uidKey = user.getUidKey();

		model.addAttribute("user", userService.get(uidKey));

		return "/user/userMypage";
	}

	// 회원탈퇴
	@PostMapping("/remove")
	public String remove(@RequestParam("uidKey") String uidKey, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		log.info("remove..." + uidKey);
		// 회원 탈퇴 전 회원의 이미지 파일 확보
		UserAttachVO attach = userService.getAttach(uidKey);

		if (userService.remove(uidKey)) { // 회원 정보 삭제

			// delete Attach Files
			deleteFiles(attach); // c:upload 밑 복사본 삭제

			rttr.addFlashAttribute("result", "success");
		}
		session.removeAttribute(SessionNames.LOGIN);
		session.invalidate(); // 세션에 담아둔 모든 것을 비워 버리겠다
		// 쿠키도 있으면 삭제
		Cookie loginCookie = WebUtils.getCookie(request, SessionNames.LOGIN_COOKIE);
		if(loginCookie !=null ) {
			// 쿠키 유효기간을 7일로 지정했는데, 없애려면 지금 시간으로 바꾸면 된다
			loginCookie.setPath("/");
			loginCookie.setMaxAge(0);
			
			response.addCookie(loginCookie);
		}
		return "redirect:/board/main";
	}


	// 회원정보 수정
	@PostMapping("/modify")
	public String modify(UserVO user, RedirectAttributes rttr) {
		log.info(" = = = = = modify:" + user);

		if (user.getAttach() != null) {
			log.info(user.getAttach());
		}

		if (user.getSnoList() != null) {
			user.getSnoList().forEach(sno -> log.info(sno));
		}

		if (userService.modify(user)) {
			rttr.addFlashAttribute("result", "변경이 완료되었어요");
		}

		return "redirect:/board/main";
	}

	// 회원 프로필 이미지 불러오기
	@GetMapping(value = "/getAttach", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<UserAttachVO> getAttach(String uidKey) {
		// uidkey를 이용해 이미지파일과 관련된 데이터를 json으로 반환하도록 처리 - @ResponseBody 어노테이션 적용
		log.info("getAttach" + uidKey);
		return new ResponseEntity<>(userService.getAttach(uidKey), HttpStatus.OK);
	}

	// 회원 관심스택 불러오기
	@GetMapping(value = "/getStackList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<UserStackVO>> getStackList(String uidKey) {
		// uidkey를 이용해 관심 스택을 json으로 반환하도록 처리 - @ResponseBody 어노테이션 적용
		log.info("getStackList" + uidKey);
		return new ResponseEntity<>(userService.getStackList(uidKey), HttpStatus.OK);
	}

	// upload 폴더 밑 이미지 복사본 삭제해주는 메소드
	private void deleteFiles(UserAttachVO attach) {

		if (attach == null) {
			return;
		}

		log.info("delete attach files...................");
		log.info(attach);
		
			try {
				Path file = Paths.get(
						"C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());

				Files.deleteIfExists(file);

				if (Files.probeContentType(file).startsWith("image")) {

					Path thumbNail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_" + attach.getUuid() + "_"
							+ attach.getFileName());

					Files.delete(thumbNail);
				}

			} catch (Exception e) {
				log.error("delete file error" + e.getMessage());
			} // end catch
		
	}
	
	
	
	@Setter(onMethod_ = @Autowired)
	private BoardService service;
	
	// 관심글 페이지
	@GetMapping("/interest")
	public String getMain(@ModelAttribute("board") BoardVO board, @ModelAttribute("cri") Criteria cri, Model model, HttpSession session, UserVO vo) {
		System.out.println("interest로 이동");
		log.info("intereset 이동");

		List<BoardVO> boardList = service.getList(cri);
		model.addAttribute("board", boardList);

		// jsh 0426 nullpointerError떠서 주석처리했습니다
		//session.setAttribute(SessionNames.LOGIN, user);
		int total = service.getTotal(cri);

		log.info("total: " + total);
 
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		UserVO user = (UserVO)session.getAttribute(SessionNames.LOGIN);
		String uidKey = user.getUidKey(); 
		model.addAttribute("user", userService.get(uidKey));
		
		List<Integer> interestList = service.getInterest(uidKey);
		model.addAttribute("interestList", interestList);
		
		return "interest";
	}
	
	// 관심글 등록 POST
	@PostMapping("/interest/insert")
	@ResponseBody
	public String insertInterest(HttpSession session, @RequestParam(name="bno", required=false) int bno) {
		UserVO user = (UserVO)session.getAttribute(SessionNames.LOGIN);
	    String uidkey = user.getUidKey();
	    boardService.insertInterest(uidkey, bno);
	    return "success";
	}

	// 관심글 등록 해제 POST
	@PostMapping("/interest/delete")
	@ResponseBody
	public String deleteInterest(HttpSession session, @RequestParam(name="bno", required=false) int bno) {
		UserVO user = (UserVO)session.getAttribute(SessionNames.LOGIN);
	    String uidkey = user.getUidKey();
	    boardService.deleteInterest(uidkey, bno);
	    return "success";
	}
	
	// 추천글 페이지
	@GetMapping("/recommend")
	public String getRecommend(@ModelAttribute("board") BoardVO board, @ModelAttribute("cri") Criteria cri, Model model,
			HttpSession session, UserVO vo) {
		System.out.println("recommend로 이동");
		log.info("recommend 이동");

		List<BoardVO> boardList = service.getList(cri);
		model.addAttribute("board", boardList);

		// jsh 0426 nullpointerError떠서 주석처리했습니다
		// session.setAttribute(SessionNames.LOGIN, user);
		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));

		UserVO user = (UserVO) session.getAttribute(SessionNames.LOGIN);
		String uidKey = user.getUidKey();
		model.addAttribute("user", userService.get(uidKey));

		List<Integer> interestList = service.getInterest(uidKey);
		model.addAttribute("interestList", interestList);

		List<Integer> recommendList = service.getRecommend(uidKey);
		model.addAttribute("recommendList", recommendList);

		return "recommend";
	}

	// 사용자 작성 글 목록
	@GetMapping("/write")
	public String getWrite(Model model, HttpSession session, @ModelAttribute("cri") Criteria cri) {
		System.out.println("작성 글 목록으로 이동 YJ");
		log.info("작성 글 목록으로 이동 YJ");
		
		// 게시글 상세 조회 위해 페이징 번호 받아옴
		List<BoardVO> boardList = service.getList(cri);
		model.addAttribute("board", boardList);
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		// 로그인한 사용자 정보 가져오기
	    UserVO user = (UserVO)session.getAttribute(SessionNames.LOGIN);
	    String uidkey = user.getUidKey();

	    List<BoardVO> userWriteList = service.getListUserWrite(uidkey); // uidKey 파라미터 전달
	    model.addAttribute("board", userWriteList);

	    session.setAttribute(SessionNames.LOGIN, user);

	    model.addAttribute("user", userService.get(uidkey));

	    return "userWrite";
	}   
	
	// 사용자 읽은 글 목록
	@GetMapping("/read")
	public String getRead(Model model, HttpSession session, @ModelAttribute("cri") Criteria cri) {
		System.out.println("읽은 글 목록으로 이동 YJ");
		log.info("읽은 글 목록으로 이동 YJ");
		
		// 게시글 상세 조회 위해 페이징 번호 받아옴
		List<BoardVO> boardList = service.getList(cri);
		model.addAttribute("board", boardList);
		int total = service.getTotal(cri);
		model.addAttribute("pageMaker", new PageDTO(cri, total));

		// 로그인한 사용자 정보 가져오기
	    UserVO user = (UserVO)session.getAttribute(SessionNames.LOGIN);
	    String uidkey = user.getUidKey();

	    List<BoardVO> userReadList = service.getUserRead(uidkey); // uidKey 파라미터 전달
	    model.addAttribute("board", userReadList);

	    session.setAttribute(SessionNames.LOGIN, user);

	    model.addAttribute("user", userService.get(uidkey));

	    return "userRead";
	} 
	
	// 내 관심글 페이지
	@GetMapping("/mylike")
	public String getMyLike() {
		return "myLike";
	}
	
}
