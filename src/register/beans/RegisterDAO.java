package register.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class RegisterDAO {
	private Connection conn;		// DB 연결 커넥션 객체 선언 
	private PreparedStatement pstmt;		// 쿼리문 실행 객체 선언 
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";	// MySQL의 DB와 연동에 있어 중요한 URL
	private static final String id = "root";	// DB에 접속할 아이디 
	private static final String password = "1234";		// DB에 접속할 패스워드 
	
	public RegisterDAO() { // DB 연동 메서드
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	// JDBC를 이용해 DB와 jsp 연동
			conn = DriverManager.getConnection(url, id, password);	// 해당 명령어를 통해 DB와 jsp 연결
			System.out.println("정상실행");
			} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 회원가입 시, 입력한 데이터들이 DB에 저장되는 과정을 구현하는 메소드 
	public int join(String id, String password, String name, int age, String gender, String email) {
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,?,?)";		// 실행할 쿼리문 
		try {
			// 각각의 데이터를 DB에 실제로 넣어준다.
			pstmt = conn.prepareStatement(SQL);
			
			// 쿼리문의 ?안에 각각의 데이터를 넣어준다.
			pstmt.setString(1, id);
			pstmt.setString(2, password); 
			pstmt.setString(3, name);
			pstmt.setInt(4, age);
			pstmt.setString(5, gender);
			pstmt.setString(6, email);
			
			System.out.println("userdao/join/정상실행");
			// 명령어를 수행한 결과 반환, 반환값: insert가 된 데이터의 개수
			return pstmt.executeUpdate();	// 실행한 쿼리문 결과값 리턴 
		} catch (Exception e) {
			System.out.println("Join 함수 / try 실패");
			e.printStackTrace();
		}
		System.out.println("결과");
		return -1;
	} 
	
	
}
