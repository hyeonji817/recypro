<!-- 출처좌표 : https://coding23.tistory.com/42 || https://kjh95.tistory.com/252?category=941468 -->
<!-- 출처좌표2 : https://kjh95.tistory.com/260?category=941468 -->
<!-- 출처좌표3 (페이징처리) : https://sowon-dev.github.io/2020/07/20/200721jspi/ -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	</div> 
	
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
	</div>
	<script src="../js/html5shiv.js"></script>
	<script src="../js/jquery.min.js"></script>
	<script src="../js/respond.min.js"></script>
	<script src="../js/ie10.css"></script>
	<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>