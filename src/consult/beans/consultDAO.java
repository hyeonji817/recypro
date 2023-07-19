package consult.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import notice.beans.Notice;

public class consultDAO {
	private Connection conn;
	private ResultSet rs;
	
	// 기본 생성자 
	public consultDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");	// MySQL에 접속할 수 있도록 하는 매개체 (라이브러리)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// 매개변수를 통해 DB에 접속할 수 있도록 함. 접속이 완료되면 conn 객체에 접속정보가 담기게 됨.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 작성일자 메소드. 현재 시간을 갖고 오는 함수 (공지글 작성일자를 저장할 때 필요한 메소드) 
	public String getDate() {
		String SQL = "select now()"; 
		
		try {
			// 여러 개의 함수가 사용되기 때문에 각 DB 접근에 있어서 마찰이 일어나지 않도록 각 함수 내부에서 선언하도록 함 
			PreparedStatement pmt = conn.prepareStatement(SQL);		// conn 객체 인스턴스를 이용. SQL문장을 실행준비로 만듦 
			rs = pmt.executeQuery();
			
			if (rs.next()) {
				return rs.getString(1);		// 인자값을 1로 해서 현재 날짜 그대로 반환 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";		// 데이터베이스 오류 
	}
	
	// 게시글 번호 부여 메소드. 가장 최근 게시물의 ID값을 가져오는 함수 
	public int getNext() {
		// 현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다. 
		String SQL = "select consult_num from consult order by consult_num desc"; 
		
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);
			// conn 객체를 이용. SQL 문장을 실행준비로 만듦 
			rs = pmt.executeQuery(); 		// 쿼리의 결과물 출력 준비 
			if (rs.next()) {
				return rs.getInt(1) + 1;		// 1을 더해서 그 다음 게시글이 들어갈 수 있도록 한다. 
			}
			return 1;		// 첫 번째 게시글인 경우 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류 
	}
	
	// 글쓰기 메소드 
	public int write(String consult_title, String consult_content) {
		String SQL = "insert into consult values(?, ?, ?, ?, ?)"; 		// 입력할 데이터베이스 코드 
		
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);		// conn 객체를 이용. SQL 문장을 실행준비로 만듦 
			pmt.setInt(1, getNext()); 		// getNext 메소드로 인해 다음 번호에 쓰일 문의글 번호 
			pmt.setString(2, consult_title);		// 입력될 문의글 제목 
			pmt.setString(3, getDate());			// 작성일자
			pmt.setString(4, consult_content); 		// 작성내용 
			pmt.setInt(5, 1); 		// 글의 유효번호. 허용상태 글이 있는 상태이기 때문에 1로 시작 
			
			return pmt.executeUpdate();		// 성공적으로 수행 시, 0 이상의 값을 반환 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;			// 데이터베이스 오류 
	}
	
	// consult DB 데이터 나열 
	public ArrayList<Consult> getList(int pageNum) {
		String SQL = "SELECT * FROM consult WHERE consult_num < ? AND consult_available = 1 ORDER BY consult_num DESC LIMIT 10";
		
		// consult_num이 특정한 숫자보다 작을 때, 존재하는 글 consult_available = 1, 아래에서 10개까지 내림차순 
		ArrayList<Consult> list = new ArrayList<Consult>();		// Consult에서 나오는 인스턴스 보관 
		
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);		// conn 객체를 이용. SQL문장을 실행준비로 만듦 
			pmt.setInt(1, getNext() - (pageNum - 1) * 10);		// getNext 다음으로 작성될 글의 번호 
			rs = pmt.executeQuery();	
			
			while (rs.next()) {
				Consult cs = new Consult();		// Consult에 담긴 데이터 가져오기 
				cs.setConsult_num(rs.getInt(1));
				cs.setConsult_title(rs.getString(2));
				cs.setConsult_date(rs.getString(3));
				cs.setConsult_content(rs.getString(4));
				cs.setConsult_available(rs.getInt(5));
				
				list.add(cs);		// 모든 내용이 담긴 문의글 인스턴스를 리스트에 담아 반환 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//  게시글 수에 따라 페이징 처리하기 위함 
	public boolean nextPage(int pageNum) {	// 다음 페이지가 없을 경우에 대한 처리 
		// 조회된 기준 notice_num으로 오름차순하여 위에 10개만 보여주는 쿼리 
		String SQL = "SELECT * FROM consult WHERE consult_num < ? AND consult_available = 1 ORDER BY consult_num DESC LIMIT 10"; 
		
		ArrayList<Consult> list = new ArrayList<Consult>();		
		
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);	// conn 객체를 이용. SQL문장을 실행준비로 만듦 
			pmt.setInt(1, getNext() - (pageNum - 1) * 10);
			rs = pmt.executeQuery(); 
			
			// 다음 버튼을 보여줄지 판단하는 부분 
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	// 글 내용을 불러오는 함수 
	public Consult getConsult(int consult_num) {
		String SQL = "SELECT * FROM consult WHERE consult_num = ?";		// consult_num이 특정한 숫자일 경우 진행 
		ArrayList<Consult> list = new ArrayList<Consult>();
		
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);		// conn객체를 이용해서 SQL문장을 실행준비로 만듦 
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
		return null;			// 해당 글이 존재하지 않는 경우 null 
	}
	
	// 수정 메소드 
	public int modify(int consult_num, String consult_title, String consult_content) {
		String SQL = "UPDATE consult SET consult_title = ?, consult_content = ? WHERE consult_num = ?";
			
		try {
			PreparedStatement pmt = conn.prepareStatement(SQL);
			pmt.setString(1, consult_title);
			pmt.setString(2, consult_content);
			pmt.setInt(3, consult_num);
				
			return pmt.executeUpdate();		// 성공했을 경우 0 이상의 숫자를 반환 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
		
	// 삭제 메소드
	public int delete(int consult_num) {
		String sql = "DELETE consult SET consult_available = 0 WHERE consult_num = ?"; 
			
		try {
			PreparedStatement pmt = conn.prepareStatement(sql); 
			pmt.setInt(1, consult_num);
				
			return pmt.executeUpdate();		// 성공했을 경우 0 이상의 숫자를 반환 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류 
	}
}
