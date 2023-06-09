<%@page import="question.beans.questionDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="question.beans.Question" %>
<%@ page import="question.beans.questionDAO" %>

<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>
<jsp:useBean id="user" scope="session" class="user.beans.User" />
<jsp:useBean id="Question" class="question.beans.Question" scope="page" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<!-- bootstrap -->
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
<title>재활용품 전문점 : 리싸이프로 - 고객센터_자주묻는질문</title>
<style>
.title {
	margin-top: 17%;
	height: 150px;
	margin-left: 8%;
}

.display-3 {
	margin-left: -2%;
	color: black;
	right: 25%;
	margin-top: -2%;
	position: relative;
	font-weight: bold;
	font-size: 55px;
}

.button {
	margin-top: 30px;
	right: -84%;
}
</style>
</head>
<body>
<%@ include file="../01_main/index.jsp" %>
	
	<!-- 제목 -->
	<div class="title">
		<div class="container">
			<h1 class="display-3"
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">자주묻는질문</h1>
		</div>
	</div>
	
	<!-- 자주묻는질문 리스트 영역 내용 -->
	<div class="row">
		<table class="table" style="border: 1px solid #dddddd; width: 1000px; margin: 0 auto;">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">번호</th>
					<th style="background-color: #eeeeee; text-align: center;">제목</th>
					<th style="background-color: #eeeeee; text-align: center;">답변</th>
				</tr>
			</thead>
			<tbody> 
				<%
					int pageNum = 1; 
					if (request.getParameter("pageNum") != null) {
						// 정수형으로 타입 변경해주는 부분 
						pageNum = Integer.parseInt(request.getParameter("pageNum"));
					}
					
					questionDAO queDao = new questionDAO();		// 질문글을 뽑아올 수 있도록 인스턴스 생성 (클래스를 객체화)
					ArrayList<Question> list = queDao.getList(pageNum);
					
					for (int i = 0; i<list.size(); i++) {
				%>
				<tr>
					<!-- 질문글 번호 리턴 -->
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						<%= list.get(i).getQuestion_num() %>
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						<a href="question_view.jsp?question_num=<%=list.get(i).getQuestion_num()%>"><%=list.get(i).getQuestion_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
						.replaceAll(">", "&gt;").replaceAll("\n", "<br>;")%></a>
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="question_view.jsp?question_num=<%=list.get(i).getQuestion_num()%>" class="btn-btn-info" style="background-color: #9FFBF4; display: inline-block; width: 90%; font-size: 16px; font-weight: bold;">조회하기</a>
					</td>
				</tr>
				<%
					}
				%>
				
				<%
					// 페이지 넘버 보여주는 부분 
					if (pageNum != 1) {
				%>
				<a href="customer_question.jsp?pageNum=<%=pageNum - 1%>" class="btn btn-success btn-arrow-left">이전</a>
				<%
					} if (queDao.nextPage(pageNum + 1)) {	// 다음 페이지가 존재하는지
				%>
				<a href="customer_question.jsp?pageNum=<%=pageNum + 1%>" class="btn btn-success btn-arrow-left">다음</a>
				<%
					}
				%>
				<!-- <tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						1
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						회원탈퇴 후 보유 쿠폰은 어떻게 되나요?
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="customer_answer1.jsp" class="btn btn-default" style="background:#eee; text-align: center;">조회</a>
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						2
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						구매확정이 뭐예요?
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="customer_answer2.jsp" class="btn btn-default" style="background:#eee; text-align: center;">조회</a>
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						3
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						배송 온 상품이 변질되었을 경우, 어떻게 해결하나요?
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="customer_answer3.jsp" class="btn btn-default" style="background:#eee; text-align: center;">조회</a>
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						4
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						반품이 안 되는 경우도 있나요?
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="customer_answer4.jsp" class="btn btn-default" style="background:#eee; text-align: center;">조회</a>
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						5
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						반품/교환 신청을 했는데 처리 소요시간이 얼마나 되나요?
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="customer_answer5.jsp" class="btn btn-default" style="background:#eee; text-align: center;">조회</a>
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						6
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						현금 환불요청을 했는데 환불은 언제 되나요?
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="customer_answer6.jsp" class="btn btn-default" style="background:#eee; text-align: center;">조회</a>
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						7
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						주문 후 배송기간은 얼마나 걸리나요?
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="customer_answer7.jsp" class="btn btn-default" style="background:#eee; text-align: center;">조회</a>
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						8
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						퀵 발송도 해 주나요?
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="customer_answer8.jsp" class="btn btn-default" style="background:#eee; text-align: center;">조회</a>
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						9
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						품절 문자가 왔어요!
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="customer_answer9.jsp" class="btn btn-default" style="background:#eee; text-align: center;">조회</a>
					</td>
				</tr>
				
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						10
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						주문메세지에 메모를 남겼어요
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						<a href="customer_answer10.jsp" class="btn btn-default" style="background:#eee; text-align: center;">조회</a>
					</td>
				</tr> -->
				
			</tbody>
		</table>
	</div>
	
	<!-- 고객센터 홈 버튼 생성 -->
	<div class="button">
		<a href="customer_main.jsp" class="btn btn-default pull-right" style="color: black; background-color: #b6f5f5; margin-right: 24%; float: right; font-weight: bold;">고객센터 홈</a>
	</div>
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>