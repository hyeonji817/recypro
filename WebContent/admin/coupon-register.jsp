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
<title>재활용품 전문점 : 리싸이프로 - 관리자페이지(사용자확인)</title>
<meta name="viewport"
	content="width=device-width, 
initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.css">
<link rel="stylesheet" type="text/css" href="../css/sb-admin-2.min.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
.user_list {
	margin-right: 20%;
}

.register_coupon {
	width: 1000px; 
	min-height: 600px; 
	position: relative; 
	top: 60px;
	margin: 0 auto;
	background-color: #eee;
}

.form-group {
	margin-bottom: 5%;
}

.col-sm-2 b {
	width: 150px;
	display: inline-block;
	padding-right: 22%;
	padding-top: 10%;
}

.col-sm-6 {
	width: 330px;
	display: inline-block;
	padding-top: 0.6%;
}

/** 쿠폰사용 기간 등록 */
#use_time {
	width: 1000px;
}

#coupon_period {
	width: 100px; 
	height: 30px; 
	right: 17%;
	position: relative; 
}

#coupon_time {
	width: 80px; 
	height: 30px; 
	right: 17.5%; 
	position: relative;
}

.divide_bar {
	position: relative; 
	font-size: 17px; 
	right: 17%;
}

#coupon_period2 {
	width: 100px; 
	height: 30px; 
	right: 16.5%; 
	position: relative; 
}

#coupon_time2 {
	width: 80px; 
	height: 30px; 
	right: 17%; 
	position: relative;
}

/** 혜택구분 */ 
#event_option {
	height: 30px; 
	width: 220px;
	right: 19%; 
	position: relative; 
}

.admin_button {
	position: relative; 
	margin-top: 5%;
}
</style>
</head>
<body>
	<%
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
		String userid = "root"; // db에 입력할 id
		String password = "1234"; // db에 입력할 패스워드		
		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명, 자바코드와 db를 연결할 드라이버(연결다리)
		conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성

		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from user";
		pstmt = conn.prepareStatement(sql); // 연결 객체의 prepareStatement객체를 통해 해당 sql의 내용 호출

		rs = pstmt.executeQuery(); //조회한 결과들을 ResultSet에 rs에 저장한다.
	%>

	<div id="wrapper">
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-cloumn">
			<%@ include file="../admin/sidebar.jsp"%>
			<!-- Main Content -->
			<div id="content">

				<!-- Begin Page Content -->
				<div class="container-fluid">
				
				<!-- Page Heading -->
    			<div class="d-sm-flex align-items-center justify-content-between mb-4">
        			<h1 class="h3 mb-0 text-black-800" style="top: 12%; margin-top: 2%; margin-left: 3%; font-weight: 700;">Coupon-Register</h1>
    			</div>

				<h2 class="title" style="top: 12%; margin-top: 2%; margin-left: 3%; font-weight: 700;">쿠폰등록</h2>
					
				<!-- 쿠폰생성 레이아웃 -->
				<div class="register_coupon" style="margin: 0 auto; text-align: center;">
						<form action="#" name="register_Cp" class="form-horizontal" method="post" enctype="multipart/form-data"
						style="margin: 0 auto; position: relative; width: 750px; min-height: 400px; top: 80px;">
							<!-- 쿠폰명 -->
							<div class="form-group row" >
								<label class="col-sm-2"><b>쿠폰명</b></label>
								<div class="col-sm-6">
									<input type="text" name="coupon_name" class="form-control" placeholder="쿠폰명을 입력해주세요">
								</div>
							</div>
							<!-- 지급받을 아이디 -->
							<div class="form-group row">
								<label class="col-sm-2"><b>지급받을 아이디</b></label>
								<div class="col-sm-6">
									<input type="text" name="coupon_id" class="form-control" placeholder="아이디를 입력해주세요">
								</div>
							</div>
							<!-- 할인률 설정 -->
							<div class="form-group row">
								<label class="col-sm-2"><b>할인률 설정</b></label>
								<div class="col-sm-6">
									<input type="text" name="coupon_id" class="form-control" placeholder="할인률을 입력해주세요">
								</div>
							</div>
							<!-- 사용기간 -->
							<div class="form-group row" id="use_time">
								<label class="col-sm-2"><b>사용기간</b></label>
								<div class="col-sm-6">
									<input type="date" id="coupon_period" name="coupon_period" min="2000-03-01" />
									<input type="time" id="coupon_time" />
									<span class="divide_bar"><b>-</b></span> 
									<input type="date" id="coupon_period2" name="coupon_period2" min="2000-09-01" /> 
									<input type="time" id="coupon_time2" />
								</div>
							</div>
							<!-- 기준금액 -->
							<div class="form-group row">
								<label class="col-sm-2"><b>기준금액</b></label>
								<div class="col-sm-6">
									<input type="text" name="coupon_id" class="form-control" placeholder="기준금액을 입력해주세요">
								</div>
							</div>
							<!-- 혜택구분 -->
							<div class="form-group row">
								<label class="col-sm-2"><b>혜택구분</b></label>
								<div class="col-sm-6">
									<select name="choose" id="event_option">
										<option value="choose">선택해 주세요</option>
										<option value="join">회원가입 30% 할인</option>
										<option value="birthday">생일 50% 할인</option>
										<option value="level_11">마이레벨 11이상 등업</option>
										<option value="level_21">마이레벨 21이상 등업</option>
										<option value="level_31">마이레벨 31이상 등업</option>
										<option value="level_41">마이레벨 41이상 등업</option>
										<option value="level_51">마이레벨 51이상 등업</option>
										<option value="level_61">마이레벨 61이상 등업</option>
									</select>
								</div>
							</div>
						</form>		
				</div>

				</div>
			</div>
		</div>
	</div>
	
	<div class="admin_button">
		<a href="#" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255); 
		position: relative; margin-top: -10%; margin-right: 460px;">등록</a>
		<a href="admin_coupon.jsp" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255);
		position: relative; margin-top: -10%; margin-right: 380px;">취소</a>
	</div>
</body>
</html>