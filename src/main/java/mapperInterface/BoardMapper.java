package mapperInterface;

import java.util.List;

import vo.BoardVO;
import vo.PageVO;

public interface BoardMapper {
	int totalRowsCount(PageVO<BoardVO> pvo);
	List<BoardVO> pageList(PageVO<BoardVO> pvo);
	int stepUpdate(BoardVO vo);
	int rinsert(BoardVO vo);
	public List<BoardVO> aidBList(BoardVO vo);
	List<BoardVO> selectList();
	BoardVO selectOne(BoardVO vo);
	int countUpdate(BoardVO vo);
	int insert(BoardVO vo);
	int update(BoardVO vo);
	int delete(BoardVO vo);
}
