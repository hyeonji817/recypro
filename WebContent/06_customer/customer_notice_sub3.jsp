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
<title>재활용품 전문점 : 리싸이프로 - 고객센터_공지사항 (세부내용)</title>
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

/** 공지사항 세부내용 영역 */ 
.notice_subinfo {
	margin: 0 auto; 
	position: relative; 
	width: 800px; 
	min-height: 1000px; 
}

/** 고객상담 안내 */
.consult_info h6 {
	text-align: center; 
	font-size: 22px; 
}

.consult_subInfo h6 {
	text-align: center;
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
			<h1 class="display-3" style="font-weight: bold; text-shadow: 1px 1px 5px #bdbdbd;">고객센터_자주묻는질문 - 답변</h1>
		</div>
	</div>
	
	<div class="notice_subinfo">
		<!-- 새벽배송 배송지역 변경 안내 -->
		<div class="consult_info">
			<h6>------------------
				<br>
					<b>새벽배송 배송 시간 및 지역 변경</b>
				<br>
				------------------
			</h6>
		</div>
		
		<!-- 무료교환 안내 세부내용 -->
		<div class="consult_subInfo">
			<h6>
				안녕하세요. 리싸이프로 입니다. <br><br>
				2023년 4월 1일부로 리싸이프로의 새벽배송 배송지역이 변경되었습니다. <br>
				기존의 서울, 경기, 부산 일부 지역에서 [서울] 지역으로만 새벽배송 가능 지역으로 변경되었습니다. <br> 
				그 외에도 기존 이용하시던 새벽배송의 주문시간에도 변경이 있으니 착오 없으시길 바랍니다. <br> 
				5월 1일부터 새벽배송의 주문시간이 <br>
				21시에서 19시로 시간을 변경하게 되었습니다. <br>
				불편하시겠지만 양해 부탁드리오며, <br>
				보다 나은 새벽배송 서비스로 찾아 뵙도록 하겠습니다. <br>
				감사합니다. <br>
			</h6>
		</div>
	
	</div>
</body>
</html>