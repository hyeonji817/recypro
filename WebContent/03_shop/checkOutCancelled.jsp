<!-- 참고한 웹 페이지 주소좌표 : https://kjh95.tistory.com/284?category=941468 -->
<!-- 주문취소 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 취소</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<style>
.display-3 {
	margin-top: 17%;
	font-weight: 700;
	margin-bottom: 12%;
}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>

	<div class="container">
		<h1 class="display-3">주문 취소</h1>
	</div>


	<div class="container">
		<h2 class="alert alert-danger" style="bottom: 10%;">주문이 취소되었습니다.</h2>
	</div>

	<div class="container">
		<p>
			<a href="Products.jsp" class="btn btn-secondary btn-lg" style="color: white; font-weight: 700; margin-top: 7%;">&laquo;
				상품 목록</a>
		</p>
	</div>
</body>
</html>