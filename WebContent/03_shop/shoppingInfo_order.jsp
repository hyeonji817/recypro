<!-- 참고한 웹 페이지의 주소좌표 : https://kjh95.tistory.com/284?category=941468 -->
<!-- 상품 상세 페이지 내 '주문하기' 버튼 클릭 시, 배송 정보 프로세스 처리하는 페이지 -->
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
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>

	<!-- 쿠키로 데이터 저장. 클라이언트에 저장되는 방식 -->
	<!-- 주문 자체를 등록하서 나서 삭제처리 되도록 설정. 이후 orderConfirmation.jsp로 포워딩 -->
	<!-- URLEncoder 사용 -->
	<!-- 주문처리 페이지 진행과정 : 배송정보 패키지 -> 주문 정보 -> 주무 완료 -> 주문취소 -->

	<div class="title">
		<div class="title-container">
			<h1 class="display-3">배송정보</h1>
		</div>
	</div>

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
				SimpleDateFormat sf = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss");
				int sum = 0;

				// 세션 속성의 이름이 cardList인 세션 정보(장바구니에 담긴 물품 목록)를 가져와서 ArrayList에 대입
				ArrayList<Product> onlyOrderList = (ArrayList<Product>) session.getAttribute("onlyOrderList");

				/** cart.jsp 파일에서 전체 상품을 삭제하는 deleteCart.jsp에서 session.invalidate()을 호출하게 되면
					cartList는 null이 되기 때문에 아래와 같은 코드가 반드시 필요함 */
					
				if (onlyOrderList == null) {
					onlyOrderList = new ArrayList<Product>();
				}

				for (int i = 0; i < 1; i++) {
					Product product1 = onlyOrderList.get(i);
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
				<label class="col-sm-2">배송일</label>
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
							class="btn btn-secondary btn-lg" style="color: white;"
							role="button">이전</a> <input type="submit"
							class="btn btn-primary btn-lg" value="등록" /> <a
							href="checkOutCancelled.jsp" class="btn btn-danger btn-lg"
							style="color: white;" role="button">취소</a>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>