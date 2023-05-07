<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		Connection conn = null;
	
		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
		String id = "root";
		String password = "1234";
		
		Class.forName("com.mysql.cj.jdbc.Driver");	// 드라이버명
		conn = DriverManager.getConnection(url, id, password);	// 연결 객체생성
	%>
	<%
		String productId = request.getParameter("id");	// 어떤 제품을 삭제할 지 id값 넘어옴
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from product";
		
		pstmt = conn.prepareStatement(SQL);
		rs = pstmt.executeQuery();
		
		// rs에 있는 물품과 id값으로 저장해 놓은 것과 일치하는 것이 있다면
		if (rs.next()) {
			SQL = "delete form product where productId = ?";
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, productId);
			pstmt.executeUpdate();
		}
		else {
			out.println("일치하는 상품이 없습니다.");
		}
		
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(conn != null) conn.close();
		
		response.sendRedirect("editProduct.jsp?edit=delete");
	%>
</body>
</html>