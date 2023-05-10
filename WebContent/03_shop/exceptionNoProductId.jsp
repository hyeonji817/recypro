<!-- 참고했던 웹 페이지 주소좌표 : https://kjh95.tistory.com/267 -->
<!-- ProductId가 없는 페이지가 넘어올 때 예외처리 예제 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 아이디 오류</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<style>
	.jumbotron {
		top: 20%;
	}
</style>
</head>
<body>
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
	
	<div class="jumbotron">
		<div class="container">
			<h1 class="alert alert-danger">해당 상품이 존재하지 않습니다.</h1>
		</div>
	</div>
	
	<div class="container">
		<!-- 요청 URL을 표시, 요청 파라미터 값도 같이 표시 -->
		<p><%=request.getRequestURL() %>?<%=request.getQueryString() %></p>	<!-- 오류 페이지 출력 -->
		<p><a href="Products.jsp" class="btn btn-success btn-lg" style="color: white;">상품 목록 & raquo;</a></p>
	</div>
</body>
</html>