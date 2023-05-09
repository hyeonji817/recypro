<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	width: auto;
	position: relative;
	min-height: 40%;
	bottom: 5%;
}

.sub_title {
	font-weight: bold;
	text-align: center;
	color: black;
	font-size: 26px;
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

ul {
	list-style: none; /** 목록 리스트 중에서 점을 없애는 스타일 방식 */
}

.consumer_list1 li {
	padding: 0; 
	width: 10%;
	position: relative;
	margin: 0 auto;
	float: left;
	padding-left: 25%;
	padding-top: 3%;
	display: block;
	text-align: center;
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
</style>
</head>
<body>
	<%
		String id = request.getParameter("id");
		PrintWriter script = response.getWriter();	
		
		if (session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
	%>
	<%@ include file="../01_main/index.jsp"%>
	<%
		} else {
	%>
	<%@ include file="../01_main/index_top.jsp"%>
	<%
		}
	%>

	<!-- 제목 -->
	<div class="title">
		<div class="container">
			<h1 class="display-3"
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">고객센터</h1>
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
</body>
</html>