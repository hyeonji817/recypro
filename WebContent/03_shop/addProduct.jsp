<!-- 출처좌표 : https://kjh95.tistory.com/252?category=941468 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<title>상품 등록</title>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
<style>
	.title {
		margin-top: 120px;
		height: 140px;
	}
	
	.display-3 {
		font-weight: 700;
		color: black;
		position: relative;
		left: -12%;
	}
	
	.col-sm-2 {
		width: 25%;
		display: block;
		float: left;
		font-size: 20px;
		text-indent: 5px;
		font-weight: 700;
	}
	
	.col-sm-6 {
		width: 75%;
		display: block;
		float: left;
	}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp" %>
<!-- 	<img src="../img/moon.jpg" class="main-img" alt="tip main"> -->
	
	<div class="title">
		<div class="container" style="margin-left: 10%;">
			<h1 class="display-3">상품 등록</h1>
		</div>
	</div>
	
	<div class="container" style="margin: 0 auto;">
		<!-- class = "form-horizontal" : 폼 요소들이 수평적으로 배치되도록 해 주는 속성 -->
		<form action="processAddProduct.jsp" name="newProduct" class="form-horizontal"
		method="post" enctype="multipart/form-data">
			<div class="form-group row">
			<!-- 화면크기 768px 이상일 때, col-sm-?이 부분적으로 적용. -->
			<!-- div 요소의 block 특성에 의해 100%너비를 가지면 수직으로 쌓이게 만들어준다.  -->
				<label class="col-sm-2"><b>상품 코드</b></label>
				<div class="col-sm-6">
					<input type="text" name="productId" class="form-control" placeholder="상품코드를 입력하세요.">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><b>상품명</b></label>
				<div class="col-sm-6">
					<input type="text" name="pname" class="form-control" placeholder="상품명을 입력하세요">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><b>가격</b></label>
				<div class="col-sm-6">
					<input type="text" name="unitprice" class="form-control" placeholder="가격을 입력하세요">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2"><b>상세 정보</b></label>
				<div class="col-sm-6">
					<textarea rows="2" cols="50" name="description" class="form-control"></textarea>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">제조사</label>
				<div class="col-sm-6">
					<input type="text" name="manufacturer" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">분류</label>
				<div class="col-sm-6">
					<input type="text" name="category" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">재고 수</label>
				<div class="col-sm-6">
					<input type="text" name="numberOfstock" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">상태</label>
				<div class="col-sm-6">
					<input type="radio" name="condition" value="New">
					신규 제품 
					<input type="radio" name="condition" value="Old">
					중고 제품 
					<input type="radio" name="condition" value="Refurbished">
					재생 제품 
				</div>
			</div>
			
			<!-- 상품 이미지 업로드 부분 -->
			<div class="form-group row">
				<label class="col-sm-2"><b>이미지</b></label>
				<div class="col-sm-6">
					<input type="file" name="productImage" class="form-control">
				</div>
			</div>
			
			<div class="form-group row">
				<!-- offset 지점은 col의 2만큼 띄움 -->
				<div class="col-sm-offset-2 col-sm-10">
					<input type="submit" class="btn btn-default btn-lg" style="position: relative; float: right; right: 33%; background-color: #b6f5f5; 
					color: black; font-weight: bold;" value="등록">
					<a href="../admin/admin_index.jsp" class="btn btn-default btn-lg"
							style="background-color: #b6f5f5; position: relative; right: 12%; float: right; font-weight: bold;">관리자 홈</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>

<!-- 출처좌표 : https://coding23.tistory.com/42 -->