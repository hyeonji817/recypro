/**
 * 참고했던 웹 페이지 주소좌표 리스트 : 
 * https://sowon-dev.github.io/2020/07/13/200714jspi2/ (회원정보 수정페이지 팁)
 */

package user.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.PrimitiveIterator.OfDouble;
import com.mysql.cj.x.protobuf.MysqlxConnection.Close;

import user.beans.User;

public class UserDAO {
	private static Connection conn = null; // DB 커넥션 연결 객체
	private PreparedStatement pstmt; // sql injection 등 공격을 막기 위해 사용자에게 변수 값만 받아서 구문을 실행
	private ResultSet rs; // SQL문 수행 후 그 결과를 담는 객체
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
	// DBMS에 접속할 DB명
	private static final String id = "root"; // DBMS 접속 시 아이디
	private static final String password = "1234"; // DBMS 접속 시 비밀번호
	private static final String jdbckk = "com.mysql.cj.jdbc.Driver"; // JDBC 드라이버

	public static Connection UserDAO() {
		try {
			String dbURL = url; // 접속할 서버의 URL. 프로토콜, 서버주소, 서버포트, DB이름으로 구성
			String dbID = id; // DB서버에 로그인할 계정
			String dbPassword = password; // DB서버에 로그인할 비밀번호
			Class.forName(jdbckk); // 동적으로 JDBC 드라이브 클래스를 로드 (DB를 연결하는 선)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// DriverManager 클래스의 getConnection() 메소드를 이용하여 Connection 객체를 정의하는 방법
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	// 회원가입 입력 시, 입력한 데이터들이 DB에 삽입하는 과정의 메소드
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?, ?, ?, ?)"; // 'User' 테이블에 데이터를 입력하는 쿼리문

		try {
			conn = UserDAO();
			pstmt = conn.prepareStatement(SQL); // 'SQL' 쿼리문 대기시킴

			pstmt.setString(1, user.getId()); // 1번째 물음표에 실제 사용자가 입력한 Id를 셋팅
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getAge());
			pstmt.setString(5, user.getGender());
			pstmt.setString(6, user.getEmail());
			pstmt.setString(7, null); // DB에 만들어진 컬럼 갯수에 맞춰야 됨 (null값을 넣어서라도)
			pstmt.setString(8, null);

			return pstmt.executeUpdate(); // 등록할 쿼리문 실행

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 회원정보 가져오는 메소드
	// getUser()로 회원정보 전부 리턴 -> 테이블에 추가 필수
	// 출처좌표 : https://sowon-dev.github.io/2020/07/13/200714jspi2/
	public User getUser(String id) {
		User user = null; // 객체 레퍼런스 생성
		// 왜 null인가? 정보가 생성되는 시점은 rs에 있을 때이다.
		// 따라서 rs가 없을 때 굳이 만들 필요 X

		try {
			conn = UserDAO(); // 드라이브 로드 디비 연결

			// SQL & pstmt 생성
			String SQL = "SELECT * FROM User where id=?"; // SQL 생성
			pstmt = conn.prepareStatement(SQL); // pstmt 생성
			pstmt.setString(1, id);

			rs = pstmt.executeQuery(); // 실행 -> rs 저장

			// 데이터처리 : DB에 있는 회원정보 저장 후, userinfo 페이지로 전달
			// DB의 컬럼명을 입력할 것
			if (rs.next()) {
				user = new User(); // User 클래스 변수 데이터들을 불러들임
				user.setId(rs.getString("id"));
				user.setPassword(rs.getString("password"));
				user.setName(rs.getString("name"));
				user.setAge(rs.getString("age"));
				user.setGender(rs.getString("gender"));
				user.setEmail(rs.getString("email"));
				user.setPassword2("password2");
				user.setPassword3("password3");

				// 값을 훌륭하게 다 받아옴 6개 컬럼에서
//				System.out.println("회원정보저장완료");
			}
//			System.out.println("SQL 구문실행 완료!");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	// 로그인 처리하는 메소드
	public int login(String id, String password) {
		// 웹 페이지에서 삽입한 데이터를 DB로 전달하는 쿼리문 준비
		String SQL = "SELECT password FROM USER WHERE id = ?"; // 로그인 함수 실행시 mysql에 입력할 sql문 입력
		try {
			pstmt = conn.prepareStatement(SQL); // conn.prepareStatement(sql) = pstmt변수에 sql문을 집어 넣음
			pstmt.setString(1, id); // sql문 중 첫번째 물음표에 ID를 집어 넣음
			rs = pstmt.executeQuery(); // sql을 돌리고 그 결과를 rs라는 변수에 저장(executeQuery 같은 경우 결과 값을 숫자로 반환)

			if (rs.next()) { // 만약 아이디가 DB에 존재하는경우
				if (rs.getString(1).contentEquals(password)) { // 아이디에 해당하는 비밀번호가 일치하는 경우
					return 1; // 로그인 성공
				} else
					return 0; // Password 오류
			} // 만약 존재할 시
			return -1; // id 오류
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // db 오류
	}

	/**
	 * 참고한 웹 페이지 주소좌표 : https://okky.kr/articles/48163 (try ~ catch 구문 내부에 변수 선언
	 * 못한다는 증거)
	 */
	// 아이디찾기 메소드
	public String findId(String name, String email) {
		String id = null; // 찾을 id값 선언
		try {
			String sql = "select id from user where name=? and email=?"; // 실행할 쿼리문
			pstmt = conn.prepareStatement(sql); // 쿼리문 실행
			pstmt.setString(1, name); // 쿼리문 내 물음표에 변수값 삽입
			pstmt.setString(2, email);
			rs = pstmt.executeQuery(); // 쿼리문 결과를 rs에 저장 (rs - 결과 출력용)

			if (rs.next()) {
				id = rs.getString("id"); // 참고한 웹 페이지 주소좌표 (rs.getString 파라미터 안에 컬럼값을 넣을 때 팁) :
											// https://allg.tistory.com/21
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}

	// 비밀번호찾기 메소드
	public String findPw(String id, String name, String email) {
		String findedpassword = null; // 찾을 비밃번호값 선언
		String sql = "SELECT password FROM USER WHERE id= ? and name= ? and email= ?"; // 실행할 쿼리문
		conn = UserDAO(); // UserDAO 메소드 주소지를 통해 DB 연결

		try {
			pstmt = conn.prepareStatement(sql); // 쿼리문 실행 준비
			pstmt.setString(1, id); // 쿼리문 내 물음표 안에 실행시킬 변수값 삽입
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			ResultSet rs = pstmt.executeQuery(); // 실행한 쿼리문 결과를 rs에 저장 (rs = 쿼리문 실행 결과값을 저장, 쿼리문 저장 및 결과출력용)

			if (rs.next()) // rs 선언 후 rs.함수를 사용하려면 if 문 rs.next()를 한번 돌려줘야한다. 아니면
							// javax.servlet.ServletException: java.sql.SQLException: Illegal operation on
							// empty result set. 에러발생함
			{
				findedpassword = rs.getString("password"); // getString은 안에 값이 무조건 컬럼 값을 " " 형식으로 입력해줘야함 중요!!!
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return findedpassword; // 각종 쿼리문을 통해 얻은 findedpassword 값을 리턴 (출력 및 호출)
	}

	// 패스워드 찾기 페이지에서 버튼 눌렀을때, 입력값과 DB값을 비교하기 위해 사용될 함수임.
	public String checkpwinfo(String id, String name, String email) {
		String findedid = null;
		String sql = "SELECT id FROM USER WHERE id= ? and name= ? and email= ?"; // 실행할 쿼리문
		conn = UserDAO();

		try {
			pstmt = conn.prepareStatement(sql); // 실행할 쿼리문 준비
			pstmt.setString(1, id); // 쿼리문 내 물음표 안에 출력할 변수값 삽입
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			ResultSet rs = pstmt.executeQuery(); // 실행한 쿼리문 결과를 rs에 저장 (쿼리문 저장 및 결과 출력)

			if (rs.next()) // rs 선언 후 rs.함수를 사용하려면 if 문 rs.next()를 한번 돌려줘야한다. 아니면
							// javax.servlet.ServletException: java.sql.SQLException: Illegal operation on
							// empty result set. 에러발생함
			{
				findedid = rs.getString("id"); // getString은 안에 값이 무조건 컬럼 값을 " " 형식으로 입력해줘야함 중요!!!
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return findedid;
	}

	// 참고한 웹 페이지 주소좌표 : https://zinisang.tistory.com/5 (원복으로 돌릴 때 필요할 거 같음), 원복으로
	// 돌려야 해결할 때 도움될 듯
	public int updateUser(User user) {
		int result = -1;

		try {
			conn = UserDAO();
			// SQL 구문작성 & pstmt 생성
			String SQL = "SELECT password from user where id=?"; // 실행할 쿼리문

			pstmt = conn.prepareStatement(SQL); // 쿼리문 실행 준비
			pstmt.setString(1, user.getId()); // 쿼리문 안 물음표에 삽입할 메소드값 대입

			rs = pstmt.executeQuery(); // 결과값 임시로넣고, rs 저장
			if (rs.next()) { // DB에 있는 회원. rs.next() 메소드를 사용하여 rs 저장한 값들 출력
				if (user.getPassword().equals(rs.getString("password"))) { // 비번이 일치할 경우
					// equals메소드가 아니라, '=='으로 해야 됨

					SQL = "UPDATE user set name=?, age=?, gender=?, email=?, password=? where id=?"; // 실행할 쿼리문2
					pstmt = conn.prepareStatement(SQL); // 쿼리문 실행 준비
					pstmt.setString(1, user.getName()); // 쿼리문 안 물음표에 삽입할 메소드값 대입
					pstmt.setString(2, user.getAge());
					pstmt.setString(3, user.getGender());
					pstmt.setString(4, user.getEmail());

					System.out.println(user.getPassword2());
					System.out.println(user.getPassword3());

					if (user.getPassword2().equals(user.getPassword3()) && user.getPassword2() != null
							&& user.getPassword3() != null) {
						pstmt.setString(5, user.getPassword3());
					} else {
						pstmt.setString(5, user.getPassword());
					}
					pstmt.setString(6, user.getId());

					// 실행
					pstmt.executeUpdate();
					result = 1;
				} else {
					result = 0;
				}
			} else { // DB에 없는 회원
				result = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	// 패스워드 변경 메소드 
	public int passwordchange(User user) {
		int result = -1;
		try {
			conn = UserDAO();
			String SQL = "SELECT password from user where id=?";	// 실행할 쿼리문 
			pstmt = conn.prepareStatement(SQL);		// 실행할 쿼리문 준비 
			pstmt.setString(1, user.getId());		// 쿼리문 내 물음표 안에 들어갈 변수 메소드 (변수 메소드값 삽입)
			if (rs.next()) { // DB에 있는 회원
				if (user.getPassword().equals(rs.getString("password"))) { // 비번이 일치할 경우
					// equals메소드가 아니라, '=='으로 해야 됨

					// 비번이 일치하면 정보수정 작업
					// SQL 구문작성 & pstmt 생성
					conn = UserDAO();	// DB를 UserDAO 메소드 객체의 주소에 연결 
					SQL = "UPDATE user set password=?" + "where id=?";		// 실행할 쿼리문2  
					pstmt = conn.prepareStatement(SQL);		// 실행할 쿼리문 준비 
					pstmt.setString(1, user.getName());		// 쿼리문 내 물음표 안에 들어갈 변수 메소드 (변수 메소드값 삽입) 

					// 실행
					pstmt.executeUpdate();
					result = 1;
				} else {
					result = 0;
				}
			} else { // DB에 없는 회원
				result = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
}