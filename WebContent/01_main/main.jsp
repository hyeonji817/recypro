<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="product.beans.Product"%>
<%@ page import="product.beans.ProductRepository"%>
<%@ page import="popular_product.beans.popular_product" %>
<%@ page import="popular_product.beans.popular_pdDAO" %>

<%@ page trimDirectiveWhitespaces="true"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.text.DecimalFormat"%>
<%
	request.setCharacterEncoding("UTF-8");
	DecimalFormat dFormat = new DecimalFormat("###,###"); // 숫자 천 단위로 구분 표시
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로</title>
<link rel="stylesheet" type="text/css" href="../css/main.css">
<link rel="stylesheet" href="../css/slick.css" />
<link rel="stylesheet" href="../css/slick-theme.css" />

<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick-theme.css" />

<!-- 모바일 웹 페이지 설정 -->
<link rel="shortcut icon" href="assets/ico/favicon.ico" />
<link rel="apple-touch-icon-precomposed"
	href="assets/ico/apple-touch-icon-144-precomposed.png" />

<!-- Bootstrap -->
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css"
	media="screen" />
<%@ include file="index_top.jsp"%>
<style type="text/css">
/** 중간 및 소배너 레이아웃 */
.popular_list {
	position: relative; 
	width: 600px; 
	height: 400px;
	margin: 0 auto; 
	bottom: 18%; 
}

.popular_menu {
	width: 600px; 
	height: 300px; 
	position: relative; 
	left: 30%; 
}

.popular_item {
	position: absolute; 
	width: 600px; 
	height: 300px; 
	opacity: 0; 
	bottom: 5%; 
	transition: all 0.3s;
}

.popular_item img {
	border-radius: 30px; 
	width: 300px; 
	height: 200px; 
}

.popular_text {
	width: 150px; 
	left: 15%; 
	position: relative; 
	font-weight: 700; 
	font-size: 20px;
}

.ontheSlide { /*현재 아이템에 붙여줄 클래스*/
	opacity: 1;
	transition: all 0.3s;
}

.nextButton, .prevButton { /*다음,이전 버튼을 드래그되지 않게 방지해주기*/
	-webkit-user-select: none;
	-ms-user-select: none;
	user-select: none
}

.nextButton { /*다음 버튼을 오른쪽으로 보내기*/
	float: right;
	position: absolute;
	right: 38%;
	bottom: 0;
}

.prevButton { /*왼쪽 버튼을 왼쪽으로 보내기*/
	float: left;
	left: 35%;
	position: relative;
	margin-bottom: 30%;
	bottom: 30%;
}

/** 인기상품 목록 */
.popular {
	width: 1350px;
	position: relative;
	margin: 0 auto;
	left: 3%;
	top: -14%;
	bottom: 22%;
	padding-bottom: 22%;
}

#productLists {
	width: 1200px; 
	height: 500px;
	position: relative;  
}

#product_list {
	width: 1500px; 
	height: 500px; 
	margin: 0 auto; 
}

/** .popular li {
	width: 22%;
	display: inline-block;
	text-align: center;
	margin-bottom: 60px;
}

.popular li:nth-child(8) {
	position: relative;
	bottom: 20px;
}
*/

ul {
	list-style: none; /** 목록 리스트 중에서 점을 없애는 스타일 방식 */ 
	padding: 0;
	margin: 0;
	width: 100%;
} 

.sub_explain {
	color: black;
	margin-right: -25%;
	width: 330px;
}

.sub_explain img {
	width: 220px;
	border-radius: 30px;
}

.sub_explain p {
	width: 220px;
	height: 70px;
	margin-top: -2%;
	text-align: left;
}

.sub {
	float: left;
	margin-bottom: 10%;
	margin-left: 15%;
	position: absolute;
}

.info_pd a {
	float: left;
}

.sub_explain h2 {
	margin-top: 20px;
	font-size: 22px;
	font-weight: bold;
	margin-bottom: 30px;
	width: 300px;
	text-align: center;
}

.sub_explain h5 {
	font-size: 16px;
	top: 5%;
	font-weight: 700;
/* 	left: 15%; */
	width: 270px;
	position: relative;
}

.sub_menu h6 {
	margin-top: 5%;
	font-weight: 700;
	right: 5%;
}

h6 {
	top: 2%;
	width: 90px;
	font-size: 18px;
	float: right;
	margin-right: -7%;
	position: relative;
}

.btn btn-light {
	text-shadow: none;
	font-weight: 700;
}

/** 이벤트 레이아웃 부분 */
#event {
	background: #eee;
	width: 1700px;
	position: relative;
	margin: 0 auto;
	height: 250px;
	top: 180px;
}

#event li {
	padding: 0;
	width: 21%;
	float: left;
}

#event li:first-child {
	padding-top: 5%;
	padding-left: 2%;
	margin-right: 1%;
	margin-left: 0;
}

#event li:nth-child(2) {
	padding-top: 4%;
	margin-left: -1%;
	margin-right: -3%;
}

#event li:nth-child(3) {
	padding-bottom: 3%;
	padding-left: 1%;
	margin-left: 1%;
}

#event li:nth-child(4) {
	padding-left: 2%;
}

.gift img {
	width: 110px;
}

.wallet img {
	width: 110px;
}

.event_title {
	width: 270px;
	margin-top: -5%;
}

.event_title h2 {
	font-weight: bold;
	padding-top: -3%;
	font-size: 27px;
}

.event_info {
	padding-top: 17%;
}

.kakaotalk_plus {
	background: yellow;
	width: 144%;
	height: 200px;
	margin-left: -8%;
	margin-top: 5%;
}

.kakaotalk_title h5 {
	font-weight: 900;
	padding-top: 4%;
	float: right;
	padding-right: 2%;
}

.kakaotalk_icon {
	/* 	width: 70px; */
	display: block;
}

.kakaotalk_icon img {
	width: 100px;
	margin-left: 1%;
	position: relative;
	margin-top: 7%;
	top: 6%;
	padding-top: 4%;
}

.kakaotalk_info {
	width: 225px;
	display: block;
	float: right;
	margin-top: -13.5%;
	margin-right: -2%;
}

.kakaotalk_info h5 {
	font-weight: bold;
	font-size: 24px;
	/* 	margin-right: -2%; */
}

.kakaotalk_go {
	float: right;
	position: absolute;
	right: 39.5%;
	margin: 0 auto;
	/* 	margin-bottom: 2%; */
	/* 	margin-top: -2%; */
}

.kakaotalk_go h6 {
	width: 220px;
	color: black;
	right: -53%;
	float: right;
	margin-right: -10%;
	top: -2%;
	margin-top: 5%;
	padding-top: -1%;
	font-weight: bold;
	padding-bottom: 2%;
}

.join_event {
	width: 146%;
	background: #B3F9EB;
	height: 200px;
	margin-left: 33%;
	margin-top: 5%;
}

.join_event_title {
	float: right;
	margin-right: 3%;
}

.join_event_title h5 {
	font-weight: bold;
	width: 110%;
	padding-top: 7%;
	padding-right: 2%;
	font-size: 22px;
	margin-right: 2%;
}

.join_info {
	padding-top: 10%;
	margin-right: 2%;
}

.join_info h4 {
	width: 130%;
	padding-top: 7%;
	font-size: 25px;
	font-weight: bold;
	padding-left: 1%;
}

.join_go {
	float: right;
	position: absolute;
	right: 4%;
	height: 30px;
	margin: 0 auto;
}

.join_go h6 {
	color: black;
	width: 200px;
	position: relative;
	margin: 0 auto;
	font-weight: bold;
	padding-top: 12%;
	margin-right: -22%;
	margin-top: 12%;
}
</style>
</head>

<body>
	<img src="../img/nature.jpg" class="main-img" alt="tip main">

	<!-- 배너 영역 -->
	<div class="wrap-center">
		<div class="banner-container">
			<div class="img_wrap">
				<ul class="rolling_imgs" style="height: 500px; padding-bottom: 0px; margin-bottom: 0px;">
					<li>
						<img src="../img/main1_2.png" />
						<p class="text">재활용품 쇼핑몰</p>
					</li>
					<li>
						<img src="../img/main2_2.png" />
						<p class="text">지구지킴의 선두주자!</p>
					</li>
					<li>
						<img src="../img/cherryblossom_2.png" />
						<p class="text">
							재활용 상품으로 <br> 환경을 보존하자
						</p>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<!-- 중간 배너 및 소배너 영역(인기상품) -->
	<!-- <div class="popular_list">
		<ul>
			<li class="popular_item">
				<img src="../img/shopdetail/1_3-1_minimum.jpg" />
  				<p class="popular_text">가치솝 비누</p>
			</li>
			<li class="popular_item">
				<img src="../img/shopdetail/4_puppy_pubbag_minimum.png" />
  				<p class="popular_text2">애견 풉백 <br> 생분해 리필 </p>
			</li>
			<li class="popular_item">
				<img src="../img/shopdetail/rabbit_tumblur_minimum.png" />
  				<p class="popular_text">토끼 텀블러</p>
			</li>
			<li class="popular_item">
				<img src="../img/shopdetail/finger_snap_minimum.png" />
  				<p class="popular_text">손운동 기구</p>
			</li>
			<li class="popular_item">
				<img src="../img/shopdetail/puppy_gum_minimum.jpg" />
				<p class="popular_text">강아지 <br>개껌 간식</p>
			</li>
			<li class="popular_item">
				<img src="../img/shop/coffee_holder_minimum.png" />
				<p class="popular_text">드링크백 <br>텀블러 백</p>
			</li>
			<li class="popular_item">
				<img src="../img/shop/eats_better_minimum.jpg" />
				<p class="popular_item">비건 티쿠키</p>
			</li>
			<li class="popular_item">
				<img src="../img/shop/clean_ball_minimum.jpg" />
				<p class="popular_item">제주 시카 <br>클렌징볼</p>
			</li>
		</ul>
		<div class="popular_menu">
			<div class="popular_item">
				<img src="../img/shopdetail/1_3-1_minimum.jpg" />
  				<p class="popular_text">가치솝 비누</p>
			</div>
			<div class="popular_item">
				<img src="../img/shopdetail/4_puppy_pubbag_minimum.png" />
  				<p class="popular_text2">애견 풉백 <br> 생분해 리필 </p>
			</div>
			<div class="popular_item">
				<img src="../img/shopdetail/rabbit_tumblur_minimum.png" />
  				<p class="popular_text">토끼 텀블러</p>
			</div>
			<div class="popular_item">
				<img src="../img/shopdetail/finger_snap_minimum.png" />
  				<p class="popular_text">손운동 기구</p>
			</div>
			<div class="popular_item">
				<img src="../img/shopdetail/puppy_gum_minimum.jpg" />
				<p class="popular_text">강아지 <br>개껌 간식</p>
			</div>
			<div class="popular_item">
				<img src="../img/shop/coffee_holder_minimum.png" />
				<p class="popular_text">드링크백 <br>텀블러 백</p>
			</div>
			<div class="popular_item">
				<img src="../img/shop/eats_better_minimum.jpg" />
				<p class="popular_item">비건 티쿠키</p>
			</div>
			<div class="popular_item">
				<img src="../img/shop/clean_ball_minimum.jpg" />
				<p class="popular_item">제주 시카 <br>클렌징볼</p>
			</div>
		</div> 
	</div> -->

	<%
		// DB에서 전체 상품 목록을 읽어서 가져오기 
		// popular_pdDAO 객체 생성 
		popular_pdDAO pdao = new popular_pdDAO(); 
	
		// DB에 상품이 있는지 확인 후, 있으면 상품 모두 가져오기. 없으면 가져오지 않기 
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
		String id = "root";
		String password = "1234";

		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명
		conn = DriverManager.getConnection(url, id, password); // 연결 객체생성

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String Sql = "select * from popular_product";
		
		pstmt = conn.prepareStatement(Sql); // Connection 객체에 쿼리문을 넘겨주고 PrepareStatement를 얻음
		rs = pstmt.executeQuery(); // 쿼리문 결과 받아옴 
	%>

	<!-- 인기 상품리스트 -->
	<div class="popular">
		<!-- 변경.ver -->
		<div class="row" id="productLists" align="center">
			<%
				while (rs.next()) {
			%>
			<div class="col-md-3" id="product_list">
				<div class="sub_explain">
					<a href="../03_shop/popular_Product.jsp?id=<%=rs.getString("productId")%>">
						<img alt="이미지 업로드" src="../img/popular/<%=rs.getString("img_name")%>" />
					</a>
					<h2><%=rs.getString("pname")%></h2>
					<h5>
						<p><%=rs.getString("description")%></p>
					</h5>
				</div>
				<p class="sub">
					<a href="../03_shop/popular_Product.jsp?id=<%=rs.getString("productId")%>"
					style="font-weight: 700;" class="btn btn-light" id="button_info"
					role="button">
					 상세 정보 &raquo;
					</a>
					<span class="sub_menu">
						<h6 style="font-weight: 700;">
							<%=dFormat.format(Integer.parseInt(rs.getString("unitprice")))%>원
						</h6>
					</span>
				</p>
			</div>
			<%
				}
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			%>
		</div>
		
			
		</div>
		<!-- 원본 -->
	</div>

	<!-- 쇼핑 이벤트 레이아웃 -->
	<div class="coupon" id="event">
		<ul>
			<li><span class="gift"> <img src="../img/shop/gift.png">
			</span> <span class="wallet"> <img src="../img/shop/wallet_1.png">
			</span></li>
			<li>
				<div class="event_title">
					<h2>즐거운 쇼핑 Tip ★</h2>
				</div>
				<div class="event_info">
					<a href="event.jsp" style="font-weight: 700;" class="btn btn-dark"
						id="button_info" role="button"> 더 많은 혜택 보러가기 ▶ </a>
				</div>
			</li>
			<li>
				<div class="kakaotalk_plus">
					<div class="kakaotalk_title">
						<h5>카카오톡 플러스 친구 추가 혜택 ★</h5>
					</div>
					<div class="kakaotalk_icon">
						<img src="../img/shop/kakaotalk.png">
					</div>
					<span class="kakaotalk_info">
						<h5>20% 할인쿠폰 증정!</h5>
					</span>
					<div class="kakaotalk_go">
						<a href="#">
							<h6>카카오톡 플친 바로가기 ></h6>
						</a>
					</div>
				</div>
			</li>
			<li>
				<div class="join_event">
					<div class="join_event_title">
						<h5>리싸이프로 신규가입 혜택 ★</h5>
					</div>
					<div class="join_info">
						<h4>10,000원 + 각종 할인쿠폰 증정!</h4>
					</div>
					<div class="join_go">
						<a href="#">
							<h6>회원가입 하러가기 ></h6>
						</a>
					</div>
				</div>
			</li>
		</ul>
	</div>

	<script type="text/javascript">
		/** 맨 처음 대형 배너 관련 함수 */
		let banner = {
			rollId : null,
			interval : 2000,

			// 롤링 배너 초기화
			rollInit : function(newinterval) {
				if (parseInt(newinterval) > 0) {
					this.interval = newinterval;
				}

				// 현재 배너
				let firstitem = document.querySelector('.rolling_imgs li');
				if (firstitem) {
					firstitem.classList.add('currentroll');
				}
				// 다음 배너 
				let seconditem = document.querySelectorAll('.rolling_imgs li')[1];
				if (seconditem) {
					seconditem.classList.add('nextroll');
				}
				// 이전 배너 
				document.querySelector('.rolling_imgs li:last-child').classList
						.add('prevroll');
				this.rollId = setInterval(this.rollNext, this.interval); // 롤링 인터벌 호출 
			},

			// 다음 배너 롤링 
			rollNext : function() {
				if (document.querySelector('.prevroll')) {
					document.querySelector('.prevroll').classList
							.remove('prevroll');
				}
				if (document.querySelector('.currentroll')) {
					document.querySelector('.currentroll').classList
							.add('prevroll');
					document.querySelector('.currentroll').classList
							.remove('currentroll');
				}
				if (document.querySelector('.nextroll')) {
					document.querySelector('.nextroll').classList
							.add('currentroll');
					document.querySelector('.nextroll').classList
							.remove('nextroll');
				}
				//다음 이미지 있으면 다음 롤링 이미지로 선택, 없으면 첫번째 이미지를 롤링 이미지로 지정
				if (document.querySelector('.currentroll').nextElementSibling) {
					document.querySelector('.currentroll').nextElementSibling.classList
							.add('nextroll');
				} else {
					document.querySelector('.rolling_imgs li').classList
							.add('nextroll');
				}
			}
		}
		document.addEventListener('DOMContentLoaded', function() {
			banner.rollInit(4000); // 배너 롤링
		});

		/** 반응형 처리 */
		var resizeId = "";

		window.addEventListener('resize', function() {
			clearTimeout(resizeId);
			resizeId = setTimeout(doneResizing, 250);
		});

		function doneResizing() {
			console.log('doneResizing Window Width: ' + window.innerWidth);
			// 반응형 레이아웃 처리
		}
	</script>

	<script src="../js/html5shiv.js"></script>
	<script src="../js/respond.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<script src="../js/jquery.min.js"></script>
	<script src="http://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/jquery.slick/1.8.1/slick.min.js"></script>
	<script src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

</body>
<footer>
	<%@ include file="footer.jsp"%>
</footer>
</html>