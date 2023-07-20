<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
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
<title>재활용품 전문점 : 리싸이프로 - 마이페이지</title>
<link rel="stylesheet" type="text/css" href="../css/mypage.css">
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
<!-- 부트스트랩 CSS CDN -->
<%@ include file="../01_main/index.jsp"%>
<style>
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

.modify {
	color: white;
}

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
	left: -15%;
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
	left: -15%;
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
	left: -15%;
	width: 250px;
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
	font-size: 17px;
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
	left: -15%;
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

</style>
</head>
<body>
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
	<h2><%=id%>님 환영합니다.
	</h2>

	<!-- 제목 -->
	<div class="title">
		<div class="container">
			<h1 class="display-3"
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">마이페이지</h1>
		</div>
	</div>

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
			<li>
				<div class="coupon_list">
					<a href="#">쿠폰함</a>
				</div>
			</li>
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

	<!-- 	<div class="link-button"> -->
	<!-- 		<button type="button" class="btn btn-danger btn-lg" value="회원정보조회" onclick="location.href='userinfo.jsp'">회원정보조회</button> -->
	<!-- 		<button type="button" class="btn btn-warning btn-lg" value="회원정보수정" onclick="location.href='updateUser.jsp'"> -->
	<!-- 			<span class="modify">회원정보수정</span> -->
	<!-- 		</button> -->
	<!-- 	</div> -->

	<!-- Bootstrap JS CDN -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
		crossorigin="anonymous" />
</body>
</html>