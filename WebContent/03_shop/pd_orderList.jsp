<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="product.beans.Product"%>
<%@ page import="product.beans.ProductRepository"%>
<%@ page import="order.beans.Order"%>
<%@ page import="order.beans.orderDAO"%>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.DecimalFormat"%>
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
<title>재활용품 전문점 : 리싸이프로 - 주문내역 페이지</title>
<meta name="viewport"
	content="width=device-width, 
initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
.title {
	top: 30%;
	bottom: 10%;
}

#Order_list {
	top: 15%;
/* 	margin-top: 15%; */
	margin: 8% auto;
}

.review {
	color: white;
	font-weight: 700;
}

.return {
	color: white;
	font-weight: 700;
}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>
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
		Class.forName("com.mysql.cj.jdbc.Driver");		// 드라이버명, 자바코드와 db를 연결할 드라이버(연결다리)
		String sql = "select * from orderlist";
		
		ProductRepository dao = ProductRepository.getInstance(); // 구조체의 모든 데이터들을 호출함 (데이터)
		String productId = request.getParameter("id"); // 넘어온 상품 아이디값을 얻음, id값 : 제목(조원우의 벨트)
		
		try {
			String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
			String userid = "root"; // db에 입력할 id
			String password = "1234"; // db에 입력할 패스워드	

			conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성
			pstmt = conn.prepareStatement(sql); // 연결 객체의 prepareStatement객체를 통해 해당 sql의 내용 호출
			rs = pstmt.executeQuery(); //조회한 결과들을 ResultSet에 rs에 저장한다.
	%>
	<div id="Order_list">
		<!-- 표 영역 -->
		<h2 class="title" style="font-weight: bold; position: relative; font-size: 56px; left: 4%;">주문내역 정보</h2>
		<table class="table bg-light text-center" border="1" style="top: 60px; width: 1200px; position: relative; margin: 0 auto;">
			<thead>
				<tr class="text-muted">
					<th>아이디명</th>
					<th>사용자 이름</th>
					<th>물품명</th>
					<th>배송일</th>
					<th>배송국가</th>
					<th>주소</th>
					<th>주문번호</th>
					<th>리뷰작성</th>
					<th>반품신청</th>
				</tr>
			</thead>
			
			<!-- 다음 행으로 이동하여 결과값 출력할 때까지 반복적으로 형성 -->
			<%
				ArrayList<Product> cartList3 = (ArrayList<Product>) session.getAttribute("cartList");
			
				System.out.println("cartList3 확인");
				System.out.println(cartList3);
				
				while (rs.next()) {
			%>
			<tbody>
				<tr>
					<th><%=rs.getString("shopping_userId") %></th>
					<th><%=rs.getString("shopping_name") %></th>
					<th>
						<a href="Product_write.jsp?id=<%=rs.getString("shopping_productId")%>">
							<%=rs.getString("shopping_productId") %>
						<%-- if(cartList3 != null) { --%>
							<%-- for (int i=0; i<cartList3.size(); i++) { --%>						
								<%--=rs.getString("shopping_productId") --%>
							<%-- } --%>
						<%-- }--%>
						</a>
					</th>
					<th><%=rs.getString("shopping_date") %></th>
					<th><%=rs.getString("shopping_country") %></th>
					<th><%=rs.getString("shopping_addressName") %></th>
					<th><%=rs.getString("shopping_num") %></th>
					<th>
						<a href="Product_write.jsp?id=<%=rs.getString("shopping_productId")%>"
						class="btn btn-info">
							<span class="review">리뷰작성</span>
						</a>
					</th>
					<th>
						<a href="../03_shop/return_product.jsp" class="btn btn-info">
							<span class="return">물품 반품신청</span>
						</a>
					</th>
				</tr>
			</tbody>
			<%
					//  }	// for문
				}	// while문
			}	// try 구문
			catch (SQLException e) {
				e.printStackTrace();
				System.out.println("값을 불러들이지 못함");
			}
			%>
		</table>	
	</div>
</body>
</html>