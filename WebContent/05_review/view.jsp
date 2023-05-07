<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="review.beans.Review"%>
<%@ page import="review.beans.ReviewDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 어느 기기에서도 맞춤으로 보이는 반응형 웹에 사용되는 기본 Meta Tag -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,
minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>재활용품 전문점 : 리싸이프로 - 게시판 글 내용보기</title>
<%@ include file="../01_main/index.jsp"%>
<style>
.row {
	margin-top: 100px;
}

.button {
	position: relative;
	float: right;
	right: -84%;
}

.button a {
	color: white;
}
</style>
</head>
<body>
	<%
		String id = (String) session.getAttribute("id");		// 세션에 연결된 id값 호출 (로그인이 잘 되어 있는지 검문하기 위함)
		String userId = null;		// 사용자의 아이디 
		System.out.println(id);
		System.out.println(userId);
		// 로그인한 사용자들일 경우, userId에 값이 담기게 됨
		if (!id.equals(null)) {
			userId = (String) session.getAttribute("id"); // 로그인한 사람들은 해당 아이디가 userId에 저장
		}
		System.out.println(id);
		System.out.println(userId);
		int reviewId = 0;
		if (request.getParameter("reviewId") != null) {
			reviewId = Integer.parseInt(request.getParameter("reviewId")); // 게시글 번호 받아오기
		}

		if (reviewId == 0) { // 번호가 반드시 존재하는지 확인
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'review.jsp'"); // 다시 게시글 페이지로 이동
			script.println("</script>");
		}

		Review review = new ReviewDAO().getReview(reviewId); // 유효한 글이라면 구체적인 정보를 review에 담음
	%>
	<!-- 전반적인 웹 사이트 구성을 나타내는 네비게이션 -->
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="../05_review/review_main.jsp">JSP
				게시판 웹 사이트</a>
		</div>

		<div class="collapse navbar-collapse"
			id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="../05_review/review_main.jsp">메인</a></li>
				<li class="active"><a href="review.jsp">게시판</a></li>
			</ul>
			<%
				// 아무도 로그인 되어있지 않을 때만 로그인/회원가입 메뉴를 보이게 하기 위함
				if (userId == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-hasgroup="true"
					aria-expanded="false">접속하기 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="../02_account/login.jsp">로그인</a></li>
						<li><a href="../02_account/register.jsp">회원가입</a></li>
					</ul></li>
			</ul>
			<%
				} else { // 로그인이 되어있는 사용자가 보는 메뉴
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown"><a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-hasgroup="true"
					aria-expanded="false">회원관리 <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="../02_account/logoutAction.jsp">로그아웃</a></li>
					</ul></li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>

	<!-- 게시판 글 보이는 부분 -->
	<div class="container">
		<div class="row">
			<table class="table"
				style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">게시판 글
							보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 200px">글 제목</td>
						<td colspan="2"><%=review.getReviewTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
					.replaceAll("\n", "<br>;")%>
						</td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=review.getUserId()%></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%=review.getReviewDate().substring(0, 11) + review.getReviewDate().substring(11, 13) + ":"
					+ review.getReviewDate().substring(14, 16)%>
						</td>
					</tr>
					<tr>
						<td>글 내용</td>
						<!-- 특수문자/공백 등 입력 시 처리하는 과정에서 기본 HTML 코드와 구분이 안 되기 때문에 정상적으로 보이도록 문자를 대체함 -->
						<td colspan="2" style="min-height: 200px; text-align: left;">
							<%=review.getReviewContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&it;")
					.replaceAll(">", "&gt;").replaceAll("\n", "<br>;")%>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="button">
				<a href="review.jsp" class="btn btn-default btn-lg" style="background-color: #9FFBF4; float: right; position: relative; color: black; font-weight: bold; right: 240%;">목록</a>
				
				<%
					if (id != null) {
				%>
				<form name="ViewModify" id="ViewModify" action="modify.jsp?reviewId=<%=reviewId%>" style="float: right; position: relative; right: 135%;" method="post">		
						<a>
						<button id="modify" class="btn btn-info" name="viewvalueforward" value="<%=userId%>" onclick="ClickModify()" style="width: 72px; height: 48px; font-size: 20px; padding-top: 10%; font-weight: bold;">
						수정</a>
				</form>
				<%
					}
				%>
				<a href="#" type="submit" class="btn btn-default btn-lg" style="background-color: #9FFBF4; color: black; position: relative; right: -140%; bottom: 115%; width: 130px; height: 48px; padding-top: 14%; font-weight: bold;">신고하기</a>
				<a href="#" class="btn btn-default btn-lg" style="background-color: #9FFBF4; color: black; position: relative; right: -440%; bottom: 262%; width: 130px; height: 48px; padding-top: 14%; font-weight: bold;">삭제하기</a>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		function ClickModify() {
			document.ViewModify.submit();
			alert("ae~"); 
		}
	</script>
	<script src="js/bootstrap.js"></script>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

</body>
</html>