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
<title>재활용품 전문점 : 리싸이프로 - 관리자페이지(쿠폰관리)</title>
<meta name="viewport"
	content="width=device-width, 
initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.min.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
/** 테이블 부분 */
.table {
	text-align: center;
	margin: 0 auto;
	position: relative;
	margin-top: 11%;
	width: 1000px;
	height: 200px;
}

.table thead {
	height: 50px;
}

.table td {
	font-size: 17px;
}

/** 버튼영역 */
.admin_button {
	margin: 0 auto;
	float: right;
	right: 17%;
	top: 17%;
	position: relative;
}
</style>
</head>
<body>
	<div id="wrapper">
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-cloumn">
			<%@ include file="../admin/sidebar.jsp" %>
			
			<!-- Main Content -->
			<div id="content">
				<!-- Begin Page Content -->
				<div class="container-fluid">
					<!-- Page Heading -->
					<div class="d-sm-flex align-items-center justify-content-between mb-4">
        				<h1 class="h3 mb-0 text-black-800" style="top: 12%; margin-top: 2%; margin-left: 3%; font-weight: 700;">Coupon</h1>
    				</div> 
    				
    				<h2 class="title" style="top: 12%; margin-top: 2%; margin-left: 3%; font-weight: 700;">쿠폰관리</h2>
    				
    				<!-- 테이블 영역 -->
    				<!-- UI 구현용으로 임시 테이블을 만듦. DB 연동 및 그 외의 기능 구현할 때, 수정반영할 예정 (일단은 그렇게 하고 보류) -->
    				<table class="table" border="1">
    					<thead>
    						<tr>
    							<th style="font-weight: bold; text-align: center; font-size: 20px;">번호</th>
    							<th style="font-weight: bold; text-align: center; font-size: 20px;">쿠폰종류</th>
    							<th style="font-weight: bold; text-align: center; font-size: 20px;">유효기간</th>
    							<th style="font-weight: bold; text-align: center; font-size: 20px;">연장</th>
    							<th></th>
    						</tr>
    					</thead>
    					<tbody>
    						<tr class="light" style="padding-top: 2%;">
    							<td style="text-align: center;">3</td>
    							<td style="text-align: left; font-size: 17px;">50% OFF 할인쿠폰 (생일 이벤트)</td>
    							<td style="font-size: 17px;">2022.08.17 ~ 2023.02.17 (6개월)</td>
    							<td>
    								<a href="#" class="btn btn-default" style="font-weight: bold; background-color: #eee;">
    									연장하기
    								</a>
    							</td>
    							<td>
    								<a href="#" class="btn btn-default" style="font-weight: bold; background-color: #eee;">
    									삭제
    								</a>
    							</td>
    						</tr>
    						<tr class="light">
    							<td style="text-align: center;">2</td>
    							<td style="text-align: left; font-size: 17px;">10% OFF 할인쿠폰</td>
    							<td>2023.02.19 ~ 2023.05.19 (3개월)</td>
    							<td></td>
    							<td></td>
    						</tr>
    						<tr class="light">
    							<td style="text-align: center;">1</td>
    							<td style="text-align: left; font-size: 17px;">20% OFF 할인쿠폰</td>
    							<td>2022.08.11 ~ 2023.02.11</td>
    							<td>
    								<a href="#" class="btn btn-default" style="font-weight: bold; background-color: #eee;">
    									연장하기
    								</a>
    							</td>
    							<td>
    								<a href="#" class="btn btn-default" style="font-weight: bold; background-color: #eee;">
    									삭제
    								</a>
    							</td>
    						</tr>
    					</tbody>
    				</table>
				</div>
				
				<!-- 버튼영역 -->
				<div class="admin_button">
					<a href="coupon_create.jsp" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255);">등록하기</a>
					<a href="#" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255);">관리자 홈</a>
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>