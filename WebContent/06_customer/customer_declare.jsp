<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<!-- bootstrap -->
<!-- <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" /> -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
<title>재활용품 전문점 : 리싸이프로 - 고객센터_메인페이지</title>
<style>
.title {
	margin-top: 11%;
	height: 150px;
}

.display-3 {
	margin-left: 5%;
	color: black;
	position: relative;
	font-weight: bold;
	font-size: 55px;
}

.sub_content {
	margin: 0 auto;
	width: 1500px;
	position: relative;
	min-height: 40%;
	bottom: 5%;
}

.sub_title {
	font-weight: bold;
	text-align: center;
	color: black;
}

.sub_title h2 {
	font-size: 26px;
}

.sub_title2 {
	text-align: center;
	color: grey;
	position: relative;
	margin-top: 1%;
}

.sub_title2 h3 {
	font-size: 22px;
}

.consumer_info {
	margin: 0;
	padding: 0;
	margin-top: 5%;
}

.consumer_list1 {
	width: 1500px;
	min-height: 220px; 
	display: block;
}

.consumer_list1 li {
	padding: 0; 
/* 	width: 10%; */
	position: relative;
	margin: 0 auto;
	float: left;
	display: block;
	padding-left: 25%;
	padding-top: 3%;
	text-align: center;
}

.notice {
	position: relative;
	left: 10%;
}

.notice_text {
	width: 80px;
	left: 16%;
	position: relative;
	margin-top: 2%;
	display: block;
	padding-top: 2%;
	height: 15px; 
	text-align: center;
}

.policy_text {
	width: 80px; 
	left: 16%;
	position: relative;
	margin-top: 2%;
}

.consumer_list2 {
	width: auto;
	min-height: 220px; 
}

.consumer_list2 li {
	padding: 0;
	width: 30%; 
	position: relative;
	float: left;
	display: block;
}

.consumer_list2 li:first-child {
	position: relative;
	float: left;
	margin: 0 auto;
	left: 17%;
	margin-top: 6%;
}

.question img {
	width: 100px;
}

.question_text {
	position: relative;
	left: 1%;
	width: 150px;
}

.consumer_list2 li:nth-child(2) {
	position: relative;
	float: left; 
	margin: 0 auto; 
	left: 14%;
	margin-top: 6%;
}

.consult img {
	width: 100px;
}

.consult_text {
	position: relative;
	left: -2%;
	padding-top: 1%;
	width: 150px;
}

.consumer_list2 li:nth-child(3) {
	position: relative;
	float: left;
	right: -10%;
	margin: 0 auto;
	margin-top: 6%;
}

.claim_text {
	position: relative;
	left: 3.5%;
	width: 100px;
}

.declare {
	margin: 0 auto; 
	width: 1200px; 
	position: relative; 
	background: #eee;
	min-height: 50%;
	top: 12%;
	margin-bottom: 300px;
}

.declare h3 {
	display: block;
	font-weight: bold;
	padding-top: 2%;
	left: 4%;
	font-size: 27px;
	position: relative;
}

.declare p {
	display: block; 
	font-size: 22px;
	position: relative; 
	left: 4%; 
}

.policy_button a {
	display: block;
	position: relative; 
	float: right; 
	margin-top: 10%; 
	left: -17%; 
	bottom: 17%; 
	margin-bottom: 20%;
	font-weight: bold; 
	margin: 0 auto;
}

</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>

	<!-- 제목 -->
	<div class="title">
		<div class="container">
			<h1 class="display-3"
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">신고하기</h1>
		</div>
	</div>
	
	<!-- 안내문 -->
	<div class="sub_content">
		<div class="sub_content_in">
			<div class="sub_title" id="tc">
				<h2>고객센터에서 궁금하신 점을 찾아보세요</h2>
			</div>
			<div class="sub_title2" id="tc">
				<h3>궁금하신 점 또는 상품에 대한 질문 내용을 입력해 주시면 상세히 안내해 드립니다.</h3>
			</div>
			<!-- 고객센터 문의 항목 -->
			<div class="consumer_info">
				<ul class="consumer_list1">
					<li>
						<div class="notice">
							<a href="customer_notice.jsp">
								<img src="../img/shop/microphone.png" alt="" title="공지사항" id="notice_misc">
							</a>
							<div class="notice_text">공지사항</div>
						</div>
					</li>
					<li>
						<div class="privacy_law">
							<a href="customer_policy.jsp">
								<img src="../img/shop/privacy_policy.png" alt="" title="운영정책" id="policy">
							</a>
							<div class="policy_text">운영정책</div>
						</div>
					</li>
				</ul>
				<ul class="consumer_list2">
					<li>
						<div class="question">
							<a href="customer_question.jsp">
								<img src="../img/shop/question_1.png" alt="" title="자주 묻는 질문" id="question">
							</a>
							<div class="question_text">자주 묻는 질문</div>
						</div>
					</li>
					<li>
						<div class="consult">
							<a href="customer_consult.jsp">
								<img src="../img/shop/headset_1.png" alt="" title="온라인 상담/문의" id="consult">
							</a>
							<div class="consult_text">온라인 상담/문의</div>
						</div>
					</li>
					<li>
						<span class="claim">
							<a href="customer_declare.jsp">
								<img src="../img/shop/claim.png" alt="" title="신고하기" id="claim">
								<div class="claim_text">신고하기</div>
							</a>
						</span>
					</li>
				</ul>
			</div>
		</div>
	</div>
	
	<!-- 신고하기 기능 정의 -->
	<div class="declare">
		<h3>신고하기란?</h3>
		<p>
			신고하기 기능은 주로 게시판 페이지에서 사용되는 기능으로, <br><br>
			주로 비방글이나 불법 홍보 목적 및 악성 댓글 등을 방지하기 위해 <br><br>
			사용되는 운영정책 중 하나의 기능입니다. <br><br>
			악의적인 목적의 게시글을 발견했을 시, 신고가 가능하며 신고자의 익명처리가 <br><br>
			가능하므로 안심하고 신고하시면 됩니다.
		</p>
	</div>
	<!-- 버튼 영역 -->
	<div class="policy_button">
		<a class="btn btn-default btn-lg" style="background-color: #b6f5f5; position: relative; right: 20%; margin-bottom: 100px; width: 150px; height: 50px; top: -100px; bottom: 17%;">
			<span class="customer_home">고객센터 홈</span>
		</a>
	</div>
</body>
</html>