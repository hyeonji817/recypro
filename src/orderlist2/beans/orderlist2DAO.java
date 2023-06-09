package orderlist2.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import order.beans.Order;

public class orderlist2DAO {
	private static Connection conn; // DB 커넥션 연결 객체
	private PreparedStatement pstmt; // SQL injection 등의 공격을 막기 위해 사용자에게 변수 값만 받아서 구문 실행 (실행용)
	private ResultSet rs; // SQL문 수행 후 그 결과를 담는 객체	(저장용)
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
	// DBMS에 접속할 DB명
	private static final String id = "root"; // DBMS 접속 시 아이디
	private static final String password = "1234"; // DBMS 접속 시 비밀번호
	private static final String jdbckk = "com.mysql.cj.jdbc.Driver"; // JDBC 드라이버
	private static int help = 1;
	
	public orderlist2DAO() {	// orderlist2DAO 메소드 객체에 접속할 연결 주소지 
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
	
	// orderlist2DAO 인스턴스를 하나만 공유하게끔 싱글톤 패턴 사용 
	// orderlist2DAO 클래스의 기본 생성자에 대한 객체 변수 instance 생성 
	private static orderlist2DAO instance = new orderlist2DAO();
	
	public static orderlist2DAO getInstance() {
		return instance; 
	}
	

	
	
	// 주문정보 전부 가져오는 메소드 
	// getOrder2()로 주문정보 전부 리턴 -> 테이블에 추가하기 
	public orderlist2 getOrder2(String shopping_userId) {
		orderlist2 od2 = null; 
		
		System.out.println("kkk");
		System.out.println(shopping_userId);
		System.out.println("hhh");
		
		try {
			// 드라이브 로드 디비 연결
			String SQL = "SELECT * FROM orderlist2 where shopping_userId=?"; // SQL 생성
			pstmt = conn.prepareStatement(SQL); // pstmt 생성
			pstmt.setString(1, shopping_userId);

			rs = pstmt.executeQuery(); // 실행 -> rs 저장
			
			if (rs.next()) {
				od2 = new orderlist2();	// Order 클래스의 인스턴스 변수인 od에 new 생성자를 통해 Order 클래스 연결 주소지 저장 
				od2.setShopping_productId(rs.getString("shopping_productId"));	// od변수에 setShopping_productId 메소드 안에 shopping_productId 변수를 인자값으로 한 rs.getString 값을 넣어 쿼리 결과값 저장 
				od2.setShopping_name(rs.getString("shopping_name"));
				od2.setShopping_date(rs.getString("shopping_date"));
				od2.setShopping_country(rs.getString("shopping_country"));
				od2.setShopping_zipCode(rs.getString("shopping_zipCode"));
				od2.setShopping_addressName(rs.getString("shopping_addressName"));
				od2.setShopping_num(rs.getString("shopping_name"));
				od2.setShopping_img(rs.getString("shopping_img"));

				System.out.println("주문정보 저장완료");
			}
			System.out.println("주문정보 SQL 구문실행 완료!");
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return od2;
	}
	
	// 주문데이터 수정페이지 
	public int updateOrder2(orderlist2 od2) {
		int result = -1; 
		
		try {
			// SQL 구문작성 & pstmt 생성
			String SQL = "SELECT password from orderlist2 where id=?"; // SQL 생성
			pstmt = conn.prepareStatement(SQL); // pstmt 생성
			pstmt.setString(1, od2.getShopping_productId());
			
			rs = pstmt.executeQuery();		// SQL 쿼리문의 결과값을 임시로 넣고 rs 저장 
			
			if (rs.next()) {
				SQL = "UPDATE orderlist2 set shopping_name=?, shopping_date=?, shopping_country=?, "
						+ "shopping_zipcode=?, shopping_addressName=?, shopping_num=?, shopping_img=?" + "where shopping_cartId=?";
				pstmt = conn.prepareStatement(SQL);		// SQL 변수에 저장된 쿼리문 실행 
				pstmt.setString(1, od2.getShopping_name());	// 첫 번째 물음표에 저장할 get메소드 값 저장 
				pstmt.setString(2, od2.getShopping_date());
				pstmt.setString(3, od2.getShopping_country());
				pstmt.setString(4, od2.getShopping_zipCode());
				pstmt.setString(5, od2.getShopping_addressName());
				pstmt.setString(6, od2.getShopping_num());
				pstmt.setString(7, od2.getShopping_img());
				
				System.out.println(od2.getShopping_productId());
				
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
	public int order2(String shopping_userId, String shopping_productId, String shopping_name,
			String shopping_date, String shopping_country, String shopping_zipCode, String shopping_addressName, String shopping_img) {
		int shopping_num = help;	// 주문번호 
		
		String sql = "INSERT INTO recypro.orderlist2 VALUES(?,?,?,?,?,?,?,?,?)";	// DB에 추가될 insert 쿼리문 
		try {
			System.out.println("주문 전 주문번호 : " + help);
			System.out.println("계정 : " + shopping_userId);
			System.out.println("상품번호 : " + shopping_productId);
			System.out.println("이름 : " + shopping_name);
			System.out.println("주문일 : " + shopping_date);
			System.out.println("주문한 나라 : " + shopping_country);
			System.out.println("우편번호 : " + shopping_zipCode);
			System.out.println("주소 : " + shopping_addressName);
			System.out.println("상품이미지 : " + shopping_img); 
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, shopping_num);		// 쿼리문 중 첫 번째 물음표에 shopping_num 변수값 대입 
			pstmt.setString(2, shopping_userId); // 쿼리문 중 두 번째 물음표에 shopping_userId 변수값 대입 
			pstmt.setString(3, shopping_productId);
			pstmt.setString(4, shopping_name);
			pstmt.setString(5, shopping_date);
			pstmt.setString(6, shopping_country);
			pstmt.setString(7, shopping_zipCode);
			pstmt.setString(8, shopping_addressName);
			pstmt.setString(9, shopping_img);
			
			System.out.println("주문 후 주문번호 : " + help);
			pstmt.executeUpdate();   // 쿼리문 실행 반영 
			
			help = help + 1;	// 주문번호 반영될 때마다 숫자 증가함 (다음 주문번호 세팅) 
			return help;
		} catch (Exception e) {
			System.out.println("order2 함수 / Try 실패하고 탈출"); 
			e.printStackTrace();
		}
		return -1; 	// 실패로 예시해 놓은 것 
	}
	
	// 마이레벨 구현 메소드 (주문내역 갯수에 따라 레벨제 구현)
	public int myLevel(String shopping_userId) {	
		int countPurchase = 0;		// 구매내역 갯수를 세는 변수 
			
		try {
			String SQL = "SELECT COUNT(*) FROM orderlist2 where shopping_userId = ?";	// 주문내역 테이블 내 컬럼 갯수 세기 
			pstmt = conn.prepareStatement(SQL); // pstmt 생성
			pstmt.setString(1, shopping_userId);

			rs = pstmt.executeQuery(); // 실행 -> rs 저장
				
			if (rs.next()) {	// orderlist 테이블에 저장된 컬럼들을 호출하여 갯수를 세고, 그 갯수에 맞게 레벨 구현 
				countPurchase = rs.getInt(1);	// count(*)로 조회된 결과를 가져옴. 
			} System.out.println("SQL 구문실행 완료!");
				
		} catch (SQLException e) {
			System.out.println("DB 연결이 실패했거나, 쿼리문이 틀렸습니다."); 
			System.out.print("사유 : " + e.getMessage());
		} 

		return countPurchase;
	}
}
