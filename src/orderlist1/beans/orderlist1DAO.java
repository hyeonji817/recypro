package orderlist1.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class orderlist1DAO {
	private static Connection conn; // DB 커넥션 연결 객체
	private PreparedStatement pstmt; // SQL injection 등의 공격을 막기 위해 사용자에게 변수 값만 받아서 구문 실행 (실행용)
	private ResultSet rs; // SQL문 수행 후 그 결과를 담는 객체	(저장용)
	
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
	// DBMS에 접속할 DB명
	private static final String id = "root"; // DBMS 접속 시 아이디
	private static final String password = "1234"; // DBMS 접속 시 비밀번호
	private static final String jdbckk = "com.mysql.cj.jdbc.Driver"; // JDBC 드라이버
	private static int help = 1;
	
	public orderlist1DAO() {
		try {
			String dbURL = url; // 접속할 서버의 URL. 프로토콜, 서버주소, 서버포트, DB 이름으로 구성
			String dbID = id; // DB 서버에 로그인할 계정
			String dbPassword = password; // DB 서버에 로그인할 비밀번호
			Class.forName(jdbckk); // 동적으로 JDBC 드라이브 클래스를 로드 (DB를 연결하는 선)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// DriverManager 클래스의 getConnection() 메소드를 이용하여 Connection 객체를 정의하는 방법
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// orderlist1DAO 인스턴스를 하나만 공유하게끔 싱글톤 패턴 사용 
	// orderlist1DAO 클래스의 기본 생성자에 대한 객체 변수 instance 생성 
	private static orderlist1DAO instance = new orderlist1DAO(); 
	
	public static orderlist1DAO getInstance() {
		return instance;
	}
	
	// 주문정보 전부 가져오는 메소드 
	// getOrder1()로 주문정보 전부 리턴 -> 테이블에 추가하기 
	public orderlist1DAO getOrder1(String shopping_num) {
		orderlist1DAO od1 = null; 
		
		try {
			// 드라이브 로드 디비 연결
			String SQL = "SELECT * FROM orderlist1 where shopping_num=?"; // SQL 생성
			pstmt = conn.prepareStatement(SQL); // pstmt 생성
			pstmt.setString(1, shopping_num);
			
			rs = pstmt.executeQuery();	// 실행 -> rs 저장 
			
			if (rs.next()) {
				od1 = new orderlist1();	// orderlist1 클래스의 인스턴스 변수인 od에 new 생성자를 통해 orderlist1 클래스 연결 주소지 저장 
				od1.setShopping_num(rs.getString("shopping_num")); 
				od1.setShopping_bank(rs.getString("shopping_bank"));
				od1.setReturn_reason(rs.getString("return_reason"));
				od1.setShopping_account(rs.getString("shopping_account"));
				od1.setShopping_owner(rs.getString("shopping_owner")); 
				
				System.out.println("주문정보 저장완료"); 
			}
			System.out.println("주문정보 SQL 구문실행 완료!"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return od1; 
	}
	
	// 주문데이터 수정페이지 
	public int updateOrder1(orderlist1 od1) {
		int result = -1; 
		
		try {
			// SQL 구문작성 & pstmt 생성
			String SQL = "SELECT password from orderlist1 where shopping_num=?"; // SQL 생성
			pstmt = conn.prepareStatement(SQL); // pstmt 생성
			pstmt.setInt(1, od1.getShopping_num());
			
			rs = pstmt.executeQuery();		// SQL 쿼리문의 결과값을 임시로 넣고 rs 저장 
			
			if (rs.next()) {
				SQL = "UPDATE orderlist1 set shopping_bank=?, return_reason=?, shopping_account=?, shopping_owner=?" + "where shopping_num=?";
				
				pstmt = conn.prepareStatement(SQL);		// SQL 변수에 저장된 쿼리문 실행 
				pstmt.setString(1, od1.getShopping_bank()); 	// 첫 번째 질의문에 저장할 get메소드 값 저장 
				pstmt.setString(2, od1.getReturn_reason()); 	
				pstmt.setString(3, od1.getShopping_account());		
				pstmt.setString(4, od1.getShopping_owner());	
				
				System.out.println(od1.getShopping_num());	
				
				pstmt.executeUpdate();		// update 쿼리문 실행 반영 
				System.out.println("주문정보 수정성공"); 
				result = 1; 
			} else {
				result = 0; 
				System.out.println("주문정보 수정실패"); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result; 
	}
	
	// 주문정보 등록하는 메소드 
	public int order1(Integer shopping_num, String shopping_bank, String return_reason, String shopping_account, String shopping_owner) {
		// int shopping_num = help; 
		
		String sql = "INSERT INTO recypro.orderlist1 VALUES(?,?,?,?,?)";	// DB에 추가될 insert 쿼리문 
		try {
			System.out.println("주문 전 주문번호 : " + help);
			System.out.println("등록한 은행명 : " + shopping_bank);
			System.out.println("반품사유 : " + return_reason);
			System.out.println("계좌번호 : " + shopping_account);
			System.out.println("예금주 : " + shopping_owner);
			
			pstmt = conn.prepareStatement(sql); 
			
			pstmt.setInt(1, shopping_num);
			pstmt.setString(2, shopping_bank);
			pstmt.setString(3, return_reason);
			pstmt.setString(4, shopping_account);
			pstmt.setString(5, shopping_owner);
			
			System.out.println("주문 후 주문번호 : " + help); 
			pstmt.executeUpdate();		// 쿼리문 실행 반영 
		} catch (Exception e) {
			System.out.println("order1 함수 / Try 실패하고 탈출"); 
			e.printStackTrace();
		}
		return -1;		// 실패로 예시해 놓은 것 
	}
}
