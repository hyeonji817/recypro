<!-- 참고한 웹 페이지 주소좌표 : https://kjh95.tistory.com/285 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>

<!-- 상품 조회, 등록, 수정, 삭제하기 (DB 연동) -->
<%
	try {
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
		String user = "root";
		String password = "1234";
		
		Class.forName("com.mysql.cj.jdbc.Driver");		// 드라이버명
		DriverManager.getConnection(url, user, password);	// 연결 객체생성 
		
		System.out.println("데이터베이스 연결되었습니다.");
	} catch (SQLException e) {
		System.out.println("데이터베이스 연결 실패했습니다.");
		e.printStackTrace();
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>