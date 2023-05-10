package pd_review.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class pd_ReviewDAO {		// 데이터베이스 연결 
	private Connection conn;	// DB 연결 객체 선언 	
	private ResultSet rs;		// DB 쿼리문 결과 저장할 객체 선언 
	
	// 기본 생성자, pd_ReviewDAO 메소드 객체를 연결할 주소지  
	public pd_ReviewDAO() {
		try {	// try ~ catch 사용 이유 (원론적) : 코드 스크립트에 에러가 발생하면 콘솔이 출력 안 되고 원인을 찾기 힘드니까, 예외처리 발생을 통해 원인을 파악하고 해결하는 방안을 모색하기 위함  
			String dbURL = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";		// 연결할 DB의 주소지 
			String dbID = "root";		// 연결할 DB의 접속 아이디 
			String dbPassword = "1234";		// 연결할 DB의 접속 비밀번호 
			Class.forName("com.mysql.cj.jdbc.Driver");		// MySQL에 접속할 수 있도록 하는 매개체 (라이브러리)
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			// 매개변수를 통해 DB에 접속할 수 있도록 함. 접속이 완료되면 conn 객체에 접속정보가 담기게 됨.
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 작성일자 메소드. 현재 시간을 갖고 오는 함수 (게시글 작성일자를 저장할 때 필요)
	public String getDate() {		// 메소드를 String(문자열) 형식으로 출력 
		String sql = "select now()";
		try {
			// 여러 개의 함수가 사용되기 때문에 각 DB 접근에 있어서 마찰이 일어나지 않도록 각 함수 내부에서 선언하도록 함 
			PreparedStatement pstmt = conn.prepareStatement(sql);	// conn 객체를 이용. SQL문장을 실행준비로 만듦 
			rs = pstmt.executeQuery();		// 쿼리문 실행 결과값을 rs 변수에 저장 
			if (rs.next()) {
				return rs.getString(1);		// 1을 해서 현재 날짜 그대로 반환
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";	// 데이터베이스 오류 
	}
	
	// 게시글 번호 부여 메소드. 가장 최근 게시물의 ID값을 가져오는 함수
	public int getNext() {
		// 현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다.
		String SQL = "select pd_reviewId from pd_review order by pd_reviewId desc";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// 실행할 객체의 인스턴스 변수를 만들고, conn 객체 안에 변수 SQL을 인자값으로 한 prepareStatement 메소드를 저장하여 실행시킬 준비 
			// conn 객체를 이용. SQL 문장을 실행준비로 만듦
			rs = pstmt.executeQuery();		// 실행할 쿼리문 결과값을 rs에 저장 

			if (rs.next()) {
				return rs.getInt(1) + 1; // 1을 더해서 그 다음 게시글이 들어갈 수 있도록 한다. || rs.getInt(1) : 검색된 값의 첫 번째 컬럼값
			}
			
			return 1; // 첫 번째 게시물인 경우
			}
		
		catch (Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	// 글쓰기 메소드.
	// 글제목, 사용자 ID, 글 내용을 전달받아 DB에 새로운 데이터를 입력 
	// 게시글 번호 -> 상품명 -> 글 제목 -> 사용자ID -> 작성일자, 글 내용, 유효번호 순으로 데이터를 세팅하고 데이터베이스로 전송 
	// 매개변수로 상품명, 글제목, 글 입력한 사용자 ID, 글 내용을 입력받고 실제 데이터베이스의 테이블 속성 순서에 맞게 데이터를 입력하는 메소드 
	public int write(String pd_productId, String pd_reviewTitle, String pd_userId, String pd_reviewContent) {
		String SQL = "insert into pd_review values(?, ?, ?, ?, ?, ?, ?)";	// 데이터베이스 코드 
		System.out.println("세팅 이전");
		System.out.println(pd_userId);
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn 객체를 이용. SQL 문장을 실행준비로
			pstmt.setInt(1, getNext());		// getNext 다음 번에 쓰일 게시글 번호 
			pstmt.setString(2, pd_userId);		// 두 번째 물음표에 들어갈 변수 pd_userId 지정하여 값 삽입 
			pstmt.setString(3, pd_productId);
			pstmt.setString(4, getDate());
			pstmt.setString(5, pd_reviewTitle);						
			pstmt.setString(6, pd_reviewContent);
			pstmt.setInt(7, 1); 	// 글의 유효번호. 허용상태 글이 있는 상태이기 때문에 1
			return pstmt.executeUpdate();		// 성공적으로 수행 시, 0 이상의 값 반환 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류 
	}
	
	public ArrayList<pd_Review> getList(int pageNumber) {	// 특정한 페이지에 다른 게시글 가져올 수 있도록
		String SQL = "SELECT * FROM pd_review WHERE pd_reviewId < ? AND pd_reviewAvailable = 1 ORDER BY pd_reviewId DESC LIMIT 10";
		// pd_reviewId가 특정한 숫자보다 작을 때, 존재하는 글 Available=1, 위에서 10개까지 내림차순 
		ArrayList<pd_Review> list = new ArrayList<pd_Review>();	// pd_Review에서 나오는 인스턴스 보관 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn 객체를 이용. SQL 문장을 실행준비로 만듦.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);		// getnext 다음으로 작성될 글의 번호 
			rs = pstmt.executeQuery();		// 실행할 쿼리문의 결과 출력 준비 
			while(rs.next()) {
				pd_Review pd_rv = new pd_Review();		// pd_Review에 담긴 데이터 가져오기 
				pd_rv.setPd_reviewId(rs.getInt(1));
				pd_rv.setPd_userid(rs.getString(2));
				pd_rv.setPd_productId(rs.getString(3));
				pd_rv.setPd_reviewDate(rs.getString(4));
				pd_rv.setPd_reviewTitle(rs.getString(5));
				pd_rv.setPd_reviewContent(rs.getString(6));
				// pd_rv.setPd_reviewStar(rs.getString(7));
				pd_rv.setPd_reviewAvailable(rs.getInt(7));
				list.add(pd_rv);	// 모든 내용이 담긴 게시글 인스턴스를 리스트에 담아 반환 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 게시글 수에 따라 페이징 처리하기 위함 
	public boolean nextPage(int pageNumber) {
		// 조회된 기준 reviewId로 내림차순하여 위에 10개만 보여주는 쿼리
		String SQL = "SELECT * FROM pd_review WHERE pd_reviewId < ? AND pd_reviewAvailable = 1 ORDER BY pd_reviewId DESC LIMIT 10";
		
		ArrayList<pd_Review> list = new ArrayList<pd_Review>();		// pd_Review 클래스 데이터들을 ArrayList를 통해 나열 
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn 객체를 이용. SQL문장을 실행준비로 만듦.
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();		// 실행한 쿼리 결과값을 저장 
			
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
	public pd_Review getPd_Review(int pd_reviewId) {
		String SQL = "SELECT * FROM pd_review WHERE pd_reviewId = ?";	// pd_reviewId가 특정한 숫자일 경우 진행 
		 ArrayList<pd_Review> list = new ArrayList<pd_Review>();		// pd_Review 클래스 데이터들을 나열
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// conn 객체를 이용해서 SQL문장을 실행준비로 만듦.
			pstmt.setInt(1, pd_reviewId);
			rs = pstmt.executeQuery();		// 쿼리문 실행 결과값 저장 
			
			if (rs.next()) {	// 결과가 나올 경우
				pd_Review pd_rv = new pd_Review();		// pd_Review 클래스의 데이터들을 호출 
				pd_rv.setPd_reviewId(rs.getInt(1));
				pd_rv.setPd_userid(rs.getString(2));
				pd_rv.setPd_productId(rs.getString(3));
				pd_rv.setPd_reviewDate(rs.getString(4));
				pd_rv.setPd_reviewTitle(rs.getString(5));
				pd_rv.setPd_reviewContent(rs.getString(6));
				// pd_rv.setPd_reviewStar(rs.getString(7));
				pd_rv.setPd_reviewAvailable(rs.getInt(7));
				System.out.println("출력 완료");
				return pd_rv;	// 정보를 모두 담은 pd_rv를 리턴 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;	// 해당 글이 존재하지 않는 경우 null
	}
	
	// 게시글 수정 메소드 
	public int modify(int pd_reviewId, String pd_reviewTitle, String pd_reviewContent) {
		String SQL = "UPDATE pd_review SET pd_reviewTitle = ?, pd_reviewContent = ?, pd_reviewStar = ? WHERE pd_reviewId = ?";	// 실행할 쿼리문 
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);	// DB에 저장된 데이터 관련 SQL 쿼리문 실행 준비 
			pstmt.setString(1, pd_reviewTitle);		// 첫 번째 물음표에 pd_reviewTitle 변수값 대입 
			pstmt.setString(2, pd_reviewContent);
			pstmt.setInt(3, pd_reviewId);
			
			return pstmt.executeUpdate();	// 성공했을 경우 0 이상의 숫자 반환 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류 
	}
	
	// 게시글 수정 메소드
	public int update(int pd_reviewId, String pd_reviewTitle, String pd_reviewContent) {
		String sql = "update pd_review set pd_reviewTitle = ?, pd_reviewContent = ?, pd_reviewStar = ? where pd_reviewId = ?";	// 실행할 쿼리문 
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);	// 쿼리문 실행 준비 	
			pstmt.setString(1, pd_reviewTitle);		// 실행할 쿼리문 안 물음표에 대입할 변수값 
			pstmt.setString(2, pd_reviewContent);
			pstmt.setInt(3, pd_reviewId);
			return pstmt.executeUpdate();	// 쿼리문 실행 리턴 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;		// 데이터베이스 오류 
	}
	
	public int delete(int pd_reviewId) {	// reviewAvailable = 0하면 삭제처리됨
		String SQL = "UPDATE pd_review SET pd_reviewAvailable = 0 WHERE pd_reviewId = ?";		// 실행할 쿼리문 
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);		// 쿼리문 실행 준비 
			pstmt.setInt(1, pd_reviewId);		// 실행할 쿼리문 안의 물음표에 대입할 변수값 
			
			return pstmt.executeUpdate();	// 성공했을 경우 0 이상의 숫자를 반환
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	 // 데이터베이스 오류
	}
}
