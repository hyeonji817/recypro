package question.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
		String sql = "insert into question values(?, ?, ?, ?, ?)";		// 입력할 데이터베이스 코드
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);		// con 객체를 이용. sql 문장을 실행준비로 만듦 
			pmt.setInt(1, getNext());	// getNext 메소드로 인해 다음 번호에 쓰일 질문글 번호 
			pmt.setString(2, question_title);		// 입력될 질문글 제목 
			pmt.setString(3, question_response);		// 답변글 
			pmt.setInt(4, 1);		// 글의 유효번호. 허용상태 글이 있는 상태이기 때문에 1로 시작 
			
			return pmt.executeUpdate();		// 성공적으로 수행 시, 0 이상의 값을 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
