package review.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ReviewDAO {	// 데이터베이스 연결
	private Connection conn;
	private ResultSet rs;
	
	// 기본 생성자
	public ReviewDAO() {
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
	
	//작성일자 메소드. 현재 시간을 갖고 오는 함수 (게시글 작성일자를 저장할 때 필요)
	public String getDate() {
		String sql = "select now()";
		try {
			// 여러 개의 함수가 사용되기 때문에 각 DB 접근에 있어서 마찰이 일어나지 않도록 각 함수 내부에서 선언하도록 함
			PreparedStatement pstmt = conn.prepareStatement(sql);	// conn 객체를 이용. SQL 문장을 실행준비로 만듦
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);	// 1을 해서 현재 날짜 그대로 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ""; //데이터베이스 오류
	}
	
	//게시글 번호 부여 메소드. 가장 최근 게시물의 ID값을 가져오는 함수 
	public int getNext() {
		//현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다
		String SQL = "select reviewId from REVIEW order by reviewId desc";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			// conn 객체를 이용. SQL 문장을 실행준비로 만듦
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1; // 1을 더해서 그 다음 게시글이 들어갈 수 있도록 한다.
			}
			return 1; //첫 번째 게시물인 경우
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	//글쓰기 메소드 
	public int write(String reviewTitle, String userId, String reviewContent) {
		String SQL = "insert into REVIEW values(?, ?, ?, ?, ?, ?)";	// 데이터베이스 코드
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn 객체를 이용. SQL문장을 실행준비로 만듦
			pstmt.setInt(1, getNext());	// getNext 다음 번에 쓰일 게시글번호
			pstmt.setString(2, reviewTitle);
			pstmt.setString(3, userId);
			pstmt.setString(4, getDate());
			pstmt.setString(5, reviewContent);
			pstmt.setInt(6, 1); //글의 유효번호. 허용상태 글이 있는 상태이기 때문에 1
			return pstmt.executeUpdate();	// 성공적으로 수행 시 0 이상의 값을 반환
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터베이스 오류
	}
	
	// 이따가 상품페이지 내 리뷰 빈즈 만들 때 참고할 롤모델 페이지영역2
	public ArrayList<Review> getList(int pageNumber) {	// 특정한 페이지에 다른 게시글 가져올 수 있도록
		String SQL = "SELECT * FROM REVIEW WHERE reviewId < ? AND reviewAvailable = 1 ORDER BY reviewId DESC LIMIT 10";
		// reviewId가 특정한 숫자보다 작을 때, 존재하는 글 Available=1, 위에서 10개까지 내림차순 
		ArrayList<Review> list = new ArrayList<Review>();	// Review서 나오는 인스턴스 보관 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn 객체를 이용. SQL문장을 실행준비로 만듦.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);		// getnext 다음으로 작성될 글의 번호 
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Review review = new Review();	// Review에 담긴 데이터 가져오기 
				review.setReviewId(rs.getInt(1));
				review.setReviewTitle(rs.getString(2));
				review.setUserId(rs.getString(3));
				review.setReviewDate(rs.getString(4));
				review.setReviewContent(rs.getString(5));
				review.setReviewAvailable(rs.getInt(6));
				list.add(review);	// 모든 내용이 담긴 게시글 인스턴스를 리스트에 담아 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	} 
	
	// 게시글 수에 따라 페이징 처리하기 위함
	public boolean nextPage(int pageNumber) {	// 다음 페이지가 없을 경우에 대한 처리
		// 조회된 기준 reviewId로 내림차순하여 위에 10개만 보여주는 쿼리
		String SQL = "SELECT * FROM REVIEW WHERE reviewId < ? AND reviewAvailable = 1 ORDER BY reviewId DESC LIMIT 10";
		
		ArrayList<Review> list = new ArrayList<Review>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn 객체를 이용. SQL문장을 실행준비로 만듦
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			
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
	public Review getReview(int reviewId) {	// 특정한 ID에 해당하는 게시글을 가져오도록 함
		String SQL = "SELECT * FROM REVIEW WHERE reviewId = ?";	// reviewId가 특정한 숫자일 경우 진행
		ArrayList<Review> list = new ArrayList<Review>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn객체를 이용해서 SQL문장을 실행준비로 만듦
			pstmt.setInt(1, reviewId);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {	// 결과가 나올 경우
				Review review = new Review();
				review.setReviewId(rs.getInt(1));
				review.setReviewTitle(rs.getString(2));
				review.setUserId(rs.getString(3));
				review.setReviewDate(rs.getString(4));
				review.setReviewContent(rs.getString(5));
				review.setReviewAvailable(rs.getInt(6));
				return review;	// 정보를 모두 담은 review를 리턴
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;	// 해당 글이 존재하지 않는 경우 null
	}
	
	public int modify(int reviewId, String reviewTitle, String reviewContent) {
		String SQL = "UPDATE REVIEW SET reviewTitle = ? , reviewContent = ? WHERE reviewId = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, reviewTitle);
			pstmt.setString(2, reviewContent);
			pstmt.setInt(3, reviewId);
			
			return pstmt.executeUpdate();	// 성공했을 경우 0 이상의 숫자를 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// 데이터베이스 오류
	}
	
	public int delete(int reviewId) {	// reviewAvailable = 0하면 삭제처리됨
		String SQL = "DELETE REVIEW SET reviewAvailable = 0 WHERE reviewId = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, reviewId);
			
			return pstmt.executeUpdate();	// 성공했을 경우 0 이상의 숫자를 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	 // 데이터베이스 오류
	}
}	
