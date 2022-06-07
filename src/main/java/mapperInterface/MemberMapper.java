package mapperInterface;

import java.util.List;

import criTest.Criteria;
import vo.MemberVO;
import vo.PageVO;

public interface MemberMapper {
	
	List<MemberVO> checkList(MemberVO vo);

	int totalCriCount(Criteria cri);

	List<MemberVO> criList(Criteria cri);

	int totalRowsCount(PageVO<MemberVO> pvo);

	List<MemberVO> pageList(PageVO<MemberVO> pvo);

	List<MemberVO> selectList();

	MemberVO selectOne(MemberVO vo);

	int insert(MemberVO vo);

	int update(MemberVO vo);

	int delete(MemberVO vo);

} // interface
