<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="notice.beans.Notice" %>
<%@ page import="notice.beans.noticeDAO" %>

<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<jsp:useBean id="user" scope="session" class="user.beans.User" />
<jsp:useBean id="Notice" class="notice.beans.Notice" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 고객센터_공지사항</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<style>
/** 제목 */ 
.title {
	margin-top: 7%;
	height: 150px;
}

.display-3 {
	margin-left: -6%;
	color: black;
	position: relative;
	font-weight: bold;
	font-size: 55px;
	display: block;
}

/** 우측 사이드 경로 */
.side_path {
	float: right; 
	position: absolute; 
	right: 17%; 
	width: 300px; 
	height: 50px;
	margin-top: -3%;
}

.home_icon {
	width: 40px; 
	height: 40px; 
	position: relative; 
	top: 5px;
	left: 7px;
}

.home_icon img {
	width: 33px;
	margin-left: 3px;
}

.sub_path {
	position: relative;
	display: block; 
	float: right;
	width: 240px; 
	bottom: 10%;
	height: 40px; 
	top: -35px; 
	padding-top: 4px;
	font-size: 17px;
	font-weight: bold;
}

/** 검색기능 */
.cont-search {
	float: right; 
	position: absolute; 
	right: 18%;
	width: 40%; 
	height: 70px;
	top: 43%;
}

.search_bar {
	position: absolute; 
	left: 40%; 
	margin: 0 auto; 
	width: 300px; 
	height: 50px;
	bottom: 75%;
}

/** 테이블 부분 */
.table {
	text-align: center;
	margin: 0 auto;
	position: relative;
	top: 11%;
	width: 1000px;
	height: 200px;
}

.table thead {
	height: 50px;
}

/** 버튼 부분 */
.policy_button {
	margin: 0 auto; 
	float: right; 
	right: 24%; 
	top: 17%; 
	position: relative;
}
</style>
</head>
<body>
	<%
		// 한글처리, 파라미터 (세션생성)
		request.setCharacterEncoding("UTF-8");
	
		// id값의 존재 유무를 통해 로그인 되어 있는지 사전체크 
		String id = null; 
		PrintWriter pw = response.getWriter(); 
		
		if (session.getAttribute("id") != null) {
			id = (String)session.getAttribute("id"); 
			pw.println("location.href='../06_customer/customer_notice.jsp'");
		}
		
		if (id == null) {
	%>
	<%@ include file="../01_main/index_top.jsp" %>
	<%
		} else {
	%>
	<%@ include file="../01_main/index.jsp" %>
	<%
		}
	%>
	
	<!-- 제목 -->
	<div class="title">
		<div class="container">
			<h1 class="display-3" style="font-weight: bold; text-shadow: 1px 1px 5px #bdbdbd;">고객센터 - 공지사항</h1>
		</div>
	</div>
	
	<!-- 사이드 경로 -->
	<div class="side_path">
		<div class="home_icon">
			<img src="../img/shop/home.png" />
		</div>
		<span class="sub_path">
			home > 고객센터 > 공지사항
		</span>
	</div>
	
	<!-- 검색 영역 -->
	<div class="cont-search">
			<div class="search_bar">
				<form name="frm_search" role="search" method="get" class="search-form" 
				style="position: absolute; left: 10%;">
					<input type="search" class="search-field" placeholder="" value="" name="findStr"
					style="width: 270px;" />
<!-- 					<span class="clue"></span> -->
<!-- 					<img src="../img/shop/recypro clipping.png"> -->
					<input type="submit" name="btnFind" class="search-submit" value="검색" 
					style="position: absolute; top: -1%; left: 100%;"/>
					<input type="hidden" name="nowPage" value="" size="10">
					<input type="hidden" name="serial" size="10">
					<input type="hidden" name="search" value="select">
				</form>
			</div>
		</div>
	
	<!-- 고객센터 - 공지사항 리스트 -->
	<table class="table" border="1">
		<thead>
			<tr>
				<th style="background-color: #eeeeee; text-align: center;">번호</th>
				<th style="background-color: #eeeeee; text-align: center;">제목</th>
				<th style="background-color: #eeeeee; text-align: center;">작성자</th>
				<th style="background-color: #eeeeee; text-align: center;">작성일</th>
				<th style="background-color: #eeeeee; text-align: center;">조회하기</th>
			</tr>
		</thead>
		
		<tbody><!-- 게시글 업로드 될 부분 -->
			<%
				int pageNum = 1; 
				if (request.getParameter("pageNum") != null) {
					// 정수형으로 타입 변경해주는 부분
					pageNum = Integer.parseInt(request.getParameter("pageNum"));
				}
			
				noticeDAO notiDao = new noticeDAO();		// 공지글을 뽑아올 수 있도록 인스턴스 생성 (클래스를 객체화)
				ArrayList<Notice> list = notiDao.getList(pageNum);	
				
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
					<a href="notice_view.jsp?notice_num=<%=list.get(i).getNotice_num()%>" class="btn-btn-default" style="background-color: #9FFBF4; display: inline-block; width: 75%; font-size: 16px; font-weight: bold;">조회하기</a>
				</td>
			</tr>
			<%
				}
			%>
			
			<%
				// 페이지 넘버 보여주는 부분
				if (pageNum != 1) {
			%>
			<a href="customer_notice.jsp?pageNum=<%=pageNum - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if (notiDao.nextPage(pageNum + 1)) {	// 다음 페이지가 존재하는지
			%>
			<a href="customer_notice.jsp?pageNum=<%=pageNum + 1%>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
		</tbody>
	</table>
	
	<!-- 버튼 영역 -->
	<div class="policy_button">
		<a href="customer_main.jsp" class="btn btn-default btn-lg" style="background-color: #b6f5f5; font-weight: bold;">고객센터 홈</a>
	</div>
</body>
</html>