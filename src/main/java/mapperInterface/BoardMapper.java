package mapperInterface;

import java.util.List;

import vo.BoardVO;

public interface BoardMapper {
	public List<BoardVO> aidBList(BoardVO vo);
	List<BoardVO> selectList();
	BoardVO selectOne(BoardVO vo);
	int countUpdate(BoardVO vo);
	int insert(BoardVO vo);
	int update(BoardVO vo);
	int delete(BoardVO vo);
}
