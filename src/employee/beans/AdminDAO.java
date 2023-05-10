package employee.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import employee.beans.Admin;
import user.beans.User;

public class AdminDAO {
	private static Connection conn = null; // DB 커넥션 연결 객체
	private PreparedStatement pstmt;	// sql injection 등 공격을 막기 위해 사용자에게 변수 값만 받아서 구문을 실행
	private ResultSet rs;	// SQL문 수행 후 그 결과를 담는 객체
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
	// DBMS에 접속할 DB명 연결 주소 
	private static final String id = "root";	// DBMS 접속 시 아이디 
	private static final String password = "1234";	// DBMS 접속 시 비밀번호
	private static final String jdbckk = "com.mysql.cj.jdbc.Driver";	// JDBC 드라이버
	
	public static Connection AdminDAO() {
		try {
			String dbURL = url;	// 접속할 서버의 URL. 프로토콜, 서버주소, 서버포트, DB이름으로 구성
			String dbID = id;	// DB서버에 로그인할 계정 
			String dbPassword = password;	// DB서버에 로그인할 비밀번호 
			Class.forName(jdbckk);	// 동적으로 JDBC 드라이브 클래스를 로드 (DB를 연결하는 선)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// DriverManager 클래스의 getConnection() 메소드를 이용하여 Connection 객체를 정의하는 방법
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public Admin getAdmin(String id) {
		Admin ad = null;	// Admin 객체 레퍼런스 생성
		try {
			conn = AdminDAO();
			
			// 드라이브 로드 디비 연결,  
			String SQL = "SELECT * FROM employee where id=?";	// SQL 생성
			pstmt = conn.prepareStatement(SQL);	// pstmt 생성 
			pstmt.setString(1, id);	
			
			rs = pstmt.executeQuery();	// 실행 -> rs 저장 
			
			
			if (rs.next()) {
				ad = new Admin();		// Admin 클래스의 인스턴스 변수인 ad에 new 생성자를 통해 Admin 클래스 주소지를 저장 (해당 주소를 통해 Admin 클래스로 이동하여 변수 데이터들을 호출하기 위함) 
				ad.setId(rs.getString("id"));		// ad변수 안의 setId 메소드에 id 파라미터를 넣은 rs.getString메소드를 저장하여 결과값 저장 
				ad.setPassword(rs.getString("password"));
				ad.setName(rs.getString("name"));
				ad.setAge(rs.getString("age"));
				ad.setGender(rs.getString("gender"));
				ad.setEmail(rs.getString("email"));
				
				System.out.println(ad.getId());
				System.out.println(ad.getPassword());
				System.out.println(ad.getName());
				System.out.println(ad.getAge());
				System.out.println(ad.getGender());
				System.out.println(ad.getEmail());
				// 값을 훌륭하게 다 받아옴 6개 컬럼에서
				
				System.out.println("회원정보 저장완료");
			}
			System.out.println("SQL 구문실행 완료!");
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return ad;
	}
	
	public int login(String id, String password) {
		// 웹 페이지에서 삽입한 데이터를 DB로 전달하는 쿼리문 준비 
		String SQL = "SELECT password FROM USER WHERE id = ?";  // 로그인 함수 실행시 mysql에 입력할 sql문 입력
		try {
			pstmt = conn.prepareStatement(SQL); // conn.prepareStatement(sql) = pstmt변수에 sql문을 집어 넣음
			pstmt.setString(1, id); // sql문 중 첫번째 물음표에 ID를 집어 넣음
			rs = pstmt.executeQuery(); // sql을 돌리고 그 결과를 rs라는 변수에 저장(executeQuery 같은 경우 결과 값을 숫자로 반환)
			if (rs.next()) { // 만약 아이디가 DB에 존재하는경우
				if (rs.getString(1).contentEquals(password)) { // 아이디에 해당하는 비밀번호가 일치하는 경우
					return 1;	// 로그인 성공
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
