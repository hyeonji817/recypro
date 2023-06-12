<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="question.beans.Question" %>
<%@ page import="question.beans.questionDAO" %>

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
<jsp:useBean id="Question" class="question.beans.Question" scope="page" />
<jsp:setProperty name="user" property="id" />
<jsp:setProperty name="user" property="password" />
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 관리자페이지(자주묻는질문)</title>
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
        				<h1 class="h3 mb-0 text-black-800" style="top: 12%; margin-top: 2%; margin-left: 3%; font-weight: 700;">Question</h1>
    				</div> 
    				
    				<h2 class="title" style="top: 12%; margin-top: 8%; margin-left: 3%; font-weight: 700;">자주묻는질문</h2>
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
							<th style="background-color: #eeeeee; text-align: center;">답변</th>
						</tr>
					</thead>
					<tbody>
						<%
							int pageNum = 1;
							questionDAO queDao = new questionDAO();		// 질문글을 뽑아올 수 있도록 인스턴스 생성 (클래스를 객체화)
							ArrayList<Question> list = queDao.getList(pageNum);
							
							for (int i = 0; i<list.size(); i++) {
						%>
						<tr>
							<!-- 질문글 번호 리턴 -->
							<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
								<%= list.get(i).getQuestion_num() %>
							</td>
							<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
								<a href="../06_customer/question_view.jsp?question_num=<%=list.get(i).getQuestion_num()%>"><%=list.get(i).getQuestion_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
								.replaceAll(">", "&gt;").replaceAll("\n", "<br>;")%></a>
							</td>
							<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
								<a href="question_view.jsp?question_num=<%=list.get(i).getQuestion_num()%>" class="btn-btn-info" style="background-color: #9FFBF4; display: inline-block; width: 90%; font-size: 16px; font-weight: bold;">조회하기</a>
							</td>
						</tr>
						<%
							}
						%>
						
						<%
							// 페이지 넘버 보여주는 부분
							if (pageNum != 1) {
						%>
						<a href="../admin/admin_question.jsp?pageNum=<%=pageNum - 1%>" class="btn btn-success btn-arrow-left">이전</a>
							<%
								} if (queDao.nextPage(pageNum + 1)) {	// 다음 페이지가 존재하는지
							%>
						<a href="../admin/admin_question.jsp?pageNum=<%=pageNum + 1%>" class="btn btn-success btn-arrow-left">다음</a>
							<%
								}
							%>
					</tbody>
				</table>
				<!-- 테이블 영역 끝 -->
				
				<!-- 버튼영역 -->
				<div class="admin_button">
					<a href="question_write.jsp" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255);">작성하기</a>
					<a href="admin_index.jsp" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255);">관리자 홈</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>