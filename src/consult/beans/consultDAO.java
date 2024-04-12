package consult.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class consultDAO {
	private Connection conn;	// DB ���� ��ü ȣ�� (�̰� �־�� DB ���� ������) 
	private ResultSet rs; 
	
	// �⺻ ������ (�⺻ �����ڸ� �� ������ �ϴ°���.. �ش� �޼ҵ带 Ȱ��ȭ��Ű�� �����ΰ�?) 
	public consultDAO() {
		try {	// try ~ catch���� ����Ͽ� DB���� ������ �Ǳ� ���� �����غ�  
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
		String SQL = "select now()";
		
		try {
			// ���� ���� �Լ��� ���Ǳ� ������ �� DB ���ٿ� �־ ������ �Ͼ�� �ʵ��� �� �Լ� ���ο��� �����ϵ��� �� 
			PreparedStatement pmt = conn.prepareStatement(SQL); 	// conn ��ü �ν��Ͻ��� �̿�. SQL ������ �����غ�� ���� 
			rs = pmt.executeQuery(); 
			
			if (rs.next()) {
				return rs.getString(1);		// ���ڰ��� 1�� �ؼ� ���� ��¥ �״�� ��ȯ 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";		// �����ͺ��̽� ���� 
	}
	
	// �Խñ� ��ȣ �ο� �޼ҵ�. ���� �ֱ� �Խù��� ID���� �������� �Լ� 
	public int getNext() {
		// ���� �Խñ��� ������������ ��ȸ�Ͽ� ���� ������ ���� ��ȣ�� ���Ѵ�. 
		String SQL = "select consult_num from consult order by consult_num desc"; 
			
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
	public int write(String consult_title, String consult_content) {
		String SQL = "insert into consult values(?, ?, ?, ?, ?)"; 		// �Է��� �����ͺ��̽� �ڵ� 
			
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);		// conn ��ü�� �̿�. SQL ������ �����غ�� ���� 
			pmt.setInt(1, getNext()); 		// getNext �޼ҵ�� ���� ���� ��ȣ�� ���� ���Ǳ� ��ȣ 
			pmt.setString(2, consult_title);		// �Էµ� ���Ǳ� ���� 
			pmt.setString(3, getDate());			// �ۼ�����
			pmt.setString(4, consult_content); 		// �ۼ����� 
			pmt.setInt(5, 1); 		// ���� ��ȿ��ȣ. ������ ���� �ִ� �����̱� ������ 1�� ���� 
			
			return pmt.executeUpdate();		// ���������� ���� ��, 0 �̻��� ���� ��ȯ 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;			// �����ͺ��̽� ���� 
	}
	
	// consult DB ������ ���� 
	public ArrayList<Consult> getList(int pageNum) {
		String SQL = "SELECT * FROM consult WHERE consult_num < ? AND consult_available = 1 ORDER BY consult_num DESC LIMIT 10";
			
		// consult_num�� Ư���� ���ں��� ���� ��, �����ϴ� �� consult_available = 1, �Ʒ����� 10������ �������� 
		ArrayList<Consult> list = new ArrayList<Consult>();		// Consult���� ������ �ν��Ͻ� ���� 
			
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);		// conn ��ü�� �̿�. SQL������ �����غ�� ���� 
			pmt.setInt(1, getNext() - (pageNum - 1) * 10);		// getNext �������� �ۼ��� ���� ��ȣ 
			rs = pmt.executeQuery();	
				
			while (rs.next()) {
				Consult cs = new Consult();		// Consult�� ��� ������ �������� 
				cs.setConsult_num(rs.getInt(1));
				cs.setConsult_title(rs.getString(2));
				cs.setConsult_date(rs.getString(3));
				cs.setConsult_content(rs.getString(4));
				cs.setConsult_available(rs.getInt(5));
					
				list.add(cs);		// ��� ������ ��� ���Ǳ� �ν��Ͻ��� ����Ʈ�� ��� ��ȯ 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
		
	//  �Խñ� ���� ���� ����¡ ó���ϱ� ���� 
	public boolean nextPage(int pageNum) {	// ���� �������� ���� ��쿡 ���� ó�� 
		// ��ȸ�� ���� notice_num���� ���������Ͽ� ���� 10���� �����ִ� ���� 
		String SQL = "SELECT * FROM consult WHERE consult_num < ? AND consult_available = 1 ORDER BY consult_num DESC LIMIT 10"; 
		
		ArrayList<Consult> list = new ArrayList<Consult>();		
		
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
	public Consult getConsult(int consult_num) {
		String SQL = "SELECT * FROM consult WHERE consult_num = ?";		// consult_num�� Ư���� ������ ��� ���� 
		ArrayList<Consult> list = new ArrayList<Consult>();
			
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);		// conn��ü�� �̿��ؼ� SQL������ �����غ�� ���� 
			pmt.setInt(1, consult_num);
			rs = pmt.executeQuery();
				
			if (rs.next()) {
				Consult cs = new Consult();
				cs.setConsult_num(rs.getInt(1));
				cs.setConsult_title(rs.getString(2));
				cs.setConsult_date(rs.getString(3));
				cs.setConsult_date(rs.getString(4));
				cs.setConsult_available(rs.getInt(5));
					
				return cs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;			// �ش� ���� �������� �ʴ� ��� null 
	}
		
	// ���� �޼ҵ� 
	public int modify(int consult_num, String consult_title, String consult_content) {
		String SQL = "UPDATE consult SET consult_title = ?, consult_content = ? WHERE consult_num = ?";
				
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);
			pmt.setString(1, consult_title);
			pmt.setString(2, consult_content);
			pmt.setInt(3, consult_num);
					
			return pmt.executeUpdate();		// �������� ��� 0 �̻��� ���ڸ� ��ȯ 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
		
	// ���� �޼ҵ�
	public int delete(int consult_num) {
		String sql = "DELETE consult SET consult_available = 0 WHERE consult_num = ?"; 
			
		try {
			PreparedStatement pmt = conn.prepareStatement(sql); 
			pmt.setInt(1, consult_num);
					
			return pmt.executeUpdate();		// �������� ��� 0 �̻��� ���ڸ� ��ȯ 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// �����ͺ��̽� ���� 
	}	
}
