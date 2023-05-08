package org.hub.mapper;

import java.util.List;

import org.hub.domain.UserAttachVO;

public interface UserAttachMapper {
	// 첨부파일의 수정이라는 개념 없이 insert(), delete() 작업만 처리한다
	
	public void insert(UserAttachVO vo);
	
	public void delete(String uuid);
	
	public UserAttachVO findByUidKey(String uidKey); // uidKey로 해당 user의 이미지파일 찾는다
	
	public void deleteAll(String uidKey);
	
	public List<UserAttachVO> getOldFiles(); // DB에서 어제 등록된 모든 사용자 이미지 파일의 목록 가져오기
}
