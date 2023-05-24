<!-- 장바구니 페이지를 클릭했을 때 진행되는 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8"); // 이거 값 추가하고, clean, build, 톰캣재시작해야 한글적용 (별표!!!!!!)
%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="order.beans.Order"%>
<%@ page import="order.beans.orderDAO"%>
<%@ page import="product.beans.Product" %>
<%@ page import="product.beans.ProductRepository" %>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.util.DBConn"%>

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.io.*,java.util.*,javax.servlet.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="user" class="user.beans.User" scope="page" />
<jsp:useBean id="order" class="order.beans.Order" />	<!-- 해당 빈즈에 들어있는 데이터를 사용하겠다고 선언 -->
<jsp:setProperty property="*" name="order"/>
<jsp:setProperty name="order" property="shopping_userId"/> <!-- 수정 시 userid 에러 뭐시기에서 해결됨.-->
<jsp:setProperty name="order" property="shopping_productId"/> <!-- 수정 시 userid 에러 뭐시기에서 해결됨.-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 - 리싸이프로 : 배송정보 페이지 처리과정</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<style>
.main-img {
	position: fixed;
	top: 5%;
	width: 100%;
	height: 100%;
	opacity: 0.3;
	background-attachment: fixed;
	z-index: -10;
}

.title {
	margin-top: 150px;
	height: 160px;
}

.display-3 {
	margin-left: 70px;
	margin-top: -20px;
	font-weight: 700;
	color: white;
	text-shadow: 1px 1px 5px #bdbdbd;
}
</style>
</head>
<body>
	<%
		// 한글처리 & 로그인 여부체크 -> 로그인 페이지로 이동 
		request.setCharacterEncoding("UTF-8");
		String id = (String) session.getAttribute("id");
		if (id == null) {
			response.sendRedirect("../02_account/login.jsp");
		}
	%>


	<%
		Connection conn;
		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // DB를 연결할 url 서버주소 
		String userid = "root"; // db에 입력할 db전용 아이디 
		String password = "1234"; // db에 입력할 db전용 패스워드 
		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명, 자바코드와 db를 연결할 드라이버 (연결다리)
		conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성
		
		/** 추가 내용 (102번째 줄까지) */
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		int sum = 0;
		int total = 0;
		Product product1 = new Product();		// 첨부할 product 구현체 객체 인스턴스 선언
		
		// 세션 속성의 이름이 cartList인 세션 정보(장바구니에 담긴 물품 목록)를 가져와서 ArrayList에 대입
		ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartList");

		/** cart.jsp 파일에서 전체 상품을 삭제하는 deleteCart.jsp에서 session.invalidate()을 호출하게 되면
			cartList는 null이 되기 때문에 아래와 같은 코드가 반드시 필요함 */
		if (cartList == null) {
			cartList = new ArrayList<Product>();
		}

		for (int i = 0; i < cartList.size(); i++) {
			product1 = cartList.get(i);		// 상품 객체에 저장된 데이터들을 배열로 나열 
			// 소계 = 가격 * 수량 
			total = product1.getUnitprice() * product1.getQuantity();
			sum = sum + total;
		}
		
		ArrayList<Product> cartList2 = (ArrayList<Product>) session.getAttribute("cartList");
		
		// System.out.println("cartList2 확인");
		// System.out.println(cartList2);
		
		// orderDAO 객체 생성
		String shopping_userId = request.getParameter("shopping_userId"); // 접속한 사용자 id
		String shopping_productId = request.getParameter("shopping_productId"); // 상품명
		// shopping_productId = product1.getProductId();
		
		String shopping_name = request.getParameter("shopping_name"); // 성명
		String shopping_date = request.getParameter("shopping_date"); // 배송날짜
		String shopping_country = request.getParameter("shopping_country"); // 배송국가
		String shopping_zipCode = request.getParameter("shopping_zipCode"); // 우편번호
		String shopping_addressName = request.getParameter("shopping_addressName"); // 배송지

		// System.out.println(shopping_productId);

		
		// 주문정보 처리과정 (orderDAO)  
		orderDAO orderDAO = new orderDAO();
		orderDAO.orderhj(shopping_userId, shopping_productId, shopping_name, shopping_date, shopping_country, shopping_zipCode, shopping_addressName);
		response.sendRedirect("orderConfirmation.jsp"); // orderConfirmation.jsp를 실행시켜 새로운 정보 업데이트
	%>
	<input type="hidden" name="cartlist_transfer" value="<%=cartList2%>" />
</body>
</html>