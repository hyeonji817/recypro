<!-- 참고한 웹 페이지 주소좌표 : https://kjh95.tistory.com/284?category=941468 -->
<!-- 주문완료 페이지 -->
<!-- 주문이 완료되었으니, 세션 삭제하고 관련 쿠키도 삭제 -->
<!-- 변경된 쿠키를 다시 응답처리 객체에 재추가 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="order.beans.Order" %>
<%@ page import="order.beans.orderDAO" %>
<%@ page import="product.beans.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.util.DBConn"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dFormat = new DecimalFormat("###,###");
	String cartId = session.getId();
	
	Date nowTime = new Date();
	SimpleDateFormat sf = new SimpleDateFormat("yyyy년 MM월 dd일");

	String shopping_userId = "";
	String shopping_productId = "";
	String shopping_cartId = "";
	String shopping_name = "";
	String shopping_date = "";
	String shopping_country = "";
	String shopping_zipCode = "";
	String shopping_addressName = "";
	String shopping_num = "";
%>
<jsp:useBean id="user" class="user.beans.User" scope="page" />
<jsp:useBean id="order" class="order.beans.Order" scope="page" />
<jsp:setProperty name="user" property="*" />
<jsp:setProperty name="order" property="*" />
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<style>
	.container {
		margin-bottom: 5%;
		margin-top: 5%;
		font-weight: 700;
	}

	.display-3 {
		margin-top: 12%;
		font-weight: 700;
	}
	
	#progress {
	width: 1080px;
	height: 250px;
	position: relative;
	bottom: 6%;
	top: 1.5%;
	margin: 0 auto;
	display: block;
}

#progress li {
	padding: 0;
	width: 33.3%;
	float: left;
	height: 250px;
	display: block;
}

#progress li:first-child {
	/* 		border-right: 2px solid black; */
	margin: 0 auto;
}

.basket {
	margin: 0 auto;
	overflow: hidden;
	border-radius: 123px;
	position: relative;
	top: 3.5%;
	width: 65%;
	height: 90.5%;
	border: 2px solid black;
}

.basket_icon img {
	margin: 0 auto;
	width: 100px;
	position: relative;
	left: 29%;
	padding-top: 10%;
}

.first_continue h5 {
	text-align: center;
	font-weight: bold;
	padding-top: 15%;
	font-size: 22px;
}

#progress li:nth-child(2) {
	/* 		border-right: 2px solid black; */
	margin: 0 auto;
}

.card {
	margin: 0 auto;
	overflow: hidden;
	border-radius: 123px;
	top: 3.5%;
	width: 65%;
	height: 90.5%;
	position: relative;
	border: 2px solid black;
}

.card_icon img {
	margin: 0 auto;
	width: 100px;
	position: relative;
	left: 25%;
	padding-top: 10%;
	width: 120px;
}

.second_continue h5 {
	text-align: center;
	font-weight: bold;
	padding-top: 6%;
	font-size: 22px;
}

#progress li:nth-child(3) {
	margin: 0 auto;
}

.order_complete {
	margin: 0 auto;
	overflow: hidden;
	border-radius: 123px;
	top: 3.5%;
	width: 65%;
	height: 90.5%;
	position: relative;
	background: white;
	border: 2px solid black;
	background: rgb(159, 251, 244);
}

.calendar_icon img {
	margin: 0 auto;
	width: 120px;
	position: relative;
	left: 23%;
	padding-top: 8%;
}

.last_continue h5 {
	text-align: center;
	font-weight: bold;
	padding-top: 6%;
	font-size: 22px;
}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp" %>
	
	<%
		Connection conn = null;
		PreparedStatement pstmt = null; 
		ResultSet rs = null;
		Class.forName("com.mysql.cj.jdbc.Driver");		// 드라이버명, 자바코드와 db를 연결할 드라이버(연결다리)
		String sql = "select * from orderlist";
		
		try {
			String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
			String userid = "root"; // db에 입력할 id
			String password = "1234"; // db에 입력할 패스워드		
			
			conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성			
			pstmt = conn.prepareStatement(sql);		// 연결 객체의 prepareStatement 객체를 통해 해당 sql의 내용 호출 
			rs = pstmt.executeQuery();		// 조회한 결과들을 ResultSet 내의 rs에 저장
		
			if(rs.next()) {
	%>
	
	<!-- 페이지 제목명 -->
	<div class="container">
		<h1 class="display-3" style="position: relative; right: 5%;">주문 완료</h1>
	</div>
	
	<!-- 진행 상황 -->
	<div class="cart_continue" id="progress">
		<ul>
			<li>
				<!-- 장바구니 -->
				<div class="basket">
					<!-- 장바구니 아이콘 -->
					<div class="basket_icon">
						<img src="../img/shop/shopping_basket1.png" />
					</div>
					<!-- 장바구니 이름 -->
					<div class="first_continue">
						<h5>장바구니</h5>
					</div>
				</div>
			</li>
			<li>
				<!-- 주문 / 결제 -->
				<div class="card">
					<!-- 카드 아이콘 -->
					<div class="card_icon">
						<img src="../img/shop/card.png" />
					</div>
					<!-- 주문/결제 -->
					<div class="second_continue">
						<h5>주문/결제</h5>
					</div>
				</div>
			</li>
			<li>
				<!-- 주문완료 -->
				<div class="order_complete">
					<!-- 캘린더 아이콘 -->
					<div class="calendar_icon">
						<img src="../img/shop/purchase_order.png" />
					</div>
					<!-- 주문완료 -->
					<div class="last_continue">
						<h5>주문완료</h5>
					</div>
				</div>
			</li>
		</ul>
	</div>
	
	<!-- 내용 -->
	<div class="container">
		<h2 class="alert alert-danger">주문해 주셔서 감사합니다.</h2>
	</div>
	
	<div class="container">
		<p><%rs.last();%> 주문은 <%=sf.format(nowTime)%>에 배송될 예정입니다.</p>
		<p>주문번호 : <%=rs.getString("shopping_num")%></p>
	</div>
	<%
			} 
		} catch (SQLException se) {
			se.printStackTrace();
			System.out.println("값을 불러들이지 못함");
		} 
	%>
	<div class="container">
		<p><h2><a href="Products.jsp" style="color: black; position: relative; float: right; font-weight: bold; background-color: #9FFBF4;" class="btn btn-default btn-lg">상품 목록</a></h2></p>
	</div>
</body>
</html>