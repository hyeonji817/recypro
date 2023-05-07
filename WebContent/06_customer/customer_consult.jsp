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
<title>재활용품 전문점 : 리싸이프로 - 고객센터_온라인 상담문의</title>
<style>
.title {
	margin-top: 11%;
	height: 150px;
	margin-bottom: 5%;
}

.display-3 {
	margin-left: 10px;
	color: black;
	position: relative;
	font-weight: bold;
	left: -17%;
	font-size: 55px;
}

.sub_content {
	margin: 0 auto;
	width: auto;
	position: relative;
	min-height: 40%;
	bottom: 5%;
}

.sub_title {
	font-weight: bold;
	text-align: center;
	color: black;
	margin: 0 auto;
	width: 500px;
}

.sub_title h2 {
	font-weight: bold;
	font-size: 26px;
}

.sub_title2 {
	text-align: center;
	color: grey;
	position: relative;
	margin-top: -1%;
	margin: 0 auto;
	width: 700px;
}

.sub_title2 h3 {
	font-size: 22px;
	font-weight: bold;
}

.consumer_info {
	margin: 0 auto;
	padding: 0;
	width: 1000px;
}

.consumer_list1 {
	width: 900px;
	min-height: 220px; 
	margin: 0 auto;
}

.consumer_list1 li {
	padding: 0; 
	width: 10%;
	position: relative;
	margin: 0 auto;
	float: left;
	padding-left: 25%;
	padding-top: 3%;
/* 	display: block; */
	text-align: center;
}

.notice {
	display: block;
	margin: 0 auto;
	position: relative;
	
}

.notice_text {
	width: 80px;
	left: 16%;
	position: relative;
	height: 15px; 
	display: block;
	margin-top: 2%;
	text-align: center;
}

.policy_text {
	width: 80px;
	left: 16%;
	position: relative;
	height: 15px; 
	display: block;
	margin-top: 2%;
	text-align: center;
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


#consultant {
	margin: 0 auto; 
	display: block; 
	position: relative; 
	top: 20%;
	width: 1200px; 
	min-height: 45%;
	background: #eee;
	margin-bottom: 10%;
}

#consultant h1 {
	text-align: center; 
	position: absolute; 
	right: 40%; 
	font-weight: bold;
	top: 3%;
}

.write_area {
	display: block; 
	width: 1000px; 
/* 	background: green; */
	margin: 0 auto;
	min-height: 300px; 
	position: relative; 
	top: 100px;
	margin-bottom: 100px;
}

#write_consult {
	display: block; 
	margin: 0 auto; 
	position: relative;
	width: 800px; 
}

#write_consult input {
	margin: 0 auto; 
	position: relative; 
	right: 1%;
	display: block;
	width: 700px; 
	height: 40px; 
	top: 30px;
	border: 1px solid black;
}

#write_consult textarea {
	margin: 0 auto; 
	position: relative;
	right: -5.3%;
	top: 40px;
	width: 700px;
	height: 140px;
	border-radius: 5px;
}

.submit_write button {
	margin: 0 auto;
	position: relative; 
	right: 92%;
	top: 70px;
}

.policy_button {
	margin-top: 10%;
	position: relative; 
	top: 22%;
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
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd; width: 1200px;">고객센터 - 온라인 상담/문의</h1>
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
	
	<!-- 문의글 작성 -->
	<div class="consult_write" id="consultant">
		<h1>문의글 작성</h1>
		<div class="write_area">
			<form action="write_ok.jsp" name="cw_form" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" value="" />
				<!-- 나만의 방식 (목업 참고) -->
				<div class="form-group" id="write_consult">
					<input name="write_title" id="write_title" class="form-control" type="text" placeholder="제목" />
					<textarea name="write_content" id="write_content" type="text" placeholder="내용을 입력해주세요."></textarea>
					<a class="submit_write" style="position: relative; left: 9.3%;">
						<button type="submit">첨부파일</button>
					</a>
				</div>
				
				<!-- 참고했던 내용 -->
				<!-- <div class="wi_line"></div>
				<div class="in_text">
					<textarea name="qa_text" placeholder="내용" required></textarea>
				</div>
				<div class="in_text in_date">
					<input type="file" name="qa_file" />
				</div>
				<div class="bt_se">
					<button type="submit">글 작성</button>
				</div> -->
			</form>
		</div>
	</div>
	
	<!-- 버튼 영역 -->
	<div class="policy_button">
		<a class="btn btn-default btn-lg" style="background-color: #b6f5f5; position: relative; right: 70%;">
			<span class="register">신청하기</span>
		</a>
		<a class="btn btn-default btn-lg" style="background-color: #b6f5f5; position: relative; right: 22%;">
			<span class="customer_home">고객센터 홈</span>
		</a>
		<a href="customer_consultList.jsp" class="btn btn-default btn-lg" style="background-color: #b6f5f5; position: relative; right: -5%;">
			<span class="quest_list">문의글 목록</span>
		</a>
	</div>
</body>
</html>