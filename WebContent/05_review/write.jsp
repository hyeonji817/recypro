<!-- 참고했던 웹 사이트 주소좌표 : https://ee2ee2.tistory.com/21 
|| https://happy-inside.tistory.com/91?category=878524 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="../css/bootstrap.css">
<title>재활용품 전문점 : 리싸이프로 - 게시판 작성하기</title>
<%
	String id = null; 
	if (session.getAttribute("id") != null) {
		id = (String)session.getAttribute("id");
%>
<%@ include file="../01_main/index.jsp" %>
<%
	} else {
%>
<%@ include file="../01_main/index_top.jsp" %>
<%
	}
%>
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
	
	.navbar {
	 	margin-top: 100px;
	}
	
	.navbar navbar-default {
		margin-top: 100px;
		padding-top: 100px;
	}
	
	.table table-striped {
		width: 300px;
	}
	
	.container {
		width: 300px;
		position: center;
		margin-right: 50%;
		margin-top: 300px;
	}
	
	#write {
		position: relative;
		right: 45%;
	}
	
	.submit{
		right: -70%;
		position: relative;	
	}
	
</style>
</head>
<body>
	<!-- <img src="../img/resort.jpg" class="main-img" alt="tip main"> -->
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크 
		String userId = null;
		if(session.getAttribute("userId") != null) {
			userId = (String)session.getAttribute("userId");	// 로그인한 사람들은 해당 아이디가 userId에 저장
		}
	%>
	
	<!-- 게시판 글쓰기 양식 영역 시작 -->
	<div class="container">
		<div class="row" id="write">
			<form method="post" action="writeAction.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; width:800px; text-align: center;">게시판 글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="reviewTitle" maxlength="50" style="width:800px"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용" name="reviewContent" maxlength="2048" style="height: 500px; width:800px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<!-- 글쓰기 버튼 생성 -->
				<span class="submit">
					<input type="submit" class="btn btn-defulat pull-right" style="background-color: #9FFBF4; font-weight: bold;" value="글쓰기">
					<%--
						PrintWriter script = response.getWriter();
					
						if (session.getAttribute("id") != null) {
							id = (String)session.getAttribute("id");
						
					--%>
					<!-- <input type="submit" class="btn btn-default pull-right" style="background-color: #9FFBF4; font-weight: bold;" value="수정하기"> -->
					<%--
						} else {
							script.println("location.href = '../02_account/login.jsp'");
						}
					--%>
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