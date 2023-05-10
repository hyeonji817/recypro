<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="product.beans.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<title>재활용품 전문점 : 리싸이프로 - 장바구니</title>
<style>
	.title {
		margin-top: 150px;
		height: 160px;
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
		margin-left: 70px;
		margin-top: -20px;
		font-weight: 700;
		color: #000;
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
		background: rgb(159, 251, 244);
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
	
	.table {
		font-size: 20px;
		font-weight: 700;
		color: black;
		border-color: #eee;
		border-style: solid;
	}
	
	.table table-hover {
		font-size: 20px;
		font-weight: 700;
	}
	
	.cart_del {
		color: white;
		font-weight: 700;
	}
	
	.btn-option {
		float: right;
	}
	
	.continue {
		color: black;
		font-weight: 700;
	}
	
	.order {
		color: black;
		font-weight: 700;
	}
	
	.delete {
		color: black;
		font-weight: 700;
	}
	
	.container {
		margin-top: 50px;
		font-weight: 700;
		position: relative;
		top: -8%;
	}
</style>
<%
	// 세션 id값 가져오기
	String cartId = session.getId();
	DecimalFormat dFormat = new DecimalFormat("###,###");	// 숫자를 천 단위 구분
%>
</head>
<body>
	<%@ include file="../01_main/index.jsp" %>
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
	<!-- 페이지 제목 -->
	<div class="title">
		<div class="title-container">
			<h1 class="display-3">장바구니</h1>
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
	
	<!-- 구매 상품 내역 -->
	<div class="container">
		<div style="padding-top:50px;">
			<!-- table-hover : 마우스 포인터가 있는 행의 배경을 바꾸어 눈에 띄도록 만들어진 클래스 -->
			<table class="table table-hover">
				<tr>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
		<%
			int sum = 0;
		
			// 세션 속성의 이름이 cardList인 세션 정보(장바구니에 담긴 물품 목록)를 가져와서 ArrayList에 대입
			ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartList");
			
			/** cart.jsp 파일에서 전체 상품을 삭제하는 deleteCart.jsp에서 session.invalidate()을 호출하게 되면
				cartList는 null이 되기 때문에 아래와 같은 코드가 반드시 필요함 */
			if (cartList == null) {
				cartList = new ArrayList<Product>();
			}
			
			for (int i=0; i<cartList.size(); i++) {
				Product product = cartList.get(i);
				// 소계 = 가격 * 수량 
				int total = product.getUnitprice() * product.getQuantity();
				sum = sum + total;
		%>
			<tr>
				<td><%=product.getProductId() %>-<%=product.getPname() %></td>
				<td><%=dFormat.format(product.getUnitprice()) %></td>
				<td><%=product.getQuantity() %></td>
				<td><%=dFormat.format(total) %></td>
				<td>
					<a href="removeCart.jsp?id=<%=product.getProductId() %>" class="badge badge-danger">
						<span class="cart_del">삭제</span></a>
				</td>
			</tr>
		<%
			}
		%>	<tr>
				<th></th>
				<th></th>
				<th>총액</th>
				<th><%=dFormat.format(sum)%></th>
				<th></th>
			</tr>
			</table>
			<div class="btn-option">
				<a href="Products.jsp" class="btn btn-default btn-lg" style="background-color: #9FFBF4;">
					<span class="continue"> 쇼핑 계속하기 </span>
				</a>
				<a href="shoppingInfo_cart.jsp?cartId=<%=cartId %>" class="btn btn-default btn-lg" style="background-color: #9FFBF4;">
					<span class="order">주문하기</span>
				</a>
				<a href="deleteCart.jsp?cartId=<%=cartId%>" class="btn btn-default btn-lg" style="background-color: #9FFBF4;">
					<span class="delete">삭제하기</span>
				</a>
			</div>
		</div>
	</div>
</body>
</html>