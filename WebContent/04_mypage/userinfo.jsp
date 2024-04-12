<!-- 참고한 원본내용 : memberinfo.jsp(회원정보 조회페이지) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.beans.User" %>
<%@ page import="user.beans.UserDAO" %>
<%@ page import="com.util.DBConn" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 회원정보 조회페이지</title>
<meta name="viewport" content="width=device-width, 
initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
.title {
	margin-left: 30px;
	margin-bottom: 30px;
	margin-top: 120px;
	height: 120px;
	font-weight: 700;
	font-size: 60px;
	color: black;
	text-shadow: 1px 1px 5px #bdbdbd;
}

.check_userInfo {
	width: 1200px; 
	margin: 0 auto; 
}

/** 사이드 메뉴 */
.side_menubar {
	float: left;
	width: 250px;
	position: relative;
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
	left: -20%;
	background-color: #eee;  
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
	left: -20%;
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
	left: -20%;
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
	left: -20%; 
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
	left: -20%; 
	width: 250px;
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
	left: -20%;
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

.table {
	text-align: center;
/* 	margin-left: 35%; */
	margin: 0 auto;
	width: 700px;
}

.button {
/* 	margin-left: 20px; */
	margin: 0 auto;
	float: right;
	right: 22%;
	position: relative;
}

.main-img {
		position: fixed;
		top: 5%;
		width: 100%;
		height: 100%;
		background-attachment: fixed;
		z-index: -10;
		opacity: 0.1;
	}
</style>
</head>
<body>
<%@ include file="../01_main/index.jsp" %>
<!-- <img src="../img/sea.jpg" class="main-img" alt="tip main"> -->
	<%
		// 한글설정 & 변수생성 
		String id = (String) session.getAttribute("id");
		// id값 확인 - 없으면 로그인 페이지로 이동 
		if (id == null) {
			response.sendRedirect("../02_account/login.jsp");
		}
		
		// 멤버 DAO 객체 생성 -> 회원정보 가져오는 메소드 생성 
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUser(id);
		
		// 데이터 처리 : 테이블로 표현 
		if (user != null) {
			%>
			<h2 class="title">회원정보</h2>
			
			<!-- 사이드 메뉴 -->
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
			
			<div class="check_userInfo">
				<table class="table" border="1">
				<thead>
					<tr>
						<th>회원정보 종류</th>
						<th>회원정보</th>
					</tr>
				</thead>
				<tbody>
					<tr class="white">
						<td>아이디</td>
						<td><%=user.getId() %></td>
					</tr>
					<tr class="light">
						<td>비밀번호</td>
						<td><%=user.getPassword() %></td>
					</tr>
					<tr class="light">
						<td>이름</td>
						<td><%=user.getName() %></td>
					</tr>
					<tr class="light">
						<td>나이</td>
						<td><%=user.getAge() %></td>
					</tr>
					<tr class="light">
						<td>성별</td>
						<td><%=user.getGender() %></td>
					</tr>
					<tr class="light">
						<td>이메일</td>
						<td><%=user.getEmail() %></td>
					</tr>
				</tbody>
			</table>
			<%
		}
		 %>
		 <hr>
		</div>
			
		 
		 <!-- 관리자일 때만 메뉴확인 가능하게끔 페이지 구현 -->
		 
		 <div class="button">
		 	<input type="button" class="btn btn-default btn-lg" value="뒤로가기" onclick="location.href='mypage.jsp'" style="background-color: #b6f5f5; font-weight: bold; right: -10%; color: black;">
		 </div>
		 
</body>
</html>