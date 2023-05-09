<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="review.beans.Review" %>
<%@ page import="review.beans.ReviewDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %><!-- 게시판의 목록을 출력하기 위해서 필요 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<title>재활용품 전문점 : 리싸이프로 - 게시판</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
	
	.title {
		margin-top: 20px;
		height: 120px;
		margin-bottom: 20px;
	}
	
	.container {
		margin-top: 100px;
		right: 20%;
	}
	
	.display-3 {
		margin-top: 50px;
		font-weight: 700;
		color: black;
		text-shadow: 1px 1px 5px #bdbdbd;
	}
	
	.button {
		margin-top: 30px;
		position: relative;
		right: -93%;
		float: right;
	}
	
	.button a {
		font-weight: 700;
	}
</style>
</head>
<body>
<%@ include file="../01_main/index_top.jsp" %>
	<%
		// id값의 존재유무를 통해 로그인 되어 있는지 사전검문
			String id = null;
			PrintWriter script = response.getWriter();
	
			if (session.getAttribute("id") != null) {
				id = (String)session.getAttribute("id");
				script.println("location.href = '../05_review/review.jsp'");
			} 
	
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크 
			String userId = null;
			if (session.getAttribute("userId") != null) {
				userId = (String)session.getAttribute("userId");	// 로그인한 사람들은 해당 아이디가 userId에 저장
			}
			
			// 가장 기본 페이지 1로 설정 
			int pageNumber = 1;
			
			if (request.getParameter("pageNumber") != null) {
				// 정수형으로 타입 변경해주는 부분
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
	<nav class="navbar navbar-default"> <!-- 네비게이션 메뉴 -->
		<div class="navbar-header">	<!-- 네비게이션 상단 부분 -->
			<!-- 네비게이션 상단 박스 영역 -->
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
			data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<!-- 이 세 줄 버튼은 화면이 좁아지면 우측에 나타남 -->
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<!-- 상단 바에 제목이 나타나고 클릭하면 main 페이지로 이동 -->
<!-- 			<a class="navbar-brand" href="review_main.jsp">JSP 게시판 웹 사이트</a> -->
		</div>
		
		<!-- 게시판 제목 이름 옆에 나타나는 메뉴 영역 -->
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
		<!-- ul은 리스트를 보여줄 때 쓰는 tag -> 안에 원소는 li로 사용 -->
			<ul class="nav navbar-nav">
				<li><a href="../05_review/review_main.jsp">메인</a></li>
				<li class="active"><a href="review.jsp">게시판</a></li>
			</ul>
			<%
				// 로그인하지 않았을 때 보여지는 화면 
					if (userId == null) {
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" 
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->
					<ul class="dropdown-menu">
						<li><a href="../02_account/login.jsp">로그인</a></li>
						<li><a href="../02_account/register.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%
				// 로그인이 되어 있는 상태에서 보여주는 화면 
					} else {
			%>
			<!-- 헤더 우측에 나타나는 드랍다운 영역 -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<!-- 드랍다운 아이템 영역 -->	
					<ul class="dropdown-menu">
						<li><a href="../02_account/logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>
			</ul>
			<%
				}
			%>
		</div>
	</nav>
	<!-- 네비게이션 영역 끝 -->
	
	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div class="title">
			<div class="title_main">
				<h1 class="display-3">게시판</h1>
			</div>
		</div>
		
		<div class="row">
			<table class="table" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>	<!-- 테이블의 행, 한 줄 -->
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
						<th style="background-color: #eeeeee; text-align: center;">조회하기</th>
					</tr>
				</thead>
				<tbody><!-- 게시글 업로드 될 부분 -->
					<%
						ReviewDAO reviewDAO = new ReviewDAO();	// 게시글을 뽑아올 수 있도록 인스턴스 생성
						ArrayList<Review> list = reviewDAO.getList(pageNumber);
									
						for (int i = 0; i<list.size(); i++) {	// 모든 게시글 불러옴
					%>
					<tr>
					<td><%= list.get(i).getReviewId() %></td>	<!-- 게시글 번호 리턴 -->
					<td><a href="view.jsp?reviewId=<%=list.get(i).getReviewId()%>"><%=list.get(i).getReviewTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
					.replaceAll(">", "&gt;").replaceAll("\n", "<br>;")%></a></td>
					<!-- 제목을 눌렀을 때 해당 게시물로 이동, 해당번호에 맞는 페이지가 나올 수 있도록 함. 게시글 제목 리턴 -->
					<td><%= list.get(i).getUserId() %></td> <!-- UserId 리턴 -->
					<td><%= list.get(i).getReviewDate().substring(0,11) + list.get(i).getReviewDate().substring(11,13) + ":" + list.get(i).getReviewDate().substring(14,16)%></td>
					<!-- 작성시간 리턴 -->
					<td>
						<a href="view.jsp?reviewId=<%=list.get(i).getReviewId()%>" class="btn-btn-info" style="background-color: #9FFBF4; display: inline-block; width: 90%; font-size: 16px; font-weight: bold;">조회하기</a>
					</td>
					</tr>
					<%
						}
					%>
				
				</tbody>
			</table>
			<%
				// 페이지 넘버 보여주는 부분
				if (pageNumber != 1) {
			%>
			<a href="review.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} if (reviewDAO.nextPage(pageNumber + 1)) {	// 다음 페이지가 존재하는지
			%>
			<a href="review.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			<!-- 글쓰기 버튼 생성 -->
			<div class="button">
				<a href="write.jsp" class="btn btn-default pull-right" style="color: black; background-color: #9FFBF4;">작성하기</a>
			</div>
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>