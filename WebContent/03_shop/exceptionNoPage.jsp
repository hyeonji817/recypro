<!-- 참고한 웹 페이지 주소 좌표 : https://kjh95.tistory.com/267?category=941468 -->
<!-- 해당 페이지를 설정한 에러 안내 페이지로 변경하게 하는 서비스 제공하는 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 아이디 오류</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<style>
	.container-3 {
		margin-top: 17%;
	}
	
	.container {
		margin: 0 auto;
	}
	
	.url {
 		margin-top: 12%; 
 		margin-left: -12%;
/* 		margin: 0 12%; */
		width: 100%;
	}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp" %>
	
	
		<div class="container-3">
			<h2 class="alert alert-danger" style="width: 100%; margin: 0 auto;">요청하신 페이지를 찾을 수 없습니다.</h2>
		</div>
	
	
	<div class="container">
		<!-- 요청 URL을 표시 -->
		<p class="url" style="top: 10%;"><%=request.getRequestURL() %></p>
		<p><a href="Products.jsp" class="btn btn-secondary btn-lg" style="margin-left: -12%;">상품 목록 &raquo;</a></p>
	</div>
</body>
</html>