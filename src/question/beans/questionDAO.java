package question.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class questionDAO {
	private Connection con;
	private ResultSet rs;
	
	// 기본 생성자 
	public questionDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
			String dbID = "root";
			String dbPassword = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");	// MySQL에 접속할 수 있도록 하는 매개체 (라이브러리)
			con = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// 매개변수를 통해 DB에 접속할 수 있도록 함. 접속이 완료되면 conn 객체에 접속정보가 담기게 됨.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 질문글 번호 부여 메소드. 가장 최근 게시물의 ID값을 가져오는 함수 
	public int getNext() {
		// 현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다. 
		String sql = "select question_num from question order by question_num desc";
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);
			// con 객체를 이용. sql 문장을 실행준비로 만듦 
			rs = pmt.executeQuery();		// 쿼리의 결과물 출력 준비 
			if (rs.next()) {
				return rs.getInt(1) + 1;		// 1을 더해서 그 다음 게시글이 들어갈 수 있도록 한다. 
			}
			return 1; 		// 첫 번째 게시글인 경우 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류 
	}
	
	// 글쓰기 메소드 
	public int write(String question_title, String question_response) {
		String sql = "insert into question values(?, ?, ?, ?)";		// 입력할 데이터베이스 코드
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);		// con 객체를 이용. sql 문장을 실행준비로 만듦 
			pmt.setInt(1, getNext());	// getNext 메소드로 인해 다음 번호에 쓰일 질문글 번호 
			pmt.setString(2, question_title);		// 입력될 질문글 제목 
			pmt.setString(3, question_response);		// 답변글 
			pmt.setInt(4, 1);		// 글의 유효번호. 허용상태 글이 있는 상태이기 때문에 1로 시작 
			//pmt.setInt(5, 1);
			
			return pmt.executeUpdate();		// 성공적으로 수행 시, 0 이상의 값을 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Question> getList(int pageNum) {
		String sql = "SELECT * FROM question WHERE question_num < ? AND question_available = 1 ORDER BY question_num DESC LIMIT 10";
		
		// question_num이 특정한 숫자보다 작을 때, 존재하는 글 question_available = 1, 아래에서 10개까지 내림차순
		ArrayList<Question> list = new ArrayList<Question>();			// question에서 나오는 인스턴스 보관 
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);		// con 객체를 이용. sql문장을 실행준비로 만듦 
			pmt.setInt(1, getNext() - (pageNum - 1) * 10);		// getNext 다음올 작성될 글의 번호 
			rs = pmt.executeQuery();	
			
			while (rs.next()) {
				Question que = new Question();		// question에 담긴 데이터 가져오기 (자바빈즈) 
				que.setQuestion_num(rs.getInt(1));
				que.setQuestion_title(rs.getString(2));
				que.setQuestion_response(rs.getString(3));
				que.setQuestion_available(rs.getInt(4));
				list.add(que);		// 모든 내용이 담긴 질문글 인스턴스를 리스트에 담아 반환 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 질문글 수에 따라 페이징 처리하기 위함 
	public boolean nextPage(int pageNum) {
		// 조회된 기준 question_num으로 내림차순하여 위에 10개만 보여주는 쿼리 
		String sql = "SELECT * FROM question WHERE question_num < ? AND question_available = 1 ORDER BY question_num DESC LIMIT 10";
		
		ArrayList<Question> list = new ArrayList<Question>();
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);		// con 객체를 이용. sql문장을 실행준비로 만듦 
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
	public Question getQuestion(int question_num) {
		String sql = "SELECT * FROM question WHERE question_num = ?";		// question_num이 특정한 숫자일 경우 진행 
		ArrayList<Question> list = new ArrayList<Question>();
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);		// con 객체를 이용해서 sql문장을 실행준비로 만듦
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
		return null;		// 해당 글이 존재하지 않는 경우 null
	}
	
	// 수정 메소드 
	public int modify(int question_num, String question_title, String question_response) {
		String sql = "UPDATE question SET question_title = ?, question_response = ? WHERE question_num = ?";
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);
			pmt.setString(1, question_title);
			pmt.setString(2, question_response);
			pmt.setInt(3, question_num);
			
			return pmt.executeUpdate();		// 성공했을 경우 0 이상의 숫자를 반환 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 삭제 메소드
		public int delete(int question_num) {
			String sql = "DELETE question SET question_available = 0 WHERE question_num = ?"; 
			
			try {
				PreparedStatement pmt = con.prepareStatement(sql); 
				pmt.setInt(1, question_num);
				
				return pmt.executeUpdate();		// 성공했을 경우 0 이상의 숫자를 반환 
			} catch (Exception e) {
				e.printStackTrace();
			}
			return -1;		// 데이터베이스 오류 
		}
}
