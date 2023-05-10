<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="product.beans.Product" %>
<%@ page import="product.beans.ProductRepository" %>
<%@ page import="pd_review.beans.pd_Review" %>
<%@ page import="pd_review.beans.pd_ReviewDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %><!-- 게시판의 목록을 출력하기 위해서 필요 -->
<jsp:useBean id="product" class="product.beans.Product" scope="page" />
<jsp:setProperty name="product" property="*" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 화면 최적화 -->
<meta name="viewport" content="width-device-width", initial-scale="1">
<!-- 루트 폴더에 부트스트랩을 참조하는 링크 -->
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<title>재활용품 전문점 : 리싸이프로 - 상품 리뷰확인</title>
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
	
	.review {
		position: relative;
		left: 30%;
		width: auto;
		top: 10%;
		margin-bottom: 20%;
	}
	
	.container {
		margin-top: 100px;
	}
	
	.display-3 {
		margin-top: 50px;
		font-weight: 700;
		color: gray;
		width: 400px; 
		position: relative; 
		right: 22%;
		text-shadow: 1px 1px 5px #bdbdbd;
	}
	
	.button {
		margin-top: 30px;
		position: relative;
		right: -92%;
	}
</style>
</head>

<body>
	<%
		// 한글처리, 파라미터 (세션생성)
		request.setCharacterEncoding("UTF-8");
	
		// id값의 존재유무를 통해 로그인되어 있는지 사전검문 
		String id = null;
		PrintWriter script = response.getWriter();
		String pd_userId = (String)session.getAttribute("pd_userId");
		
		if (session.getAttribute("id") != null) {
			id = (String)session.getAttribute("id");
			// pd_userId = (String)session.getAttribute("pd_userId");
			script.println("location.href = '../03_shop/Product_Review.jsp'");
		}
		
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크 
		// String pd_userId = null;	// pd_userId라는 선언했던 클래스 변수에 사용자 이름값이 들어가게 하기 위해 세팅함
		// 수정.ver (feat.챗GPT)
		pd_userId = request.getParameter("pd_userId");
		if (session.getAttribute("pd_userId") != null) {
			pd_userId = (String)session.getAttribute("pd_userId");
		} else {
			System.out.println("세션에 pd_userId 속성이 설정되어 있지 않습니다.");
		}
		
		System.out.println(id);		// witch0817
		System.out.println(pd_userId);		// 요 부분에서 null이 뜨넹..
		
		// 가장 기본 페이지 1로 설정 
		int pageNumber = 1; 
		
		// 만약 파라미터로 넘어온 오브젝트 타입 'pageNumber'가 존재한다면 
		// 'int'타입으로 캐스팅을 해 주고 그 값을 'pageNumber' 변수에 저장 
		if (request.getParameter("pageNumber") != null) {
			// 정수형으로 타입 변경해 주는 부분 
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

	<!-- 게시판 메인 페이지 영역 시작 -->
	<div class="container">
		<div class="title">
			<div class="title_main">
				<h1 class="display-3">상품 리뷰</h1>
			</div>
		</div>
		
		<div class="row">
			<table class="table" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>	<!-- 테이블의 행, 한 줄 -->
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<!-- <th style="background-color: #eeeeee; text-align: center;">별점 수</th> -->
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">상품명</th>
						<th style="background-color: #eeeeee; text-align: center;">사용자 ID명</th>
						<th style="background-color: #eeeeee; text-align: center;">작성일</th>
					</tr>
				</thead>
				<tbody><!-- 게시글 업로드 될 부분 -->
					<%
						pd_ReviewDAO pd_Dao = new pd_ReviewDAO();	// 게시글을 뽑아올 수 있도록 인스턴스 생성
						ArrayList<pd_Review> list = pd_Dao.getList(pageNumber);

						for (int i = 0; i<list.size(); i++) {
							// 모든 게시글 불러옴
							%>
							<tr>
							<td><%= list.get(i).getPd_reviewId() %></td>	<!-- 게시글 번호 리턴, 게시글 제목을 누르면 해당 글을 볼 수 있도록 링크를 걸어둠 -->
							<% System.out.println(pd_userId); %>	<!-- null -->
							<!-- <td></td> -->
							<td>
								<a href="../03_shop/Product_reviewView.jsp?pd_reviewId=<%=list.get(i).getPd_reviewId()%>">	<!-- 숫자 -->								
									<% System.out.println(list.get(i).getPd_reviewId());%>	<!-- null -->
									<%= list.get(i).getPd_reviewTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>;") %>
								</a>
							</td>							
							<!-- pd_UserId 리턴 -->
							
							<td><%=list.get(i).getPd_productId().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;")
		 					.replaceAll(">", "&gt;").replaceAll("\n", "<br>;")%></td> 
							<!-- 제목을 눌렀을 때 해당 게시물로 이동, 해당번호에 맞는 페이지가 나올 수 있도록 함. 게시글 제목 리턴 -->

							<td><%=list.get(i).getPd_userid() %></td>	<!-- null -->

							
							<td><%--<%=list.get(i).getPd_reviewDate().substring(0,11) + list.get(i).getPd_reviewDate().substring(11,13) + ":" + 
							list.get(i).getPd_reviewDate().substring(14,16)--%>
								<%=list.get(i).getPd_reviewDate().substring(0,11) %>
							</td>
							
							<!-- 작성시간 리턴 -->
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
			<a href="../03_shop/Product_Review.jsp?pageNumber=<%=pageNumber - 1%>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				} 
			
			
				if (pd_Dao.nextPage(pageNumber + 1)) {	// 다음 페이지가 존재하는지
			%>
			<a href="../03_shop/Product_Review.jsp?pageNumber=<%=pageNumber + 1%>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
				
				
			%>
			<!-- 글쓰기 버튼 생성 -->
			<div class="button">
				<a href="../03_shop/Products.jsp" class="btn btn-default pull-right" style="color: black; position: right; background-color: #b6f5f5; font-weight: bold;">상품 목록</a>
			</div>
		</div>
	</div>
	<!-- 게시판 메인 페이지 영역 끝 -->
	
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="../js/bootstrap.js"></script>
</body>
</html>