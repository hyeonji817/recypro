<!-- 참고한 웹 페이지의 주소좌표 : https://kjh95.tistory.com/284?category=941468 -->
<!-- '주문하기' 버튼 클릭 시, 배송 정보 프로세스 처리하는 페이지 -->
<!-- 장바구니 페이지 내에서 '주문하기' 버튼 클릭 시, 이동할 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="order.beans.Order"%>
<%@ page import="order.beans.orderDAO"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="product.beans.Product"%>
<%@ page import="product.beans.ProductRepository"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.util.DBConn"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.PreparedStatement"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배송 정보 테스트</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<style>
.title {
	margin-top: 150px;
	height: 160px;
}

.display-3 {
	margin-left: 70px;
	margin-top: -20px;
	font-weight: 700;
	color: black;
	text-shadow: 1px 1px 5px #bdbdbd;
}

#progress {
	width: 1080px;
	height: 250px;
	position: relative;
	bottom: 6%;
	margin: 0 auto;
	display: block;
}

#progress li {
	padding: 0;
	width: 33.3%;
	float: left;
	height: 250px;
	display: block;
}

#progress li:first-child {
	/* 		border-right: 2px solid black; */
	margin: 0 auto;
}

.basket {
	margin: 0 auto;
	overflow: hidden;
	border-radius: 123px;
	position: relative;
	top: 3.5%;
	width: 67.5%;
	height: 93%;
	border: 2px solid black;
}

.basket_icon img {
	margin: 0 auto;
	width: 100px;
	position: relative;
	left: 29%;
	padding-top: 10%;
}

.first_continue h5 {
	text-align: center;
	font-weight: bold;
	padding-top: 15%;
	font-size: 22px;
}

#progress li:nth-child(2) {
	/* 		border-right: 2px solid black; */
	margin: 0 auto;
}

.card {
	margin: 0 auto;
	overflow: hidden;
	border-radius: 123px;
	top: 3.5%;
	width: 67.5%;
	height: 93%;
	position: relative;
	background: rgb(159, 251, 244);
	border: 2px solid black;
}

.card_icon img {
	margin: 0 auto;
	width: 100px;
	position: relative;
	left: 25%;
	padding-top: 10%;
	width: 120px;
}

.second_continue h5 {
	text-align: center;
	font-weight: bold;
	padding-top: 6%;
	font-size: 22px;
}

#progress li:nth-child(3) {
	margin: 0 auto;
}

.order_complete {
	margin: 0 auto;
	overflow: hidden;
	border-radius: 123px;
	top: 3.5%;
	width: 67.5%;
	height: 93%;
	position: relative;
	background: white;
	border: 2px solid black;
}

.calendar_icon img {
	margin: 0 auto;
	width: 120px;
	position: relative;
	left: 23%;
	padding-top: 8%;
}

.last_continue h5 {
	text-align: center;
	font-weight: bold;
	padding-top: 6%;
	font-size: 22px;
}

.container {
	border: 3px solid #eee;
	margin-top: 3%;
	position: relative;
}

.container form {
	top: 5%;
	position: relative;
}

.button {
	float: right;
	margin-bottom: 2%;
	position: relative;
	color: white;
	right: -17%;
}

.form-group {
	margin-top: 3%;
}
</style>
<script type="javascript/text">
	var today = new Date(); 

	var dateFormat = today.getFullYear() + "." + (today.getMonth()+1) + "." + today.getDate() + ".";
</script>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>

	<!-- 쿠키로 데이터 저장. 클라이언트에 저장되는 방식 -->
	<!-- 주문 자체를 등록하서 나서 삭제처리 되도록 설정. 이후 orderConfirmation.jsp로 포워딩 -->
	<!-- URLEncoder 사용 -->
	<!-- 주문처리 페이지 진행과정 : 배송정보 패키지 -> 주문 정보 -> 주무 완료 -> 주문취소 -->

	<!-- 제목 부분 -->
	<div class="title">
		<div class="title-container">
			<h1 class="display-3">배송정보</h1>
		</div>
	</div>

	<!-- 진행 상황 -->
	<div class="cart_continue" id="progress">
		<ul>
			<li>
				<!-- 장바구니 -->
				<div class="basket">
					<!-- 장바구니 아이콘 -->
					<div class="basket_icon">
						<img src="../img/shop/shopping_basket1.png" />
					</div>
					<!-- 장바구니 이름 -->
					<div class="first_continue">
						<h5>장바구니</h5>
					</div>
				</div>
			</li>
			<li>
				<!-- 주문 / 결제 -->
				<div class="card">
					<!-- 카드 아이콘 -->
					<div class="card_icon">
						<img src="../img/shop/card.png" />
					</div>
					<!-- 주문/결제 -->
					<div class="second_continue">
						<h5>주문/결제</h5>
					</div>
				</div>
			</li>
			<li>
				<!-- 주문완료 -->
				<div class="order_complete">
					<!-- 캘린더 아이콘 -->
					<div class="calendar_icon">
						<img src="../img/shop/purchase_order.png" />
					</div>
					<!-- 주문완료 -->
					<div class="last_continue">
						<h5>주문완료</h5>
					</div>
				</div>
			</li>
		</ul>
	</div>

	<!-- 입력 양식 -->
	<div class="container">
		<form action="shoppingInfo_process.jsp" class="form-horizontal"
			method="post">
			<%
				String id = (String) session.getAttribute("id");
				// 멤버 DAO 객체 생성 -> 회원정보 가져오는 메소드 생성 
				UserDAO userDAO = new UserDAO();
				User user = userDAO.getUser(id);
			%>
			<!-- 회원의 id -->
			<div class="form-group row">
				<label class="col-sm-2">id명</label>
				<div class="col-sm-3">
					<input type="text" name="shopping_userId" class="form-control"
						value="<%=user.getId()%>" placeholder="id명" readonly />
					<%
						System.out.println(id);
					%>
				</div>
			</div>

			<%
				Date nowTime = new Date();
				SimpleDateFormat sf = new SimpleDateFormat("yyyy.MM.dd");
				int sum = 0;

				// 세션 속성의 이름이 cardList인 세션 정보(장바구니에 담긴 물품 목록)를 가져와서 ArrayList에 대입
				ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartList");

				/** cart.jsp 파일에서 전체 상품을 삭제하는 deleteCart.jsp에서 session.invalidate()을 호출하게 되면
					cartList는 null이 되기 때문에 아래와 같은 코드가 반드시 필요함 */
				if (cartList == null) {
					cartList = new ArrayList<Product>();
				}

				for (int i = 0; i < cartList.size(); i++) {
					Product product1 = cartList.get(i);
					// 소계 = 가격 * 수량 
					int total = product1.getUnitprice() * product1.getQuantity();
					sum = sum + total;
			%>

			<!-- 상품명 -->
			<div class="form-group row">
				<label class="col-sm-2">상품명</label>
				<div class="col-sm-3" name="shopping_productId">
					<input type="text" name="shopping_productId" class="form-control"
						value="<%=product1.getProductId()%>-<%=product1.getPname()%>"
						placeholer="상품명" readonly />
					<!-- 					요 부분에서 DB 연동되냐 안 되냐 결정되는 구간인듯 -->
					<!-- readonly : 읽기전용 -->
				</div>
			</div>
			<%
				}
			%>

			<!-- 성명을 입력받는 부분 -->
			<div class="form-group row">
				<label class="col-sm-2">성명</label>
				<div class="col-sm-3">
					<input type="text" name="shopping_name" class="form-control"
						placeholder="성명" />
				</div>
			</div>
			<!-- 배송일을 입력받는 부분 -->
			<div class="form-group row">
				<label class="col-sm-2">주문일</label>
				<div class="col-sm-3">
					<input type="text" name="shopping_date" class="form-control"
						value="<%=sf.format(nowTime)%>" placeholder="yyyy/mm/dd"
						/ readonly>
				</div>
			</div>

			<!-- 국가명을 입력받는 부분 -->
			<div class="form-group row">
				<label class="col-sm-2">국가명</label>
				<div class="col-sm-3">
					<input type="text" name="shopping_country" class="form-control"
						placeholder="국가명" />
				</div>
			</div>

			<!-- 우편번호를 입력받는 부분 -->
			<div class="form-group row">
				<label class="col-sm-2">우편번호</label>
				<div class="col-sm-3">
					<input type="text" name="shopping_zipCode" class="form-control"
						placeholder="우편번호" />
				</div>
			</div>

			<!-- 주소를 입력받는 부분 -->
			<div class="form-group row">
				<label class="col-sm-2">주소</label>
				<div class="col-sm-3">
					<input type="text" name="shopping_addressName" class="form-control"
						placeholder="주소" />
				</div>
			</div>

			<!-- 이전 페이지, 등록, 취소 버튼을 생성 -->
			<div class="form-group row">
				<div class="col-sm-offset2 col-sm-10">
					<div class="button">
						<a href="cart.jsp?cartId=<%=request.getParameter("cartId")%>"
							class="btn btn-default btn-lg" style="color: black; background-color: #9FFBF4;"
							role="button">이전</a> 
								
						<input type="submit" class="btn btn-info btn-lg" value="등록" /> 
						<a href="checkOutCancelled.jsp" class="btn btn-default btn-lg"
							style="color: black; background-color: #9FFBF4;" role="button">취소</a>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>