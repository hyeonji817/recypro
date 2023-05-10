<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="product.beans.Product"%>
<%@ page import="product.beans.ProductRepository"%>
<%@ page import="order.beans.Order"%>
<%@ page import="order.beans.orderDAO"%>

<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.sql.PreparedStatement"%>
<%
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dFormat = new DecimalFormat("###,###"); 
	String cartId = session.getId(); 
	
	String shopping_userId = "";
	String shopping_productId = "";
	String shopping_cartId = ""; 
	String shopping_name = ""; 
	String shopping_date = ""; 
	String shopping_country = ""; 
	String shopping_zipCode = ""; 
	String shopping_addressName = ""; 
%>

<!-- 사용할 빈즈클래스 선언(만 함) -->
<jsp:useBean id="user" scope="session" class="user.beans.User" />
<jsp:useBean id="order" class="order.beans.Order" scope="page" />
<jsp:useBean id="product" class="product.beans.Product" scope="page" />

<!-- 호출할 빈즈 클래스가 가진 데이터 -->
<jsp:setProperty name="order" property="*" />
<jsp:setProperty name="product" property="*" />
<jsp:setProperty name="user" property="*" />
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 마이페이지_쇼핑내역</title>
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
	left: -16%;
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

.shopping_list {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -16%; 
	width: 250px;
	background-color: #eee;
	border: 1px solid gray; 
}

.shopping_list a {
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

.shop_list {
	width: 1500px; 
	margin: 0 auto; 
}

/** 테이블 부분 */
.table {
	text-align: center;
	margin: 0 auto;
	position: relative;
	top: 11%;
	width: 1000px;
	height: 200px;
}

.table thead {
	height: 50px;
}

/** 버튼영역 */
.button {
	margin: 0 auto;
	float: right;
	right: 17%;
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
			<h1 class="display-3" style="font-weight: bold; text-shadow: 1px 1px 5px #bdbdbd;">쇼핑내역</h1>
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
	</div>
	
	<!-- DB 연동 -->
	<%
		Connection conn = null; 
		PreparedStatement ps = null; 
		ResultSet rs = null; 
		Class.forName("com.mysql.cj.jdbc.Driver");		// 드라이버명, 자바코드와 DB를 연결할 드라이버 (연결다리)
		String sql = "select * from orderlist"; 	// 아니면 '주문번호'와 '사용자명', '물품명', '배송일' 컬럼만 솎아낼까
		
		ProductRepository pr = ProductRepository.getInstance();	// 구조체의 모든 데이터들을 호출함 
		String productId = request.getParameter("id");	// 넘어온 상품 아이디값을 얻음, id값 : 제목
		
		try {
			String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
			String userid = "root"; // db에 입력할 id
			String password = "1234"; // db에 입력할 패스워드	

			conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성
			ps = conn.prepareStatement(sql); // 연결 객체의 prepareStatement객체를 통해 해당 sql의 내용 호출
			rs = ps.executeQuery(); //조회한 결과들을 ResultSet에 rs에 저장한다.
	%>
	
	<div class="shop_list">
		<!-- 쇼핑내역 리스트 테이블 -->
		<table class="table" border="1">
			<thead>
				<tr>
					<th style="text-align: center;">주문번호</th>
					<th style="text-align: center;">사용자명</th>
					<th style="text-align: center;">물품명</th>
					<th style="text-align: center;">배송일</th>
				</tr>
			</thead>
		
			<!-- 다음 행으로 이동하여 결과값 출력할 때까지 반복적으로 형성 -->
			<%
				while (rs.next()) {
			%>
		
			<!-- 일단은 UI만 구현하고, 모든 페이지의 UI 구현 끝나는대로 DB 연동 등의 기능 구현 예정 -->
			<!-- 관리자페이지나 상품리뷰 내 상품구매목록 리스트 페이지보고 구현할 예정 -->
			<tbody>
				<tr class="light">
					<td><%=rs.getString("shopping_num") %></td>
					<td><%=rs.getString("shopping_name") %></td>
					<td><%=rs.getString("shopping_productId") %></td>
					<td><%=rs.getString("shopping_date") %></td>
				</tr>
			</tbody>
			<%
				}
			} catch (SQLException e) {
				e.printStackTrace(); 
				System.out.println("값을 불러들이지 못함"); 
			}
			%>
		</table>
	</div>
	
	
	<!-- 뒤로가기 버튼 -->
	<div class="button">
		 <input type="button" class="btn btn-default btn-lg" value="뒤로가기" onclick="location.href='mypage.jsp'" style="background-color: #b6f5f5; font-weight: bold; color: black;">
	</div>
</body>
</html>