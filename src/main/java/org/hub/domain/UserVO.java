package org.hub.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserVO {
	
	// 식별키 또는 아이디
	private String uidKey;		
	
	// 회원가입 시 입력한 비밀번호
	private String inputPw;
	
	// 암호화한 비밀번호
	private String userPw;
	
	// 닉네임
	private String unickName;
	
	// 이메일
	private String uemail;
	
	// 관심 스택
	private List<UserStackVO> snoList;
	
	// 프로필 이미지
	private UserAttachVO attach;

	// 네이버, 카카오, 구글
	private String usnsType;
	
	//회원가입 일자
	private Date regDate; 

}
