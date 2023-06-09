package org.hub.service;

import java.util.List;

import org.hub.domain.BoardFieldVO;
import org.hub.domain.BoardStackVO;
import org.hub.domain.BoardVO;
import org.hub.domain.Criteria;
import org.hub.domain.UserReadVO;
import org.hub.mapper.BoardFieldMapper;
import org.hub.mapper.BoardMapper;
import org.hub.mapper.BoardStackMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	@Setter(onMethod_ = @Autowired)
	private BoardMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardFieldMapper fieldMapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardStackMapper stackMapper;
	
	@Setter(onMethod_ = @Autowired)
	private BoardFieldVO field;
	
	@Setter(onMethod_ = @Autowired)
	private BoardStackVO stack;
	
	@Transactional
	@Override
	public void register(BoardVO board) {
		log.info("register......" + board);
		
		mapper.insert(board);

		if(board.getFnames() == null || board.getFnames().length() <=0) {
			return;
		}
		
		if(board.getSnames() == null || board.getSnames().length() <=0) {
			return;
		}
		
		String[] fnameList = board.getFnames().split(",");
		for(String fname : fnameList) {
			field.setBno(board.getBno()); // 보드의 bno를 BoardFieldVO의 bno에 등록
			int fno = fieldMapper.getFno(fname); // fname를 이용해 mapper에서 fno를 찾고 변수 fno에 저장
			field.setFno(fno); // fieldVO 의 fno에 변수 fno를 저장
			fieldMapper.insertBoardField(field); // 그리고 sql에 등록
		}
		
		String[] snameList = board.getSnames().split(",");
		for(String sname : snameList) {
			stack.setBno(board.getBno()); // 보드의 bno를 BoardStackVO의 bno에 등록
			int sno = stackMapper.getSno(sname); // sname을 이용해 mapper에서 sno를 찾고 변수 sno에 저장
			stack.setSno(sno); // StackVO의 sno에 변수 sno를 저장
			stackMapper.insertBoardStack(stack); // 그리고 sql에 등록
		}
		// 등록한 글의 마감일자가 이미 지난 것이라면 status 값을 closed로 바꾸고 register() 메소드 끝낸다
		mapper.updateBoardStatus();
	}

	@Override
	public BoardVO get(int bno) {

		log.info("get......" + bno);
		
		// kdh 04-21 추가 조회수 증가
		mapper.updateViewCnt(bno);
		return mapper.read(bno);

	}

	// 글 수정하기
	@Transactional
	@Override
	public boolean modify(BoardVO board) {
	// 글 수정은 우선 기존 모집분야/관련스택 데이터 삭제 후 다시 데이터를 삽입하는 방식으로 동작
		log.info("modify BoardServiceImpl ......" + board);
		
		fieldMapper.delete(board.getBno());
		stackMapper.delete(board.getBno());
		
		// 1. board_tbl 수정
		boolean modifyResult = mapper.update(board) == 1;
		
		// 2. board_tbl 수정이 되고, 모집분야가 null이 아니라면 boardfield_tbl에 데이터 삽입 진행
		if(modifyResult && board.getFnames() != null && board.getFnames().length() > 0) {
			String[] fnameList = board.getFnames().split(",");
			for(String fname : fnameList) {
				field.setBno(board.getBno()); // 보드의 bno를 BoardFieldVO의 bno에 등록
				int fno = fieldMapper.getFno(fname); // fname를 이용해 mapper에서 fno를 찾고 변수 fno에 저장
				field.setFno(fno); // fieldVO 의 fno에 변수 fno를 저장
				fieldMapper.insertBoardField(field); // 그리고 sql에 등록
			}
		}
		
		// 3. board_tbl 수정이 되고, 관련스택이 null이 아니라면 boardstack_tbl에 데이터 삽입 진행
		if(modifyResult && board.getSnames() != null && board.getSnames().length() > 0) {
			String[] snameList = board.getSnames().split(",");
			for(String sname : snameList) {
				stack.setBno(board.getBno()); // 보드의 bno를 BoardStackVO의 bno에 등록
				int sno = stackMapper.getSno(sname); // sname을 이용해 mapper에서 sno를 찾고 변수 sno에 저장
				stack.setSno(sno); // StackVO의 sno에 변수 sno를 저장
				stackMapper.insertBoardStack(stack); // 그리고 sql에 등록
			}
		}		
		return modifyResult;
	}
	
	@Override
	
	// 버튼 클릭 시 모집 마감
	public boolean updateStatus(int bno) {			
		log.info("updateStatus BoardServiceImpl ......" +bno);		
		return mapper.updateClose(bno) == 1;
	}
	
	// 마감 처리 취소하기
	@Override
	public boolean resetStatus(int bno) {
		log.info("resetStatus BoardServiceImpl ......" +bno);	
		return mapper.updateOpend(bno) == 1;
	}
	
	// 게시물 삭제
	@Override
	public boolean remove(int bno) {
		log.info("remove...." + bno);
		return mapper.delete(bno) == 1;
	}
	
	// 일반 메인 게시글 불러오기
	@Override
	public List<BoardVO> getList(Criteria cri) {

		log.info("get List with criteria: " + cri);

		return mapper.getListWithPaging(cri);
	}
	
	// 일반 메인 게시글 총 개수
	@Override
	public int getTotal(Criteria cri) {

		log.info("get total count");
		return mapper.getTotalCount(cri);
	}
    
	// 메인 with 필터 게시글 불러오기
	@Override
	public List<BoardVO> getListWithFilter(Criteria cri) {

		log.info("get List with criteria: " + cri);

		return mapper.getListWithPagingWithFilter(cri);
	}
	
	// 메인 with 필터 게시글 총 개수
	@Override
	public int getTotalWithFilter(Criteria cri) {
		log.info("get total count with filter");
		return mapper.getTotalCountWithFilter(cri);
	}
	
	// 메인 with position 게시글 불러오기
		@Override
		public List<BoardVO> getListWithPosition(Criteria cri) {

			log.info("get List with position: " + cri);

			return mapper.getListWithPagingWithPosition(cri);
		}
		
		// 메인 with position 게시글 총 개수
		@Override
		public int getTotalWithPosition(Criteria cri) {
			log.info("get total count with position");
			return mapper.getTotalCountWithPosition(cri);
		}
	
	// 추천목록 가져오기
	@Override
	public List<Integer> getRecommend(String uidkey) {
		log.info("get Recommend");
		return mapper.getRecommend(uidkey);
	}
	
	// 관심목록 가져오기
	@Override
	public List<Integer> getInterest(String uidkey) {
		log.info("get Interest");
		return mapper.getInterest(uidkey);
	}
	
	//kdh 04-21 추가 스택 가져오기
	@Override
	public String[] getStack(int bno) {
		// TODO Auto-generated method stub
		return null;
	}

	// YJ 04-22 작성글 목록 가져오기 
	@Override
	public List<BoardVO> getListUserWrite(String uidkey) {
		log.info("get List User Write : " + uidkey);
		return mapper.getListUserWrite(uidkey);
	}
	
	// YJ 04-26 읽은 글 목록 가져오기
	@Override
	public List<BoardVO> getUserRead(String uidkey) {
		log.info("get List User Read : " + uidkey);
		return mapper.getUserRead(uidkey);
	}
	
	// YJ 04-26 읽은 글 DB 등록
	@Override
	public void saveUserRead(UserReadVO userread) {
		log.info("saveUserRead......" + userread);
		mapper.saveUserRead(userread);
	}
	
	// YJ 05-02 읽은 글 중복 체크
	@Override
	public int bnoCheck(UserReadVO userread) {
		return mapper.bnoCheck(userread);
	}

		
		@Override
		public void insertInterest(String uidkey, int bno) {
		    mapper.insertInterest(uidkey, bno);
		    log.info("sts-----insertInterest" + uidkey + bno);
		}


		@Override
		public void deleteInterest(String uidkey, int bno) {
			mapper.deleteInterest(uidkey, bno); 
			log.info("sts-----deleteInterest" + uidkey + bno);
		}
	
}