<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.util.DBConn"%>
<%@ page import="java.sql.ResultSet"%>
<!-- resultset은 커서 지정용 -->
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.beans.User" scope="page" />
<jsp:setProperty name="user" property="id" />
<jsp:setProperty name="user" property="password" />
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 관리자페이지(사용자확인)</title>
<meta name="viewport"
	content="width=device-width, 
initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.min.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
.user_list {
	margin-right: 20%;
}
</style>
</head>
<body>
	<%
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
		String userid = "root"; // db에 입력할 id
		String password = "1234"; // db에 입력할 패스워드		
		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명, 자바코드와 db를 연결할 드라이버(연결다리)
		conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from user";
		pstmt = conn.prepareStatement(sql); // 연결 객체의 prepareStatement객체를 통해 해당 sql의 내용 호출

		rs = pstmt.executeQuery(); //조회한 결과들을 ResultSet에 rs에 저장한다.
	%>

	<div id="wrapper">
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-cloumn">
			<%@ include file="../admin/sidebar.jsp"%>
			<!-- Main Content -->
			<div id="content">

				<!-- Begin Page Content -->
				<div class="container-fluid">
				
				<!-- Page Heading -->
    			<div class="d-sm-flex align-items-center justify-content-between mb-4">
        			<h1 class="h3 mb-0 text-black-800" style="top: 12%; margin-top: 2%; margin-left: 3%; font-weight: 700;">Member</h1>
    			</div>

					<!-- Content Row (표를 만들 영역) -->
					<div class="row">
						<!-- Earning (Monthly) Card Example -->
						<div class="col-xl-3 col-md-6 mb-4">
							<!-- 사용자 테이블 생성 -->
							<div class="container-fluid">
								<div class="row mb-5">
									<div class="col-xl-10 col-lg-9 col-md-8 ml-auto">
										<div class="row">

										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					
					<h2 class="title" style="top: 12%; margin-top: 2%; margin-left: 3%; font-weight: 700;">회원정보</h2>
					<table class="table bg-light text-center" border="1" style="margin: 0 auto; width: 1000px; margin-top: 7%;">
						<thead>
							<tr class="text-muted">
								<th>이름</th>
								<th>아이디</th>
								<th>나이</th>
								<th>성별</th>
								<th>이메일</th>
							</tr>
						</thead>
						<tbody>
						<!-- rs.next while문 사용팁 : https://iinomad.com/157 -->
							<% while (rs.next()) { %>	<!-- 다음 행으로 이동하여 결과값 출력할 때까지 반복적으로 형성 -->
							<tr>
								<th><%=rs.getString("name")%></th> 
 								<th><%=rs.getString("id")%></th> 
								<th><%=rs.getString("age")%></th>
								<th><%=rs.getString("gender")%></th>
								<th><%=rs.getString("email")%></th> 
							</tr> 
							<%
								}
							%>
						</tbody>
					</table>
					
				</div>
			</div>
		</div>
	</div>
	
	<div class="admin_button">
		<a href="#" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255);">관리자 홈</a>
	</div>
</body>
</html>