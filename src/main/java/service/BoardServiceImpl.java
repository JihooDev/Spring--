package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import mapperInterface.BoardMapper;
import util_DB.BoardDAO;
import vo.BoardVO;
import vo.PageVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardMapper mapper;
//	BoardDAO dao;
	// => Mybatis 로 교체 (interface 방식)
	// => interface BoardMapper 를 통해서
	//    BoardMapper.xml 의 SQL 구문 접근
	
	@Override
	public PageVO<BoardVO> pageList(PageVO<BoardVO> pvo) {	
		pvo.setTotalRowCount(mapper.totalRowsCount(pvo));
		pvo.setList(mapper.pageList(pvo)); 
		return pvo;
	}
	
	@Override
	public int stepUpdate(BoardVO vo) {	
		return mapper.stepUpdate(vo);
	}
	
	
	@Override
	public int rinsert(BoardVO vo) {
		System.out.println(mapper.stepUpdate(vo)); 
		return mapper.rinsert(vo);
	}
	
	@Override
	public List<BoardVO> aidBList(BoardVO vo) {
		return mapper.aidBList(vo);
	}
	@Override
	public List<BoardVO> selectList() {
		return mapper.selectList();
	}
	
	@Override
	public BoardVO selectOne(BoardVO vo) {
		return mapper.selectOne(vo);
	}// list 읽어보기
	
	@Override
	public int countUpdate(BoardVO vo) {
		return mapper.countUpdate(vo);
	} // 조회수
	
	@Override
	public int insert(BoardVO vo) {
		return mapper.insert(vo);
	}
	
	@Override
	public int update(BoardVO vo) {
		return mapper.update(vo);
	}
	
	@Override
	public int delete(BoardVO vo) {
		return mapper.delete(vo);
	}
} // class
