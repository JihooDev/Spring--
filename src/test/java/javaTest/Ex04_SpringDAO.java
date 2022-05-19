package javaTest;

import static org.junit.Assert.*;

import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import util_DB.MemberDAO;
import vo.MemberVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class Ex04_SpringDAO {
	
	// ** 자동주입 : 생성은 root~~~.xml 로 설정
	// => 해당 클래스들은 생성 되어 있어야함. (@ , xml)
	@Autowired
	MemberDAO dao;
	@Autowired
	MemberVO vo;
	
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
		vo.setId("jspring");
		vo.setPassword("12345");
		vo.setName("봄봄봄");
		vo.setLev("C");
		vo.setBirthd("1998-08-29");
		vo.setPoint(1000);
		vo.setWeight(10.3);		
		assertEquals(dao.insert(vo), 1);
	}

}

