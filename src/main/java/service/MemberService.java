package service;

import java.util.List;

import criTest.Criteria;
import vo.MemberVO;
import vo.PageVO;

public interface MemberService {
	
	List<MemberVO> checkList(MemberVO vo);
	
	int totalCriCount(Criteria cri);
	
	List<MemberVO> criList(Criteria cri); 

	PageVO<MemberVO> pageList(PageVO<MemberVO> pvo);

	List<MemberVO> selectList();

	MemberVO selectOne(MemberVO vo);

	int insert(MemberVO vo);

	int update(MemberVO vo);

	int delete(MemberVO vo);

}