<!-- 참고했던 웹 페이지 주소좌표1 : https://wogus789789.tistory.com/175 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "user.beans.User" %>
<%@ page import = "user.beans.UserDAO" %>
<%@ page import = "register.beans.RegisterDAO"%>
<%@ page import = "java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">
<title>재활용품 전문점 : 리싸이프로 - 비밀번호 찾기 확인 및 재설정</title>
<style>
@import url("http://fonts.googleapis.com/earlyaccess/nanumgothic.css");

html {
	height: 100%;
}

body {
	width: 100%;
	height: 100%;
	margin: 0;
	padding-top: 200px;
	padding-bottom: 40px;
	font-family: "Nanum Gothic", arial, helvetica, sans-serif;
	background-repeat: no-repeat;
}

.card {
	margin: 0 auto; /* Added */
	float: none; /* Added */
	margin-bottom: 10px; /* Added */
}

#btn-Yes {
	background-color: #e4932b;
	border: none;
}

.form-signin .form-control {
	position: relative;
	height: auto;
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	padding: 10px;
	font-size: 16px;
}

.checkbox {
	margin-right: 20px;
	text-align: right;
}

.card-title {
	margin-left: 28%;
	width: 150px;
}

a {
	color: #f58b34;
	text-decoration: none;
}

.links {
	text-align: center;
	margin-bottom: 10px;
}
</style>
</head>
<body cellpadding="0" cellspacing="0" marginleft="0" margintop="0"
	width="100%" height="100%" align="center">
	<%
		request.setCharacterEncoding("UTF-8");
		String id = request.getParameter("id");		// 입력할 id값을 불러들이기 위한 변수 선언 
		String name = request.getParameter("name");		// 입력할 name 값을 불러들이기 위한 변수 선언 
		String email = request.getParameter("email");	// 입력할 email 값을 불러들이기 위한 변수 선언 
		
		System.out.println(id);
		System.out.println(name);
		System.out.println(email);
		
		UserDAO udao = new UserDAO();
	// 이놈이 문제 // 이놈이 문제 // 이놈이 문제
		String password = udao.findPw(id, name, email);	// 아이디를 DB에서 가져옴. 실패 시 Null 처리
	// 이놈이 문제 // 이놈이 문제 // 이놈이 문제	
	%>
	<div class="card align-middle" style="width: 25rem;">
		<div class="card-title" style="margin-top: 30px;">
			<h2 class="card-title" style="color: #f58b34;">
				<img src="../img/recypro_logo.png" />
			</h2>
		</div>
		
		<div class="card-body">
			<form action="resetPw" class="form-signin" method="POST">
				<input type="hidden" name="password">
				<p class="check" id="check">
					현재 비밀번호 : <%=password%>		<!-- 앞서 선언했던 password 변수를 투입하여 값 출력 -->
				</p>
				<br />
			</form>
		</div>
		<div class="links">
			<a href="login.jsp">로그인</a> | <a href="register.jsp">회원가입</a>
		</div>
	</div>
</body>
</html>