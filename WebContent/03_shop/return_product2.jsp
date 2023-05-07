<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="orderlist2.beans.orderlist2" %>
<%@ page import="orderlist2.beans.orderlist2DAO" %>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<jsp:useBean id="user" scope="session" class="user.beans.User" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 마이페이지_반품신청(주문조회)</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<style>
/** 제목 */
.title {
	margin-top: 7%;
	height: 150px;
}

.display-3 {
	margin-left: -6%;
	color: black;
	position: relative;
	font-weight: bold;
	font-size: 55px;
	display: block;
}

/** 사이드바 메뉴 */

.side_menubar {
	float: left;
	width: 250px;
	position: relative;
	top: 3%;
	min-height: 480px;
	margin-bottom: 10%;
	display: block;
/* 	background-color: #eee; */
}

.side_menubar li {
	padding: 0;
	display: block;
	position: relative; 
	height: 60px; 
	width: auto;
}

.user_check {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15%;
/* 	background-color: red;  */
	width: 250px;
	border: 1px solid gray; 
}

.user_check a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-weight: bold;
}

.user_modify {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15%;
	width: 250px;
	border: 1px solid gray; 
}

.user_modify a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-weight: bold;
}

.mylevel {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15%;
	width: 250px;
	border: 1px solid gray; 
}

.mylevel a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-weight: bold;
}

.return {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15%;
	width: 250px;
	background-color: #eee;
	border: 1px solid gray; 
}

.return a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-weight: bold;
}

.coupon_list {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15%; 
	width: 250px;
	border: 1px solid gray; 
}

.coupon_list a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-weight: bold;
}

.shopping_list {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15%; 
	width: 250px;
	border: 1px solid gray; 
}

.shopping_list a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-weight: bold;
}

.review_list {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15%; 
	width: 250px;
	border: 1px solid gray; 
}

.review_list a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-weight: bold;
}

.product_review {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15%;
	width: 250px;
	border: 1px solid gray; 
}

.product_review a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-weight: bold;
}

.return_pd2 {
	width: 1500px; 
	margin: 0 auto; 
}

.order_view {
	margin: 0 auto; 
	width: 800px; 
	min-height: 600px;
}

.order_view_title h2 {
	font-weight: bold;
	padding-top: 4%; 
	position: relative; 
	left: 6%;
}

.order_number h6 {
	font-weight: bold;
	width: 300px; 
	position: relative;
	left: 6%; 
	margin-top: 4%;
}

.order_review {
	margin: 0 auto; 
	width: 700px; 
	min-height: 300px; 
	margin-top: 5%;
	border: 1px solid black;
}

.order_img img {
	float: left; 
	position: relative; 
	right: -2%;
	display: block;
	top: 10px; 
	width: 170px;
	border-radius: 20px;
}

.order_data h5 {
	font-weight: bold; 
	width: 500px;
	position: relative; 
	padding-top: 10%; 
	left: 8%;
} 

.order_data h6 {
	font-weight: bold;
	width: 300px; 
	position: relative;
	top: -140px; 
	left: 48%;
}

.order_button {
	float: right; 
}

.order_product a {
	display: block; 
	position: relative;
	right: 27%; 
	float: right; 
	margin: 0 auto; 
	font-weight: bold; 
	margin-bottom: 10%;
}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>

	<%
		// 한글처리, 파라미터 (세션생성)
		request.setCharacterEncoding("UTF-8");
		String id = (String) session.getAttribute("id");
		String name = request.getParameter("name");
		// id없이는 진입불가, id없는 경우 로그인페이지로 이동 
		if (id == null) {
			response.sendRedirect("../02_account/login.jsp");
		}
	%>
	
	<!-- 제목 -->
	<div class="title">
		<div class="container">
			<h1 class="display-3"
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">물품 반품신청</h1>
		</div>
	</div>
	
	<!-- 사이드바 메뉴 -->
	<!-- <div class="side_menubar">
		<ul>
			<li>
				<div class="user_check">
					<a href="userinfo.jsp">
						회원정보조회
					</a>
				</div>
			</li>
			<li>
				<div class="user_modify">
					<a href="updateUser.jsp">회원정보수정</a>
				</div>
			</li>
			<li>
				<div class="mylevel">
					<a href="mylevel.jsp">마이레벨</a>
				</div>
			</li>
			<li>
				<div class="return">
					<a href="return_product.jsp">물품 반품신청</a>
				</div>
			</li>
			<li>
				<div class="coupon_list">
					<a href="coupon_list.jsp">쿠폰함</a>
				</div>
			</li>
			<li>
				<div class="shopping_list">
					<a href="shopping_history.jsp">쇼핑내역</a>
				</div>
			</li>
			<li>
				<div class="review_list">
					<a href="review_history.jsp">게시판 작성 내역</a>
				</div>
			</li>
			<li>
				<div class="product_review">
					<a href="productReview_history.jsp">상품리뷰 확인</a>
				</div>
			</li>
		</ul>
	</div> --> 
	<!-- DB 연동 -->
	<%
		Connection conn = null;
	
		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
		String userid = "root"; // db에 입력할 id
		String password = "1234"; // db에 입력할 패스워드

		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명, 자바코드와 db를 연결할 드라이버(연결다리)
		conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성
		
		orderlist2DAO odao2 = orderlist2DAO.getInstance();	// 구조체의 모든 데이터들을 호출함 (데이터 )
		orderlist2 od2 = odao2.getOrder2(id);	// 원하는 데이터가 있는지 확인하고, 해당 조건의 데이터를 호출 (검색)
		String Shopping_userId = request.getParameter("id");	// 넘어온 상품 아이디값을 얻음.
		
		// PreparedStatement : 각각의 인수에 대해 위치홀더 (placeholder)를 사용하여 SQL 문장을 정의
		// 각각의 SQL 타입을 처리할 수 있는 setXxxx() 메소드를 제공		ex) setString()
		PreparedStatement pstmt = null;
		ResultSet rs = null; // select의 결과를 저장하는 객체, 명령에 대한 반환값 
		String sql = "select * from orderlist2";
		pstmt = conn.prepareStatement(sql); // 연결 객체의 prepareStatement객체를 통해 해당 sql의 내용 호출
		
		rs = pstmt.executeQuery();
		
		while (rs.next()) {
	%>
	
	<div class="return_pd2">
		<!-- 주문조회 페이지 -->
		<div class="order_view">
			<!-- 주문 조회 -->
			<div class="order_view_title">
				<h2>주문 조회</h2>
			</div>
			<div class="order_number">
				<!-- <h6>주문번호 : 5</h6> -->
				<h6>주문번호 : <%=rs.getString("shopping_num") %></h6>
			</div>
			<div class="order_review">	<!-- 여기서부터 DB에 저장된 내용을 가지고 오면 될 듯 -->
				<div class="order_img">
					<!-- <img src="../img/shopdetail/1_3-1_minimum.jpg" /> -->
					<img alt="사진업로드" src="/recypro/img/shopdetail/<%=rs.getString("shopping_img")%>" style="width: 40%">
				</div>
				<div class="order_data">
					<!-- <h5>유기농 설거지 비누</h5> -->
					<h5><%=rs.getString("shopping_productId")%></h5>
					<h6>3000원 / 1개</h6> 
				</div>
				<div class="order_button">
					<a href="#" class="btn btn-default btn-lg" style="border: 2px solid black; position: relative; margin-top: -170%; left: 36%;">
						<span class="review_send">배송조회</span>
					</a>
					<a href="#" class="btn btn-default btn-lg" style="border: 2px solid black; position: relative; margin-top: -120%; right: 15%;">
						<span class="return_change">반품/교환</span>
					</a>
				</div>
			</div>
		</div>
	</div>
	<%
		}
	%>
	
	<!-- 신청하기 버튼 -->
	<div class="order_product">
		<a href="#" class="btn btn-default btn-lg" style="background-color: #b6f5f5; position: relative;">
			<span class="product_order">
				신청하기
			</span>
		</a>
	</div>
</body>
</html>