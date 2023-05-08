package org.hub.service;

import java.util.List;

import javax.inject.Inject;

import org.hub.domain.UserAttachVO;
import org.hub.domain.UserStackVO;
import org.hub.domain.UserVO;
import org.hub.mapper.UserAttachMapper;
import org.hub.mapper.UserMapper;
import org.hub.mapper.UserStackMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.lang.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@RequiredArgsConstructor  //UserMapper를 주입받는 생성자 생성
public class UserServiceImpl implements UserSerivce {
	
	@NonNull
	@Inject
	private UserMapper mapper;
	
	@Autowired
	private UserAttachMapper attachMapper;		
	
	@Autowired
	private UserStackMapper stackMapper;	
	
	// 일반 로그인
	@Override
	public UserVO login(UserVO user) {
		return mapper.login(user);		
	}
	
	// 전체 회원 목록
	@Override
	public List<UserVO> getList() {
		log.info("getList . . . . . .");
		return mapper.getList();
	}
	
	// 회원가입
	@Transactional
	@Override
	public void register(UserVO user) {
	// 트랜잭션 하에서 user_tbl에 먼저 유저를 등록하고, 첨부파일/관심스택은 생성된 uidkey를 세팅한 후 DB에 데이터 추가
		log.info("register . . . . . ." + user);
		String usnsType = user.getUsnsType();
		
		log.info(usnsType);
		
		if(usnsType != null) {  // 소셜 회원가입
			mapper.insertBySns(user);
		} else if (usnsType == null) { // 일반 회원가입
			mapper.insert(user); 
		}
		
		if(user.getAttach() == null) {
			
		} else {
			UserAttachVO attach = user.getAttach();
			attach.setUidkey(user.getUidKey());
			attachMapper.insert(attach);
		}
		
		if(user.getSnoList() == null || user.getSnoList().size() <=0) {
			
		} else {
			user.getSnoList().forEach(sno ->{			
				sno.setUidKey(user.getUidKey());
				stackMapper.insert(sno);
			});
		}									
	}
	
	// SNS로그인, 아이디 중복검사 - 해당 uidKey 유저 찾아오기
	@Override
	public UserVO get(String uidKey) {
		log.info("register . . . . . ." + uidKey);
		return mapper.read(uidKey);
	}
	
	// 회원정보 수정
	@Transactional
	@Override
	public boolean modify(UserVO user) {
	// 회원 수정은 우선 기존 첨부파일/스택 데이터 삭제 후 다시 첨부파일 데이터를 추가하는 방식으로 동작
		log.info("modify . . . . . ." + user);
		
		attachMapper.deleteAll(user.getUidKey());
		stackMapper.deleteAll(user.getUidKey());
		
		boolean modifyResult = mapper.update(user) == 1;
		
		if(modifyResult && user.getAttach() !=null) {
			UserAttachVO attach = user.getAttach();
			attach.setUidkey(user.getUidKey());
			attachMapper.insert(attach);				
		}
		
		if(modifyResult && user.getSnoList() !=null && user.getSnoList().size() > 0) {
			user.getSnoList().forEach(stack -> {
				stack.setUidKey(user.getUidKey());
				stackMapper.insert(stack);
			});
		}
		
		return modifyResult;
	}
	
	
	// 회원탈퇴
	@Transactional
	@Override
	public boolean remove(String uidKey) {
	// 트랜잭션 하에서 유저가 회원탈퇴 시 이미지 파일 함께 삭제되도록 @Transactional 어노테이션 사용
		log.info("remove . . . . . ." + uidKey);
		
		attachMapper.deleteAll(uidKey);
		
		return mapper.delete(uidKey) == 1;
	}
	
	// 닉네임 중복 검사 시 사용
	@Override
	public UserVO getByNickname(String unickName) {
		log.info("register . . . . . ." + unickName);
		return mapper.readByNickname(unickName);
		
	}
	
	// 회원 프로필 이미지 불러오기
	@Override
	public UserAttachVO getAttach(String uidKey) {

		log.info("get Attach list by uidKey" + uidKey);
		
		return attachMapper.findByUidKey(uidKey);
	}
	
	// 회원 관심스택 불러오기
	@Override
	public List<UserStackVO> getStackList(String uidKey) {
		
		log.info("get Stack list by uidKey" + uidKey);
		
		return stackMapper.findByUidKey(uidKey);
	}
	
	// 비밀번호 찾기 인증 후 비밀번호 변경
	@Override
	public boolean modify(String uidKey, String userPw) {
		
		log.info("pwd reset = " + uidKey + ":" + userPw);
		
		boolean modifyResult = mapper.modifyByAuth(uidKey, userPw)==1;

		return modifyResult;
	}

}
