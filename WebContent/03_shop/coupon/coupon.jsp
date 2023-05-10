<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
<title>쿠폰페이지 UI</title>
<style>
.container {
	width: 800px;
	margin: 0 auto; 
	position: relative; 
	margin-top: 10%;
	height: 500px;
	display: block;
	background-color: rgb(248, 244, 85);
}

.coupon_title h3 {
	font-weight: bold;
	position: relative; 
	padding-top: 3%;
	left: 2%;
	font-size: 36px;
}

.coupon_img {
	width: 400px; 
	margin: 0 auto; 
	position: relative; 
	display: block; 
	background-color: #eee;
	height: 350px;
	margin-top: 3%;
}

.10percent_off h3 {
	text-align: center;
	display: inline-block;
	position: relative; 
}

.adjust_button {
	position: relative; 
	margin: 0 auto; 
	display: block; 
	left: 45%; 
	margin-top: 4%;
}
</style>
</head>
<body>
	<div class="container">
		<div class="coupon_title">
			<h3>리싸이프로</h3>
		</div>
		<div class="coupon_img">
			<span class="recycle">
				<img src="/recypro/img/shopdetail/recycle_2.jpg" />
			</span>
			<div class="dollar">
				<img src="/recypro/img/shopdetail/dollar.jpg" />
			</div>
			<div class="10percent_off">
				<h3>10% OFF</h3>
			</div>
		</div>
	</div>
	
	<div class="adjust_button">
		<a href="#" class="btn btn-default btn-lg" style="font-weight: bold; color: black; background-color: #b6f5f5; margin: 0 auto;">
			쿠폰 적용하기
		</a>
	</div>
</body>
</html>