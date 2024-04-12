/**
 * �����ߴ� �� ������ �ּ���ǥ ����Ʈ : 
 * https://sowon-dev.github.io/2020/07/13/200714jspi2/ (ȸ������ ���������� ��)
 */

package user.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.PrimitiveIterator.OfDouble;
import com.mysql.cj.x.protobuf.MysqlxConnection.Close;

import user.beans.User;

public class UserDAO {
	private static Connection conn = null; // DB Ŀ�ؼ� ���� ��ü
	private PreparedStatement pstmt; // sql injection �� ������ ���� ���� ����ڿ��� ���� ���� �޾Ƽ� ������ ����
	private ResultSet rs; // SQL�� ���� �� �� ����� ��� ��ü
	private static final String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
	// DBMS�� ������ DB��
	private static final String id = "root"; // DBMS ���� �� ���̵�
	private static final String password = "1234"; // DBMS ���� �� ��й�ȣ
	private static final String jdbckk = "com.mysql.cj.jdbc.Driver"; // JDBC ����̹�

	public static Connection UserDAO() {
		try {
			String dbURL = url; // ������ ������ URL. ��������, �����ּ�, ������Ʈ, DB�̸����� ����
			String dbID = id; // DB������ �α����� ����
			String dbPassword = password; // DB������ �α����� ��й�ȣ
			Class.forName(jdbckk); // �������� JDBC ����̺� Ŭ������ �ε� (DB�� �����ϴ� ��)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// DriverManager Ŭ������ getConnection() �޼ҵ带 �̿��Ͽ� Connection ��ü�� �����ϴ� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}

	// ȸ������ �Է� ��, �Է��� �����͵��� DB�� �����ϴ� ������ �޼ҵ�
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?, ?, ?, ?)"; // 'User' ���̺� �����͸� �Է��ϴ� ������

		try {
			conn = UserDAO();
			pstmt = conn.prepareStatement(SQL); // 'SQL' ������ ����Ŵ

			pstmt.setString(1, user.getId()); // 1��° ����ǥ�� ���� ����ڰ� �Է��� Id�� ����
			pstmt.setString(2, user.getPassword());
			pstmt.setString(3, user.getName());
			pstmt.setString(4, user.getAge());
			pstmt.setString(5, user.getGender());
			pstmt.setString(6, user.getEmail());
			pstmt.setString(7, null); // DB�� ������� �÷� ������ ����� �� (null���� �־��)
			pstmt.setString(8, null);

			return pstmt.executeUpdate(); // ����� ������ ����

		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// ȸ������ �������� �޼ҵ�
	// getUser()�� ȸ������ ���� ���� -> ���̺� �߰� �ʼ�
	// ��ó��ǥ : https://sowon-dev.github.io/2020/07/13/200714jspi2/
	public User getUser(String id) {
		User user = null; // ��ü ���۷��� ����
		// �� null�ΰ�? ������ �����Ǵ� ������ rs�� ���� ���̴�.
		// ���� rs�� ���� �� ���� ���� �ʿ� X

		try {
			conn = UserDAO(); // ����̺� �ε� ��� ����

			// SQL & pstmt ����
			String SQL = "SELECT * FROM user where id=?"; // SQL ����
			pstmt = conn.prepareStatement(SQL); // pstmt ����
			pstmt.setString(1, id);

			rs = pstmt.executeQuery(); // ���� -> rs ����

			// ������ó�� : DB�� �ִ� ȸ������ ���� ��, userinfo �������� ����
			// DB�� �÷����� �Է��� ��
			if (rs.next()) {
				user = new User(); // User Ŭ���� ���� �����͵��� �ҷ�����
				user.setId(rs.getString("id"));
				user.setPassword(rs.getString("password"));
				user.setName(rs.getString("name"));
				user.setAge(rs.getString("age"));
				user.setGender(rs.getString("gender"));
				user.setEmail(rs.getString("email"));
				user.setPassword2("password2");
				user.setPassword3("password3");

				// ���� �Ǹ��ϰ� �� �޾ƿ� 6�� �÷�����
//				System.out.println("ȸ����������Ϸ�");
			}
//			System.out.println("SQL �������� �Ϸ�!");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	// �α��� ó���ϴ� �޼ҵ�
	public int login(String id, String password) {
		// �� ���������� ������ �����͸� DB�� �����ϴ� ������ �غ�
		String SQL = "SELECT password FROM USER WHERE id = ?"; // �α��� �Լ� ����� mysql�� �Է��� sql�� �Է�
		try {
			pstmt = conn.prepareStatement(SQL); // conn.prepareStatement(sql) = pstmt������ sql���� ���� ����
			pstmt.setString(1, id); // sql�� �� ù��° ����ǥ�� ID�� ���� ����
			rs = pstmt.executeQuery(); // sql�� ������ �� ����� rs��� ������ ����(executeQuery ���� ��� ��� ���� ���ڷ� ��ȯ)

			if (rs.next()) { // ���� ���̵� DB�� �����ϴ°��
				if (rs.getString(1).contentEquals(password)) { // ���̵� �ش��ϴ� ��й�ȣ�� ��ġ�ϴ� ���
					return 1; // �α��� ����
				} else
					return 0; // Password ����
			} // ���� ������ ��
			return -1; // id ����
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // db ����
	}

	/**
	 * ������ �� ������ �ּ���ǥ : https://okky.kr/articles/48163 (try ~ catch ���� ���ο� ���� ����
	 * ���Ѵٴ� ����)
	 */
	// ���̵�ã�� �޼ҵ�
	public String findId(String name, String email) {
		String id = null; // ã�� id�� ����
		try {
			String sql = "select id from user where name=? and email=?"; // ������ ������
			pstmt = conn.prepareStatement(sql); // ������ ����
			pstmt.setString(1, name); // ������ �� ����ǥ�� ������ ����
			pstmt.setString(2, email);
			rs = pstmt.executeQuery(); // ������ ����� rs�� ���� (rs - ��� ��¿�)

			if (rs.next()) {
				id = rs.getString("id"); // ������ �� ������ �ּ���ǥ (rs.getString �Ķ���� �ȿ� �÷����� ���� �� ��) :
											// https://allg.tistory.com/21
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}

	// ��й�ȣã�� �޼ҵ�
	public String findPw(String id, String name, String email) {
		String findedpassword = null; // ã�� ��A��ȣ�� ����
		String sql = "SELECT password FROM USER WHERE id= ? and name= ? and email= ?"; // ������ ������
		conn = UserDAO(); // UserDAO �޼ҵ� �ּ����� ���� DB ����

		try {
			pstmt = conn.prepareStatement(sql); // ������ ���� �غ�
			pstmt.setString(1, id); // ������ �� ����ǥ �ȿ� �����ų ������ ����
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			ResultSet rs = pstmt.executeQuery(); // ������ ������ ����� rs�� ���� (rs = ������ ���� ������� ����, ������ ���� �� �����¿�)

			if (rs.next()) // rs ���� �� rs.�Լ��� ����Ϸ��� if �� rs.next()�� �ѹ� ��������Ѵ�. �ƴϸ�
							// javax.servlet.ServletException: java.sql.SQLException: Illegal operation on
							// empty result set. �����߻���
			{
				findedpassword = rs.getString("password"); // getString�� �ȿ� ���� ������ �÷� ���� " " �������� �Է�������� �߿�!!!
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return findedpassword; // ���� �������� ���� ���� findedpassword ���� ���� (��� �� ȣ��)
	}

	// �н����� ã�� ���������� ��ư ��������, �Է°��� DB���� ���ϱ� ���� ���� �Լ���.
	public String checkpwinfo(String id, String name, String email) {
		String findedid = null;
		String sql = "SELECT id FROM USER WHERE id= ? and name= ? and email= ?"; // ������ ������
		conn = UserDAO();

		try {
			pstmt = conn.prepareStatement(sql); // ������ ������ �غ�
			pstmt.setString(1, id); // ������ �� ����ǥ �ȿ� ����� ������ ����
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			ResultSet rs = pstmt.executeQuery(); // ������ ������ ����� rs�� ���� (������ ���� �� ��� ���)

			if (rs.next()) // rs ���� �� rs.�Լ��� ����Ϸ��� if �� rs.next()�� �ѹ� ��������Ѵ�. �ƴϸ�
							// javax.servlet.ServletException: java.sql.SQLException: Illegal operation on
							// empty result set. �����߻���
			{
				findedid = rs.getString("id"); // getString�� �ȿ� ���� ������ �÷� ���� " " �������� �Է�������� �߿�!!!
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return findedid;
	}

	// ������ �� ������ �ּ���ǥ : https://zinisang.tistory.com/5 (�������� ���� �� �ʿ��� �� ����), ��������
	// ������ �ذ��� �� ����� ��
	public int updateUser(User user) {
		int result = -1;

		try {
			conn = UserDAO();
			// SQL �����ۼ� & pstmt ����
			String SQL = "SELECT password from user where id=?"; // ������ ������

			pstmt = conn.prepareStatement(SQL); // ������ ���� �غ�
			pstmt.setString(1, user.getId()); // ������ �� ����ǥ�� ������ �޼ҵ尪 ����

			rs = pstmt.executeQuery(); // ����� �ӽ÷γְ�, rs ����
			if (rs.next()) { // DB�� �ִ� ȸ��. rs.next() �޼ҵ带 ����Ͽ� rs ������ ���� ���
				if (user.getPassword().equals(rs.getString("password"))) { // ����� ��ġ�� ���
					// equals�޼ҵ尡 �ƴ϶�, '=='���� �ؾ� ��

					SQL = "UPDATE user set name=?, age=?, gender=?, email=?, password=? where id=?"; // ������ ������2
					pstmt = conn.prepareStatement(SQL); // ������ ���� �غ�
					pstmt.setString(1, user.getName()); // ������ �� ����ǥ�� ������ �޼ҵ尪 ����
					pstmt.setString(2, user.getAge());
					pstmt.setString(3, user.getGender());
					pstmt.setString(4, user.getEmail());

					System.out.println(user.getPassword2());
					System.out.println(user.getPassword3());

					if (user.getPassword2().equals(user.getPassword3()) && user.getPassword2() != null
							&& user.getPassword3() != null) {
						pstmt.setString(5, user.getPassword3());
					} else {
						pstmt.setString(5, user.getPassword());
					}
					pstmt.setString(6, user.getId());

					// ����
					pstmt.executeUpdate();
					result = 1;
				} else {
					result = 0;
				}
			} else { // DB�� ���� ȸ��
				result = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}

	// �н����� ���� �޼ҵ�
	public int passwordchange(User user) {
		int result = -1;
		try {
			conn = UserDAO();
			String SQL = "SELECT password from user where id=?"; // ������ ������
			pstmt = conn.prepareStatement(SQL); // ������ ������ �غ�
			pstmt.setString(1, user.getId()); // ������ �� ����ǥ �ȿ� �� ���� �޼ҵ� (���� �޼ҵ尪 ����)
			if (rs.next()) { // DB�� �ִ� ȸ��
				if (user.getPassword().equals(rs.getString("password"))) { // ����� ��ġ�� ���
					// equals�޼ҵ尡 �ƴ϶�, '=='���� �ؾ� ��

					// ����� ��ġ�ϸ� �������� �۾�
					// SQL �����ۼ� & pstmt ����
					conn = UserDAO(); // DB�� UserDAO �޼ҵ� ��ü�� �ּҿ� ����
					SQL = "UPDATE user set password=?" + "where id=?"; // ������ ������2
					pstmt = conn.prepareStatement(SQL); // ������ ������ �غ�
					pstmt.setString(1, user.getName()); // ������ �� ����ǥ �ȿ� �� ���� �޼ҵ� (���� �޼ҵ尪 ����)

					// ����
					pstmt.executeUpdate();
					result = 1;
				} else {
					result = 0;
				}
			} else { // DB�� ���� ȸ��
				result = -1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return result;
	}
}