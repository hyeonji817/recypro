<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
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
<title>재활용품 전문점 : 리싸이프로 - 고객센터_공지사항(세부내용)</title>
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

/** 공지사항 세부내용 영역 */ 
.notice_subinfo {
	margin: 0 auto; 
	position: relative; 
	width: 800px; 
	min-height: 1000px; 
}

/** 고객상담 안내 */
.consult_info h6 {
	text-align: center; 
}

.consult_subInfo h6 {
	text-align: center;
}

/** 배송 안내 */
.shipment_info {
	margin-top: 10%;
}

.shipment_info h6 {
	text-align: center;
}

.shipment_subInfo {
	margin-top: 2%;
}

.shipment_subInfo h6 {
	text-align: center;
}

/** 교환/반품(환불) 안내 */
.change_info {
	margin-top: 10%;
}

.change_info h6 {
	text-align: center;
}

.change_subInfo {
	margin-top: 3%;
}

.change_subInfo h6 {
	text-align: center;
}

.red_font {
	color: red;
}

.blue_font {
	color: blue;
}

/** 버튼 부분 */
.policy_button {
	margin: 0 auto; 
	float: right; 
	right: 24%; 
	top: 17%; 
	position: relative;
}
</style>
</head>
<body>
	<%
		// 한글처리, 파라미터 (세션생성)
		request.setCharacterEncoding("UTF-8");
	
		// id값의 존재 유무를 통해 로그인 되어 있는지 사전체크 
		String id = null; 
		PrintWriter pw = response.getWriter(); 
		
		if (session.getAttribute("id") != null) {
			id = (String)session.getAttribute("id"); 
			pw.println("location.href='../04_mypage/shopping_history.jsp'");
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
	
	<!-- 제목 -->
	<div class="title">
		<div class="container">
			<h1 class="display-3" style="font-weight: bold; text-shadow: 1px 1px 5px #bdbdbd;">고객센터_공지사항 세부사항</h1>
		</div>
	</div>
	
	<div class="notice_subinfo">
		<!-- 고객상담 안내 -->
		<div class="consult_info">
			<h6>---------------
				<br>
				고객상담 안내
				<br>
				---------------
			</h6>
		</div>
		
		<!-- 고객상담 안내 세부내용 -->
		<div class="consult_subInfo">
			<h6>
				리싸이프로 콜센터 업무 시간은 평일 오전 11시부터 오후 5시(주말, 공휴일제외)까지이며, <br>
				점심시간(12:00 ~ 13:00)에는 운영하지 않습니다. 
				<br>
				상담시간 외에는 홈페이지 게시판을 이용해 주시면 빠르게 답변드리겠습니다. <br>
				톡톡 상담을 이용해 주시면 가장 빠른 상담을 받아보실 수 있습니다. <br><br>
				리싸이프로콜센터 : 1993-0817 <br>
			</h6>
		</div>
		
		<!-- 배송안내 -->
		<div class="shipment_info">
			<h6>
				---------------
				<br>
				배송 안내 
				<br>
				---------------
			</h6>
		</div>
		
		<!-- 배송안내 세부내용 -->
		<div class="shipment_subInfo">
			<h6>
				배송지역 : 국내 지역, 일부 해외 지역 <br>
				배송료 : 총 결제금액이 60,000원 미만일 경우 배송료 3,500원이 발생합니다. <br>
				배송기간은 재고가 있는 품목에 한하여 당일배송이 되며 <br>
				그 외 품목은 입금 확인 후 약 2~5일(주말, 공휴일 제외) 소요됩니다. <br> 
				인기품목은 조기 품절이나 배송지연 될 수 있으며, <br> 
				지연될 경우 7~14일이 소요될 수 있으니 이점 양해바랍니다. <br> 
				저희 '리싸이프로'는 CJ대한통운 택배를 이용하고 있습니다. <br> 
				운송장 번호를 확인하시면 CJ 대한통운 홈페이지 또는 모바일 전용 APP을 다운 받아보시면 <br>
				빠르게 배송현황을 조회하실 수 있습니다. 
			</h6>
		</div>
		
		<!-- 교환/반품(환불) 안내 -->
		<div class="change_info">
			<h6>
				------------------------
				<br>
				교환/반품(환불) 안내
				<br>
				------------------------
			</h6>
		</div>
		
		<!-- 교환/반품(환불) 안내 세부내용 -->
		<div class="change_subInfo">
			<h6>
				<span class="red_font">상품을 받아보시고 맘에 안 드신다면 3일 이내 게시판으로 알려주세요</span> <br>
				(72시간이면 불량을 발견하거나 교환&반품을 결정하시기에 충분한 시간입니다.) <br>
				3일 이내 언제든지 연락주시면 원활한 반품&교환처리 도와드리겠습니다. <br><br>
				변심으로 인한 단순반품은 왕복배송비 7,000원 고객님 부담이십니다. <br>
				<span class="blue_font">받으신 상품이 불량일 경우 무상으로 교환 도와드리고 있습니다.</span> <br>
				불량상품을 다른 상품이나 다른 색상으로 교환 시 또는 반품하실 경우, <br> 
				왕복배송료의 절반에 해당하는 3,500원의 배송료가 발생합니다. <br>
				선 배송 받아보시고 후 배송상품이 남아 있을 경우 후 배송상품 마저 받아보신 후 반품신청 부탁드리며, <br> 
				따로 받으셨어도 ★꼭! 한 상자에 담아서 보내주셔야 택배비 과중부담이 없으십니다. 				
			</h6>
		</div>
	</div>
	
	<!-- 버튼 영역 -->
	<div class="policy_button">
		<a class="btn btn-default btn-lg" style="background-color: #b6f5f5; font-weight: bold;">고객센터 홈</a>
	</div>
</body>
</html>