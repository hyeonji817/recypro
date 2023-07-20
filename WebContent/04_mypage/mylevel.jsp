<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="order.beans.Order" %>
<%@ page import="order.beans.orderDAO" %>

<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.text.DecimalFormat"%>
<!-- 사용할 빈즈클래스 선언(만 함) -->
<jsp:useBean id="order" class="order.beans.Order" scope="page" />

<!-- 호출할 빈즈 클래스가 가진 데이터 -->
<jsp:setProperty name="order" property="*" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<!-- bootstrap -->
<!-- <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" /> -->
<!-- <link rel="stylesheet" 
 	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"> -->
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
<title>재활용품 전문점 : 리싸이프로 - 마이페이지_마이레벨</title>
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

/** 등급표 아이콘 */
.flow_chart_icon {
	position: relative;
	width: 100px; 
	right: 8%;
	float: right;
	height: 100px;  
	bottom: 17%;
/* 	background-color: #eee;  */
}

.flow_chart_icon img {
	margin: 0 auto;
	position: relative; 
}

/** 사이드바 메뉴 */ 
.side_menubar {
	float: left;
	width: 250px;
	position: relative;
	left: 1%;
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

/** .user_check {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15.5%;
	width: 250px;
	border: 1px solid gray; 
}

.user_check a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
} */

.user_modify {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15.5%;
	width: 250px;
	border: 1px solid gray; 
}

.user_modify a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

.mylevel {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15.5%;
	width: 250px;
	background-color: #eee;
	border: 1px solid gray; 
}

.mylevel a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

/** .return {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15.5%;
	width: 250px;
	border: 1px solid gray; 
}

.return a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
} */

.coupon_list {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15.5%; 
	width: 250px;
	border: 1px solid gray; 
}

.coupon_list a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

/** .shopping_list {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15.5%; 
	width: 250px;
	border: 1px solid gray; 
}

.shopping_list a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
} */

.review_list {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15.5%; 
	width: 250px;
	border: 1px solid gray; 
}

.review_list a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

.orderlist {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15%; 
	width: 250px;
	border: 1px solid gray; 
}

.orderlist a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

.product_review {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -15.5%;
	width: 250px;
	border: 1px solid gray; 
}

.product_review a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

.mylevel_img {
	margin: 0 auto; 
	width: 600px; 
	min-height: 550px; 
	display: block;
	position: relative; 
/* 	background-color: #eee;  */
}

.mylevel_img img {
	margin: 0 auto; 
	display: block; 
	position: relative;
	bottom: 10%;
	padding-top: 17%;
	width: 400px;
	min-height: 350px;
}

.level_info {
	margin-top: 5%;
}

.level_info h4 {
	text-align: center; 
	font-size: 22px;
	font-weight: bold;
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
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">마이레벨</h1>
		</div>
	</div>
	
	<!-- 등급표 아이콘 -->
	<div class="flow_chart_icon">
		<a href="mylevel_grade.jsp">
			<img src="../img/shopdetail/flowchart.png" />
		</a>
	</div>
	
	<!-- 사이드바 메뉴 -->
	<div class="side_menubar">
		<ul>
			<!-- <li>
				<div class="user_check">
					<a href="userinfo.jsp">
						회원정보조회
					</a>
				</div>
			</li> -->
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
			<!-- <li>
				<div class="return">
					<a href="return_product.jsp">물품 반품신청</a>
				</div>
			</li> -->
			<li>
				<div class="coupon_list">
					<a href="coupon_list.jsp">쿠폰함</a>
				</div>
			</li>
			<!-- <li>
				<div class="shopping_list">
					<a href="shopping_history.jsp">쇼핑내역</a>
				</div>
			</li> -->
			<li>
				<div class="review_list">
					<a href="review_history.jsp">게시판 작성 내역</a>
				</div>
			</li>
			<li>
				<div class="orderlist">
					<a href="../03_shop/pd_orderList.jsp">주문내역 조회</a>
				</div>
			</li>
			<li>
				<div class="product_review">
					<a href="productReview_history.jsp">상품리뷰 확인</a>
				</div>
			</li>
		</ul>
	</div>
	
	<!-- 마이레벨 이미지 -->
	<div class="mylevel_img">
	 <% 
	 	Connection conn = null; 
	 	PreparedStatement pstmt = null; 
	 	ResultSet rs = null; 
	 	Class.forName("com.mysql.cj.jdbc.Driver"); 	// 드라이버명, 자바코드와 DB를 연결할 드라이버 (연결다리)
	 	String sql = "select count(*) from orderlist"; 
	 
	 	String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
	 	String userid = "root"; // db에 입력할 id
		String password = "1234"; // db에 입력할 패스워드

		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명, 자바코드와 db를 연결할 드라이버(연결다리)
		conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성
		
		String shopping_userId = request.getParameter("id");	// 넘어온 상품 아이디값을 얻음 
		orderDAO od = new orderDAO();	// 구조체의 모든 데이터들을 호출함 (DAO 클래스에 존재하는 데이터 호출)
		
		int countPurchase = od.myLevel(shopping_userId); 	// 원하는 데이터가 있는지 확인하고, 해당 조건의 데이터를 호출 (검색), 출처 : chatGPT
		String level = "";
        String img = "";
        
		if (countPurchase >= 61) {
			level = "황금열매";
			img = "../img/shopdetail/gold_apple.jpg";
	 %>
		<img src="<%=img%>" />
	<%
		} else if (countPurchase >= 11 && countPurchase <= 20) {	
			level = "새싹";
            img = "../img/shopdetail/sprout.jpg";
	%>
		<img src="<%=img%>" />
	<%
		} else if (countPurchase >= 21 && countPurchase <= 30) {
			level = "묘목";
            img = "../img/shopdetail/sapling.jpg";
	%>	
		<img src="<%=img%>" /> 
	<%
		} else if (countPurchase >= 31 && countPurchase <= 40) {
			level = "나무";
			img = "../img4/shopdetail/tree.jpg"; 
	%>
		<img src="<%=img%>" /> 
	<%
		} else if (countPurchase >= 41 && countPurchase <= 50) {
			level = "나무열매"; 
			img = "../img5/shopdetail/tree.jpg";
	%>
		<img src="<%=img%>" /> 
	<%
		} else if (countPurchase >= 51 && countPurchase <= 60) {
			level = "열매";
			img = "../img/shopdetail/apple.jpg";
	%>
		<img src="<%=img%>" /> 
	<%
		} else {	// 왜 마지막 꺼만 적용이 되는건지?
			level = "씨앗"; 
			img = "../img/shopdetail/seed.jpg";
	%>
		<img src="<%=img%>" /> 
	<%
		}
	%>
		<div class="level_info">
			<h4>회원 ID : witch0817</h4>
			<br>
			<h4>나의 등급 : 씨앗 (lv.8)</h4>
			
			<br>
			<h4>받을 수 있는 혜택 : 미정</h4>
		</div>
	</div>
</body>
</html>