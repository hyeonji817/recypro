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
<title>재활용품 전문점 : 리싸이프로 - 관리자페이지(공지사항 수정페이지)</title>

<meta name="viewport"
	content="width=device-width, 
initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.min.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>

</style>
</head>
<body>
	<!-- 관리자페이지 전체 내용 -->
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
        				<h1 class="h3 mb-0 text-black-800" style="top: 12%; margin-top: 2%; margin-left: 3%; font-weight: 700;">Notice</h1>
    				</div> 
    				
    				<h2 class="title" style="top: 12%; margin-top: 8%; margin-left: 3%; font-weight: 700;">공지사항 - 수정하기</h2>
				</div>
				<!-- Begin Page Content End -->
				
				<!-- 공지사항 수정 양식 테이블 영역 -->
				<div class="notice_modify">
					<div class="row">
						<form method="post" action="" style="width: 800px; padding-top: 10%; margin: 0 auto;">
							<!-- 데이터를 액션 페이지로, 실제로 글 수정 -->
							<table class="table" style="text-align: center; border: 1px solid #dddddd">
								<thead>
									<tr>
										<th colspan="2"
										style="background-color: #eeeeee; text-align: center;">공지사항 
										글 수정 양식</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<input type="text" class="form-control" placeholder="글 제목" 
											name="noticeTitle" maxlength="50" value="리싸이프로 이용 가이드(구매 전 필독★)" /> 
										</td>
									</tr>
									<tr>
										<td>
											
											
 											<textarea class="form-control" placeholder="글 내용" 
 											name="reviewContent" maxlength="3000" style="height: 350px;"> 
 								
 											</textarea> 
										</td>
									</tr>
								</tbody>
							</table>
							
							<!-- 버튼영역 -->
							<div class="admin_button">
								<a href="#" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; right: 29%; position: relative; background-color: rgb(11, 103, 255);">관리자 홈</a>
								<a href="#" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; right: 1%; position: relative; background-color: rgb(11, 103, 255);">수정하기</a>
								<a href="#" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; right: -27%; position: relative; background-color: rgb(11, 103, 255);">삭제하기</a>
							</div>	
						</form>
						<!-- 테이블 영역 끝 -->
						
					</div>
				</div>
				<!-- 공지사항 수정 양식 테이블 영역 끝 -->
			</div>
			<!-- Main Content End -->
		</div>
		<!-- Content Wrapper end -->
		
	</div>
	<!-- 관리자페이지 전체 내용 끝 -->
</body>
</html>