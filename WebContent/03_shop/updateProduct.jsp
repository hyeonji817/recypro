<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dFormat = new DecimalFormat("###,###");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 - WebStore</title>
<link rel="stylesheet" href="../css/bootstrap.min.css" />
<style>
	.display-3 {
		margin-top: 17%;
		font-weight: 700;
	}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>


	<div class="container">
		<h1 class="display-3">상품 수정</h1>
	</div>


	<%
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
		String id = "root";
		String password = "1234";

		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명 
		conn = DriverManager.getConnection(url, id, password); // 연결 객체생성
	%>
	<%
		String productId = request.getParameter("id"); // 어떤 제품 수정할 지 id값 넘어옴

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String SQL = "select * from product where productId = ?";

		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1, productId);

		rs = pstmt.executeQuery();

		if (rs.next()) {
	%>
	<div class="container">
		<div class="row">
			<div class="col-md-5">
				<img alt="사진" src="../img/4-2_minimum.jpg" style="width: 100%">
			</div>

			<div class="col-md-5">
				<form action="processUpdateProduct.jsp" name="newProduct"
					class="form-horizontal" method="post" enctype="multipart/form-data">
					<div class="form-group row">
						<label class="col-sm-3">상품코드</label>
						<div class="col-sm-3">
							<input type="text" id="productId" name="productId"
								class="form-control" value='<%=rs.getString("productId")%>'>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-3">상품명</label>
						<div class="col-sm-3">
							<input type="text" id="pname" name="pname" class="form-control"
								value='<%=rs.getString("pname")%>'>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-3">가격</label>
						<div class="col-sm-3">
							<input type="text" id="unitprice" name="unitprice"
								class="form-control" value='<%=rs.getString("unitprice")%>'>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-3">상세 설명</label>
						<div class="col-sm-3">
							<input type="text" id="description" name="description"
								class="form-control" value='<%=rs.getString("description")%>'>
						</div>
					</div>

					<div class="form-group row">
						<label class="col-sm-3">이미지</label>
						<div class="col-sm-5">
							<input type="file" name="filename" class="form-control">
						</div>
					</div>

					<div class="form-group row">
						<div class="col-sm-offset-2 col-sm-2">
							<input type="submit" class="btn btn-primary" value="수정완료">
						</div>
					</div>
				</form>
			</div>
		</div>
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
</body>
</html>