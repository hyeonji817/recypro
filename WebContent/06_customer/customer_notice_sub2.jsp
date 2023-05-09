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
<title>재활용품 전문점 : 리싸이프로 - 고객센터_공지사항 (세부내용)</title>
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
	font-size: 22px; 
}

.consult_subInfo h6 {
	text-align: center;
}

/** 안내사항 */
.notice_report {
	margin-top: 10%;
	text-align: center;
}

.notice_report h6 {
	text-align: center;
}

.notice_report_subInfo {
	margin-top: 2%;
}

.notice_report_subInfo h6 {
	text-align: center;
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
			<h1 class="display-3" style="font-weight: bold; text-shadow: 1px 1px 5px #bdbdbd;">고객센터_자주묻는질문 - 답변</h1>
		</div>
	</div>
	
	<div class="notice_subinfo">
		<!-- 무료교환 안내 -->
		<div class="consult_info">
			<h6>------------------
				<br>
					<b>1회 무료교환</b>
				<br>
				------------------
			</h6>
		</div>
		
		<!-- 무료교환 안내 세부내용 -->
		<div class="consult_subInfo">
			<h6>
				리싸이프로에서는 옵션 고민으로 쇼핑이 많이 어렸웠을 고객님들을 위해 <br>
				동일 상품으로 사이즈 교환을 한 주문 건에 한해서 <br>
				1회 무료교환 서비스를 진행해 드리고 있습니다. <br> 
				☆ 자사구매 주문건만 가능, 외부 타 사이트 구매 건 불가 <br><br><br><br><br>
				
				1회 무료교환 후 재차 환불의 경우 <br>
			 	<b>첫 상품 배송비 + 무료교환 상품 배송비가 합산</b>되어 <br>
			 	고객님 부담이 되시는 점 참고 부탁드립니다. <br><br><br> 
			 	
			 	불량상품을 다른 상품이나 다른 색상으로 교환 시, <br>
			 	왕복 배송료의 절반에 해당하는 <b>3,500원</b>의 배송료가 발생합니다. <br>
			</h6>
		</div>
		
		<!-- 안내 사항 -->
		<div class="notice_report">
			<h6>
				-----------------
				<br>
					<b>안내사항</b> 
				<br>
				-----------------
			</h6>
		</div>
		
		<!-- 안내사항 세부내용 -->
		<div class="notice_report_subInfo">
			<h6>
				<b>
					1. 무료배송 제품의 경우, 고객 사정에 의한 반송 <br> 
					(부재 / 주소불분명 / 전화연결불가) 시 <br>
				</b>
				택배사의 재접수로 인하여 <b>왕복 택배료 7,000원</b>이 발생합니다. <br>
				(반품 및 재배송 요청 시 모두 적용됩니다.) <br><br>
				
				<b>
					2. 무료 배송상품 반품으로 인하여 <br> 
					구매금액 (실결제금액)이 6만원 이하가 될 경우 <br>
				</b>
				초기 배송료 3,500원 + 반품배송비 3,500원 해서 <br>
				<b>총 7,000원</b>을 부담해 주셔야 합니다. <br><br>
				
				<b>
					3. 무료교환 상품과 + 변심반품 상품을 같이 보내실 경우 <br>
				</b>
				<b>3,500원</b> 고객님 부담이 발생합니다. <br><br>
				
				
				<b>
					4. 불량반품과 + 변심반품 상품을 같이 보내실 경우 <br>
				</b>
				<b>3,500원</b> 고객님 부담이 발생합니다. <br><br>
	
				<b>
					5. 반품 시 함께 배송되어진 구성품 (옷걸이, 사은품 등)은 <br>
				</b>
				꼭 <b>동봉</b>해서 보내주세요 
				<b>추가비용 (2,000원)</b>이 발생할 수 있습니다. <br><br>
			</h6>
		</div>
	</div>
</body>
</html>