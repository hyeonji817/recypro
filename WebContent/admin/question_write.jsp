<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>    
    
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.PreparedStatement"%>

<jsp:useBean id="user" scope="session" class="user.beans.User" />
<jsp:useBean id="question" class="question.beans.Question" scope="page" />    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="../css/bootstrap.css">
<title>재활용품 전문점 : 리싸이프로 - 고객센터_자주묻는질문 작성하기</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
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
.title {
	margin-top: 7%;
	height: 150px;
}

.display-3 {
	margin-left: 6%;
	color: black;
	position: relative;
	font-weight: bold;
	font-size: 55px;
	top: 30px;
	display: block;
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
			pw.println("location.href='../admin/notice_write.jsp'");
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
		<div class="container_title">
			<h1 class="display-3" style="font-weight: bold; text-shadow: 1px 1px 5px #bdbdbd;">고객센터 - 자주묻는질문_작성하기</h1>
		</div>
	</div>
	
	<!-- 자주묻는질문 글쓰기 양식 영역 시작 -->
	<div class="container">
		<div class="row" id="write" style="width: 800px; margin: 0 auto; position: relative;">
			<form method="post" action="question_Action.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; width: 800px; text-align: center;">질문글 글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<input type="text" class="form-control" placeholder="글 제목" name="question_title" maxlength="50"  style="width:800px">
							</td>
						</tr>
						<tr>
							<td>
								<textarea class="form-control" placeholder="글 내용" name="question_content" maxlength="2048" style="min-height: 500px; width:800px;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				
				<!-- 글쓰기 버튼 생성 -->
				<span class="submit">
					<input type="submit" class="btn btn-default pull-right" style="background-color: #9FFBF4; font-weight: bold;" value="글쓰기">
					<%
						PrintWriter script = response.getWriter();
					
						if (session.getAttribute("id") != null) {
							id = (String)session.getAttribute("id");
					%>
					<input type="submit" class="btn btn-default pull-right" style="background-color: #9FFBF4; font-weight: bold;" value="수정하기">
					<%
						} else {
							script.println("location.href = '../02_account/login.jsp'");
						}
					%>
					<a href="#" class="btn btn-default pull-right" style="background-color: #9FFBF4; color: black; font-weight: bold;">취소하기</a>
				</span>
			</form>
		</div>
	</div>
	<!-- 게시판 글쓰기 양식 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>