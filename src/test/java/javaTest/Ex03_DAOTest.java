package javaTest;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertSame;

import org.junit.Test;

import util_DB.MemberDAO;
import vo.MemberVO;

// ** DAO Test 시나리오

// Test1) Detail 이 정확하게 구현 되어 있는지 확인
// => 존재하는 id Test -> NotNull : green
// => 존재하지 않는 id Test -> Null : red

// Test2) Insert 의 정확성
// => 입력이 가능한 데이터를 적용 시, 성공 : 1 return 
// => 입력 불가능한 데이터를 적용 시, 실패 : 0 return

public class Ex03_DAOTest {
	MemberDAO dao = new MemberDAO();
	MemberVO vo = new MemberVO();
	
	@Test
	public void detailTest() {
		// 1.1 ) 존재하는 ID
//		vo.setId("banana");
//		dao.memberDetail(vo);
//		assertNotNull(dao);
		
		// 1.1 ) 존재하는 ID
		vo.setId("wlgn829");
		vo = dao.memberDetail(vo);
		assertNotNull(vo);
	}
	@Test
	public void insertTest() {
		vo.setId("wlgn1");
		vo.setPassword("12345");
		vo.setName("지후");
		vo.setLev("C");
		vo.setBirthd("1998-08-29");
		vo.setPoint(1000);
		vo.setWeight(10.3);		
		assertEquals(dao.insert(vo), 1);
	}
}
