package register.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class RegisterDAO {
	private Connection conn;		// DB ���� Ŀ�ؼ� ��ü ���� 
	private PreparedStatement pstmt;		// ������ ���� ��ü ���� 
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";	// MySQL�� DB�� ������ �־� �߿��� URL
	private static final String id = "root";	// DB�� ������ ���̵� 
	private static final String password = "1234";		// DB�� ������ �н����� 
	
	public RegisterDAO() { // DB ���� �޼���
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");	// JDBC�� �̿��� DB�� jsp ����
			conn = DriverManager.getConnection(url, id, password);	// �ش� ��ɾ ���� DB�� jsp ����
			System.out.println("�������");
			} 
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// ȸ������ ��, �Է��� �����͵��� DB�� ����Ǵ� ������ �����ϴ� �޼ҵ� 
	public int join(String id, String password, String name, int age, String gender, String email) {
		String SQL = "INSERT INTO User VALUES (?,?,?,?,?,?)";		// ������ ������ 
		try {
			// ������ �����͸� DB�� ������ �־��ش�.
			pstmt = conn.prepareStatement(SQL);
			
			// �������� ?�ȿ� ������ �����͸� �־��ش�.
			pstmt.setString(1, id);
			pstmt.setString(2, password); 
			pstmt.setString(3, name);
			pstmt.setInt(4, age);
			pstmt.setString(5, gender);
			pstmt.setString(6, email);
			
			System.out.println("userdao/join/�������");
			// ��ɾ ������ ��� ��ȯ, ��ȯ��: insert�� �� �������� ����
			return pstmt.executeUpdate();	// ������ ������ ����� ���� 
		} catch (Exception e) {
			System.out.println("Join �Լ� / try ����");
			e.printStackTrace();
		}
		System.out.println("���");
		return -1;
	} 
}
