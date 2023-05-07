<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

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
<title>마이레벨 등급표</title>
<style>
/** 제목 */ 
.title {
	margin-top: 7%;
	height: 150px;
}

.display-3 {
	margin-left: -6%;
	color: black;
	position: relative;
	font-weight: bold;
	font-size: 55px;
	display: block;
}

.button {
	margin-top: 30px;
	margin-bottom: 30px;
	right: -84%;
}
</style>
</head>
<body>
	<!-- 제목 -->
	<div class="title">
		<div class="container">
			<h1 class="display-3"
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">마이레벨 등급표</h1>
		</div>
	</div>
	
	<!-- 레벨 등급표 영역 내용 -->
	<div class="row">
		<table class="table" style="width: 1000px; margin: 0 auto;">
			<thead>
				<tr>
					<th style="background-color: #eeeeee; text-align: center;">등급표</th>
					<th style="background-color: #eeeeee; text-align: center;">레벨등급 기준</th>
					<th style="background-color: #eeeeee; text-align: center;">답변</th>
				</tr>
			</thead>
			<tbody>	
				<!-- 1행 -->
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						씨앗
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						lv.1 ~ 10
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						없음.
					</td>
				</tr>
				
				<!-- 2행 -->
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						새싹
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						lv.11 ~ 20
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						할인 10% OFF 쿠폰 지급
					</td>
				</tr>
				
				<!-- 3행 -->
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						묘목
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						lv.21 ~ 30
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						할인 20% OFF 쿠폰 지급. 배송비 30% 차감 
					</td>
				</tr>
				
				<!-- 4행 -->
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						나무
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						lv.31 ~ 40
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						할인 30% OFF 쿠폰 지급. 배송비 50% 차감 
					</td>
				</tr>
				
				<!-- 5행 -->
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						열매 
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						lv.41 ~ 50
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						할인 40% OFF 쿠폰 지급. 배송비 없음.
					</td>
				</tr>
				
				<!-- 6행 -->
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						황금열매 
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						lv.51 이후 
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						할인 50% OFF 쿠폰 지급. 배송비 없음. 
					</td>
				</tr>
				
				<!-- 7행 -->
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						생일날
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						레벨무관
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						할인 50% OFF 쿠폰 지급. 유효기간 6개월
					</td>
				</tr>
				
				<!-- 8행 -->
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						lv.51 이후
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						5만원 이상 결제 시, 할인 60% OFF 쿠폰 지급.
					</td>
				</tr>
				
				<!-- 9행 -->
				<tr>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 2%;">
						
					</td>
					<td style="font-size: 17px; position: relative; left: 5%; padding-top: 2%;">
						lv.61 이후
					</td>
					<td style="font-size: 17px; position: relative; left: 2%; padding-top: 1%;">
						10만원 이상 결제 시, 할인 70% OFF 쿠폰 지급.
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<!-- 뒤로가기(마이레벨 페이지) 버튼 생성 -->
	<div class="button">
		<a href="../04_mypage/mylevel.jsp" class="btn btn-default pull-right" style="color: black; background-color: #b6f5f5; margin-right: 24%; float: right; font-weight: bold;">뒤로가기</a>
	</div>
</body>
</html>