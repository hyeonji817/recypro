<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
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
<title>재활용품 전문점 : 리싸이프로 - 고객센터_온라인 상담/문의 - 문의글 목록</title>
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

.table tbody td {
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
			pw.println("location.href='../04_mypage/shopping_history.jsp'");
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
			<h1 class="display-3" style="font-weight: bold; text-shadow: 1px 1px 5px #bdbdbd;">문의글 목록</h1>
		</div>
	</div>
	
	<!-- 문의글 목록 페이지(임시용)를 임시로 연결한 것임. 이것도 게시판 등록 양식과 유사할 듯.. -->
	<!-- 문의글 목록 영역 -->
	<table class="table" border="1">
		<thead>
			<tr>
				<th style="text-align: center;">번호</th>
				<th style="text-align: center;">제목</th>
				<th style="text-align: center;">작성날짜</th>
			</tr>
		</thead>
		<tbody>
			<tr class="light">
				<td style="text-align: center; postion: relative; padding-top: 2%; font-size: 20px;">1</td>
				<td style="postion: relative; padding-top: 2%; font-size: 20px;">상품 배송이 늦어요..ㅠㅠ 언제 도착하시나요?ㅠㅠ</td>
				<td style="text-align: center; postion: relative; padding-top: 2%; font-size: 20px;">2023.03.04</td>
			</tr>
			<tr class="light">
				<td style="text-align: center; postion: relative; padding-top: 2%; font-size: 20px;">2</td>
				<td style="postion: relative; padding-top: 2%; font-size: 20px;">물건 변상 요청합니다. 손상된 채로 들어왔네요</td>
				<td style="text-align: center; postion: relative; padding-top: 2%; font-size: 20px;">2023.03.03</td>
			</tr>
		</tbody>
	</table>
	
	<!-- 버튼 영역 -->
	<div class="policy_button">
		<a class="btn btn-default btn-lg" style="background-color: #b6f5f5; font-weight: bold;">고객센터 홈</a>
	</div>
</body>
</html>