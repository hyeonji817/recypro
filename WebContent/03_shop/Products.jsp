<!-- 출처좌표 : https://coding23.tistory.com/42 || https://kjh95.tistory.com/252?category=941468 -->
<!-- 출처좌표2 : https://kjh95.tistory.com/260?category=941468 -->
<!-- 출처좌표3 (페이징처리) : https://sowon-dev.github.io/2020/07/20/200721jspi/ -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%--@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="product.beans.Product"%>
<%@ page import="product.beans.ProductRepository"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dFormat = new DecimalFormat("###,###"); // 숫자 천 단위로 구분 표시
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<!-- bootstrap -->
<link rel="stylesheet" href="../css/bootstrap.css" />
<link rel="stylesheet" href="../css/ie10.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../css/bootstrap.min.css" /> 
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" />
<title>재활용품 전문점 : 리싸이프로 - 상품목록</title>
<style>
.title {
	margin-top: 150px;
	height: 140px;
}

ul, li {
	list-style: none;
}

li:hover {
	cursor: pointer; 
}

a:link {
	color: rgb(53, 53, 53);
	text-decoration: none;
}

a:visited {
    color: rgb(53, 53, 53);
    text-decoration: none;
}

#nav-right2 {
	width: 930px;
	position: absolute;
	right: -6%;
	margin: 0 auto;
	opacity: 1;
	line-height: 80px;
	text-align: center;
	top: 10%;
	z-index: 3;
}

#sub_menu:hover {
	color: #b6f5f5;
}

#nav-right2>li {
	display: inline-block;
	vertical-align: middle;
	margin-right: 33px;
	text-align: center;
	position: relative;
	font-size: 17px;
	font-weight: bold;
}

#nav-right2>li:last-child {
    font-weight: 800;
}

#nav-right2>li ul.submenu {
/* 	display: none;  */
	position: absolute; 
	padding: 0; 
	text-align: center; 
/* 	background-color: black;  */
	font-size: 18px; 
	font-weight: bold !important;
}

/** .cont-search {
	float: right; 
	position: absolute; 
	right: 5%;
	width: 40%; 
	height: 70px;
	top: 22%;
}

.search_bar {
	position: relative; 
	left: 38%; 
	margin: 0 auto; 
	top: 17%;
	width: 300px; 
	height: 50px;
	display: inline-block;
}

.clue {
	width: 30px; 
	height: 30px; 
	right: -11%;
	top: -30px; 
	float: right; 
	position: relative; 
	margin: 0 auto; 
	display: inline-block;
	background-color: #eee;
} */

/* .search_bar .clue {  */
/*  	display: inline-block;   */
/*  	width: 73px;   */
/*  	height: 74px;   */
/*  	margin: auto;   */
/*  	background-image: url(img/recypro_clipping.png);   */
/*  	background-position: -102px -110px;   */
/*  	background-size: 165px 86px;   */
/*  	background-repeat: no-repeat;   */
/*  	text-indent: -10000px;  */
/* }  */

/** .clue img {
	width: 20px; 
	height: 20px; 
	right: 12%;
	margin-top: 17%;
	float: right;
	position: relative;
} */

/* 검색 */

#search51{
    background: url(data:image/png;base64,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) no-repeat 10px 6px #fcfcfc;
    border:1px solid #d1d1d1;
    font: bold 12px Arial, Helvetica, Sans-serif;
    color:#bebebe;
    width:300px;
    padding:6px 15px 6px 35px;
    border-radius:20px;
    text-shadow:0 2px 3px rgba(0,0,0,0.1);
    box-shadow:0 1px 3px rgba(0,0,0,0.15) inset;
    -webkit-transition: all 0.7s ease 0s;
}

#search51:focus {
	width: 200px; 
	outline: 0;
}

/** .clue #clude_search {
	background-image: url(../img/recypro_clipping.png);
	background-position: 0px 0px;
	background-repeat: no-repeat;
	background-size: 30px 30px;
	display: inline-block; 
	width: 30px; 
	height: 30px; 
	margin: auto; 
	top: -83% !important;
	text-indent: -10000px;
} */

.submenu a {
	font-weight: 700; 
	position: relative;
}

.btn btn-secondary {
	font-size: 20px;
}

.btn btn-warning {
	font-size: 20px;
}

.row {
	font-size: 20px;
}

.display-3 {
	margin-top: 50px;
	color: black;
	font-weight: 700;
	position: relative;
	margin-left: -30%;
}

.table table-hover {
	font-size: 20px;
}

.container {
	margin-top: 10px;
}

#product_lists {
	width: 400px;
	height: 500px;
	right: 17%;
	position: relative;
}

#product_list {
	width: 1500px;
	height: 1270px;
	margin: 0 auto;
}

.sub_explain {
	color: black;
	margin-right: -25%;
}

.sub_explain img {
	width: 160px;
	border-radius: 30px;
}

.sub_explain p {
	width: 280px;
	height: 70px;
	position: static;
	margin-top: -2%;
	text-align: left;
}

.sub {
	float: left;
	margin-bottom: 10%;
	margin-left: 15%;
	position: absolute;
}

.sub_explain h2 {
	margin-top: 20px;
	font-size: 22px;
	font-weight: bold;
	margin-bottom: 30px;
}

.sub_explain h5 {
	font-size: 16px;
	top: 5%;
	font-weight: 700;
	position: relative;
}

.sub_menu a {
	margin-top: 5%;
	font-weight: 700;
	position: relative;
}

h6 {
	top: 2%;
	width: 100px;
	font-size: 10px;
	float: right;
	margin-right: -5%;
	position: relative;
}

.btn btn-light {
	text-shadow: none;
	font-weight: 700;
}

.side_bar {
	float: right;
	position: relative;
	right: -35%;
	height: 1000px;
	bottom: 80%;
	width: 100px;
}

.scroll_bar {
	width: 100px;
	height: 450px;
	/*   		right: 20%;   */
	bottom: 135%;
	float: right;
	position: absolute;
	background: #eee;
}

.mini_menu li {
	right: 30%;
	border-bottom: 1px solid;
	top: 20%;
	margin-top: 30%;
	margin-bottom: 30%;
	position: relative;
}

.search {
	margin-top: 27%;
}

.cart {
	margin-right: 7%;
}
</style>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/scoll_bar.css">
<link rel="stylesheet" type="text/css" href="../css/products.css">
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>
	
	<%
		// DB에서 전체 상품 목록을 읽어서 가져오기 
		// ProductRepository 객체 생성 
		ProductRepository pr = new ProductRepository(); 
	
		// DB에 상품이 있는지 확인 후 있으면 상품 모두 가져오기, 없으면 가져오지 않기 : getBoardCount()
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
		String id = "root";
		String password = "1234";

		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명
		conn = DriverManager.getConnection(url, id, password); // 연결 객체생성

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from product";

		pstmt = conn.prepareStatement(sql); // Connection 객체에 쿼리문을 넘겨주고 PrepareStatement를 얻음
		rs = pstmt.executeQuery(); // 쿼리문 결과 받아옴 

	%>

	<div class="title">
		<div class="container">
			<h1 class="display-3"
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">상품목록</h1>
		</div>

		<!-- 검색창 -->
		<!-- <div class="cont-search">
			<div class="search_bar">
				<form method="post" action="searchProducts.jsp" name="frm_search" role="search" method="get" class="search-form" 
				style="position: absolute; left: 10%;">
					<input type="search" class="search-field" placeholder="상품명" value="" name="findStr"
					style="width: 270px;" />
					<span class="clue">
						<a href="#">
							 <img src="../img/clude.png" /> 
							<input id="search51" type="submit" name="btnFind" class="search-submit" id="clude_search" value="" style="position: relative; top: -10%; left: 100%;"/> 
						</a>
					</span>
					<input type="hidden" name="nowPage" value="" size="10">
					<input type="hidden" name="serial" size="10">
					<input type="hidden" name="search" value="select">
				</form>
			</div>
		</div> -->
	</div> 
	
	<!-- 검색창 (리뉴얼) -->
	<!-- <div class="search_bar" style="margin-left:71%; top:-12%; position: relative;">
		<form method="post" action="searchProducts.jsp" id="searchbox5">
			<input id="search51" name="keyword" type="text" size="40" placeholder="상품명 찾기" value="${keyword}" />
		</form>
	</div> -->
	
	<div class="container">
		<div class="row" id="product_list" align="center">
			<%
				while (rs.next()) {
			%>

			<div class="col-md-3" id="product_lists">
				<div class="sub_explain">
					<a href="Product.jsp?id=<%=rs.getString("productId")%>"> 
						<img alt="이미지 업로드" src="../img/shop/<%=rs.getString("filename")%>"
						style="width: 70%">
					</a>
					<h2><%=rs.getString("pname")%></h2>
					<h5>
						<p><%=rs.getString("description")%></p>
					</h5>
					<!-- <span><h6><p><%--<%=dFormat.format(Integer.parseInt(rs.getString("unitprice"))) %>--%>원</p></h6></span> -->
				</div>
				<p class="sub">
					<a href="Product.jsp?id=<%=rs.getString("productId")%>"
						style="font-weight: 700;" class="btn btn-light" id="button_info"
						role="button"> 상세 정보 &raquo;</a> 
					<span class="sub_menu">
						<h6 style="font-weight: 700;"><%=dFormat.format(Integer.parseInt(rs.getString("unitprice")))%>원</h6>
					</span>
				</p>
			</div>
			<%
				}
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			%>

		</div>
		<!-- 페이징 처리 -->
		<%
			// 페이지 이동버튼 
			// if ()
		%>

		<!-- 사이드 스크롤바 -->
		<div class="side_bar" align="right">
			<div class="scroll_bar">
				<ul class="mini_menu">
					<!-- 					상품 검색 -->
					<li class="search"><a href="../03_shop/pd_orderList.jsp"
						class="mini_search"> <img src="../img/clude.png" />
					</a></li>

					<!-- 주문·배송조회 로그오프 상태 -->
					<li class="shipment"><a
						href="../03_shop/orderConfirmation.jsp" class="mini_shipment">
							<img src="../img/shipment.png" />
					</a></li>
					<!-- 주문·배송조회 -->

					<!-- 장바구니 -->
					<li class="cart"><a href="../03_shop/cart.jsp"
						class="mini_cart"> <img src="../img/cart-icon.png" /> <span
							class="xans-element- xans-myshop xans-myshop-main count "
							style="display: none;"> <span
								class="xans_myshop_main_basket_cnt">0</span>
						</span>
					</a></li>

					<!-- 게시판 -->
					<li class="review"><a href="../03_shop/Product_Review.jsp">
							<img src="../img/review.png" />
					</a></li>
				</ul>
			</div>
		</div>
	</div>
	<script src="../js/html5shiv.js"></script>
	<script src="../js/jquery.min.js"></script>
	<script src="../js/respond.min.js"></script>
	<script src="../js/ie10.css"></script>
	<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>