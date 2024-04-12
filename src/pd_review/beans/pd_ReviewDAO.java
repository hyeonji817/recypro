package pd_review.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class pd_ReviewDAO {
	private Connection conn; // DB ���� ��ü ����
	private ResultSet rs; // DB ������ ��� ������ ��ü ����

	// �⺻ ������, pd_ReviewDAO �޼ҵ� ��ü�� ������ �ּ���
	public pd_ReviewDAO() {
		try { // try ~ catch ��� ���� (������) : �ڵ� ��ũ��Ʈ�� ������ �߻��ϸ� �ܼ��� ��� �� �ǰ� ������ ã�� ����ϱ�, ����ó�� �߻���
				// ���� ������ �ľ��ϰ� �ذ��ϴ� ����� ����ϱ� ����
			String dbURL = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // ������ DB��
																											// �ּ���
			String dbID = "root"; // ������ DB�� ���� ���̵�
			String dbPassword = "1234"; // ������ DB�� ���� ��й�ȣ
			Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL�� ������ �� �ֵ��� �ϴ� �Ű�ü (���̺귯��)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// �Ű������� ���� DB�� ������ �� �ֵ��� ��. ������ �Ϸ�Ǹ� conn ��ü�� ���������� ���� ��.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// �ۼ����� �޼ҵ�. ���� �ð��� ���� ���� �Լ� (�Խñ� �ۼ����ڸ� ������ �� �ʿ�)
	public String getDate() { // �޼ҵ带 String(���ڿ�) �������� ���
		String sql = "select now()";
		try {
			// ���� ���� �Լ��� ���Ǳ� ������ �� DB ���ٿ� �־ ������ �Ͼ�� �ʵ��� �� �Լ� ���ο��� �����ϵ��� ��
			PreparedStatement pstmt = conn.prepareStatement(sql); // conn ��ü�� �̿�. SQL������ �����غ�� ����
			rs = pstmt.executeQuery(); // ������ ���� ������� rs ������ ����
			if (rs.next()) {
				return rs.getString(1); // 1�� �ؼ� ���� ��¥ �״�� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; // �����ͺ��̽� ����
	}

	// �Խñ� ��ȣ �ο� �޼ҵ�. ���� �ֱ� �Խù��� ID���� �������� �Լ�
	public int getNext() {
		// ���� �Խñ��� ������������ ��ȸ�Ͽ� ���� ������ ���� ��ȣ�� ���Ѵ�.
		String SQL = "select pd_reviewId from pd_review order by pd_reviewId desc";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // ������ ��ü�� �ν��Ͻ� ������ �����, conn ��ü �ȿ� ���� SQL�� ���ڰ����� ��
																	// prepareStatement �޼ҵ带 �����Ͽ� �����ų �غ�
			// conn ��ü�� �̿�. SQL ������ �����غ�� ����
			rs = pstmt.executeQuery(); // ������ ������ ������� rs�� ����

			if (rs.next()) {
				return rs.getInt(1) + 1; // 1�� ���ؼ� �� ���� �Խñ��� �� �� �ֵ��� �Ѵ�. || rs.getInt(1) : �˻��� ���� ù ��° �÷���
			}

			return 1; // ù ��° �Խù��� ���
		}

		catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}

	// �۾��� �޼ҵ�.
	// ������, ����� ID, �� ������ ���޹޾� DB�� ���ο� �����͸� �Է�
	// �Խñ� ��ȣ -> ��ǰ�� -> �� ���� -> �����ID -> �ۼ�����, �� ����, ��ȿ��ȣ ������ �����͸� �����ϰ� �����ͺ��̽��� ����
	// �Ű������� ��ǰ��, ������, �� �Է��� ����� ID, �� ������ �Է¹ް� ���� �����ͺ��̽��� ���̺� �Ӽ� ������ �°� �����͸� �Է��ϴ�
	// �޼ҵ�
	public int write(String pd_productId, String pd_reviewTitle, String pd_userId, String pd_reviewContent) {
		String SQL = "insert into pd_review values(?, ?, ?, ?, ?, ?, ?)"; // �����ͺ��̽� �ڵ�
		System.out.println("���� ����");
		System.out.println(pd_userId);
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // conn ��ü�� �̿�. SQL ������ �����غ��
			pstmt.setInt(1, getNext()); // getNext ���� ���� ���� �Խñ� ��ȣ
			pstmt.setString(2, pd_userId); // �� ��° ����ǥ�� �� ���� pd_userId �����Ͽ� �� ����
			pstmt.setString(3, pd_productId);
			pstmt.setString(4, getDate());
			pstmt.setString(5, pd_reviewTitle);
			pstmt.setString(6, pd_reviewContent);
			pstmt.setInt(7, 1); // ���� ��ȿ��ȣ. ������ ���� �ִ� �����̱� ������ 1
			return pstmt.executeUpdate(); // ���������� ���� ��, 0 �̻��� �� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}

	public ArrayList<pd_Review> getList(int pageNumber) { // Ư���� �������� �ٸ� �Խñ� ������ �� �ֵ���
		String SQL = "SELECT * FROM pd_review WHERE pd_reviewId < ? AND pd_reviewAvailable = 1 ORDER BY pd_reviewId DESC LIMIT 10";
		// pd_reviewId�� Ư���� ���ں��� ���� ��, �����ϴ� �� Available=1, ������ 10������ ��������
		ArrayList<pd_Review> list = new ArrayList<pd_Review>(); // pd_Review���� ������ �ν��Ͻ� ����
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // conn ��ü�� �̿�. SQL ������ �����غ�� ����.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // getnext �������� �ۼ��� ���� ��ȣ
			rs = pstmt.executeQuery(); // ������ �������� ��� ��� �غ�
			while (rs.next()) {
				pd_Review pd_rv = new pd_Review(); // pd_Review�� ��� ������ ��������
				pd_rv.setPd_reviewId(rs.getInt(1));
				pd_rv.setPd_userid(rs.getString(2));
				pd_rv.setPd_productId(rs.getString(3));
				pd_rv.setPd_reviewDate(rs.getString(4));
				pd_rv.setPd_reviewTitle(rs.getString(5));
				pd_rv.setPd_reviewContent(rs.getString(6));
				// pd_rv.setPd_reviewStar(rs.getString(7));
				pd_rv.setPd_reviewAvailable(rs.getInt(7));
				list.add(pd_rv); // ��� ������ ��� �Խñ� �ν��Ͻ��� ����Ʈ�� ��� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// �Խñ� ���� ���� ����¡ ó���ϱ� ����
	public boolean nextPage(int pageNumber) {
		// ��ȸ�� ���� reviewId�� ���������Ͽ� ���� 10���� �����ִ� ����
		String SQL = "SELECT * FROM pd_review WHERE pd_reviewId < ? AND pd_reviewAvailable = 1 ORDER BY pd_reviewId DESC LIMIT 10";

		ArrayList<pd_Review> list = new ArrayList<pd_Review>(); // pd_Review Ŭ���� �����͵��� ArrayList�� ���� ����

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // conn ��ü�� �̿�. SQL������ �����غ�� ����.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // ������ ���� ������� ����

			// ���� ��ư�� �������� �Ǵ��ϴ� �κ�
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	// �� ������ �ҷ����� �Լ�
	public pd_Review getPd_Review(int pd_reviewId) {
		String SQL = "SELECT * FROM pd_review WHERE pd_reviewId = ?"; // pd_reviewId�� Ư���� ������ ��� ����
		pd_Review pd_rv = null;
		ArrayList<pd_Review> list = new ArrayList<pd_Review>(); // pd_Review Ŭ���� �����͵��� ����

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // conn ��ü�� �̿��ؼ� SQL������ �����غ�� ����.
			pstmt.setInt(1, pd_reviewId);
			rs = pstmt.executeQuery(); // ������ ���� ����� ����

			if (rs.next()) { // ����� ���� ���
				pd_rv = new pd_Review(); // pd_Review Ŭ������ �����͵��� ȣ��
				pd_rv.setPd_reviewId(rs.getInt(1));
				pd_rv.setPd_userid(rs.getString(2));
				pd_rv.setPd_productId(rs.getString(3));
				pd_rv.setPd_reviewDate(rs.getString(4));
				pd_rv.setPd_reviewTitle(rs.getString(5));
				pd_rv.setPd_reviewContent(rs.getString(6));
				// pd_rv.setPd_reviewStar(rs.getString(7));
				pd_rv.setPd_reviewAvailable(rs.getInt(7));
				// System.out.println("��� �Ϸ�");
				return pd_rv; // ������ ��� ���� pd_rv�� ����
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return pd_rv; // �ش� ���� �������� �ʴ� ��� null
	}

	// �Խñ� ���� �޼ҵ�
	public int modify(int pd_reviewId, String pd_reviewTitle, String pd_reviewContent) {
		// String SQL2 = "UPDATE pd_review SET pd_reviewTitle = ?, pd_reviewContent = ?,
		// pd_reviewStar = ? WHERE pd_reviewId = ?"; // ������ ������ (����)
		String SQL = "UPDATE pd_review SET pd_reviewTitle = ?, pd_reviewContent = ?, WHERE pd_reviewId = ?"; // ������ ������

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // DB�� ����� ������ ���� SQL ������ ���� �غ�
			pstmt.setString(1, pd_reviewTitle); // ù ��° ����ǥ�� pd_reviewTitle ������ ����
			pstmt.setString(2, pd_reviewContent);
			pstmt.setInt(3, pd_reviewId);

			return pstmt.executeUpdate(); // �������� ��� 0 �̻��� ���� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}

	// �Խñ� ���� �޼ҵ�
	public int update(int pd_reviewId, String pd_reviewTitle, String pd_reviewContent) {
		String sql = "update pd_review set pd_reviewTitle = ?, pd_reviewContent = ? where pd_reviewId = ?"; // ������ ������
		// String sql2 = "update pd_review set pd_reviewTitle = ?, pd_reviewContent = ?,
		// pd_reviewStar = ? where pd_reviewId = ?"; // ������ ������ (����)

		try {
			PreparedStatement pstmt = conn.prepareStatement(sql); // ������ ���� �غ�
			pstmt.setString(1, pd_reviewTitle); // ������ ������ �� ����ǥ�� ������ ������
			pstmt.setString(2, pd_reviewContent);
			pstmt.setInt(3, pd_reviewId);
			return pstmt.executeUpdate(); // ������ ���� ����
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}

	public int delete(int pd_reviewId) { // reviewAvailable = 0�ϸ� ����ó����
		String SQL = "UPDATE pd_review SET pd_reviewAvailable = 0 WHERE pd_reviewId = ?"; // ������ ������

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); // ������ ���� �غ�
			pstmt.setInt(1, pd_reviewId); // ������ ������ ���� ����ǥ�� ������ ������

			return pstmt.executeUpdate(); // �������� ��� 0 �̻��� ���ڸ� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
}
