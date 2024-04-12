package employee.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminDAO {
	private static Connection conn = null; // DB Ŀ�ؼ� ���� ��ü
	private PreparedStatement pstmt;	// sql injection �� ������ ���� ���� ����ڿ��� ���� ���� �޾Ƽ� ������ ����
	private ResultSet rs;	// SQL�� ���� �� �� ����� ��� ��ü
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
	// DBMS�� ������ DB�� ���� �ּ� 
	private static final String id = "root";	// DBMS ���� �� ���̵� 
	private static final String password = "1234";	// DBMS ���� �� ��й�ȣ
	private static final String jdbckk = "com.mysql.cj.jdbc.Driver";	// JDBC ����̹�
	
	public static Connection AdminDAO() {
		try {
			String dbURL = url;	// ������ ������ URL. ��������, �����ּ�, ������Ʈ, DB�̸����� ����
			String dbID = id;	// DB������ �α����� ���� 
			String dbPassword = password;	// DB������ �α����� ��й�ȣ 
			Class.forName(jdbckk);	// �������� JDBC ����̺� Ŭ������ �ε� (DB�� �����ϴ� ��)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// DriverManager Ŭ������ getConnection() �޼ҵ带 �̿��Ͽ� Connection ��ü�� �����ϴ� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	public Admin getAdmin(String id) {
		Admin ad = null;	// Admin ��ü ���۷��� ����
		try {
			conn = AdminDAO();
			
			// ����̺� �ε� ��� ����,  
			String SQL = "SELECT * FROM employee where id=?";	// SQL ����
			// String SQL = "SELECT * FROM admin where id=?";	// SQL ����
			pstmt = conn.prepareStatement(SQL);	// pstmt ���� 
			pstmt.setString(1, id);	
			
			rs = pstmt.executeQuery();	// ���� -> rs ���� 
			
			
			if (rs.next()) {
				ad = new Admin();		// Admin Ŭ������ �ν��Ͻ� ������ ad�� new �����ڸ� ���� Admin Ŭ���� �ּ����� ���� (�ش� �ּҸ� ���� Admin Ŭ������ �̵��Ͽ� ���� �����͵��� ȣ���ϱ� ����) 
				ad.setId(rs.getString("id"));		// ad���� ���� setId �޼ҵ忡 id �Ķ���͸� ���� rs.getString�޼ҵ带 �����Ͽ� ����� ���� 
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
				// ���� �Ǹ��ϰ� �� �޾ƿ� 6�� �÷�����
				
				System.out.println("ȸ������ ����Ϸ�");
			}
			System.out.println("SQL �������� �Ϸ�!");
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return ad;
	}
	
	public int login(String id, String password) {
		// �� ���������� ������ �����͸� DB�� �����ϴ� ������ �غ� 
		String SQL = "SELECT password FROM USER WHERE id = ?";  // �α��� �Լ� ����� mysql�� �Է��� sql�� �Է�
		try {
			pstmt = conn.prepareStatement(SQL); // conn.prepareStatement(sql) = pstmt������ sql���� ���� ����
			pstmt.setString(1, id); // sql�� �� ù��° ����ǥ�� ID�� ���� ����
			rs = pstmt.executeQuery(); // sql�� ������ �� ����� rs��� ������ ����(executeQuery ���� ��� ��� ���� ���ڷ� ��ȯ)
			if (rs.next()) { // ���� ���̵� DB�� �����ϴ°��
				if (rs.getString(1).contentEquals(password)) { // ���̵� �ش��ϴ� ��й�ȣ�� ��ġ�ϴ� ���
					return 1;	// �α��� ����
				}
				else 
					return 0;	// Password ����
			}	// ���� ������ ��
			return -1;	// id ����
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2;	// db ����
	}
}
