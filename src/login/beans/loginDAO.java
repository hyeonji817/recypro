package login.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class loginDAO {
	private Connection conn;	// DB 연결용 객체 선언 
	private PreparedStatement pstmt;	// sql injection 등 공격을 막기 위해 사용자에게 변수 값만 받아서 구문을 실행
	private ResultSet rs;		// SQL문 수행 후 해당 쿼리 결과를 담는 객체
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";	// MySQL의 DB와 연동에 있어 중요한 URL
	private static final String id = "root";		// DB에 접속할 아이디 
	private static final String password = "1234";		// DB에 접속할 패스워드 
	
	public loginDAO() { // DB 연동 메서드, loginDAO 메소드 객체의 주소지 
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	// JDBC를 이용해 DB와 jsp 연동
			conn = DriverManager.getConnection(url, id, password);	// 해당 명령어를 통해 DB와 jsp 연결
			// System.out.println("정상실행");
			} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String id, String password) {		// 로그인 처리과정을 수행하는 메소드 
		// 웹 페이지에서 삽입한 데이터를 DB로 전달하는 쿼리문 준비 
		String SQL = "SELECT password FROM USER WHERE id = ?";  // 로그인 함수 실행시 mysql에 입력할 sql문 입력
		try {
			pstmt = conn.prepareStatement(SQL); // conn.prepareStatement(sql) = pstmt변수에 sql문을 집어 넣음			
			pstmt.setString(1, id); // sql문 중 첫번째 물음표에 ID를 집어 넣음
			rs = pstmt.executeQuery(); // sql을 돌리고 그 결과를 rs라는 변수에 저장(executeQuery 같은 경우 결과 값을 숫자로 반환)
			if (rs.next()) { // 만약 아이디가 DB에 존재하는경우
				if (rs.getString(1).contentEquals(password)) { // 아이디에 해당하는 비밀번호가 일치하는 경우
					return 1;	// 로그인 성공s
				}
				else 
					return 0;	// Password 오류
			}	// 만약 존재할 시
			return -1;	// id 오류
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;	// db 오류
	}
}
