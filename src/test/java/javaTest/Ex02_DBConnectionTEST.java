package javaTest;

import static org.junit.Assert.assertNotNull;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;



public class Ex02_DBConnectionTEST {
	// ** Connection 객체 생성 TEST
	// => @Test 적용 메서드는 non static , void 메서드 여야 한다
	// => static, return 값이 있는 메서드 
	//	1) Test용 메서드는 따로 작성한다
	//	2) non static의 void로 정의한다
	
	// 1) Test메서드 별도 작성
	// => id password 오류 :java.sql.SQLException: Access denied for user 'root'@'localhost' (using password: YES)
	// => port번호 오류 :java.sql.SQLNonTransientConnectionException: Could not create connection to database server.
	public static Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/mydb?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
			System.out.println("** JDBC Connection 요기까지 성공 **");
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
//		assertNotNull(getConnection());
	}
	
	@Test
	//	2) non static의 void로 정의한다
	public void getConnectionVoid() {
		Connection cn = null;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/mydb?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false&allowPublicKeyRetrieval=true";
			cn = DriverManager.getConnection(url, "root", "wlgn829");
			System.out.println("** Connection 성공 => " + cn);
		} catch (Exception e) {
			System.out.println("** JDBC Connection 실패 => "+e);
		} finally {
			assertNotNull(cn);
			// => 위 메서드 있는것과 없는경우 비교
		}
		
	}
} // class
