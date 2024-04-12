package notice.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class noticeDAO {
	private Connection conn;
	private ResultSet rs;
	
	// �⺻ ������ 
	public noticeDAO() {		
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
	
	// �ۼ����� �޼ҵ�. ���� �ð��� ���� ���� �Լ� (������ �ۼ����ڸ� ������ �� �ʿ��� �޼ҵ�) 
	public String getDate() {
		String Sql = "select now()";
			
		try {
			// ���� ���� �Լ��� ���Ǳ� ������ �� DB ���ٿ� �־ ������ �Ͼ�� �ʵ��� �� �Լ� ���ο��� �����ϵ��� �� 
			PreparedStatement pmt = conn.prepareStatement(Sql);		// conn ��ü�� �̿�. SQL ������ �����غ�� ���� 
			rs = pmt.executeQuery(); 
				
			if (rs.next()) {
				return rs.getString(1);		// ���ڰ��� 1�� �ؼ� ���� ��¥ �״�� ��ȯ 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";	// �����ͺ��̽� ���� 
	}
		
	// �Խñ� ��ȣ �ο� �޼ҵ�. ���� �ֱ� �Խù��� ID���� �������� �Լ� 
	public int getNext() {
		// ���� �Խñ��� ������������ ��ȸ�Ͽ� ���� ������ ���� ��ȣ�� ���Ѵ�. 
		String SQL = "select notice_num from notice order by notice_num desc";
			
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL); 
			// conn ��ü�� �̿�. SQL ������ �����غ�� ���� 
			rs = pmt.executeQuery(); 		// ������ ����� ��� �غ� 
			if (rs.next()) {
				return rs.getInt(1) + 1;		// 1�� ���ؼ� �� ���� �Խñ��� �� �� �ֵ��� �Ѵ�. 
			}
			return 1;		// ù ��° �Խñ��� ��� 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// �����ͺ��̽� ���� 
	}
	
	// �۾��� �޼ҵ� 
	public int write(String notice_title, String userId, String notice_content) {
		String SQL = "insert into notice values(?, ?, ?, ?, ?, ?)";		// �Է��� �����ͺ��̽� �ڵ� 
			
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);		// conn ��ü�� �̿�. SQL ������ �����غ�� ���� 
			pmt.setInt(1, getNext()); 	// getNext �޼ҵ�� ���� ���� ��ȣ�� ���� ������ ��ȣ 
			pmt.setString(2, notice_title);		// �Էµ� ������ ���� 
			pmt.setString(3, userId); 		// �ۼ��ڸ� 
			pmt.setString(4, getDate());		// �ۼ����� 
			pmt.setString(5, notice_content);		// �ۼ����� 
			pmt.setInt(6, 1);		// ���� ��ȿ��ȣ. ������ ���� �ִ� �����̱� ������ 1�� ���� 
				
			return pmt.executeUpdate();		// ���������� ���� ��, 0 �̻��� ���� ��ȯ
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// �����ͺ��̽� ���� 
	}
	
	// notice DB ������ ����
	public ArrayList<Notice> getList(int pageNum) {
		String SQL = "SELECT * FROM notice WHERE notice_num < ? AND notice_available = 1 ORDER BY notice_num DESC LIMIT 10";
			
		// notice_num�� Ư���� ���ں��� ���� ��, �����ϴ� �� notice_available = 1, �Ʒ����� 10������ �������� 
		ArrayList<Notice> list = new ArrayList<Notice>();		// Notice���� ������ �ν��Ͻ� ���� 
			
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);	// conn ��ü�� �̿�. SQL������ �����غ�� ���� 
			pmt.setInt(1, getNext() - (pageNum - 1) * 10);		// getNext �������� �ۼ��� ���� ��ȣ 
			rs = pmt.executeQuery();
				
			while (rs.next()) {
				Notice noti = new Notice();		// Notice�� ��� ������ �������� 
				noti.setNotice_num(rs.getInt(1));
				noti.setNotice_title(rs.getString(2));
				noti.setUserId(rs.getString(3));
				noti.setNotice_date(rs.getString(4));
				noti.setNotice_content(rs.getString(5));
				noti.setNotice_available(rs.getInt(6));
				list.add(noti);		// ��� ������ ��� ������ �ν��Ͻ��� ����Ʈ�� ��� ��ȯ
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
		
	//  �Խñ� ���� ���� ����¡ ó���ϱ� ���� 
	public boolean nextPage(int pageNum) {	// ���� �������� ���� ��쿡 ���� ó�� 
		// ��ȸ�� ���� notice_num���� ���������Ͽ� ���� 10���� �����ִ� ���� 
		String SQL = "SELECT * FROM notice WHERE notice_num < ? AND notice_available = 1 ORDER BY notice_num DESC LIMIT 10"; 
		
		ArrayList<Notice> list = new ArrayList<Notice>();		
		
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);	// conn ��ü�� �̿�. SQL������ �����غ�� ���� 
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
	public Notice getNotice(int notice_num) {
		String SQL = "SELECT * FROM notice WHERE notice_num = ?";	// notice_num�� Ư���� ������ ��� ���� 
		ArrayList<Notice> list = new ArrayList<Notice>();	
			
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);	// conn��ü�� �̿��ؼ� SQL������ �����غ�� ���� 
			pmt.setInt(1, notice_num);		
			rs = pmt.executeQuery();
				
			if (rs.next()) {
				Notice noti = new Notice();
				noti.setNotice_num(rs.getInt(1));
				noti.setNotice_title(rs.getString(2));
				noti.setUserId(rs.getString(3));
				noti.setNotice_date(rs.getString(4));
				noti.setNotice_content(rs.getString(5));
				noti.setNotice_available(rs.getInt(6));
					
				return noti;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;		// �ش� ���� �������� �ʴ� ��� null
	}
	
	// ���� �޼ҵ� 
	public int modify(int notice_num, String notice_title, String notice_content) {
		String SQL = "UPDATE notice SET notice_title = ?, notice_content = ? WHERE notice_num = ?";
			
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);
			pmt.setString(1, notice_title);
			pmt.setString(2, notice_content);
			pmt.setInt(3, notice_num);
				
			return pmt.executeUpdate();		// �������� ��� 0 �̻��� ���ڸ� ��ȯ 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
		
	// ���� �޼ҵ�
	public int delete(int notice_num) {
		String sql = "DELETE notice SET notice_available = 0 WHERE notice_num = ?"; 
			
		try {
			PreparedStatement pmt = conn.prepareStatement(sql); 
			pmt.setInt(1, notice_num);
			
			return pmt.executeUpdate();		// �������� ��� 0 �̻��� ���ڸ� ��ȯ 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// �����ͺ��̽� ���� 
	}
}
