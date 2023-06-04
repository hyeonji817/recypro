<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="notice.beans.Notice" %>
<%@ page import="notice.beans.noticeDAO" %>

<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="com.util.DBConn"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet"%>
<!-- resultset은 커서 지정용 -->
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.beans.User" scope="page" />
<jsp:useBean id="Notice" class="notice.beans.Notice" scope="page" />
<jsp:setProperty name="user" property="id" />
<jsp:setProperty name="user" property="password" />
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 관리자페이지(공지사항)</title>
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
    				
    				<h2 class="title" style="top: 12%; margin-top: 8%; margin-left: 3%; font-weight: 700;">공지사항</h2>
				</div>
				<!-- Begin Page Content End -->
				
				<!-- 테이블 영역 -->
				<!-- 일단은 UI만 구현하되, 향후 공지사항 수정 기능 추가할 예정 -->
				<!-- 게시판 페이지 구현방식을 참고해서 작성해야 하나... -->
				<table class="table" border="1">
					<thead>
						<tr>
							<th style="background-color: #eeeeee; text-align: center;">번호</th>
							<th style="background-color: #eeeeee; text-align: center;">제목</th>
							<th style="background-color: #eeeeee; text-align: center;">작성자</th>
							<th style="background-color: #eeeeee; text-align: center;">작성일</th>
							<th style="background-color: #eeeeee; text-align: center;">조회하기</th>
						</tr>
					
						<!-- <tr>
							<th style="text-align: center;">번호</th>
							<th style="text-align: center;">제목</th>
							<th style="text-align: center;">작성자</th>
							<th style="text-align: center;">작성일</th>
							<th style="text-align: center;">조회수</th>
							<th style="text-align: center;">편집</th>
						</tr> -->
					</thead>
					<tbody>
						<%
							noticeDAO notiDao = new noticeDAO();		// 공지글을 뽑아올 수 있도록 인스턴스 생성 (클래스를 객체화)
							ArrayList<Notice> list = noticeDAO.getList(pageNumber);	
				
							for (int i = 0; i<list.size(); i++) {
						%>
						<tr>
							<td>
								<%= list.get(i).getNotice_num() %>
							</td>		<!-- 공지글 번호 리턴 -->
							<td>
								<a href="notice_view.jsp?notice_num=<%=list.get(i).getNotice_num()%>"><%=list.get(i).getNotice_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
								.replaceAll(">", "&gt;").replaceAll("\n", "<br>;")%></a>
							</td>
							<td>
								<%= list.get(i).getUserId() %>		<!-- UserId 리턴 -->
							</td>
							<td>
								<%= list.get(i).getNotice_date().substring(0,11) %>
							</td>
							<td>
								<a href="notice_view.jsp?notice_num=<%=list.get(i).getNotice_num()%>" class="btn-btn-info" style="background-color: #9FFBF4; display: inline-block; width: 90%; font-size: 16px; font-weight: bold;">조회하기</a>
							</td>
					</tr>
					<%
						}
					%>
			
					<%
						// 페이지 넘버 보여주는 부분
						if (pageNumber != 1) {
					%>
					<a href="review.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
					<%
						} if (reviewDAO.nextPage(pageNumber + 1)) {	// 다음 페이지가 존재하는지
					%>
					<a href="review.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음</a>
					<%
						}
					%>
					
						<!-- <tr class="light">
							<td style="text-align: center;">1</td>
							<td>리싸이프로 이용 가이드 (구매 전 필독★)</td>
							<td>admin</td>
							<td>2023.03.02</td>
							<td>1</td>
							<td>
								<a href="notice_modify.jsp" class="btn btn-default" style="font-weight: bold; background-color: #eee;">
    								수정하기
    							</a>
							</td>
						</tr>
						<tr class="light">
							<td style="text-align: center;">2</td>
							<td>사이즈 교환 1회 무료서비스 실시</td>
							<td>admin</td>
							<td>2023.03.02</td>
							<td>2</td>
							<td>
								<a href="#" class="btn btn-default" style="font-weight: bold; background-color: #eee;">
    								수정하기
    							</a>
							</td>
						</tr>
						<tr class="light">
							<td style="text-align: center;">3</td>
							<td>새벽배송 배송지역 변경</td>
							<td>admin</td>
							<td>2023.03.02</td>
							<td>3</td>
							<td>
								<a href="#" class="btn btn-default" style="font-weight: bold; background-color: #eee;">
    								수정하기
    							</a>
							</td>
						</tr> -->
					</tbody>
				</table>
				<!-- 테이블 영역 끝 -->
				
				<!-- 버튼영역 -->
				<div class="admin_button">
					<a href="notice_write.jsp" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255);">작성하기</a>
					<a href="admin_index.jsp" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255);">관리자 홈</a>
				</div>
				
			</div>
			<!-- Main Content -->
			
		</div>
		<!-- Content Wrapper End -->
	</div>
	<!-- 관리자페이지 전체 내용 끝 -->
</body>
</html>