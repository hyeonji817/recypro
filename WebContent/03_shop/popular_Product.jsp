<%@page import="popular_product.beans.popular_pdDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="popular_product.beans.popular_product" %>
<%@ page import="popular_product.beans.popular_pdDAO" %>
<%@ page errorPage="exceptionNoProductId.jsp"%>
<!-- id값이 유효하지 않으면 에러페이지로 이동 -->
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dFormat = new DecimalFormat("###,###");
	String cartId = session.getId();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 인기상품 페이지</title>
<link rel="stylesheet" type="text/css" href="../css/product.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
<style>
.title {
	margin-top: 140px;
	height: 140px;
}

.btn {
	color: white;
}

.btn btn-secondary {
	font-size: 20px;
}

.btn-warning {
	font-size: 20px;
	color: white;
}

.row {
	font-size: 20px;
	border: 5px solid #eee;
	right: 5%;
	background: white;
	width: 1400px;
	height: 650px;
	position: relative;
	/* 		margin-top: 3%; */
}

.display-3 {
	top: 15%;
	left: 20%;
	color: black;
	font-weight: 700;
	width: 300px;
	text-shadow: 1px 1px 5px #bdbdbd;
}

.table table-hover {
	font-size: 20px;
}

.col-md-5 img {
	border-radius: 30px;
	top: 7%;
	position: relative;
	left: 5%;
	overflow: hidden;
}

.sub_explain {
	color: black;
	/* 		text-shadow: 1px 1px 5px #000; */
	font-weight: bold;
	margin-left: 10%;
	top: 8%;
	position: relative;
}

.pname {
	margin-top: 10px;
	font-weight: 700;
	position: relative;
}

.desc {
	margin-top: 10px;
	font-weight: 700;
	position: relative;
}

.button {
	font-weight: 700;
}

.product_bt {
	margin-top: 10%;
	width: 1000px;
	float: right;
	position: absolute;
	left: 11%;
	bottom: 17%;
}

#order {
	position: absolute;
	bottom: 7%;
}

.cart_into {
	color: black;
	font-weight: 700;
}

.order {
	color: black;
	font-weight: 700;
}

.review {
	color: black;
	font-weight: 700;
}

.pd_orderlist {
	color: black;
	font-weight: 700;
}

.pd_list {
	color: black;
	font-weight: 700;
}

.review_view {
	color: black;
	font-weight: 700;
}

.coupon_set {
	color: black;
	font-weight: 700;
}

.sub_container {
	left: 23%;
	width: 350px;
}

.container {
	top: 15%;
}

.membership {
	width: 1700px;
	height: 460px;
	margin: 0 auto;
	background-color: #eee;
	margin-top: 10%;
	position: relative;
	left: 5%;
	bottom: 5%;
}

.mb_title {
	text-align: center;
	margin: 0 auto;
	padding-top: 2%;
}

.mb_title h2 {
	font-weight: 900;
	font-size: 40px;
	position: relative;
	top: 1%;
}

#event {
	position: relative;
	width: auto;
	background: #eee;
	height: 300px;
	top: 5%;
}

#event li {
	padding: 0;
	width: 24%;
	float: left;
	height: 300px;
	display: block;
}

#event li:first-child {
	border-right: 2px solid gray;
	height: 300px;
	position: relative;
	top: 2%;
}

#event li:nth-child(2) {
	border-right: 2px solid gray;
	height: 300px;
}

#event li:nth-child(3) {
	border-right: 2px solid gray;
	height: 300px;
}

#event li:nth-child(4) {
	margin: 0 auto;
	padding-left: 2%;
}

.coupon_give {
	display: block;		/** display 속성이 약함. 좀 더 공부해야 겠다 */
	background: #FFF612;
	margin: 0 auto;
	width: 90%;
	height: 260px;
	margin-top: 4%;
	margin-bottom: 4%;
	margin-left: 0;
}

.new_member_give {
	background: white;
	border: 2px solid black;
	border-radius: 30px;
	margin: 0 auto;
	width: 80%;
	height: 100px;
	position: relative;
	top: 5%;
}

.new_member_give_title h6 {
	text-align: center;
	padding-top: 3%;
	font-weight: bold;
	font-size: 15px;
}

.pay h5 {
	text-align: center;
	padding-top: 2%;
	font-weight: bold;
	font-size: 28px;
}

.direct_give h4 {
	text-align: center;
	font-weight: bold;
	padding-top: 10%;
}

.coupon_event h6 {
	text-align: center;
	padding-top: 8%;
	font-weight: bold;
	font-size: 17px;
}

.star img {
	display: block; 
	margin: 0 auto;
/* 	left: 42.5%; */
/* 	right: 5%; */
	position: relative;
	padding-top: 2%;
}

.level h4 {
	text-align: center; 
	padding-top: 6%;
	font-weight: bold; 
	font-size: 27px;
}

.level_event h6 {
	text-align: center; 
	padding-top: 8%;
	font-weight: bold; 
	font-size: 17px;
}

.truck img {
	display: block; 
	margin: 0 auto;
	position: relative;
	padding-top: 5%;
	width: 100px;
}

.shipment_title h4 {
	text-align: center; 
	padding-top: 3%;
	font-weight: bold;
	font-size: 27px;
}

.shipment_event h6 {
	text-align: center; 
	padding-top: 10%;
	font-weight: bold;
}

.alarm_event img {
	display: block; 
	margin: 0 auto; 
	position: relative; 
	padding-top: 4%; 
}

.new_update h4 {
	text-align: center; 
	padding-top: 4%; 
	font-weight: bold;
}

.new_discount h6 {
	text-align: center; 
	padding-top: 17%; 
	font-weight: bold;
}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>
	<!-- 	<img src="../img/moon.jpg" class="main-img" alt="tip main"> -->

	<%
		String id = request.getParameter("id");
		PrintWriter script = response.getWriter();

		if (session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
	%>
	<%@ include file="../01_main/index.jsp"%>
	<%
		} else {
			script.println("location.href = '../02_account/login.jsp'");
	%>
	<%@ include file="../01_main/index_top.jsp"%>
	<%
		}
	%>
	
	<div class="title">
		<div class="container">
			<h1 class="display-3">상품 정보</h1>
		</div>
	</div>
	<%
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
		String userid = "root"; // db에 입력할 id
		String password = "1234"; // db에 입력할 패스워드

		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명, 자바코드와 db를 연결할 드라이버(연결다리)
		conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성
		
		popular_pdDAO pdDao = popular_pdDAO.getInstance();		// 구조체의 모든 데이터들을 호출함 (데이터)
		popular_product pp = pdDao.getProductById(id);	// 원하는 데이터가 있는지 확인하고, 해당 조건의 데이터를 호출 (검색)
		String productId = request.getParameter("id");	// 넘어온 상품 아이디값을 얻음
		
		// PreparedStatement : 각각의 인수에 대해 위치홀더 (placeholder)를 사용하여 SQL 문장을 정의
		// 각각의 SQL 타입을 처리할 수 있는 setXxxx() 메소드를 제공		ex) setString()
		PreparedStatement pst = null;
		ResultSet rs = null; // select의 결과를 저장하는 객체, 명령에 대한 반환값 
		String sql = "select * from popular_product where productId = ?";
		pst = conn.prepareStatement(sql); // 연결 객체의 prepareStatement객체를 통해 해당 sql의 내용 호출
		pst.setString(1, productId);
		rs = pst.executeQuery();
		
		if (rs.next()) {
	%>
	
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<!-- 특정 상품 이미지 -->
				<span class="pd_img"> 
					<img alt="사진업로드" src="${pageContext.request.contextPath}/img/popular/<%=rs.getString("img_name")%>" style="width: 100%">
				</span>
			</div>
			<div class="col-md-6">
				<div class="sub_explain">
					<!-- 상품 정보 데이터 -->
					<span class="pname"><b><h3><%=rs.getString("pname")%></h3></b></span>
					<span class="desc"><h5>
							<p><%=rs.getString("description")%></p>
						</h5></span>
					<p>
						<b>상품 코드 : </b><span class="badge badge-danger"><%=rs.getString("productId")%></span>
					</p>
					<p>
						<b>제조사 : </b><%=rs.getString("manufacturer")%></p>
					<p>
						<b>분류 : </b><%=rs.getString("category")%></p>
					<p>
						<b>재고 수 : </b><%=dFormat.format(rs.getLong("numberOfstock"))%>
					</p>
					<h4>
						<b>가격 : <%=dFormat.format(rs.getInt("unitprice"))%>원 </b>
					</h4>
				</div>
				<p class="button">
					<!-- 버튼영역 -->
					<form name="addForm" action="./addCart.jsp?id=<%=rs.getString("productId")%>" method="post">
						<!-- 상품 주문을 클릭하면 자바스크립트 핸들러 함수 addToCart() 호출 -->
						<div class="product_bt">
							<a class="btn btn-default btn-lg" onclick="addToCart()"
								style="background-color: #b6f5f5; margin-right: 1%;"> <span
								class="cart_into">장바구니 담기 </span>
							</a> 
							<a href="Products.jsp" class="btn btn-default btn-lg"
								style="background-color: #b6f5f5; margin-right: 1%;"> 
								<span class="pd_list">상품 목록 </span>
							</a>
							<!-- 요 구간에서는 상품페이지 내 상품명을 불러들어야 하니까 앞서 상품데이터가 들어간 객체 파일을 선언하여 인스턴스변수(미니화)를 선언한 후, 그 미니변수 안의 get변수 메소드를 호출한다. -->
							<a href="Product_Review.jsp" class="btn btn-default btn-lg"
								style="background-color: #b6f5f5;"> 
								<span class="review_view">리뷰확인</span>
							</a>
						</div>
					</form>
					<form name="addForm2" action="./addOrder.jsp?id=<%=rs.getString("productId")%>" method="post">
						<div class="product_bt" id="order">
							<a class="btn btn-default btn-lg" onclick="addToOrder()"
								style="background-color: #b6f5f5; margin-right: 1%;"> 
								<span class="cart_into">주문하기 </span> <!-- '주문만하기'에서 '주문하기'로 명칭만 바꿈 -->
							</a> 
							<a href="#" class="btn btn-default btn-lg" style="background-color: #b6f5f5; margin-right: 1%;"> 
								<span class="coupon_set">쿠폰적용 </span>
							</a> 
							<a href="pd_orderList.jsp" class="btn btn-default btn-lg"
								style="background-color: #b6f5f5;"> 
								<span class="pd_orderlist">주문내역 조회 </span>
							</a>
						</div>
					</form>
				</div>
			<%
				} 
				if (rs != null)
					rs.close(); 
				if (pst != null) 
					pst.close();
				if (conn != null)
					conn.close();
			%>
		</div>
	</div>
	<!-- container 끝 -->
	
	<!-- 하단 멤버쉽 이벤트 배너 -->
	<div class="membership">
		<!-- 이벤트명 제목 -->
		<div class="mb_title">
			<h2>Membership</h2>
		</div>
		<!-- 이벤트 종류 -->
		<div class="membership_events" id="event">
			<ul>
				<li>
					<!-- 쿠폰 지급 이벤트 -->
					<div class="coupon_give">
						<!-- 신규회원 즉시발급 영역 -->
						<div class="new_member_give">
							<div class="new_member_give_title">
								<h6>신규회원 즉시발급</h6>
							</div>
							<div class="pay">
								<h5>10,000</h5>
							</div>
						</div>
						<!-- 쿠폰 즉시발급 영역 -->
						<div class="direct_give">
							<a href="#">
								<h4>쿠폰 즉시발급</h4>
							</a>
						</div>
						<!-- 신규회원 부분 -->
						<div class="coupon_event">
							<h6>
								신규회원 <br> 10,000 + 30% 할인쿠폰
							</h6>
						</div>
					</div>
				</li>
				<li>
					<!-- 등급별 혜택 --> <!-- 이미지 제목 -->
					<div class="star">
						<a href="#"> 
							<img src="../img/shop/star.png" />
						</a>
					</div> 
				<!-- 등급별 혜택 --> 
				<a href="#"> 
					<span class="level">
						<h4>등급별 혜택</h4>
					</span>
					<span class="level_event">
						<h6>
							할인/적립 <br>
							무료배송 및 배송비 할인 <br> 
							생일쿠폰 지급 
						</h6>
					</span>
				</a>
				</li>
				<!-- 무료배송 -->
				<li>
					<div class="free_shipment">
						<a href="#">
							<!-- 트럭 아이콘 -->
							<span class="truck">
								<img src="../img/shipment.png" />
							</span>
							<!-- 무료배송 -->
							<span class="shipment_title">
								<h4>무료배송</h4>
							</span>
							<span class="shipment_event">
								<h6>
									6만원 이상 <br>
									구매 시, <br>
									무료배송
								</h6>
							</span>
						</a>	
					</div>
				</li>
				<!-- 신상 업데이트 -->
				<li>
					<div class="new_event">
						<a href="#">
							<!-- 알람 아이콘 -->
							<span class="alarm_event">
								<img src="../img/shop/alarm.png" />
							</span>
							<!-- 신상 UP TO -->
							<span class="new_update">
								<h4>신상 UP TO</h4>
							</span>
							<!-- 신상 할인 내용 -->
							<span class="new_discount">
								<h6>
									매일 업데이트 <br> 
									30% 할인 지급 
								</h6>
							</span>
						</a>
					</div>
				</li>
			</ul>
		</div>
	</div>
	<script type="text/javascript">
		/** 장바구니에 추가하기 위한 핸들러 함수 */
		function addToCart() {
			if (confirm("해당 상품을 장바구니에 추가하겠습니까?")) {
				document.addForm.submit();
			} else {
				document.addForm.submit();
			}
		}
		function addToOrder() {
			document.addForm2.submit();
		}
	</script>
</body>
</html>