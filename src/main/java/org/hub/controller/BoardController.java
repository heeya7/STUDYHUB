package org.hub.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.hub.domain.BoardVO;
import org.hub.domain.Criteria;
import org.hub.domain.PageDTO;
import org.hub.domain.UserReadVO;
import org.hub.domain.UserVO;
import org.hub.interceptor.SessionNames;
import org.hub.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	@Autowired
	private BoardService service;
	
	// 일반메인
	@GetMapping("/main")
	public String getMain(@ModelAttribute("board") BoardVO board, @ModelAttribute("cri") Criteria cri, Model model,
			HttpSession session) {

		log.info("main 이동");

		// 메인페이지의 기본은 '모집중 on' 상태
		cri.setStatus(true);

		int total = service.getTotal(cri);

		log.info("total: " + total);

		model.addAttribute("pageMaker", new PageDTO(cri, total));

		List<BoardVO> boardList = service.getList(cri);

		model.addAttribute("board", boardList);

		// 관심글용
		UserVO user = (UserVO) session.getAttribute(SessionNames.LOGIN);
		if (user != null) {
			String useridKey = user.getUidKey();
			List<Integer> interestList = service.getInterest(useridKey);
			model.addAttribute("interestList", interestList);
		}

		return "main";
	}

	// 필터작용
	@GetMapping("/mainWithFilter")
	public String getMainWithFilter(@ModelAttribute("board") BoardVO board, @ModelAttribute("cri") Criteria cri,
			@RequestParam(name = "filter[]", required = false) String filter,
			@RequestParam(name = "position", required = false) String position,
			@RequestParam(name = "deadline", required = false) boolean deadline, Model model, HttpSession session) {
		log.info("mainWithFilter 이동 : " + position);

		// 뷰단에서 받은 필터값들을 담을 String 배열
		String[] filters = new String[0];

		// positionSelected 값이 '전체'이면 true, '전체 외' 이면 False
		log.info("뷰단에서 넘어오는 position" + position);
		boolean positionFlag = (position == "");
		log.info("positionFlag 값 확인 : " + positionFlag);

		// 뷰단에서 넘어오는 deadline은 'true'이면 '모집중인 글만 보기 on', false이면 모든 글 보기
		log.info("deadline Toggle 값 확인 : " + deadline);

		// '모집글만 on' 이라면, cri에 true set하기
		if (deadline) {
			cri.setStatus(true);
		}

		// 관심글용
		UserVO user = (UserVO) session.getAttribute(SessionNames.LOGIN);
		if (user != null) {
			String useridKey = user.getUidKey();
			List<Integer> interestList = service.getInterest(useridKey);
			model.addAttribute("interestList", interestList);
		}

		// 전제 1) 모집글 on이면, status=opend인 게시글 안에서 filter 2) 모집글 on이 아니면, 모든 게시글 안에서
		// filter
		// 기준1(기본세팅) : 1) 선택한 스택이 없음 2) 모집분야가 '전체' 3) 모든 글 보기
		if ((filter == null) && positionFlag) {

			// 페이징
			int total = service.getTotalWithFilter(cri);
			log.info("기준1 total: " + total);
			model.addAttribute("pageMaker", new PageDTO(cri, total));

			// 게시글 불러오기
			List<BoardVO> boardList = service.getList(cri);
			model.addAttribute("board", boardList);

		} else if ((filter == null) && !positionFlag) {
			// 기준2 : 1) 선택한 스택이 없음 2) 모집 분야가 '전체 외'

			// 페이징
			cri.setPosition(position);
			int total = service.getTotalWithFilter(cri);
			log.info(cri);
			log.info("기준2 total: " + total);
			model.addAttribute("pageMaker", new PageDTO(cri, total));

			// 게시글 불러오기
			List<BoardVO> boardList = service.getListWithFilter(cri);
			model.addAttribute("board", boardList);

			// 2-1. 관련 글이 있을 때
			if (boardList.size() > 0) {
				model.addAttribute("board", boardList);
				return "mainWithFilter";
			} else {
				// 2-2. 관련 글이 없을 때
				return "mainNone";
			}

		} else if ((filter != null) && positionFlag) {
			// 기준3 : 1) 선택한 스택이 있음 2) 모집 분야가 '전체'

			// 뷰단에서 받은 필터값
			filter = filter.toLowerCase();
			filters = filter.split(",");

			// 페이징
			cri.setFilters(filters);
			int total = service.getTotalWithFilter(cri);
			log.info("기준3 total: " + total);
			model.addAttribute("pageMaker", new PageDTO(cri, total));

			// 게시글 불러오기
			List<BoardVO> boardList = service.getListWithFilter(cri);

			// 3-1. 선택한 스택 관련 글이 있을 때
			if (boardList.size() > 0) {
				model.addAttribute("board", boardList);
				return "mainWithFilter";
			} else {
				// 3-2. 선택한 스택 관련 글이 없을 때
				return "mainNone";
			}

		} else if ((filter != null) && !positionFlag) {
			// 기준4 : 1) 선택한 스택이 있음 2) 모집 분야가 '전체 외'

			// 뷰단에서 받은 필터값
			filter = filter.toLowerCase();
			filters = filter.split(",");

			// 페이징
			cri.setFilters(filters);
			cri.setPosition(position);
			int total = service.getTotalWithFilter(cri);
			log.info("기준total : " + total);
			model.addAttribute("pageMaker", new PageDTO(cri, total));

			// 게시글 불러오기
			List<BoardVO> boardList = service.getListWithFilter(cri);

			// 4-1. 선택한 스택 관련 글이 있을 때
			if (boardList.size() > 0) {
				model.addAttribute("board", boardList);
				return "mainWithFilter";
			} else {
				// 4-2. 선택한 스택 관련 글이 없을 때
				return "mainNone";
			}

		}

		return "mainWithFilter";
	}

	// 글쓰기 GET
	@GetMapping("/register")
	public String registerView(HttpSession session) throws Exception {
		UserVO user = (UserVO) session.getAttribute(SessionNames.LOGIN);

		log.info("새 글쓰기로 이동");
		return "register";
	}

	// 글쓰기 POST
	@PostMapping("/register")
	public String registerProc(BoardVO board, HttpSession session, RedirectAttributes rttr) {
		System.out.println("글 등록 컨트롤러");
		System.out.println();
		System.out.println(session.getId());

		UserVO user = (UserVO) session.getAttribute(SessionNames.LOGIN);

		String uidkey = user.getUidKey();
		System.out.println(uidkey);
		board.setUidkey(uidkey);

		if (board.getFnames() != null) {
			String[] fnameList = board.getFnames().split(",");
			for (String fname : fnameList) {
				log.info(fname);
			}
		}

		if (board.getSnames() != null) {
			String[] snameList = board.getSnames().split(",");
			for (String sname : snameList) {
				log.info(sname);
			}
		}
		rttr.addFlashAttribute("registerResult", "글 등록완료");
		service.register(board);
		return "redirect:/board/main";
	}

	// 글 수정화면
	@GetMapping(value = "/modify")
	public String modifyView(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("/ modify");
		model.addAttribute("board", service.get(bno));
		model.addAttribute("cri", cri);
		log.info("cri 확인(0)[화면갈때] :" + cri);
		return "modify";
	}

	// 글 수정 POST
	@PostMapping("/modify")
	public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		log.info("글 수정 POST 컨트롤러 = = = = = ");
		log.info("수정 내용 반영된 board : " + board);
		log.info("cri 확인(1) :" + cri);
		// field 선택된 것 log로 확인
		if (board.getFnames() != null) {
			String[] fnameList = board.getFnames().split(",");
			for (String fname : fnameList) {
				log.info(fname);
			}
		}

		// stack 선택된 것 log로 확인
		if (board.getSnames() != null) {
			String[] snameList = board.getSnames().split(",");
			for (String sname : snameList) {
				log.info(sname);
			}
		}

		// service.modify() 호출
		boolean result = service.modify(board);
		if (result == true) {
			rttr.addFlashAttribute("modifyResult", "글 수정이 되었습니다.");
		}
		// 페이징 정보 URL이 붙여서 페이징 정보 유지하며 화면 이동
		log.info("cri 확인(2) :" + cri);
		return "redirect:/board/main" + cri.getListLink();
	}

	// 버튼 클릭 시 글 모집 마감
	@GetMapping("/upClose")
	@ResponseBody
	public String updateStatus(@RequestParam("bno") int bno) {
		log.info("upClose..." + bno);
		boolean result = service.updateStatus(bno);
		if (result == true) {
			return "success";
		} else {
			return "fail";
		}
	}

	// 마감 처리 취소하기
	@GetMapping(value = "/upOpen")
	@ResponseBody
	public String resetStatus(@RequestParam("bno") int bno) {
		log.info("resetStatus..." + bno);
		boolean result = service.resetStatus(bno);
		if (result == true) {
			return "success";
		} else {
			return "fail";
		}
	}

	// 글 삭제 GET
	@GetMapping("/remove")
	public String remove(@RequestParam("bno") int bno, RedirectAttributes rttr) {
		log.info("remove..." + bno);
		if (service.remove(bno)) {
			rttr.addFlashAttribute("removeResult", "삭제완료");
		}
		return "redirect:/board/main";
	}

	// 글 삭제 POST
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") int bno, Criteria cri, RedirectAttributes rttr) {
		log.info("remove..." + bno);
		if (service.remove(bno)) {
			rttr.addFlashAttribute("removeResult", "삭제완료");
		}
		return "redirect:/board/main" + cri.getListLink();
	}

	// 글 상세보기
	@GetMapping(value = "/get")
	public String get(@RequestParam("bno") int bno, @ModelAttribute("cri") Criteria cri, Model model,
			HttpSession session, UserReadVO userread) {
		log.info("/get");
		log.info("cri 확인(get화면)) :" + cri);
		model.addAttribute("board", service.get(bno));

		// userread_tbl 에 데이터 넣기 위함
		// 로그인한 사용자 정보 가져오기
		UserVO user = (UserVO) session.getAttribute(SessionNames.LOGIN);
		if (user != null) {
			String uidKey = user.getUidKey();
			userread.setUidkey(uidKey);
			userread.setBno(bno);

			// 읽은글 중복 확인
			int result = service.bnoCheck(userread);
			log.info("결과값 = " + result);
			if (result == 0) {
				service.saveUserRead(userread);
			}
		}
		return "get";
	}

	// 댓글 GET
	@GetMapping("/reply")
	public String getboard() {
		System.out.println("reply으로 이동");
		log.info("reply 이동");

		return "reply";
	}
}
