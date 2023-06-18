<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>재활용품 전문점 : 리싸이프로 - 쿠폰생성 페이지</title>
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
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
<script src="https://kit.fontawesome.com/75e53ee709.js"
	crossorigin="anonymous"></script>
<style>
.title {
	margin-top: 80px;
	height: 100px;
	position: relative;
	left: 10%;
	width: 600px;
	font-weight: 700;
}

.display-3 {
	margin-top: 22%;
	margin-left: -12%;
	color: black;
	font-weight: 700;
	width: 500px;
	text-shadow: 1px 1px 5px #bdbdbd;
}

/** 쿠폰 등록 양식 */
.coupon_Info {
	width: 1200px;
	min-height: 1000px;
	margin: 0 auto;
	/** background-color: #eee; */
	position: relative;
	top: 17%;
}

.form-group {
	margin: 0 auto;
	height: 90px;
	width: 350px;
	position: relative;
}

#coupon_title select {
	display: inline-block;
	bottom: 40px; 
	width: 300px; 
	height: 40px;
	position: relative; 
	left: 40%;
}

input .form-control {
	font-size: 14px;
	border: 1px solid #eee;
	width: 650px;
}

.form-button {
	position: relative;
	margin-top: 22%;
	min-height: 80px; 
}
</style>
</head>
<body>
	<%@ include file="../01_main/index_admin.jsp"%>
	<!-- 페이지 제목 -->
	<div class="title">
		<div class="container">
			<h1 class="display-3">쿠폰 등록하기</h1>
		</div>
	</div>

	<div class="coupon_Info">
		<form action="" method="post" style="width: 700px; margin: 0 auto;">
			<!-- 쿠폰종류 -->
			<div class="form-group">
				<h5 for="coupon_title" class="tap1">쿠폰제목</h5>
				<div class="tap2">
					<!-- <input type="text" name="coupon_title" class="form-control" value="" /> -->
					<select name="coupon_title" id="coupon_title" class="coupon_title" style="width: 350px; height: 38px;">
						<option value="choose">쿠폰을 선택하세요</option>
						<option value="choose">10% OFF 할인쿠폰</option>
						<option value="choose">20% OFF 할인쿠폰</option>
						<option value="choose">30% OFF 할인쿠폰</option>
						<option value="choose">40% OFF 할인쿠폰</option>
						<option value="choose">50% OFF 할인쿠폰</option>
						<option value="choose">60% OFF 할인쿠폰</option>
						<option value="choose">70% OFF 할인쿠폰</option>
						<option value="choose">30% OFF 할인쿠폰 (회원가입 이벤트)</option>
						<option value="choose">10000원 할인쿠폰 (회원가입 이벤트)</option>
						<option value="choose">50% OFF 할인쿠폰 (생일 이벤트)</option>
					</select>
				</div>
			</div>
			<!-- 유효기간 -->
			<div class="form-group">
				<h5 for="coupon_period" class="tap1">쿠폰기간</h5>
				<div class="tap2">
					<input type="text" name="coupon_period" class="form-control" value="" />
				</div>
			</div>
			<!-- 쿠폰 사용시작일 -->
			<div class="form-group">
				<h5 for="coupon_start" class="tap1">쿠폰사용시작</h5>
				<div class="tap2">
					<input type="text" name="coupon_start" class="form-control" value="" />
				</div>
			</div>
			<!-- 쿠폰 사용마감일 -->
			<div class="form-group">
				<h5 for="coupon_end" class="tap1">쿠폰사용마감</h5>
				<div class="tap2">
					<input type="text" name="coupon_end" class="form-control" value="" />
				</div>
			</div>
			<!-- 쿠폰 연장 -->
			<div class="form-group">
				<h5 for="coupon_extend" class="tap1">쿠폰연장</h5>
				<div class="tap2">
					<input type="text" name="coupon_extend" class="form-control" value="" />
				</div>
			</div>
			<div class="form-button">
				<input type="submit" class="btn btn-default pull-right" style="background-color: #9FFBF4; font-weight: bold; margin-right: -3%; margin-left: 2%; height: 48px; font-size: 20px;" value="등록하기">
				<a href="admin_index.jsp" class="btn btn-default btn-lg pull-right" style="font-weight: bold; color: white; background-color: rgb(11, 103, 255);">관리자 홈</a>
			</div>
		</form>
	</div>
</body>
</html>