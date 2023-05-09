<!-- 참고한 웹 페이지 주소좌표 : https://kjh95.tistory.com/286?category=941468 -->
<!-- get 방식으로 넘겨받아서 같은 페이지 활용됨 (수정, 삭제) -->
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String edit = request.getParameter("edit"); // 메뉴 "상품수정" 클릭 시 넘어오는 edit 값 받음.
	DecimalFormat dFormat = new DecimalFormat("###,###");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 수정 - recypro</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<style>
.display-3 {
	margin-top: 17%;
}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>

	<div class="container">
		<h1 class="display-3">상품 수정</h1>
	</div>

	<div class="container">
		<div class="row" align="center">
			<%
				Connection conn = null;

				String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
				String user = "root";
				String password = "1234";

				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(url, user, password); // 연결 객체생성
			%>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "select * from product";

				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();

				while (rs.next()) {
			%>
			<div class="col-md-4">
				<img alt="사진"
					src="${pageContext.request.contextPath}/img/shop/<%=rs.getString("filename") %>"
					style="width: 100%">
				<h3><%=rs.getString("pname")%></h3>
				<p><%=rs.getString("description")%></p>
				<p><%=dFormat.format(Integer.parseInt(rs.getString("unitprice")))%></p>
				<p>
					<%
						if (edit.equals("update")) {
					%>
					<a href="updateProduct.jsp?id=<%=rs.getString("productId")%>"
						class="btn btn-success btn-lg" role="button">수정 &raquo;</a>
					<%
						} else if (edit.equals("delete")) {
					%>
					<a href="#"
						onclick="deleteConfirm('<%=rs.getString("productId")%>')"
						class="btn btn-danger btn-lg" role="button">삭제 &raquo;</a>
					<%
						}
					%>
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
		<hr>
	</div>

	<script type="text/javascript">
		function deleteConfirm(id) {
			if (confirm("해당 상품을 삭제합니다!") == true) {
				location.href = "deleteProduct.jsp?id=" + id;
			} else
				return;
		}
	</script>
</body>
</html>