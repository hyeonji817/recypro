package login.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class loginDAO {
	private Connection conn;	// DB ����� ��ü ���� 
	private PreparedStatement pstmt;	// sql injection �� ������ ���� ���� ����ڿ��� ���� ���� �޾Ƽ� ������ ����
	private ResultSet rs;		// SQL�� ���� �� �ش� ���� ����� ��� ��ü
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";	// MySQL�� DB�� ������ �־� �߿��� URL
	private static final String id = "root";		// DB�� ������ ���̵� 
	private static final String password = "1234";		// DB�� ������ �н����� 
	
	public loginDAO() { // DB ���� �޼���, loginDAO �޼ҵ� ��ü�� �ּ��� 
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	// JDBC�� �̿��� DB�� jsp ����
			conn = DriverManager.getConnection(url, id, password);	// �ش� ��ɾ ���� DB�� jsp ����
			// System.out.println("�������");
			} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String id, String password) {		// �α��� ó�������� �����ϴ� �޼ҵ� 
		// �� ���������� ������ �����͸� DB�� �����ϴ� ������ �غ� 
		String SQL = "SELECT password FROM User WHERE id = ?";  // �α��� �Լ� ����� mysql�� �Է��� sql�� �Է�
		try {
			pstmt = conn.prepareStatement(SQL); // conn.prepareStatement(sql) = pstmt������ sql���� ���� ����			
			pstmt.setString(1, id); // sql�� �� ù��° ����ǥ�� ID�� ���� ����
			rs = pstmt.executeQuery(); // sql�� ������ �� ����� rs��� ������ ����(executeQuery ���� ��� ��� ���� ���ڷ� ��ȯ)
			if (rs.next()) { // ���� ���̵� DB�� �����ϴ°��
				if (rs.getString(1).contentEquals(password)) { // ���̵� �ش��ϴ� ��й�ȣ�� ��ġ�ϴ� ���
					return 1;	// �α��� ����s
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
