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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
<title>재활용품 전문점 : 리싸이프로 - 메인페이지_이벤트</title>
<style>
.special_event {
	width: 1000px; 
	min-height: 560px; 
	position: relative; 
	top: 22%;
	margin: 0 auto; 
	display: block;
	border: 1px solid black;
/* 	background-color: #eee;  */
}

.special_event h4 {
	text-align: center; 
	font-weight: bold; 
	font-size: 26px;
	padding-top: 8%;
}

.special_event h2 {
	font-weight: bold; 
	text-align: center;
	font-size: 45px; 
	padding-top: 10%;
}

.mint {
	font-weight: bold; 
	color: rgb(26, 188, 156);
}

.give_coupon {
	margin: 0 auto; 
	width: 400px; 
	position: relative;
	min-height: 56px;
	display: block;
	margin-top: 6%;
}

.special_event h5 {
	text-align: center; 
	padding-top: 5%;
	font-weight: bold; 
}

/** 두 번째 레이아웃 */ 

.special_event2 {
	width: 1000px; 
	min-height: 560px;
	position: relative; 
	top: 22%;  
	margin: 0 auto;
	display: block;
	border-bottom: 2px dotted black;
/* 	background-color: orange;   */
}

.special_event2_notice {
	width: 700px; 
	min-height: 400px; 
	position: relative; 
	top: 60px;
	margin: 0 auto; 
/* 	background-color: yellow; */
}

.special_event2_notice h3 {
	text-align: center; 
	font-weight: bold; 
	padding-top: 2%;
	font-size: 40px;
}

.new_event {
	color: red; 
	font-weight: bold;
}

/** 쿠폰리스트 레이아웃 */ 
.give_couponList {
	width: 1000px; 
	min-height: 1740px;
	position: relative; 
	top: 22%; 
	margin: 0 auto; 
	display: block;
/* 	background-color: #e6e6fa; */
}

.couponList_title h3 {
	text-align: center; 
	font-weight: bold;
	font-size: 36px;
	padding-top: 6%;
}

/** 10% 할인 쿠폰 */ 
.first_coupon {
	width: 500px; 
	min-height: 300px; 
	position: relative; 
	top: 36px;
	display: block;
	margin: 0 auto; 
	background-color: rgb(248, 244, 85); 
}

.coupon_title1 h3 {
	font-weight: bold;
	display: inline-block; 
	position: relative; 
	padding-top: 4%; 
	left: 2%; 
	font-size: 36px;
}

.coupon_img1 {
	width: 400px; 
	margin: 0 auto; 
	position: relative; 
	display: inline-block; 
	height: 350px; 
	margin-top: 3%;
}

.10percent_off h3 {
	text-align: center; 
	display: inline-block; 
	position: relative;
}

/** 20% 할인 쿠폰 */ 
.second_coupon {
	width: 500px; 
	min-height: 300px; 
	position: relative; 
	top: 50px;
	display: block;
	margin: 0 auto; 
	background-color: rgb(46, 204, 113); 
}

.coupon_title2 h3 {
	font-weight: bold;
	display: inline-block; 
	position: relative; 
	padding-top: 4%; 
	left: 2%; 
	font-size: 36px;
}

.coupon_img2 {
	width: 400px; 
	margin: 0 auto; 
	position: relative; 
	display: inline-block; 
	height: 350px; 
	margin-top: 3%;
}

.20percent_off h3 {
	text-align: center; 
	display: inline-block; 
	position: relative;
}

/** 30% 할인쿠폰 */ 
.third_coupon {
	width: 500px; 
	min-height: 300px; 
	position: relative; 
	top: 60px;
	display: block;
	margin: 0 auto; 
	background-color: rgb(231, 76, 60); 
}

.coupon_title3 h3 {
	font-weight: bold;
	display: inline-block; 
	position: relative; 
	padding-top: 4%; 
	left: 2%; 
	font-size: 36px;
}

.coupon_img3 {
	width: 400px; 
	margin: 0 auto; 
	position: relative; 
	display: inline-block; 
	height: 350px; 
	margin-top: 3%;
}

.30percent_off h3 {
	text-align: center; 
	display: inline-block; 
	position: relative;
}

/** 만원짜리 할인 쿠폰 */ 
.ten_thousands_coupon {
	width: 500px; 
	min-height: 170px; 
	position: relative; 
	top: 70px;
	display: block;
	margin: 0 auto; 
	background-color: #eee; 
}

.coupon_title4 h3 {
	font-weight: bold;
	display: inline-block; 
	position: relative; 
	padding-top: 4%; 
	left: 2%; 
	font-size: 36px;
}

.dollar2 {
	float: left; 
	display: block;
	position: relative; 
}

.dollar2 img {
	float: left; 
	display: inline-block;
}

.dollar2 h6 {
	font-weight: bold; 
	display: inline-block;
}

.count_money {
	float: right; 
	display: inline-block;
	right: 4%; 
	padding-top: 3%;
	position: relative; 
	font-weight: bold; 
}

/** 버튼 레이아웃 */ 
.button_list {
	float: right;
	position: relative;
	right: 22%;
	top: 24%; 
	display: block;
	width: 500px; 
	min-height: 60px;
/* 	background-color: #1E90FF; */
}
</style>
</head>
<body>
	<%
		// id값의 존재 유무를 통해 로그인 되어 있는지 사전체크 
		String id = null; 
		PrintWriter pw = response.getWriter(); 
		
		if (session.getAttribute("id") != null) {
			id = (String)session.getAttribute("id"); 
			pw.println("location.href='../01_main/event.jsp'");
		}
		
		if (id == null) {
	%>
	<%@ include file="../01_main/index_top.jsp" %>
	<%
		} else {
	%>
	<%@ include file="../01_main/index.jsp" %>
	<%
		}
	%>
	
	<!-- 신규회원 특별 혜택 레이아웃 -->
	<div class="special_event">
		<h4>New Membership Benefits</h4>
		
		<h2>3월 봄맞이 <span class="mint">신규회원</span> <br>
		특별한 혜택!
		</h2>
		
		<!-- 신규가입 시 할인쿠폰 증정! -->
		<div class="give_coupon">
			<a href="#" class="btn btn-default btn-lg" style="background-color: rgb(26, 188, 156); position: relative; width: 400px; min-height: 50px; font-weight: bold; color: white;">
				신규가입 시 할인쿠폰 증정!
			</a>
		</div>
		
		<!-- 이벤트 기간 -->
		<h5>2023.03.01 ~ 04.30까지</h5>
	</div>
	
	<!-- 신규회원 특별 혜택 레이아웃2 -->
	<div class="special_event2">
		<div class="special_event2_notice">
			<h3>
				_ <br><br>
				새로운 계절을 맞아 <br>
				리싸이프로 <span class="new_event">신규 가입하는 고객님께</span> <br> 
				<span class="new_event">특별한 혜택</span>을 드립니다★
				<br>
				<br>
				3월 기간동안 회원가입 하시면 <br> 
				<span class="new_event">최대 30% 할인쿠폰</span>을 드려요!
				<br>
				<br>
			</h3>
		</div>
	</div>
	
	<!-- 제공 쿠폰리스트 레이아웃 -->
	<div class="give_couponList">
		<!-- 제목 -->
		<div class="couponList_title">
			<h3>[BENEFIT]</h3>
		</div>
		
		<!-- 첫 번째 쿠폰 (10% 할인) -->
		<div class="first_coupon">
			<!-- 리싸이프로 로고명 -->
			<div class="coupon_title1">
				<h3>리싸이프로</h3>
			</div>
			
			<!-- 이미지 레이아웃 -->
			<div class="coupon_img1">
				<span class="recycle">
					<img src="../img/shopdetail/recycle_2.PNG" />
				</span>
				<span class="dollar">
					<img src="../img/shopdetail/dollar.PNG" />
				</span>
				<div class="10percent_off">
					<h3>10% OFF</h3>
				</div>
			</div>
		</div>
		
		<!-- 두 번째 쿠폰 (20% 할인) -->
		<div class="second_coupon">
			<div class="coupon_title2">
				<h3>리싸이프로</h3>
			</div>
			
			<!-- 이미지 레이아웃 -->
			<div class="coupon_img2">
				<span class="recycle">
					<img src="../img/shopdetail/recycle_2.PNG" />
				</span>
				<span class="dollar">
					<img src="../img/shopdetail/dollar.PNG" />
				</span>
				<div class="20percent_off">
					<h3>20% OFF</h3>
				</div>
			</div>
		</div>
		
		<!-- 세 번째 쿠폰 (30% 할인) -->
		<div class="third_coupon">
			<div class="coupon_title3">
				<h3>리싸이프로</h3>
			</div>
			
			<!-- 이미지 레이아웃 -->
			<div class="coupon_img3">
				<span class="recycle">
					<img src="../img/shopdetail/recycle_2.PNG" />
				</span>
				<span class="dollar">
					<img src="../img/shopdetail/dollar.PNG" />
				</span>
				<div class="30percent_off">
					<h3>30% OFF</h3>
				</div>
			</div>
		</div>
		
		<!-- 10000원 할인 쿠폰 -->
		<div class="ten_thousands_coupon">
			<div class="coupon_title4">
				<h3>리싸이프로</h3>
			</div>
			
			<!-- 달러 아이콘 -->
			<div class="dollar2">
				<img src="../img/shopdetail/dollar.PNG" />
				<h6>적립금</h6>
			</div>
			
			<!-- 가격 -->
			<div class="count_money">
				<h3>10,000</h3>
			</div>
		</div>
	</div>
	
	<!-- 버튼 레이아웃 -->
	<div class="button_list">
		<a href="#" class="btn btn-default btn-lg" style="background-color: #b6f5f5; position: relative; right: -14%; font-weight: bold;">
			<span class="download">회원가입 및 쿠폰 다운받기</span>
		</a>
		<a href="#" class="btn btn-default btn-lg" style="background-color: #b6f5f5; position: relative; right: -17%; font-weight: bold;">
			<span class="return">뒤로가기</span>
		</a>
	</div>
</body>
</html>