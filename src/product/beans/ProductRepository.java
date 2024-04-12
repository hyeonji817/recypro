package product.beans;
// ��ó��ǥ : https://kjh95.tistory.com/285?category=941468 (�̹��� ÷��)
// ��ó��ǥ2 : https://kjh95.tistory.com/260?category=941468
// dao -> �̱��� ���� ����
// ��ó��ǥ3 (�˻���� �޼ҵ� ����) : https://wogus789789.tistory.com/167

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import product.beans.Product;

public class ProductRepository {	
	private ArrayList<Product> listOfProducts = new ArrayList<>();	// Product Ŭ���� ���� ���� �����͵��� �����ڸ� ���� �ּ����� �����Ͽ� ȣ���� �� �ְ� ���� 
	
	// ProductRepository �ν��Ͻ��� �ϳ��� �����ϰԲ� �̱��� ���� ���
	// ProductRepository Ŭ������ �⺻ �����ڿ� ���� ��ü ���� instance ����
	private static ProductRepository instance = new ProductRepository();
	// ����, add ������
	
	// ProductRepository �ν��Ͻ��� �����ϴ� getter �޼ҵ� 
	public static ProductRepository getInstance() {
		return instance;
	}
	
	// DB ���ӿ� �ʿ��� ���
	private Connection conn = null;		// DB ���� ��ü ���� 
	private PreparedStatement pstmt = null;		// ���� ���ǹ��� ������ �� ����ϴ� ��ü 
	private ResultSet rs = null;		// ResultSet : select�� ����� �����ϴ� ��ü
	private static String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";	// DB�� ������ �ּ� 
	private static String id = "root";		// DB�� ������ ���̵� 
	private static String password = "1234"; 	// DB�� ������ ��й�ȣ 

	// �׸��� �������ִ� ��ü �߰�
	public ArrayList<Product> getAllProducts() {
		
		String sql = "select * from product";		// ������ ������ 
		
		try {
			// Product.jsp (Ư�� ��ǰ ������)�� �����ϴ� �� ����. �̷� �ҽ��� ���߿� Product.jsp�� �����ϴµ� ȣ��� 
			conn = getConnection();		// Ŀ�ؼ� ��� 
			pstmt = conn.prepareStatement(sql);	// �������� ������ �غ� 
			rs = pstmt.executeQuery(); 	 // DB�� ����Ǿ� �ִ� ��ǰ�� ��� ������ ResultSet�� ����
			
			while(rs.next()) {
				Product product = new Product();	// �� ��ü�� product�� ���� DB���� �����´�. 
				product.setProductId(rs.getString("productId"));
				product.setPname(rs.getString("pname"));
				product.setUnitprice(rs.getInt("unitprice"));
				product.setDescription(rs.getString("description"));
				product.setManufacturer(rs.getString("manufacturer"));
				product.setCategory(rs.getString("category"));
				product.setNumberOfstock(rs.getLong("numberOfstock"));
				product.setCondition(rs.getString("conditions"));
				product.setFilename(rs.getString("filename"));
				
				listOfProducts.add(product);		// Arraylist �÷��ǿ� product ��ü �߰� 
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) rs.close();
				if (pstmt != null) pstmt.close();
				if (conn != null) conn.close();
				System.out.println("DB���� ����");
			} catch (Exception e2) {
				e2.printStackTrace();
			} 
		} 
		return listOfProducts;	// �� ��ü�� ����Ǿ� ArrayList ������ 
	}
	
	// DB ���� (Connection ��ü �����ϴ� �޼ҵ�)
	public Connection getConnection() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	// ����̹���
			conn = DriverManager.getConnection(url, id, password);	// DB���� ��ü ����.
			System.out.println("DB ���� �Ϸ�");
		} catch (Exception e) {
			System.out.println("DB ���� ����");
			e.printStackTrace();
		}
		
		return conn;
	} 
	
	// get ������� ���� productId ���� �޾Ƽ� �������ش�.
	// listOfProducts�� ����� ��� ��ǰ ����� ��ȸ�ؼ� ��ǰ���̵�� ��ġ�ϴ� ��ǰ�� �����ϴ� �޼ҵ� 
	public Product getProductById(String productId) {
		Product productById = new Product();	// Product Ŭ������ �����͵��� ȣ���ϱ� ���� Product Ŭ������ �ּ��� ���� 
		String sql = "select * from product where productId = ?";		// ������ ������ 

		// Product.jsp (Ư�� ��ǰ ������)�� �����ϴ� �� ����
		try {
			conn = getConnection();		// Ŀ�ؼ� ���  
			pstmt = conn.prepareStatement(sql);		// ������ ������ ���� 
			pstmt.setString(1, productId);	// ������ ���� ù ��° ����ǥ�� ������ productId ���� 
			
			rs = pstmt.executeQuery();	// ���ڰ����� �Ѿ�� productId�� �ش��ϴ� ��ǰ�� ResultSet�� ���� 
			
			if (!rs.next()) {
				return null;	// ��ġ�ϴ� ��ǰ�� ���� ���� 
			}
			
			// ���ڰ����� �Ѿ�� productId���� �ִٸ� 
			if(rs.next()) {
				productById.setProductId(rs.getString("productId"));	// DB�� ���� productId ���� ���� 
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
	
	// ��ǰ�� �߰��ϴ� �޼ҵ�
	public void addProduct(Product product) {
		listOfProducts.add(product);
	}
	
	// ��ǰ�˻� �޼ҵ� 
	public List<Product> select(String findStr) { 
		List<Product> list = new ArrayList<Product>(); 
		
		try {
			conn = getConnection();		// DB ���� 
			
			String Sql = "SELECT * FROM product WHERE pname LIKE ?"; 	// ��ȸ�� ������ 
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
