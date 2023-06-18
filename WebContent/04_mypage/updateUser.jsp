<!-- 회원정보수정페이지 updateForm.jsp -->
<!-- 참고한 웹 페이지 주소 : https://sowon-dev.github.io/2020/07/13/200714jspi2/ -->
<!-- 참고한 웹 페이지 주소2 : https://rsorry.tistory.com/189 -->
<!-- 참고한 웹 페이지 주소3 : https://heezit.tistory.com/75 -->
<!-- 참고한 교재 : HTML5 웹 표준 실무완성 3일차 37p -->
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
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>재활용품 전문점 : 리싸이프로 - 회원정보 수정페이지</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<!-- font awesome -->
<link
	href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css"
	rel="stylesheet">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap.css">
<script src="../js/jquery.validate.min.js"></script>
<script src="../js/additional-methods.min.js"></script>
<!-- CSS static -->
<link rel="stylesheet" type="text/css" href="../css/index.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<script src="https://kit.fontawesome.com/75e53ee709.js"
	crossorigin="anonymous"></script>
<scipt>

</scipt>	
<style>
.main-img {
	position: fixed;
	top: 5%;
	width: 100%;
	height: 100%;
	background-attachment: fixed;
	z-index: -10;
	opacity: 0.1;
}

.title {
	margin-left: 30px;
	margin-bottom: 10px;
	margin-top: 120px;
	height: 100px;
}

/** 사이드 메뉴 */
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
	left: -20%;
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
	background-color: #eee;
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

legend {
	font-size: 3.5rem;
	font-weight: 700;
	color: black;
	text-shadow: 1px 1px 5px #bdbdbd;
}

.update_userInfo {
	width: 1200px; 
	margin: 0 auto; 
}

.form-group {
	margin: 0 auto;
	height: 90px;
	width: 350px;
	position: relative;
}

#pwd {
	width: 600px;
}

.form-button {
	bottom: 10%;
}

.col-md-2 {
	width: 300px;
	display: block;
	float: left;
	font-size: 14px;
	text-indent: 5px;
}

.col-md-10 {
	display: block;
	float: left;
	width: 650px;
}

#pwd_reply {
	height: 50px;
}

input .form-control {
	font-size: 14px;
	border: 1px solid #eee;
	width: 650px;
}

.form-modify {
	margin-top: 60px;
	display: inline-block;
	float: right;
	position: relative;
	margin-right: -22%;
}

.btn-warning {
	color: white;
}

.nav-right a {
	font-weight: 700;
	position: relative;
}

.submenu a {
	font-weight: 700;
	position: relative;
}
</style>
</head>
<body>
	<%
		// 로그인 여부 체크 (로그인 X -> 로그인페이지로 이동)
		request.setCharacterEncoding("UTF-8");
		String id = (String) session.getAttribute("id");
		
		System.out.println(id);
	
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
		String userid = "root"; // db에 입력할 id
		String passwd = "1234"; // db에 입력할 패스워드		
		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명, 자바코드와 db를 연결할 드라이버(연결다리)
		conn = DriverManager.getConnection(url, userid, passwd); // 연결 객체생성
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;	// 위치추적기
		
		String sql = "select * from user where id = ?";
		
		pstmt = conn.prepareStatement(sql); // 연결 객체의 prepareStatement객체를 통해 해당 sql의 내용 호출, 세팅준비
		pstmt.setString(1, id); // 문제는 현지입니다.땡큐, 첫 번째 물음표 쿼리문에 id변수값 대입하여 출력, 세팅준비
		rs = pstmt.executeQuery();	// 준비했던 세팅을 실행
		
		// 드라이브 로드 & DB 연결 : 로그인한 사용자의 정보를 가져오기 
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getUser(id);	// 기존에 있던 User 빈즈에 userDAO 내 getUser 메소드 기능까지 추가
	%>

	<div class="wrapper"></div>
	<!-- navbar -->
	<header>
		<div class="nav">
			<a class="logo" href="../01_main/loginOK.jsp">리싸이프로</a>
			<ul class="nav-right">
				<li><a class="link" href="../03_shop/Products.jsp">상품</a></li>
				<li><a class="link" href="../05_review/review.jsp">게시판</a></li>
				<li><img src="../img/user.png" width="30" height="30"
					alt="logo" class="user-img"> <!-- 옆에 아이디명이나 닉네임명을 구현해야 하는데 어케 하지... -->
					<ul class="submenu">
						<li><a class="link" href="../03_shop/cart.jsp">장바구니</a></li>
						<li><a class="link" href="../04_mypage/mypage.jsp">마이페이지</a>
						</li>
						<li><a class="link" href="../02_account/logoutAction.jsp">로그아웃</a>
						</li>
					</ul></li>
			</ul>
		</div>
	</header>

	<!-- 데이터처리 : 테이블 형식으로 출력 -->
	<!-- 비밀번호를 입력받은 뒤 수정하기 -> 입력받은 데이터를 updatePro.jsp으로 전달하여 진행 -->
	<fieldset>
		<div class="title">
			<legend>회원정보 수정</legend>
		</div>
		<br>
		
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

	<div class="update_userInfo">
		<form action="updatePro.jsp" method="post" style="width: 700px; margin: 0 auto;">
			<div class="form-group">
				<h5 for="id" class="tap1">아이디</h5>
				<div class="tap2">
					<input type="text" name="id" class="form-control" value="<%=user.getId()%>" readonly>
					<!--ID 영역은 disabled가 아니라 readonly로 해야 ID 값을 그대로 받아옴. disabled는  submit이 안된다고 함. -->
				</div>
			</div>
			<div class="form-group">
				<h5 for="password" class="tap1">비밀번호</h5>
				<div class="tap2">
					<input type="password" name="password" id="password1" class="form-control" placeholder="비밀번호를 입력하세요" required><br>
				</div>
			</div>
			<div class="form-group">
				<h5 for="password" class="tap1" id="pwd">변경할 비밀번호</h5>
				<div class="tap2">
					<input type="password" name="password2" id="password2" class="form-control" placeholder="비밀번호를 입력하세요"><br>
				</div>
			</div>
			<div class="form-group">
				<h5 for="password" class="tap1" id="pwd">변경할 비밀번호 재입력</h5>
				<div class="tap2" id="pwd_reply">
					<input type="password" name="password3" id="password3" class="form-control" placeholder="비밀번호를 다시 입력하세요">
					<a class="form-button">
						<button onclick="test5555()" style="float: right; width: 40pt; height: 20pt;">확인</button>
					</a> 
				</div>
			</div>
			

			<div class="form-group">
				<h5 for="name" class="tap1">이름</h5>
				<div class="tap2">
					<input type="text" name="name" class="form-control" value="<%=user.getName()%>">
				</div>
			</div>
			<div class="form-group">
				<h5 for="age" class="tap1">나이</h5>
				<div class="tap2">
					<input type="text" name="age" class="form-control" value="<%=user.getAge()%>" readonly>
					<!-- 					get으로 값을 가져올때 disabled하면 무조건 값을 못가져옴. (null 발생) -->
				</div>
			</div>
			<!-- <div class="form-group" style="height: 80px;">
				<h5 for="gender" class="tap1">성별</h5>
				<div class="tap2">
					<label> 
						<input type="radio" name="gender" value="남" style="width: 20px; height: 20px; border: 1px;"> 
						<span>
							<span style="font-size: 20px;">남자</span>
						</span>
					</label> 
					<label> 
					<input type="radio" name="gender" value="여" style="width: 20px; height: 20px; border: 1px;"> 
					<span style="font-size: 20px;">여자</span>
					</label>
				</div>
			</div> -->
			<!-- <div class="form-group">
				<h5 for="regident_registration_number" class="tap1">주민등록번호</h5>
				<div class="tap2">
					<input type="text" name="jumin1" maxlength="6" style="width: 150px;" value="주민등록번호">
					<input type="text" name="jumin2" maxlength="7" value="주민등록번호 뒷자리"> 
				</div>
			</div> -->
			<div class="form-group">
				<h5 for="email" class="tap1">이메일</h5>
				<div class="tap2">
					<input type="text" name="email" id="email_text"
						class="form-control" value="<%=user.getEmail()%>">
				</div>
			</div>
			<div class="form-modify">
				<label><input type="submit" class="btn btn-default btn-lg" style="background-color: #b6f5f5; font-weight: bold; color: black;"
					value="회원정보수정하기"></label>
				<button onclick="location.href='mypage.jsp';"
					class="btn btn-default btn-lg" style="background-color: #b6f5f5; font-weight: bold; color: black;" value="뒤로가기">뒤로가기</button>
			</div>
		</form>
	</div>
		

	</fieldset>
	<script type="text/javascript">
		// 시도한 거 ver.1 
		function test5555() {
			var p2 = document.getElementById('password2').value;
			var p3 = document.getElementById('password3').value;
// 			alert(p2);
// 			alert(p3);
			
			var pfinish = null;
		
			if (p2 == '' && p3 == '')
			{
				alert("변경할 비밀번호 값을 입력하세요.");
				event.preventDefault();
			}
			else if (p2 == p3) 
			{
				alert("비밀번호가 일치합니다.!!");				
				event.preventDefault();
			} 
			else if (p2 != p3) 
			{
				alert("비밀번호가 일치하지 않습니다.");
				event.preventDefault();
			}
		}
		/** 출처좌표 : https://pycoding.tistory.com/entry/%EC%9E%90%EB%B0%94%EC%8A%A4%ED%81%AC%EB%
		A6%BD%ED%8A%B8-%EB%B9%84%EB%B0%80%EB%B2%88%ED%98%B8-%EC%9D%BC%EC%B9%98-%ED%99%95%EC%9D%
		B8 */
	</script>

</body>
</html>