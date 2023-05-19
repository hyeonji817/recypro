<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<!-- bootstrap -->
<link rel="stylesheet" 
 	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css"> 
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" /> 
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<title>재활용품 전문점 : 리싸이프로 - 마이페이지_쿠폰함</title>
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
	left: 1.5%;
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
	left: -16%;
/* 	background-color: red;  */
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
}

.user_modify {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -16%;
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
	left: -16%;
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

/** .return {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -16%;
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
	left: -16%; 
	width: 250px;
	background-color: #eee;
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
	left: -16%; 
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
	left: -16%; 
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

.product_review {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -16%;
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

.table {
	text-align: center;
	margin: 0 auto;
	position: relative;
	top: 17%;
	width: 650px;
	height: 200px;
}

.table thead {
	height: 50px;
}

.button {
	margin: 0 auto;
	float: right;
	right: 28%;
	position: relative;
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
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">쿠폰함</h1>
		</div>
	</div>
	
	<!-- 사이드바 메뉴 -->
	<div class="side_menubar">
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
				<div class="product_review">
					<a href="productReview_history.jsp">상품리뷰 확인</a>
				</div>
			</li>
		</ul>
	</div>
	
	<!-- 쿠폰종류 테이블 -->
	<table class="table" border="1">
		<thead>
			<tr>
				<th style="text-align: center;">번호</th>
				<th style="text-align: center;">쿠폰종류</th>
				<th style="text-align: center;">유효기간</th>
				<th style="text-align: center;">사용여부</th>
			</tr>
		</thead>
		<tbody>	<!-- 지금은 일단 UI만 구현하고, UI 구현 끝나는대로 쿠폰 기능 구현할 예정 -->
			<tr class="white">
				<td style="text-align: center;">3</td>
<!-- 				<td style="float: left; text-decoration-line: none;">50% OFF 할인쿠폰 (생일 이벤트) 등급 무관하게 드려요!</td> -->
				<td>50% OFF 할인쿠폰 (생일 이벤트) 등급 무관하게 드려요!</td>
				<td>2022.08.17 ~ 2023.02.17 (6개월)</td>
				<td>N</td>
			</tr>
			<tr class="light">
				<td style="text-align: center;">2</td>
				<td>10% OFF 할인쿠폰</td>
				<td>2023.02.19 ~ 2023.05.19 (3개월)</td>
				<td>Y</td>
			</tr>
			<tr class="light">
				<td style="text-align: center;">1</td>
				<td>20% OFF 할인쿠폰</td>
				<td>2023.08.12 ~ 2023.11.12 (3개월)</td>
				<td>N</td>
			</tr>
		</tbody>
	</table>
</body>
</html>