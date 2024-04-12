<!-- 참고한 페이지 주소좌표 : https://citylock77.tistory.com/101 -->
<!-- 참고한 페이지 주소좌표2 : https://goldenrabbit.co.kr/2021/11/30/jsp%EB%A1%9C-%E1%84%86%E1%85%A9%E1%84%83%E1%85%A6%E1%86%AF
1-%E1%84%87%E1%85%A1%E1%86%BC%E1%84%89%E1%85%B5%E1%86%A8%E1%84%8B%E1%85%B4-%E1%84%92%E1%85%AC%E1%84%8B%E1%85%AF%E1%86%AB%EC%A
0%9C%EA%B2%8C/ -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="product.beans.Product"%>
<%@ page import="product.beans.ProductRepository"%>
<%@ page import="order.beans.Order"%>
<%@ page import="order.beans.orderDAO"%>
<%@ page import="com.util.DBConn"%>
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
<jsp:useBean id="user" class="user.beans.User" scope="page" />
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
<title>재활용품 전문점 : 리싸이프로 - 관리자페이지(주문내역 확인)</title>
<meta name="viewport"
	content="width=device-width, 
initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

<!-- 관리자 페이지용 배경 부트스트랩 모음 -->
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.min.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
.title {
	top: 30%;
}
</style>
</head>
<body>
	<%
		String id = (String) session.getAttribute("id");

		if (id == null) {
			response.sendRedirect("../02_account/login.jsp");
		}
	%>

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
			pstmt = conn.prepareStatement(sql); // 연결 객체의 prepareStatement객체를 통해 해당 sql의 내용 호출
			rs = pstmt.executeQuery(); //조회한 결과들을 ResultSet에 rs에 저장한다.
	%>
	<div id="wrapper">
		<!-- Content 영역 (사이드바) -->
		<div id="content-wrapper" class="d-flex flex-cloumn">
			<%@ include file="../admin/sidebar.jsp"%>
			<!-- Main 컨텐츠 (상단 메뉴바) 영역 -->
			<div id="content">

				<!-- Page Content 영역 (본문) -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<!-- Page Heading -->
    			<div class="d-sm-flex align-items-center justify-content-between mb-4">
        			<h1 class="h3 mb-0 text-black-800" style="top: 12%; margin-top: 2%; margin-left: 2%; font-weight: 700; font-size: 33px;">OrderList</h1>
    			</div>

					<!-- 모티브 페이지 : https://citylock77.tistory.com/107?category=924797 -->
					<!-- Content Row end -->
					<!-- 표 영역 -->
					<h2 class="title" style="top: 12%; margin-top: 3%; margin-left: 2%; font-weight: 700;">주문내역 정보</h2>
					<table class="table bg-light text-center" border="1"
						style="top: 30%; margin:0 auto; width: 1000px; margin-bottom: 5%;">
						<thead>
							<tr class="text-muted">
								<th>사용자 이름</th>
								<th>물품명</th>
								<th>배송일</th>
								<th>배송국가</th>
								<th>주소</th>
								<th>주문번호</th>
								<th>배송현황</th>
							</tr>
						</thead>

						<!-- 다음 행으로 이동하여 결과값 출력할 때까지 반복적으로 형성 -->
						<!-- rs.next while문 사용팁 : https://iinomad.com/157 -->
						<%								
							while (rs.next()) {
						%>
							<tbody>
								<tr>						
									<th><%=rs.getString("shopping_name")%></th>
									<th><%=rs.getString("shopping_productId")%></th>
									<th><%=rs.getString("shopping_date")%></th>
									<th><%=rs.getString("shopping_country")%></th>
									<th><%=rs.getString("shopping_addressName")%></th>
									<th><%=rs.getString("shopping_num")%></th>
									<th></th>
								</tr>						
							</tbody>
					<%
							}
						} 
						catch (SQLException e) {
							e.printStackTrace();
							System.out.println("값을 불러들이지 못함");
						}
					%>
					
					</table>
				</div>
			</div>
		</div>
	</div>
	
	<div class="admin_button">
		<a href="#" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255);">
			관리자 홈
		</a>
	</div>
</body>
</html>