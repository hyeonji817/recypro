<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="pd_review.beans.pd_Review" %>
<%@ page import="pd_review.beans.pd_ReviewDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 어느 기기에서도 맞춤으로 보이는 반응형 웹에 사용되는 기본 Meta Tag -->
<meta name="viewport" content="width=device-width, initial-scale=1.0,
minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>재활용품 전문점 : 리싸이프로 - 상품페이지 리뷰확인 페이지</title>
<%@ include file="../01_main/index.jsp" %>
<style>
	.container {
		
	}

	.row {
		margin-top: 17%;
	}
	
	.button {
		position: relative;
		float: right;
		right: -73%;
		width: 450px;
	}
	
	.button a {
		color: black;
	}
	
	.pd_md:nth-child(2) {
		position: relative; 
		float: right; 
		right: -3%;
	}
</style>
</head>
<body>
	<%
		String id = (String)session.getAttribute("id");
		String pd_userId = null;		// 사용자의 아이디
		
		// 로그인한 사용자들일 경우, pd_userId에 값이 담기게 됨
		if (!id.equals(null)) {
			pd_userId = (String) session.getAttribute("id");	// 로그인한 사람들은 해당 아이디가 userId에 저장
		}
		
		int pd_reviewId = 0;
		if (request.getParameter("pd_reviewId") != null) {
			pd_reviewId = Integer.parseInt(request.getParameter("pd_reviewId")); // 게시글 번호 받아오기
		}		

		if (pd_reviewId == 0) {	// 번호가 반드시 존재하는지 확인
			PrintWriter pw = response.getWriter();
			pw.println("<script>");
			pw.println("alert('유효하지 않은 글입니다.')");
			pw.println("location.href = '../03_shop/Product_Review.jsp'");	// 다시 게시글 페이지로 이동
			pw.println("</script>");
		} 
	
		System.out.println(pd_reviewId);			
		pd_Review pd_review = new pd_ReviewDAO().getPd_Review(pd_reviewId);		// 유효한 글이라면 구체적인 정보를 pd_review에 담음

	%>
	
	<!-- 게시판 글 보이는 부분 -->
	<div class="container">
		<div class="row">
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr><th colspan="3" style="background-color: #eeeeee; text-align: center;"> 상품리뷰 게시판 글 보기 </th></tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 200px">글 제목</td>
						<td colspan="2">
							<%=pd_review.getPd_reviewTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>;")%>
						</td>
					</tr>
					<!-- <tr>
						<td>평점 수</td>
						<td colspan="2"></td>
					</tr> -->
					<tr>
						<td>작성자</td>
						<td colspan="2"><%=pd_review.getPd_userid() %></td>
					</tr>
					<!-- <tr>
						<td>상품사진</td>
						<td colspan="2"></td>
					</tr> -->
					<tr>
						<td>작성일자</td>
						<td colspan="2">
							<%=pd_review.getPd_reviewDate().substring(0,11) + pd_review.getPd_reviewDate().substring(11,13) + ":" + pd_review.getPd_reviewDate().substring(14,16) %>
						</td>
					</tr>
					<tr>
						<td>상품명</td>
						<td colspan="2">
							<%=pd_review.getPd_productId() %>
						</td>
					</tr>
					<tr>
						<td>글 내용</td>
						<!-- 특수문자/공백 등 입력 시 처리하는 과정에서 기본 HTML 코드와 구분이 안 되기 때문에 정상적으로 보이도록 문자를 대체함 -->
						<td colspan="2" style="min-height: 200px; text-align: left;">
							<%=pd_review.getPd_reviewContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&it;").replaceAll(">", "&gt;").replaceAll("\n", "<br>;") %>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="button">
				<a href="../03_shop/Product_Review.jsp" class="btn btn-default" style="background-color: #b6f5f5; color: black; font-weight: bold;">상품 리뷰목록</a>
<!-- 				<a href="../03_shop/Product_Review.jsp" class="btn btn-default" style="background-color: #9FFBF4; color: black; font-weight: bold;">상품 리뷰목록</a> -->
				<!-- <a href="#" class="btn btn-default" style="background-color: #b6f5f5; color: black; font-weight: bold;">신고하기</a> -->
				<a onclick="confirm('정말로 삭제하시겠습니까?')" href="pd_deleteAction.jsp?pd_reviewId=<%=pd_reviewId%>" 
				class="btn btn-default" style="background-color: #b6f5f5; color: black; font-weight: bold;">삭제하기</a>
				<%
				// 현재 접속한 사람이 글 작성자라면 수정/삭제 가능하도록 수정 버튼 보이기
					if (id != null) {
				%>
				<form name="pd_ViewModify" id="pd_ViewModify" action="../03_shop/pd_modify.jsp?pd_reviewId=<%=pd_reviewId%>" style="width: 120px; float: right; right: 24.5%; position: relative;" method="post">
					<a class="pd_md">
						<button id="pd_modify" class="btn btn-default" style="background-color: #b6f5f5;" name="pd_viewvalue" value="<%=pd_userId%>" onclick="ClickModify()">
						<b>수정하기</b>
					</a>
				</form>
				<%
					}
				%>
				
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
	<script type="text/javascript">
		function ClickModify() {
			document.pd_ViewModify.submit();
		}
	</script>
</body>
</html>