package review.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReviewDAO {	// �����ͺ��̽� ����
	private Connection conn;
	private ResultSet rs;
	
	// �⺻ ������
	public ReviewDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");	// MySQL�� ������ �� �ֵ��� �ϴ� �Ű�ü (���̺귯��)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// �Ű������� ���� DB�� ������ �� �ֵ��� ��. ������ �Ϸ�Ǹ� conn ��ü�� ���������� ���� ��.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	//�ۼ����� �޼ҵ�. ���� �ð��� ���� ���� �Լ� (�Խñ� �ۼ����ڸ� ������ �� �ʿ�)
	public String getDate() {
		String sql = "select now()";
		try {
			// ���� ���� �Լ��� ���Ǳ� ������ �� DB ���ٿ� �־ ������ �Ͼ�� �ʵ��� �� �Լ� ���ο��� �����ϵ��� ��
			PreparedStatement pstmt = conn.prepareStatement(sql);	// conn ��ü�� �̿�. SQL ������ �����غ�� ����
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);	// 1�� �ؼ� ���� ��¥ �״�� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //�����ͺ��̽� ����
	}
	
	//�Խñ� ��ȣ �ο� �޼ҵ�. ���� �ֱ� �Խù��� ID���� �������� �Լ� 
	public int getNext() {
		//���� �Խñ��� ������������ ��ȸ�Ͽ� ���� ������ ���� ��ȣ�� ���Ѵ�
		String SQL = "select reviewId from REVIEW order by reviewId desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// conn ��ü�� �̿�. SQL ������ �����غ�� ����
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; // 1�� ���ؼ� �� ���� �Խñ��� �� �� �ֵ��� �Ѵ�.
			}
			return 1; //ù ��° �Խù��� ���
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	//�۾��� �޼ҵ� 
	public int write(String reviewTitle, String userId, String reviewContent) {
		String SQL = "insert into REVIEW values(?, ?, ?, ?, ?, ?)";	// �����ͺ��̽� �ڵ�
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn ��ü�� �̿�. SQL������ �����غ�� ����
			pstmt.setInt(1, getNext());	// getNext ���� ���� ���� �Խñ۹�ȣ
			pstmt.setString(2, reviewTitle);
			pstmt.setString(3, userId);
			pstmt.setString(4, getDate());
			pstmt.setString(5, reviewContent);
			pstmt.setInt(6, 1); //���� ��ȿ��ȣ. ������ ���� �ִ� �����̱� ������ 1
			return pstmt.executeUpdate();	// ���������� ���� �� 0 �̻��� ���� ��ȯ
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //�����ͺ��̽� ����
	}
	
	// �̵��� ��ǰ������ �� ���� ���� ���� �� ������ �Ѹ� ����������2
	public ArrayList<Review> getList(int pageNumber) {	// Ư���� �������� �ٸ� �Խñ� ������ �� �ֵ���
		String SQL = "SELECT * FROM REVIEW WHERE reviewId < ? AND reviewAvailable = 1 ORDER BY reviewId DESC LIMIT 10";
		// reviewId�� Ư���� ���ں��� ���� ��, �����ϴ� �� Available=1, ������ 10������ �������� 
		ArrayList<Review> list = new ArrayList<Review>();	// Review�� ������ �ν��Ͻ� ���� 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn ��ü�� �̿�. SQL������ �����غ�� ����.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);		// getnext �������� �ۼ��� ���� ��ȣ 
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Review review = new Review();	// Review�� ��� ������ �������� 
				review.setReviewId(rs.getInt(1));
				review.setReviewTitle(rs.getString(2));
				review.setUserId(rs.getString(3));
				review.setReviewDate(rs.getString(4));
				review.setReviewContent(rs.getString(5));
				review.setReviewAvailable(rs.getInt(6));
				list.add(review);	// ��� ������ ��� �Խñ� �ν��Ͻ��� ����Ʈ�� ��� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	} 
	
	// �Խñ� ���� ���� ����¡ ó���ϱ� ����
	public boolean nextPage(int pageNumber) {	// ���� �������� ���� ��쿡 ���� ó��
		// ��ȸ�� ���� reviewId�� ���������Ͽ� ���� 10���� �����ִ� ����
		String SQL = "SELECT * FROM REVIEW WHERE reviewId < ? AND reviewAvailable = 1 ORDER BY reviewId DESC LIMIT 10";
		
		ArrayList<Review> list = new ArrayList<Review>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn ��ü�� �̿�. SQL������ �����غ�� ����
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			
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
	public Review getReview(int reviewId) {	// Ư���� ID�� �ش��ϴ� �Խñ��� ���������� ��
		String SQL = "SELECT * FROM REVIEW WHERE reviewId = ?";	// reviewId�� Ư���� ������ ��� ����
		ArrayList<Review> list = new ArrayList<Review>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn��ü�� �̿��ؼ� SQL������ �����غ�� ����
			pstmt.setInt(1, reviewId);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// ����� ���� ���
				Review review = new Review();
				review.setReviewId(rs.getInt(1));
				review.setReviewTitle(rs.getString(2));
				review.setUserId(rs.getString(3));
				review.setReviewDate(rs.getString(4));
				review.setReviewContent(rs.getString(5));
				review.setReviewAvailable(rs.getInt(6));
				return review;	// ������ ��� ���� review�� ����
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;	// �ش� ���� �������� �ʴ� ��� null
	}
	
	public int modify(int reviewId, String reviewTitle, String reviewContent) {
		String SQL = "UPDATE REVIEW SET reviewTitle = ? , reviewContent = ? WHERE reviewId = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, reviewTitle);
			pstmt.setString(2, reviewContent);
			pstmt.setInt(3, reviewId);
			
			return pstmt.executeUpdate();	// �������� ��� 0 �̻��� ���ڸ� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// �����ͺ��̽� ����
	}
	
	public int delete(int reviewId) {	// reviewAvailable = 0�ϸ� ����ó����
		String SQL = "DELETE REVIEW SET reviewAvailable = 0 WHERE reviewId = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, reviewId);
			
			return pstmt.executeUpdate();	// �������� ��� 0 �̻��� ���ڸ� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	 // �����ͺ��̽� ����
	}
}	