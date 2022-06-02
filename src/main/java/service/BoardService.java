package service;

import java.util.List;

import vo.BoardVO;
import vo.PageVO;

public interface BoardService {
	
	PageVO<BoardVO> pageList(PageVO<BoardVO> pvo);
	
	int stepUpdate(BoardVO vo);
	
	int rinsert(BoardVO vo);

	List<BoardVO> selectList();
	
	List<BoardVO> aidBList(BoardVO vo);

	BoardVO selectOne(BoardVO vo);// list 읽어보기

	int countUpdate(BoardVO vo); // 조회수

	int insert(BoardVO vo);

	int update(BoardVO vo);

	int delete(BoardVO vo);

}