package orderlist2.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class orderlist2DAO {
	private static Connection conn; // DB Ŀ�ؼ� ���� ��ü
	private PreparedStatement pstmt; // SQL injection ���� ������ ���� ���� ����ڿ��� ���� ���� �޾Ƽ� ���� ���� (�����)
	private ResultSet rs; // SQL�� ���� �� �� ����� ��� ��ü	(�����)
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
	// DBMS�� ������ DB��
	private static final String id = "root"; // DBMS ���� �� ���̵�
	private static final String password = "1234"; // DBMS ���� �� ��й�ȣ
	private static final String jdbckk = "com.mysql.cj.jdbc.Driver"; // JDBC ����̹�
	private static int help = 1;
	
	public orderlist2DAO() {	// orderlist2DAO �޼ҵ� ��ü�� ������ ���� �ּ��� 
		try {
			String dbURL = url; // ������ ������ URL. ��������, �����ּ�, ������Ʈ, DB �̸����� ����
			String dbID = id; // DB ������ �α����� ����
			String dbPassword = password; // DB ������ �α����� ��й�ȣ
			Class.forName(jdbckk); // �������� JDBC ����̺� Ŭ������ �ε� (DB�� �����ϴ� ��)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// DriverManager Ŭ������ getConnection() �޼ҵ带 �̿��Ͽ� Connection ��ü�� �����ϴ� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// orderlist2DAO �ν��Ͻ��� �ϳ��� �����ϰԲ� �̱��� ���� ��� 
	// orderlist2DAO Ŭ������ �⺻ �����ڿ� ���� ��ü ���� instance ���� 
	private static orderlist2DAO instance = new orderlist2DAO();
	
	public static orderlist2DAO getInstance() {
		return instance; 
	}
	
	// �ֹ����� ���� �������� �޼ҵ� 
	// getOrder2()�� �ֹ����� ���� ���� -> ���̺� �߰��ϱ� 
	public orderlist2 getOrder2(String shopping_userId) {
		orderlist2 od2 = null; 
		
		System.out.println("kkk");
		System.out.println(shopping_userId);
		System.out.println("hhh");
		
		try {
			// ����̺� �ε� ��� ����
			String SQL = "SELECT * FROM orderlist2 where shopping_userId=?"; // SQL ����
			pstmt = conn.prepareStatement(SQL); // pstmt ����
			pstmt.setString(1, shopping_userId);

			rs = pstmt.executeQuery(); // ���� -> rs ����
			
			if (rs.next()) {
				od2 = new orderlist2();	// Order Ŭ������ �ν��Ͻ� ������ od�� new �����ڸ� ���� Order Ŭ���� ���� �ּ��� ���� 
				od2.setShopping_productId(rs.getString("shopping_productId"));	// od������ setShopping_productId �޼ҵ� �ȿ� shopping_productId ������ ���ڰ����� �� rs.getString ���� �־� ���� ����� ���� 
				od2.setShopping_name(rs.getString("shopping_name"));
				od2.setShopping_date(rs.getString("shopping_date"));
				od2.setShopping_country(rs.getString("shopping_country"));
				od2.setShopping_zipCode(rs.getString("shopping_zipCode"));
				od2.setShopping_addressName(rs.getString("shopping_addressName"));
				od2.setShopping_num(rs.getString("shopping_name"));
				od2.setShopping_img(rs.getString("shopping_img"));

				System.out.println("�ֹ����� ����Ϸ�");
			}
			System.out.println("�ֹ����� SQL �������� �Ϸ�!");
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return od2;
	}
	
	// �ֹ������� ���������� 
	public int updateOrder2(orderlist2 od2) {
		int result = -1; 
		
		try {
			// SQL �����ۼ� & pstmt ����
			String SQL = "SELECT password from orderlist2 where id=?"; // SQL ����
			pstmt = conn.prepareStatement(SQL); // pstmt ����
			pstmt.setString(1, od2.getShopping_productId());
			
			rs = pstmt.executeQuery();		// SQL �������� ������� �ӽ÷� �ְ� rs ���� 
			
			if (rs.next()) {
				SQL = "UPDATE orderlist2 set shopping_name=?, shopping_date=?, shopping_country=?, "
						+ "shopping_zipcode=?, shopping_addressName=?, shopping_num=?, shopping_img=?" + "where shopping_cartId=?";
				pstmt = conn.prepareStatement(SQL);		// SQL ������ ����� ������ ���� 
				pstmt.setString(1, od2.getShopping_name());	// ù ��° ����ǥ�� ������ get�޼ҵ� �� ���� 
				pstmt.setString(2, od2.getShopping_date());
				pstmt.setString(3, od2.getShopping_country());
				pstmt.setString(4, od2.getShopping_zipCode());
				pstmt.setString(5, od2.getShopping_addressName());
				pstmt.setString(6, od2.getShopping_num());
				pstmt.setString(7, od2.getShopping_img());
				
				System.out.println(od2.getShopping_productId());
				
				pstmt.executeUpdate();		// update ������ ���� �ݿ� 
				System.out.println("�ֹ����� ��������"); 
				result = 1; 
			} else {
				result = 0; 
				System.out.println("�ֹ����� ��������"); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result; 
	}
	
	// �ֹ����� ����ϴ� �޼ҵ� 
	public int order2(String shopping_userId, String shopping_productId, String shopping_name,
			String shopping_date, String shopping_country, String shopping_zipCode, String shopping_addressName, String shopping_img) {
		int shopping_num = help;	// �ֹ���ȣ 
		
		String sql = "INSERT INTO recypro.orderlist2 VALUES(?,?,?,?,?,?,?,?,?)";	// DB�� �߰��� insert ������ 
		try {
			System.out.println("�ֹ� �� �ֹ���ȣ : " + help);
			System.out.println("���� : " + shopping_userId);
			System.out.println("��ǰ��ȣ : " + shopping_productId);
			System.out.println("�̸� : " + shopping_name);
			System.out.println("�ֹ��� : " + shopping_date);
			System.out.println("�ֹ��� ���� : " + shopping_country);
			System.out.println("�����ȣ : " + shopping_zipCode);
			System.out.println("�ּ� : " + shopping_addressName);
			System.out.println("��ǰ�̹��� : " + shopping_img); 
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, shopping_num);		// ������ �� ù ��° ����ǥ�� shopping_num ������ ���� 
			pstmt.setString(2, shopping_userId); // ������ �� �� ��° ����ǥ�� shopping_userId ������ ���� 
			pstmt.setString(3, shopping_productId);
			pstmt.setString(4, shopping_name);
			pstmt.setString(5, shopping_date);
			pstmt.setString(6, shopping_country);
			pstmt.setString(7, shopping_zipCode);
			pstmt.setString(8, shopping_addressName);
			pstmt.setString(9, shopping_img);
			
			System.out.println("�ֹ� �� �ֹ���ȣ : " + help);
			pstmt.executeUpdate();   // ������ ���� �ݿ� 
			
			help = help + 1;	// �ֹ���ȣ �ݿ��� ������ ���� ������ (���� �ֹ���ȣ ����) 
			return help;
		} catch (Exception e) {
			System.out.println("order2 �Լ� / Try �����ϰ� Ż��"); 
			e.printStackTrace();
		}
		return -1; 	// ���з� ������ ���� �� 
	}
	
	// ���̷��� ���� �޼ҵ� (�ֹ����� ������ ���� ������ ����)
	public int myLevel(String shopping_userId) {	
		int countPurchase = 0;		// ���ų��� ������ ���� ���� 
			
		try {
			String SQL = "SELECT COUNT(*) FROM orderlist2 where shopping_userId = ?";	// �ֹ����� ���̺� �� �÷� ���� ���� 
			pstmt = conn.prepareStatement(SQL); // pstmt ����
			pstmt.setString(1, shopping_userId);

			rs = pstmt.executeQuery(); // ���� -> rs ����
				
			if (rs.next()) {	// orderlist ���̺� ����� �÷����� ȣ���Ͽ� ������ ����, �� ������ �°� ���� ���� 
				countPurchase = rs.getInt(1);	// count(*)�� ��ȸ�� ����� ������. 
			} System.out.println("SQL �������� �Ϸ�!");
				
		} catch (SQLException e) {
			System.out.println("DB ������ �����߰ų�, �������� Ʋ�Ƚ��ϴ�."); 
			System.out.print("���� : " + e.getMessage());
		} 

		return countPurchase;
	}
}
