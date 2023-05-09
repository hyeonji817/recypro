<!-- 참고한 웹 페이지 주소좌표 : https://kjh95.tistory.com/286?category=941468 -->
<!-- 수정 처리 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%
	Connection conn = null;

	String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
	String user = "root";
	String password = "1234";
	
	Class.forName("com.mysql.cj.jdbc.Driver");			// 드라이버명
	conn = DriverManager.getConnection(url, user, password);	 // 연결 객체생성
%>
<%
	request.setCharacterEncoding("UTF-8");

	// addProduct.jsp에서 사용자가 업로드한 이미지 부분을 받아 저장.
	String filename = "";
	String realFolder = "D:\\개인 프로젝트 작업\\recypro(project)\\recypro\\WebContent\\img\\shop";
	
	int maxsize = 10 * 1024 * 1024;			// 최대 업로드 크기 
	String encType = "utf-8";
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxsize, encType, new DefaultFileRenamePolicy());
	
	/** addProduct.jsp에서 사용자가 입력한 부분 받아서 저장 */
	String productId = multi.getParameter("productId");	// 상품 아이디 
	String pname = multi.getParameter("pname");			// 상품명 
	String unitprice = multi.getParameter("unitprice");	// 상품 가격 
	String description = multi.getParameter("description");		// 상품 설명 
	String manufacturer = multi.getParameter("manufacturer");	// 제조사 
	String category = multi.getParameter("category");		// 분류 
	String numberOfstock = multi.getParameter("numberOfstock");		// 재고 수 
	String condition = multi.getParameter("condition");		// 신상품 or 중고품 or 재생품 
	
	Integer price;
	long stock;
	
	// 단가 입력창에 미 입력시에 
	if (unitprice.isEmpty()) {
		price = 0;		// 오토박싱 
	} else {
		// String을 숫자로 변환함
		price = Integer.valueOf(unitprice);
	}
	
	// 재고 수량 입력창에 미 입력시에 
	if (numberOfstock.isEmpty()) {
		stock = 0;
	} else {
		// String을 long 타입으로 변환
		stock = Long.valueOf(numberOfstock);
	}
	
	Enumeration files = multi.getFileNames();
	String fname = (String)files.nextElement();
	String fileName = multi.getFilesystemName(fname);
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "select * from product where productId = ?";
	
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	
	rs = pstmt.executeQuery();
	
	if (rs.next()) {
		if(fileName != null) {
			sql = "update product set pname=?, unitPrice=?, description=?, manufacturer=?" + 
		"category=?, numberOfstock=?, conditions=?, filename=? where productId=?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pname);
			pstmt.setInt(2, price);
			pstmt.setString(3, description);
			pstmt.setString(4, manufacturer);
			pstmt.setString(5, category);
			pstmt.setLong(6, stock);
			pstmt.setString(7, condition);
			pstmt.setString(8, productId);
			pstmt.executeUpdate();
		}
	}
	
	if (rs != null) rs.close();
	if (pstmt != null) pstmt.close();
	if (conn != null) conn.close();
	
	response.sendRedirect("editProduct.jsp?edit=update");
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