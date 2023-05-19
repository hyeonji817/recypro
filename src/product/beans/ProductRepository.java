package product.beans;
// 출처좌표 : https://kjh95.tistory.com/285?category=941468 (이미지 첨부)
// 출처좌표2 : https://kjh95.tistory.com/260?category=941468
// dao -> 싱글톤 패턴 적용
// 출처좌표3 (검색기능 메소드 구현) : https://wogus789789.tistory.com/167

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import product.beans.Product;

public class ProductRepository {	
	private ArrayList<Product> listOfProducts = new ArrayList<>();	// Product 클래스 안의 변수 데이터들을 생성자를 통해 주소지를 저장하여 호출할 수 있게 세팅 
	
	// ProductRepository 인스턴스를 하나만 공유하게끔 싱글톤 패턴 사용
	// ProductRepository 클래스의 기본 생성자에 대한 객체 변수 instance 생성
	private static ProductRepository instance = new ProductRepository();
	// 생성, add 생성자
	
	// ProductRepository 인스턴스를 리턴하는 getter 메소드 
	public static ProductRepository getInstance() {
		return instance;
	}
	
	// DB 접속에 필요한 멤버
	private Connection conn = null;		// DB 연결 객체 선언 
	private PreparedStatement pstmt = null;		// 많은 질의문을 정리할 때 사용하는 객체 
	private ResultSet rs = null;		// ResultSet : select의 결과를 저장하는 객체
	private static String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";	// DB로 연결할 주소 
	private static String id = "root";		// DB로 연결할 아이디 
	private static String password = "1234"; 	// DB로 연결할 비밀번호 

	// 항목을 리턴해주는 객체 추가
	public ArrayList<Product> getAllProducts() {
		
		String sql = "select * from product";		// 실행할 쿼리문 
		
		try {
			// Product.jsp (특정 상품 페이지)를 세팅하는 데 사용됨. 이런 소스가 나중에 Product.jsp를 구성하는데 호출됨 
			conn = getConnection();		// 커넥션 얻기 
			pstmt = conn.prepareStatement(sql);	// 쿼리문을 실행할 준비 
			rs = pstmt.executeQuery(); 	 // DB에 저장되어 있는 상품을 모두 가져와 ResultSet에 담음
			
			while(rs.next()) {
				Product product = new Product();	// 빈 객체인 product에 각각 DB에서 가져온다. 
				product.setProductId(rs.getString("productId"));
				product.setPname(rs.getString("pname"));
				product.setUnitprice(rs.getInt("unitprice"));
				product.setDescription(rs.getString("description"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setNumberOfstock(rs.getLong("numberOfstock"));
				product.setCondition(rs.getString("conditions"));
				product.setFilename(rs.getString("filename"));
				
				listOfProducts.add(product);		// Arraylist 컬렉션에 product 객체 추가 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
				System.out.println("DB연동 해제");
			} catch (Exception e2) {
				e2.printStackTrace();
			} 
		} 
		return listOfProducts;	// 각 객체가 저장되어 ArrayList 리턴함 
	}
	
	// DB 접속 (Connection 객체 리턴하는 메소드)
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	// 드라이버명
			conn = DriverManager.getConnection(url, id, password);	// DB연결 객체 얻음.
			System.out.println("DB 연동 완료");
		} catch (Exception e) {
			System.out.println("DB 연동 실패");
			e.printStackTrace();
		}
		
		return conn;
	} 
	
	// get 방식으로 받은 productId 값을 받아서 리턴해준다.
	// listOfProducts에 저장된 모든 상품 목록을 조회해서 상품아이디와 일치하는 상품을 리턴하는 메소드 
	public Product getProductById(String productId) {
		Product productById = new Product();	// Product 클래스의 데이터들을 호출하기 위해 Product 클래스의 주소지 저장 
		String sql = "select * from product where productId = ?";		// 실행할 쿼리문 

		// Product.jsp (특정 상품 페이지)를 세팅하는 데 사용됨
		try {
			conn = getConnection();		// 커넥션 얻기  
			pstmt = conn.prepareStatement(sql);		// 실행할 쿼리문 세팅 
			pstmt.setString(1, productId);	// 쿼리문 안의 첫 번째 물음표에 변수값 productId 삽입 
			
			rs = pstmt.executeQuery();	// 인자값으로 넘어온 productId에 해당하는 상품을 ResultSet에 저장 
			
			if (!rs.next()) {
				return null;	// 일치하는 상품이 없는 상태 
			}
			
			// 인자값으로 넘어온 productId값이 있다면 
			if(rs.next()) {
				productById.setProductId(rs.getString("productId"));	// DB에 변수 productId 값을 저장 
				productById.setPname(rs.getString("pname"));
				productById.setUnitprice(rs.getInt("unitprice"));
				productById.setDescription(rs.getString("description"));
				productById.setManufacturer(rs.getString("manufacturer"));
				productById.setCategory(rs.getString("category"));
				productById.setNumberOfstock(rs.getLong("numberOfstock"));
				productById.setCondition(rs.getString("conditions"));
				productById.setFilename(rs.getString("filename"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} 
		return productById;
	}  
	
	// 상품을 추가하는 메소드
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}
	
	// 상품검색 메소드 
	public List<Product> select(String findStr) { 
		List<Product> list = new ArrayList<Product>(); 
		
		try {
			conn = getConnection();		// DB 연동 
			
			String Sql = "SELECT * FROM product WHERE pname LIKE ?"; 	// 조회할 쿼리문 
			pstmt = conn.prepareStatement(Sql);
			pstmt.setString(1,  "%" + findStr + "%");
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				Product pd = new Product();
				pd.setPname(rs.getString("pname"));
				pd.setUnitprice(rs.getInt("unitprice"));
				pd.setFilename(rs.getString("filename"));
				pd.setDescription(rs.getString("description"));
				
				list.add(pd);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	} 
}
