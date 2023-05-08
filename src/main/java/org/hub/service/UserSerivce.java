package org.hub.service;

import java.util.List;

import org.hub.domain.UserAttachVO;
import org.hub.domain.UserStackVO;
import org.hub.domain.UserVO;

public interface UserSerivce {
	
		// 일반 로그인 - 세션 구워야 하니 유저VO 리턴
		public UserVO login(UserVO user);
		
		// 전체 회원 목록
		public List<UserVO> getList();
		
		// 회원가입
		public void register(UserVO user);
		
		// SNS로그인 - 세션 구워야 하니 유저VO 리턴 
		public UserVO get(String uidKey);
		
		// 닉네임 중복 검사 시 사용
		public UserVO getByNickname(String unickName);
		
		// 회원 프로필 이미지 불러오기
		public UserAttachVO getAttach(String uidKey);
		
		// 회원정보 수정
		public boolean modify(UserVO user);
		
		// 회원탈퇴
		public boolean remove(String uidKey);

		// 회원 관심스택 불러오기
		public List<UserStackVO> getStackList(String uidKey);
		
		// 비밀번호 변경
		public boolean modify(String uidKey, String userPw);
	
}
