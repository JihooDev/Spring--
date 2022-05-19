package service;

import java.util.List;

import vo.BoardVO;

public interface BoardService {
	

	List<BoardVO> selectList();
	
	List<BoardVO> aidBList(BoardVO vo);

	BoardVO selectOne(BoardVO vo);// list 읽어보기

	int countUpdate(BoardVO vo); // 조회수

	int insert(BoardVO vo);

	int update(BoardVO vo);

	int delete(BoardVO vo);

}