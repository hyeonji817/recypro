<!-- 참고한 웹 페이지 주소좌표 : https://kjh95.tistory.com/284?category=941468 -->
<!-- 최종적인 주문 확인 페이지 -->
<!-- 세션을 활용해 주문정보를 가져온다. -->
<!-- 세션명을 cartList로 저장됨 -->
<!-- 항목은 쿠키에서 가져옴 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="order.beans.Order"%>
<%@ page import="order.beans.orderDAO"%>
<%@ page import="product.beans.Product"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.net.URLDecoder"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.util.DBConn"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.text.DecimalFormat"%>
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
<jsp:useBean id="user" class="user.beans.User" scope="page" />
<jsp:useBean id="order" class="order.beans.Order" scope="page" />
<jsp:setProperty name="user" property="*" />
<%-- <jsp:setProperty name="user" property="password" /> --%>
<jsp:setProperty name="order" property="*" />
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 정보</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<style>
.title {
	margin-top: 150px;
	height: 160px;
}

.display-3 {
	margin-left: 70px;
	margin-top: 15;
	margin-bottom: 30px;
	font-weight: 700;
	color: black;
	text-shadow: 1px 1px 5px #bdbdbd;
}

#progress {
	width: 1080px;
	height: 250px;
	position: relative;
	bottom: 2%;
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
	border: 2px solid black;
	background: rgb(159, 251, 244);
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

.container col-8 alert alert-info {
	width: 450px;
}

.button {
	position: relative;
	float: right;
	botton: -10%;
	margin-top: 5%;
}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>

	<%
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명, 자바코드와 db를 연결할 드라이버(연결다리)
		String sql = "select * from orderlist";

		try {
			String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
			String userid = "root"; // db에 입력할 id
			String password = "1234"; // db에 입력할 패스워드		

			conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성			
			pstmt = conn.prepareStatement(sql); // 연결 객체의 prepareStatement 객체를 통해 해당 sql의 내용 호출 
			rs = pstmt.executeQuery(); // 조회한 결과들을 ResultSet 내의 rs에 저장

			if (rs.next()) {
	%>

	<!-- 페이지명 -->
	<div class="container">
		<h1 class="display-3">주문 정보</h1>
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

	<!-- 주문한 영수증 내역 -->
	<div class="container col-8 alert alert-info">
		<div class="text-center">
			<h1>영수증</h1>
		</div>

		<div class="row justify-content-between">
			<div class="col-4" align="left">
				<strong>배송 내역</strong><br />
				<%
					rs.last();
				%>
				성명 :
				<%=rs.getString("shopping_name")%><br /> 우편번호 :
				<%=rs.getString("shopping_zipCode")%><br /> 주소 :
				<%=rs.getString("shopping_addressName")%><br />
			</div>

			<div class="col-4" align="right">
				<p>
					<em>배송일 : <%=rs.getString("shopping_date")%></em>
				</p>
				<%
					}
					} catch (SQLException se) {
						se.printStackTrace();
						System.out.println("값을 불러들이지 못함");
					}
				%>
			</div>
		</div>

		<div class="table">
			<table class="table table-hover">
				<tr>
					<th class="text-center">물품</th>
					<th class="text-center">수량</th>
					<th class="text-center">가격</th>
					<th class="text-center">소계</th>
				</tr>

				<%
					ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartList");
					ArrayList<Product> onlyOrderList = (ArrayList<Product>) session.getAttribute("onlyOrderList");
					int sum = 0;
					if (cartList != null) {
						if (cartList == null) {
							cartList = new ArrayList<>();
						}

						for (int i = 0; i < cartList.size(); i++) {
							Product product = cartList.get(i);
							int total = product.getUnitprice() * product.getQuantity(); // 한 물품의 가격
							sum += total; // 총합
				%>

				<tr>
					<td class="text-center"><em><%=product.getPname()%></em></td>
					<td class="text-center"><em><%=product.getQuantity()%></em></td>
					<td class="text-center"><em><%=dFormat.format(product.getUnitprice())%></em></td>
					<td class="text-center"><em><%=dFormat.format(total)%> 원</em></td>
				</tr>
				<%
					}
					} else if (onlyOrderList != null) {
						if (onlyOrderList == null) {
							onlyOrderList = new ArrayList<>();
						}
						for (int i = 0; i < 1; i++) {
							Product product = onlyOrderList.get(i);
							int total = product.getUnitprice() * product.getQuantity(); // 한 물품의 가격
							sum += total; // 총합
				%>
				<tr>
					<td class="text-center"><em><%=product.getPname()%></em></td>
					<td class="text-center"><em><%=product.getQuantity()%></em></td>
					<td class="text-center"><em><%=dFormat.format(product.getUnitprice())%></em></td>
					<td class="text-center"><em><%=dFormat.format(total)%> 원</em></td>
				</tr>
				<%
					}
					}
				%>
				<tr>
					<td class="text-center"><em></em></td>
					<td class="text-center"><em></em></td>
					<td class="text-right"><strong>총액 : </strong></td>
					<td class="text-center text-danger"><strong><%=dFormat.format(sum)%>
							원</strong></td>
				</tr>
			</table>
			<div class="button">
				<a href="javascript:history.back();" class="btn btn-default" 
					style="color: black; font-weight: 700; background-color: #9FFBF4;" role="button">이전</a> <a
					href="thanksCustomer.jsp" class="btn btn-default"
					style="color: black; font-weight: 700; background-color: #9FFBF4;" role="button">주문완료</a> <a
					href="checkOutCancelled.jsp" class="btn btn-default"
					style="color: black; font-weight: 700; background-color: #9FFBF4;" role="button">취소</a>
			</div>
		</div>
	</div>
</body>
</html>