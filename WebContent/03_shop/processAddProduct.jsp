<!-- 참고한 페이지 출처좌표 : https://kjh95.tistory.com/252?category=941468 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="product.beans.Product" %>
<%@ page import="product.beans.ProductRepository" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ include file="dbconn.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	// addProduct.jsp에서 사용자가 업로드한 이미지 부분을 받아 저장. 
	String filename = "";
	String realFolder = "D:\\개인 프로젝트 작업\\recypro(project)\\recypro\\WebContent\\img\\shop";	// 웹 애플리케이션에서 절대경로
	int maxsize = 100 * 1024 * 1024;	// 최대 업로드 크기 
	String encType = "UTF-8";			// 인코딩 유형 
	
	// MultipartRequest 적용 시, 상세상품 이미지 출력하게 됨 
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxsize, encType,
			new DefaultFileRenamePolicy());
	
	/** addProduct.jsp에서 사용자가 입력한 부분 받아서 저장 */
	String productId = multi.getParameter("productId");		// 상품 아이디
	String pname = multi.getParameter("pname");				// 상품 
	String unitprice = multi.getParameter("unitprice");		// 상품 가격 
	String description = multi.getParameter("description");	// 상품 설명 
	String manufacturer = multi.getParameter("manufacturer");	// 제조사 
	String category = multi.getParameter("category");		// 분류 
	String numberOfstock = multi.getParameter("numberOfstock");	// 재고 수 
	String condition = multi.getParameter("condition");		// 신상품 or 중고품 or 재생품
	
	Integer price;
	long stock;
	
	// 단가 입력창에 미 입력시에
	if (unitprice.isEmpty()) {
		price = 0;	// 오토박싱
	} else {
		price = Integer.valueOf(unitprice);
	}
	
	if (numberOfstock.isEmpty()) {
		stock = 0;
	} else {
		stock = Long.valueOf(numberOfstock);	// String을 long 타입으로 변환
	}
	
	Enumeration files = multi.getFileNames();
	String fname = (String)files.nextElement();	
	String fileName = multi.getFilesystemName(fname);
	
	Connection conn = null; 
	
	String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
	String user = "root"; 
	String password = "1234"; 
	
	Class.forName("com.mysql.cj.jdbc.Driver");		// 드라이버명
	conn = DriverManager.getConnection(url, user, password);	// 연결 객체생성 
	
	PreparedStatement pstmt = null;
	String sql = "insert into product values(?,?,?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	
	/** 9개의 사용자로부터 입력받은 데이터를 DB에 저장 */ 
	pstmt.setString(1, productId);
	pstmt.setString(2, pname);
	pstmt.setInt(3, price);
	pstmt.setString(4, description);
	pstmt.setString(5, manufacturer);
	pstmt.setString(6, category);
	pstmt.setLong(7, stock);
	pstmt.setString(8, condition);
	pstmt.setString(9, fileName);
	
	pstmt.executeUpdate();
	System.out.println("상품 등록 완료");
	
	// 자원 해제 
	if (pstmt != null) pstmt.close();
	if (conn != null) conn.close();
	
	// 페이지 이동시킴
	response.sendRedirect("Products.jsp");
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
<!-- 출처좌표 : https://coding23.tistory.com/42 -->