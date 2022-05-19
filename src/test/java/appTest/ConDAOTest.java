package appTest;

import static org.junit.Assert.*;
import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import util_DB.MemberDAO;
import vo.MemberVO;

public class ConDAOTest {
	
	MemberDAO dao = new MemberDAO();
	MemberVO vo = new MemberVO();
	
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
	
	@Test
	public void detailTest() {
		// 1.1 ) 존재하는 ID
		vo.setId("wlgn829222");
		vo = dao.memberDetail(vo);
		assertNotNull(vo);
	}
	
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/mydb?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
			System.out.println("** JDBC Connection **");
			return DriverManager.getConnection(url, "root", "wlgn829") ;
		} catch (Exception e) {
			System.out.println("** JDBC Connection 실패 => "+e);
			return null;
		} //try
	} //getConnection
	
	
	@Test
	public void connectionTest() {
		System.out.println("** Connection => " + getConnection());
		 // true: 연결 성공 || false: 연결 실패
		assertNotNull(getConnection());
	}



	
	

}
