package popular_product.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class popular_pdDAO {
	private ArrayList<popular_product> listOfpp = new ArrayList<>(); // popular_product 클래스 안의 변수 데이터들을 생성자를 통해 주소지를
																		// 저장하여 호출할 수 있게 세팅

	// popular_pdDAO 인스턴스를 하나만 공유하게끔 싱글톤 패턴 사용
	// popluar_pdDAO 클래스의 기본 생성자에 대한 객체 변수 instance 생성
	private static popular_pdDAO instance = new popular_pdDAO();
	// add 생성자

	// popular_pdDAO 인스턴스를 리턴하는 getter 메소드
	public static popular_pdDAO getInstance() {
		return instance;
	}

	// DB 접속에 필요한 멤버
	private Connection conn = null; // DB 연결 객체 선언
	private PreparedStatement pst = null; // 많은 쿼리문을 정리할 때 사용하는 객체 (쿼리문 준비하는 바구니 같은 류)
	private ResultSet rs = null; // Resultset : select의 결과를 저장하는 객체
	private static String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // DB로
																													// 연결할
																													// 주소
	private static String id = "root"; // DB로 연결할 아이디
	private static String password = "1234"; // DB로 연결할 비밀번호

	// 항목을 리턴해주는 객체 추가
	public ArrayList<popular_product> getProducts() {
		String sql = "select * from popular_product"; // 실행할 쿼리문

		try {
			// Product.jsp (특정 인기 상품 페이지)를 세팅하는 데 사용됨. 이런 소스가 나중에 Product.jsp를 구성하는 데 호출됨
			conn = getConnection(); // 커넥션 얻기
			pst = conn.prepareStatement(sql); // 쿼리문을 실행할 객체 선언
			rs = pst.executeQuery(); // DB에 저장되어 있는 인기상품을 모두 가져와 ResultSet에 담음

			while (rs.next()) {
				popular_product pp = new popular_product(); // 빈 객체인 pp(인스턴스화, 분신)에 각각 DB에서 가져온다.
				pp.setProductId(rs.getString("productId"));
				pp.setPname(rs.getString("pname"));
				pp.setUnitprice(rs.getInt("unitprice"));
				pp.setDescription(rs.getString("description"));
				pp.setManufacturer(rs.getString("manufacturer"));
				pp.setCategory(rs.getString("category"));
				pp.setNumberOfstock(rs.getLong("numberOfstock"));
				pp.setCondition(rs.getString("conditions"));
				pp.setImg_name(rs.getString("img_name"));

				listOfpp.add(pp); // Arraylist 컬렉션에 pp 인스턴스 객체 추가
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pst != null)
					pst.close();
				if (conn != null)
					conn.close();
				System.out.println("DB 연동해제");
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return listOfpp; // 각 객체가 저장되어 ArrayList 리턴함
	}

	// DB 접속 (Connection 객체 리턴하는 메소드)
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명
			conn = DriverManager.getConnection(url, id, password); // DB연결 객체 얻음.
			System.out.println("DB 연동 완료");
		} catch (Exception e) {
			System.out.println("DB 연동 실패");
			e.printStackTrace();
		}

		return conn;
	}

	// get 방식으로 받은 productId 값을 받아서 리턴한다.
	// listOfpp에서 저장된 모든 상품 목록을 조회해서 상품 아이디와 일치하는 상품을 리턴하는 메소드
	public popular_product getProductById(String productId) {
		popular_product productById = new popular_product(); // popular_product 클래스의 데이터들을 호출하기 위해 Product 클래스의 주소지 저장
		String sql = "select * from popular_product where productId = ?"; // 실행할 쿼리문

		// Product.jsp (특정 인기상품 페이지)를 세팅하는 데 사용됨
		try {
			conn = getConnection(); // 커넥션 얻기
			pst = conn.prepareStatement(sql); // 실행할 쿼리문 세팅
			pst.setString(1, productId); // 쿼리문 안의 첫 번째 물음표에 변수값 productId 삽입

			rs = pst.executeQuery(); // 인자값으로 넘어온 productId에 해당하는 인기상품을 ResultSet에 저장

			if (!rs.next()) {
				return null; // 일치하는 인기상품이 없는 상태
			}

			// 인자값으로 넘어온 productId값이 있다면
			if (rs.next()) {
				productById.setProductId(rs.getString("productId")); // DB에 변수 productId 값을 저장
				productById.setPname(rs.getString("pname"));
				productById.setUnitprice(rs.getInt("unitprice"));
				productById.setDescription(rs.getString("description"));
				productById.setManufacturer(rs.getString("manufacturer"));
				productById.setCategory(rs.getString("category"));
				productById.setNumberOfstock(rs.getLong("numberOfstock"));
				productById.setCondition(rs.getString("conditions"));
				productById.setImg_name(rs.getString("img_name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pst != null)
					pst.close();
				if (conn != null)
					conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return productById;
	}

	// 상품을 추가하는 메소드
	public void addProduct(popular_product pp) {
		listOfpp.add(pp);
	}
}
