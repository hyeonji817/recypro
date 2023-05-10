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
<title>재활용품 전문점 : 리싸이프로 - 고객센터_공지사항 답변2</title>
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

/** 답변 영역 */ 
.question_answer {
	margin: 0 auto; 
	position: relative; 
	display: block; 
	width: 800px;
}

#answer {
	position: relative;
/* 	right: 45%; */
}

/** 버튼 영역 */
.button {
	margin-top: 30px;
	position: relative;
	right: 29%;
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
	
	<!-- 자주묻는질문 답변 양식 영역 시작 -->
	<div class="question_answer">
		<div class="row" id="answer">
			<form method="post" action="#">
				<table class="table" style="border: 1px solid #dddddd">
					<tbody>
						<tr>
							<td>
<!-- 								제목 -->
								<input type="text" class="form-control" placeholder="품절 문자가 왔어요!" name="question_title" maxlength="50" style="width: 500px;">
							</td>
						</tr>
						<tr>
							<td>
								안녕하세요~ 리싸이프로입니다. <br>
								요청하신 질문 확인했습니다. <br><br> 
								
								품절 문자를 받으셨다면 구매신청한 상품의 재고가 없거나 생산이 중단된 제품이에요ㅠ.ㅠ <br>
								일정 금액의 환급 받으시거나 다른 상품으로 교환하실 수 있습니다. <br>
								환불도 가능하시구요~ <br><br> 
								
								제작 상품이기에 원단품절, 부자재품절로 생산이 불가능한 일이 종종 있으니 양해 부탁드립니다^^; <br><br> 
								
								게시판이나 고객센터로 문의요청하시면 원하시는대로 처리 해드리겠습니다. <br>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>
	
	<!-- 고객센터 홈 버튼 생성 -->
	<div class="button">
		<a href="history.back();" class="btn btn-default pull-right" style="color: black; background-color: #b6f5f5; margin-right: 6%; float: right; font-weight: bold;">이전페이지</a>
		<a href="customer_main.jsp" class="btn btn-default pull-right" style="color: black; background-color: #b6f5f5; margin-right: -11.5%; float: right; font-weight: bold;">고객센터 홈</a>
	</div>
</body>
</html>