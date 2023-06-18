package coupon.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class couponDAO {
	private Connection con;
	private ResultSet rs;
	
	// 기본 생성자 
	public couponDAO() {
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
	
	// 게시글 번호 부여 메소드. 가장 최근 게시물의 ID값을 가져오는 함수 
	public int getNext() {
		// 현재 게시글을 내림차순으로 조회하여 가장 마지막 글의 번호를 구한다. 
		String sql = "select coupon_num from coupon order by coupon_num desc";
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);
			// conn 객체를 이용. SQL 문장을 실행준비로 만듦
			rs = pmt.executeQuery();
			
			if (rs.next()) {
				return rs.getInt(1) + 1;		// 1을 더해서 그 다음 게시글이 들어갈 수 있도록 한다. 
			}
			return 1; 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
 	}
	
	// 쿠폰등록 메소드 
	public int register(int coupon_num, String coupon_title, String coupon_period, String coupon_start, String coupon_end, String coupon_extend) {
		String sql = "insert into coupon values(?, ?, ?, ?, ?, ?)";
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);
			pmt.setInt(1, coupon_num);
			pmt.setString(2, coupon_title);
			pmt.setString(3, coupon_period);
			pmt.setString(4, coupon_start);
			pmt.setString(5, coupon_end);
			pmt.setString(6, coupon_extend);
			pmt.setInt(7, 1);
			
			return pmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return -1;		// 예외가 발생한 경우 -1 반환
		}
	}
	
	// coupon DB 데이터 나열
	public ArrayList<Coupon> getList(int pageNum) {
		String sql = "SELECT * FROM coupon WHERE coupon_num < ? AND coupon_available = 1 ORDER BY coupon_num DESC LIMIT 10";
		
		// coupon_num이 특정한 숫자보다 작을 때, 존재하는 글 coupon_available = 1, 아래에서 10개까지 내림차순 
		ArrayList<Coupon> list = new ArrayList<Coupon>();		// coupon에서 나오는 인스턴스 보관 
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);		// con 객체를 이용. SQL문장을 실행준비로 만듦. 
			pmt.setInt(1, getNext() - (pageNum - 1) * 10);		// getNext 다음으로 작성될 글의 번호 
			rs = pmt.executeQuery();
			
			while(rs.next()) {
				Coupon cp = new Coupon();		// coupon에 담긴 데이터 가져오기 
				cp.setCoupon_num(rs.getInt(1));
				cp.setCoupon_title(rs.getString(2));
				cp.setCoupon_period(rs.getString(3));
				cp.setCoupon_start(rs.getString(4));
				cp.setCoupon_end(rs.getString(5));
				cp.setCoupon_expend(rs.getString(6));
				cp.setCoupon_available(rs.getInt(7));
				list.add(cp);		// coupon DB 테이블에 모든 내용이 담긴 쿠폰 인스턴스를 리스트에 담아 반환(호출)
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	// 쿠폰 내용 불러오는 함수 
	public Coupon getCoupon(int coupon_num) {
		String sql = "SELECT * FROM coupon WHERE coupon_num = ?";
		ArrayList<Coupon> list = new ArrayList<Coupon>();
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);
			pmt.setInt(1, coupon_num);
			rs = pmt.executeQuery();
			
			if (rs.next()) {
				Coupon cp = new Coupon();
				cp.setCoupon_num(rs.getInt(1));
				cp.setCoupon_title(rs.getString(2));
				cp.setCoupon_period(rs.getString(3));
				cp.setCoupon_start(rs.getString(4));
				cp.setCoupon_end(rs.getString(5));
				cp.setCoupon_expend(rs.getString(6));
				cp.setCoupon_available(rs.getInt(7));
				
				return cp;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 수정 메소드 
	public int modify(int coupon_num, String coupon_title, String coupon_period, String coupon_start, String coupon_end, String coupon_extend) {
		String sql = "UPDATE coupon SET coupon_title = ?, coupon_period = ?, coupon_start = ?, coupon_end = ?, coupon_extend = ? WHERE coupon_num = ?";
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql);
			pmt.setString(1, coupon_title);
			pmt.setString(2, coupon_period);
			pmt.setString(3, coupon_start);
			pmt.setString(4, coupon_end);
			pmt.setString(5, coupon_extend);
			
			return pmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	// 삭제 메소드 
	public int delete(int coupon_num) {
		String sql = "DELETE coupon SET coupon_available = 0 WHERE coupon_num = ?";
		
		try {
			PreparedStatement pmt = con.prepareStatement(sql); 
			pmt.setInt(1, coupon_num);
			
			return pmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
