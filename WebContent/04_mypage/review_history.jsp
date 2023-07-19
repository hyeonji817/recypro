<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="review.beans.Review" %>
<%@ page import="review.beans.ReviewDAO" %>
<%@ page import="java.util.ArrayList" %><!-- 게시판의 목록을 출력하기 위해서 필요 -->

<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<jsp:useBean id="user" scope="session" class="user.beans.User" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 마이페이지_게시판 작성 내역</title>
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

/** 사이드바 메뉴 */ 
.side_menubar {
	float: left;
	width: 250px;
	position: relative;
	left: 1.5%;
	top: 3%;
	min-height: 480px;
	margin-bottom: 10%;
	display: block;
/* 	background-color: #eee; */
}

.side_menubar li {
	padding: 0;
	display: block;
	position: relative; 
	height: 60px; 
	width: auto;
}

.user_check {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -16.5%;
/* 	background-color: red;  */
	width: 250px;
	border: 1px solid gray; 
}

.user_check a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

.user_modify {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -16.5%;
	width: 250px;
	border: 1px solid gray; 
}

.user_modify a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

.mylevel {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -16.5%;
	width: 250px;
	border: 1px solid gray; 
}

.mylevel a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

.coupon_list {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -16.5%; 
	width: 250px;
	border: 1px solid gray; 
}

.coupon_list a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

.review_list {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -16.5%; 
	width: 250px;
	background-color: #eee;
	border: 1px solid gray; 
}

.review_list a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

.product_review {
	border-radius: 10px; 
	height: 60px;
	position: relative; 
	left: -16.5%;
	width: 250px;
	border: 1px solid gray; 
}

.product_review a {
	padding-top: 3%;
	top: 23%; 
	position: relative; 
	left: 3%;
	font-size: 17px;
	font-weight: bold;
}

.rv_list {
	width: 1500px; 
	margin: 0 auto; 
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

/** 버튼영역 */
.button {
	margin: 0 auto;
	float: right;
	right: 17%;
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
			pw.println("location.href='../04_mypage/shopping_history.jsp'");
		}
		
		// 메인 페이지로 이동했을 때, 세션에 값이 담겨있는지 체크 
		String userId = null; 
		if (session.getAttribute("userId") != null) {
			userId = (String)session.getAttribute("userId");	// 로그인한 사람들은 해당 아이디가 userId에 저장
		}
		
		// 가장 기본 페이지 1로 설정 
		int pageNumber = 1;
					
		if (request.getParameter("pageNumber") != null) {
			// 정수형으로 타입 변경해주는 부분
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
			<h1 class="display-3" style="font-weight: bold; text-shadow: 1px 1px 5px #bdbdbd;">게시판 작성 내역</h1>
		</div>
	</div>
	
	<!-- 사이드바 메뉴 -->
	<div class="side_menubar">
		<ul>
			<li>
				<div class="user_check">
					<a href="userinfo.jsp">
						회원정보조회
					</a>
				</div>
			</li>
			<li>
				<div class="user_modify">
					<a href="updateUser.jsp">회원정보수정</a>
				</div>
			</li>
			<li>
				<div class="mylevel">
					<a href="mylevel.jsp">마이레벨</a>
				</div>
			</li>
			<li>
				<div class="coupon_list">
					<a href="coupon_list.jsp">쿠폰함</a>
				</div>
			</li>
			<li>
				<div class="review_list">
					<a href="review_history.jsp">게시판 작성 내역</a>
				</div>
			</li>
			<li>
				<div class="product_review">
					<a href="productReview_history.jsp">상품리뷰 확인</a>
				</div>
			</li>
		</ul>
	</div>
	
	<div class="rv_list">
		<!-- 게시판 작성내역 리스트 테이블 -->
		<table class="table" border="1">
			<thead>
				<tr>
					<th style="text-align: center;">번호</th>
					<th style="text-align: center;">제목</th>
					<th style="text-align: center;">작성자</th>
					<th style="text-align: center;">작성일</th>
				</tr>
			</thead>
		
			<!-- 일단은 UI만 구현하고, 모든 페이지의 UI 구현 끝나는대로 DB 연동 등의 기능 구현 예정 -->
			<!-- 관리자페이지나 게시판 리스트 페이지보고 구현할 예정 -->
			<tbody>
				<%
					ReviewDAO rvDAO = new ReviewDAO(); 	// 게시글을 뽑아올 수 있도록 인스턴스 생성
					ArrayList<Review> list = rvDAO.getList(pageNumber);
				
					for (int i = 0; i<list.size(); i++) {	// 모든 게시글 불러옴
				%>
		
				<tr class="light">
					<td><%= list.get(i).getReviewId() %></td>	<!-- 게시글 번호 리턴 -->
					<td><a href="../05_review/view.jsp?reviewId=<%=list.get(i).getReviewId()%>"><%=list.get(i).getReviewTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>;")%></a></td>
					<!-- 제목을 눌렀을 때 해당 게시물로 이동, 해당번호에 맞는 페이지가 나올 수 있도록 함. 게시글 제목 리턴 -->
					<td><%=list.get(i).getUserId() %></td>	<!-- UserId 리턴 -->
					<td><%=list.get(i).getReviewDate().substring(0,11) %></td>
				</tr>
				<%
					}
				%>
			</tbody>
		</table>
	</div>
	
	<!-- 뒤로가기 버튼 -->
	<div class="button">
		 <input type="button" class="btn btn-default btn-lg" value="뒤로가기" onclick="location.href='mypage.jsp'" style="background-color: #b6f5f5; font-weight: bold; color: black;">
	</div>
</body>
</html>