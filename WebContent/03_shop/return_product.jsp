<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="orderlist1.beans.orderlist1" %>
<%@ page import="orderlist1.beans.orderlist1DAO" %>
<%@ page import="product.beans.Product"%>
<%@ page import="product.beans.ProductRepository"%>

<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>

<!-- 사용할 빈즈클래스 선언 -->
<jsp:useBean id="user" class="user.beans.User" scope="page" />
<jsp:useBean id="order" class="order.beans.Order" scope="page" />
<jsp:useBean id="orderlist2" class="orderlist2.beans.orderlist2" scope="page" />
<jsp:useBean id="product" class="product.beans.Product" scope="page" />

<!-- 호출할 빈즈 클래스가 가진 데이터 -->
<jsp:setProperty name="order" property="*" />
<jsp:setProperty name="orderlist1" property="*" />
<jsp:setProperty name="orderlist2" property="*" />
<jsp:setProperty name="product" property="*" />
<jsp:setProperty name="user" property="*" />
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 마이페이지_반품신청</title>
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

.return_pd {
	width: 1500px; 
	margin: 0 auto; 
}

.return_product {
	margin: 0 auto; 
	width: 750px; 
	position: relative; 
	top: 10%;
	margin-bottom: 10%;
	min-height: 600px;
	background-color: #eee;
}

.return_reason {
	margin: 0 auto; 
	width: 600px; 
	position: relative; 
	left: 1%;
	padding-top: 3%; 
	display: block; 
}

.return_reason select {
	display: inline-block;
	width: 300px; 
	height: 40px;
	position: relative; 
	left: -3%;
}

.detail_reason {
	margin: 0 auto;
	display: block; 
	position: relative;
	left: -1.5%;
}

.detail_reason textarea {
	margin: 0 auto; 
	position: relative; 
	right: 15%; 
	left: 10%;
	top: 40px; 
	width: 600px; 
	height: 140px; 
}

.order_number input {
	margin: 0 auto; 
	position: relative; 
	right: 15%; 
	display: block; 
	width: 400px; 
	height: 40px;
	top: 70px; 
	border: 1px solid black; 
}

.bank_name input {
	margin: 0 auto; 
	position: relative; 
	right: 15%; 
	display: block; 
	width: 400px; 
	height: 40px;
	top: 100px; 
	border: 1px solid black; 
}

.count_num input {
	margin: 0 auto; 
	position: relative; 
	right: 15%; 
	display: block; 
	width: 400px; 
	height: 40px;
	top: 130px; 
	border: 1px solid black; 
}

.account_holder input {
	margin: 0 auto; 
	position: relative; 
	right: 15%; 
	display: block; 
	width: 400px; 
	height: 40px;
	top: 160px; 
	border: 1px solid black; 
}

.return_button a {
	display: block; 
	position: relative; 
	float: right; 
	margin-bottom: 20%; 
	margin: 0 auto;
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
		PreparedStatement pstmt = null; 
		ResultSet rs = null; 
		Class.forName("com.mysql.cj.jdbc.Driver");		// 드라이버명, 자바코드와 DB를 연결할 드라이버(연결다리)
		String sql = "select * from orderlist1";
		
		ProductRepository dao = ProductRepository.getInstance(); // 구조체의 모든 데이터들을 호출함 (데이터)
		String productId = request.getParameter("id"); // 넘어온 상품 아이디값을 얻음
		
		try {
			String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
			String userid = "root"; // db에 입력할 id
			String password = "1234"; // db에 입력할 패스워드	

			conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성
			pstmt = conn.prepareStatement(sql); // 연결 객체의 prepareStatement객체를 통해 해당 sql의 내용 호출
			rs = pstmt.executeQuery(); //조회한 결과들을 ResultSet에 rs에 저장한다.
		} catch (Exception e) {
			e.printStackTrace(); 
			System.out.println("값을 불러들이지 못함"); 
		}
	%>
	
	<div class="return_pd">
		<!-- <form method="post" action="returnAction.jsp"> -->
			<!-- 반품처리 페이지 -->
			<!-- div 태그 이전에 form 태그로 감싸고 보낼 페이지를 return_product2.jsp로 지정하면 될 듯 -->
			<div class="return_product">
				<!-- 반품 사유 -->
				<div class="return_reason">
					<select name="return_reason" id="return_reason">
						<option value="choose">반품사유를 선택해 주세요.</option>
						<option value="break">파손 및 변질</option>
						<option value="delay">배송 지연</option>
						<option value="different_product">전혀 다른 상품이 들어옴</option>
					</select>
				</div>
		
				<!-- 상세 사유 입력란 -->
				<div class="detail_reason">
					<textarea name="detail_reason" id="detail_reason" type="text" placeholder="상세 사유를 입력해 주세요. (선택사항)"></textarea>
				</div>
		
				<!-- 주문번호 -->
				<div class="order_number">
					<input name="order_number" id="order_number" type="text" placeholder="주문번호" />
				</div>
		
				<!-- 은행명 -->
				<div class="bank_name">
					<input name="bank_name" id="bank_name" type="text" placeholder="은행명" />
				</div>
		
				<!-- 계좌번호 -->
				<div class="count_num">
					<input name="count_num" id="count_num" type="text" placeholder="계좌번호" />
				</div>
			
				<!-- 예금주 -->
				<div class="account_holder">
					<input name="account_holder" id="account_holder" type="text" placeholder="예금주" />
				</div>
			</div>
		<!-- </form> --> 
	</div>
	
	
	<!-- 버튼 -->
	<div class="return_button">
		<a href="pd_orderList.jsp" class="btn btn-default btn-lg" style="background-color: #b6f5f5; position: relative; right: 33%; font-weight: bold;">
			<span class="before">이전</span>
		</a>
		<a href="return_product2.jsp" class="btn btn-default btn-lg" style="background-color: #b6f5f5; position: relative; right: 25%; font-weight: bold;">
			<span class="next">다음</span>
		</a>
	</div>
</body>
</html>