package org.hub.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.hub.domain.UserVO;

public interface UserMapper {
	
		// 일반 로그인 - 세션 구워야 하니 유저VO 리턴
		public UserVO login(UserVO user);
		
		// 전체 회원 목록
		public List<UserVO> getList();
		
		// 일반 회원가입
		public void insert(UserVO user);
		
		// 소셜 회원가입
		public void insertBySns(UserVO user);
		
		// SNS로그인 - 세션 구워야 하니 유저VO 리턴 
		public UserVO read(String uidKey);
		
		// 닉네임 중복 검사 시 사용
		public UserVO readByNickname(String unickName);		
		
		// 회원정보 수정
		public int update(UserVO user);
		
		// 회원탈퇴 -  삭제된 행의 개수를 받환 받아, if(1==1)이 true이면 회원탈퇴되었다는 모달창 띄우기
		public int delete(String uidKey);
		
		// 비밀번호 찾기 => 비밀번호 변경
		public int modifyPw(@Param("uidKey")String uidKey, @Param("userPw")String userPw);
}
