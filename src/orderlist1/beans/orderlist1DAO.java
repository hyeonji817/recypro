package orderlist1.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class orderlist1DAO {
	private static Connection conn; // DB Ŀ�ؼ� ���� ��ü
	private PreparedStatement pstmt; // SQL injection ���� ������ ���� ���� ����ڿ��� ���� ���� �޾Ƽ� ���� ���� (�����)
	private ResultSet rs; // SQL�� ���� �� �� ����� ��� ��ü	(�����)
	
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
	// DBMS�� ������ DB��
	private static final String id = "root"; // DBMS ���� �� ���̵�
	private static final String password = "1234"; // DBMS ���� �� ��й�ȣ
	private static final String jdbckk = "com.mysql.cj.jdbc.Driver"; // JDBC ����̹�
	private static int help = 1;
	
	public orderlist1DAO() {
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
	
	// orderlist1DAO �ν��Ͻ��� �ϳ��� �����ϰԲ� �̱��� ���� ��� 
	// orderlist1DAO Ŭ������ �⺻ �����ڿ� ���� ��ü ���� instance ���� 
	private static orderlist1DAO instance = new orderlist1DAO(); 
	
	public static orderlist1DAO getInstance() {
		return instance;
	}
	
	// �ֹ����� ���� �������� �޼ҵ� 
	// getOrder1()�� �ֹ����� ���� ���� -> ���̺� �߰��ϱ� 
	public orderlist1DAO getOrder1(String shopping_num) {
		orderlist1DAO od1 = null; 
		
		try {
			// ����̺� �ε� ��� ����
			String SQL = "SELECT * FROM orderlist1 where shopping_num=?"; // SQL ����
			pstmt = conn.prepareStatement(SQL); // pstmt ����
			pstmt.setString(1, shopping_num);
			
			rs = pstmt.executeQuery();	// ���� -> rs ���� 
			
			if (rs.next()) {
				od1 = new orderlist1();	// orderlist1 Ŭ������ �ν��Ͻ� ������ od�� new �����ڸ� ���� orderlist1 Ŭ���� ���� �ּ��� ���� 
				od1.setShopping_num(rs.getString("shopping_num")); 
				od1.setShopping_bank(rs.getString("shopping_bank"));
				od1.setReturn_reason(rs.getString("return_reason"));
				od1.setShopping_account(rs.getString("shopping_account"));
				od1.setShopping_owner(rs.getString("shopping_owner")); 
				
				System.out.println("�ֹ����� ����Ϸ�"); 
			}
			System.out.println("�ֹ����� SQL �������� �Ϸ�!"); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return od1; 
	}
	
	// �ֹ������� ���������� 
	public int updateOrder1(orderlist1 od1) {
		int result = -1; 
		
		try {
			// SQL �����ۼ� & pstmt ����
			String SQL = "SELECT password from orderlist1 where shopping_num=?"; // SQL ����
			pstmt = conn.prepareStatement(SQL); // pstmt ����
			pstmt.setInt(1, od1.getShopping_num());
			
			rs = pstmt.executeQuery();		// SQL �������� ������� �ӽ÷� �ְ� rs ���� 
			
			if (rs.next()) {
				SQL = "UPDATE orderlist1 set shopping_bank=?, return_reason=?, shopping_account=?, shopping_owner=?" + "where shopping_num=?";
				
				pstmt = conn.prepareStatement(SQL);		// SQL ������ ����� ������ ���� 
				pstmt.setString(1, od1.getShopping_bank()); 	// ù ��° ���ǹ��� ������ get�޼ҵ� �� ���� 
				pstmt.setString(2, od1.getReturn_reason()); 	
				pstmt.setString(3, od1.getShopping_account());		
				pstmt.setString(4, od1.getShopping_owner());	
				
				System.out.println(od1.getShopping_num());	
				
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
	public int order1(Integer shopping_num, String shopping_bank, String return_reason, String shopping_account, String shopping_owner) {
		// int shopping_num = help; 
		
		String sql = "INSERT INTO recypro.orderlist1 VALUES(?,?,?,?,?)";	// DB�� �߰��� insert ������ 
		try {
			System.out.println("�ֹ� �� �ֹ���ȣ : " + help);
			System.out.println("����� ����� : " + shopping_bank);
			System.out.println("��ǰ���� : " + return_reason);
			System.out.println("���¹�ȣ : " + shopping_account);
			System.out.println("������ : " + shopping_owner);
			
			pstmt = conn.prepareStatement(sql); 
			
			pstmt.setInt(1, shopping_num);
			pstmt.setString(2, shopping_bank);
			pstmt.setString(3, return_reason);
			pstmt.setString(4, shopping_account);
			pstmt.setString(5, shopping_owner);
			
			System.out.println("�ֹ� �� �ֹ���ȣ : " + help); 
			pstmt.executeUpdate();		// ������ ���� �ݿ� 
		} catch (Exception e) {
			System.out.println("order1 �Լ� / Try �����ϰ� Ż��"); 
			e.printStackTrace();
		}
		return -1;		// ���з� ������ ���� �� 
	}
}