package question.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class questionDAO {
	private Connection con;
	private ResultSet rs;

	// �⺻ ������
	public questionDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver"); // MySQL�� ������ �� �ֵ��� �ϴ� �Ű�ü (���̺귯��)
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// �Ű������� ���� DB�� ������ �� �ֵ��� ��. ������ �Ϸ�Ǹ� conn ��ü�� ���������� ���� ��.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// ������ ��ȣ �ο� �޼ҵ�. ���� �ֱ� �Խù��� ID���� �������� �Լ�
	public int getNext() {
		// ���� �Խñ��� ������������ ��ȸ�Ͽ� ���� ������ ���� ��ȣ�� ���Ѵ�.
		String sql = "select question_num from question order by question_num desc";

		try {
			PreparedStatement pmt = con.prepareStatement(sql);
			// con ��ü�� �̿�. sql ������ �����غ�� ����
			rs = pmt.executeQuery(); // ������ ����� ��� �غ�
			if (rs.next()) {
				return rs.getInt(1) + 1; // 1�� ���ؼ� �� ���� �Խñ��� �� �� �ֵ��� �Ѵ�.
			}
			return 1; // ù ��° �Խñ��� ���
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}

	// �۾��� �޼ҵ�
	public int write(String question_title, String question_response) {
		String sql = "insert into question values(?, ?, ?, ?)"; // �Է��� �����ͺ��̽� �ڵ�

		try {
			PreparedStatement pmt = con.prepareStatement(sql); // con ��ü�� �̿�. sql ������ �����غ�� ����
			pmt.setInt(1, getNext()); // getNext �޼ҵ�� ���� ���� ��ȣ�� ���� ������ ��ȣ
			pmt.setString(2, question_title); // �Էµ� ������ ����
			pmt.setString(3, question_response); // �亯��
			pmt.setInt(4, 1); // ���� ��ȿ��ȣ. ������ ���� �ִ� �����̱� ������ 1�� ����
			// pmt.setInt(5, 1);

			return pmt.executeUpdate(); // ���������� ���� ��, 0 �̻��� ���� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	public ArrayList<Question> getList(int pageNum) {
		String sql = "SELECT * FROM question WHERE question_num < ? AND question_available = 1 ORDER BY question_num DESC LIMIT 10";

		// question_num�� Ư���� ���ں��� ���� ��, �����ϴ� �� question_available = 1, �Ʒ����� 10������ ��������
		ArrayList<Question> list = new ArrayList<Question>(); // question���� ������ �ν��Ͻ� ����

		try {
			PreparedStatement pmt = con.prepareStatement(sql); // con ��ü�� �̿�. sql������ �����غ�� ����
			pmt.setInt(1, getNext() - (pageNum - 1) * 10); // getNext ������ �ۼ��� ���� ��ȣ
			rs = pmt.executeQuery();

			while (rs.next()) {
				Question que = new Question(); // question�� ��� ������ �������� (�ڹٺ���)
				que.setQuestion_num(rs.getInt(1));
				que.setQuestion_title(rs.getString(2));
				que.setQuestion_response(rs.getString(3));
				que.setQuestion_available(rs.getInt(4));
				list.add(que); // ��� ������ ��� ������ �ν��Ͻ��� ����Ʈ�� ��� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// ������ ���� ���� ����¡ ó���ϱ� ����
	public boolean nextPage(int pageNum) {
		// ��ȸ�� ���� question_num���� ���������Ͽ� ���� 10���� �����ִ� ����
		String sql = "SELECT * FROM question WHERE question_num < ? AND question_available = 1 ORDER BY question_num DESC LIMIT 10";

		ArrayList<Question> list = new ArrayList<Question>();

		try {
			PreparedStatement pmt = con.prepareStatement(sql); // con ��ü�� �̿�. sql������ �����غ�� ����
			pmt.setInt(1, getNext() - (pageNum - 1) * 10);
			rs = pmt.executeQuery();

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
	public Question getQuestion(int question_num) {
		String sql = "SELECT * FROM question WHERE question_num = ?"; // question_num�� Ư���� ������ ��� ����
		ArrayList<Question> list = new ArrayList<Question>();

		try {
			PreparedStatement pmt = con.prepareStatement(sql); // con ��ü�� �̿��ؼ� sql������ �����غ�� ����
			pmt.setInt(1, question_num);
			rs = pmt.executeQuery();

			if (rs.next()) {
				Question que = new Question();
				que.setQuestion_num(rs.getInt(1));
				que.setQuestion_title(rs.getString(2));
				que.setQuestion_response(rs.getString(3));
				que.setQuestion_available(rs.getInt(4));

				return que;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null; // �ش� ���� �������� �ʴ� ��� null
	}

	// ���� �޼ҵ�
	public int modify(int question_num, String question_title, String question_response) {
		String sql = "UPDATE question SET question_title = ?, question_response = ? WHERE question_num = ?";

		try {
			PreparedStatement pmt = con.prepareStatement(sql);
			pmt.setString(1, question_title);
			pmt.setString(2, question_response);
			pmt.setInt(3, question_num);

			return pmt.executeUpdate(); // �������� ��� 0 �̻��� ���ڸ� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}

	// ���� �޼ҵ�
	public int delete(int question_num) {
		String sql = "DELETE question SET question_available = 0 WHERE question_num = ?";

		try {
			PreparedStatement pmt = con.prepareStatement(sql);
			pmt.setInt(1, question_num);

			return pmt.executeUpdate(); // �������� ��� 0 �̻��� ���ڸ� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // �����ͺ��̽� ����
	}
}
