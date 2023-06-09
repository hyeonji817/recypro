<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet">

<!-- 모바일 웹 페이지 설정 -->
<link rel="shortcut icon" href="assets/ico/favicon.ico" />
<link rel="apple-touch-icon-precomposed"
	href="assets/ico/apple-touch-icon-144-precomposed.png" />
	
<!-- Bootstrap -->
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" media="screen" />
<%@ include file="index_admin.jsp" %>
<style>
	.text {
    font-family: 'MapoFlowerIsland';
    width: 100%;
    font-size: 4rem;
    color: rgb(255, 255, 255);
    text-align: center;
    position: absolute;
    top: 50%;
    left: 50%;
    font-weight: 800;
    transform: translate(-50%, -50%);
}

/** 시도한 거 4 */
.content{ /*컨텐츠 넓이지정*/
  position:relative;
  width:600px;
  margin: 0 auto;
  bottom: 18%;
}

.slides { /*슬라이드 아이템이 나올 뼈대 지정*/
  width:600px;
  height:300px;
  position:relative;
  left: 30%;
}

.slide_item { /*슬라이드 아이템을 absolute로 겹쳐놓고 투명하게 하기*/
  position:absolute;
  width:600px;
  height:300px;
  opacity:0;
  bottom: 5%;
  transition:all 0.3s;
}

.slide_item img {
	border-radius: 30px;
	width: 300px;
	height: 200px;
}

.slide_text {
	width: 150px;
	left: 15%;
/* 	bottom: 7%; */
	position: relative;
	font-weight: 700;
	font-size: 20px;
}

.slide_text2 {
	width: 150px;
	left: 15%;
	position: relative;
	font-weight: 700;
	font-size: 20px;
/* 	bottom: 7%; */
}

.ontheSlide { /*현재 아이템에 붙여줄 클래스*/
  opacity:1;
  transition:all 0.3s;
}

.nextButton,.prevButton { /*다음,이전 버튼을 드래그되지 않게 방지해주기*/
 -webkit-user-select: none;
  -ms-user-select: none;
  user-select: none
}

.nextButton { /*다음 버튼을 오른쪽으로 보내기*/
  float:right;
  position: relative;
  right: -25%;
}

.prevButton{ /*왼쪽 버튼을 왼쪽으로 보내기*/
  float:left;
  left: -15%;
  position: relative;
  bottom: 20%;
}

.Thumbnail { /*썸네일 아이템을 감쌀 뼈대*/
  display: flex;
  flex-flow: row wrap;
  width: 1000px;
  height: 50px;
  position: absolute;
  left: -27%;
  bottom: 1%;
  justify-content: center;
}

.thumbnail_item { /*썸네일 아이템의 길이 설정*/
  width:190px;
}

.thumbnail_item img {
	border-radius: 30px;
	width: 185px;
}

.popular {
	width: 1350px;	/** 반응형 화면 축소 시, 깨짐 방지하려면 명확한 수치의 픽셀 단위길이를 입력해 줘야 함 */
	position: relative;
	margin: 0 auto; 
	left: -4%;
	top: -14%;
 	bottom: 22%; 
 	padding-bottom: 22%;
}

.popular li {
	width: 22%;
	display: inline-block;
	text-align: center;
}

.popular li:nth-child(8) {
	position: relative;
	bottom: 20px;
}

ul {
	list-style: none; /** 목록 리스트 중에서 점을 없애는 스타일 방식 */
	padding: 0;
	margin: 0;
	margin-top: 20%;
	width: 100%;
}

#product_lists li {
	width: 330px;
	left: -2%;
	margin-right: 2%;
	display: block;
}

#product_list {
	width: 1500px;
	height: 500px;
	margin: 0 auto;
}

#product_list li {
	width: 100%;
}

#product_lists {
	width: 25%;
	height: 500px;
	left: 5%;
	height: 500px;
	position: relative;
}

.sub_explain {
	color: black;
	position: relative;
	right: -25%;
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
	margin-left: 35%;
	position: relative;
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
	right: 3%;
	left: 17%;
	font-size: 18px;
	float: right;
	position: relative;
}

.btn btn-light {
	text-shadow: none;
	font-weight: 700;
}

/** 이벤트 레이아웃 부분 */ 
#event {
	position: relative;
	background: #eee;
	width: 1700px;
	height: 300px;
	margin: 0 auto;
	top: -90%;
}

#event li {
	padding: 0;
	width: 21%;
	float: left;
}

#event li:first-child {
	padding-top: 5%;
	padding-left: 1.5%;
	margin-right: 1%;
	margin: 0 auto;
}

#event li:nth-child(2) {
	padding-top: 4%;
 	left: -1%; 
 	position: relative;
	margin: 0 auto;
}

#event li:nth-child(3) {
	padding-bottom: 3%;
	padding-left: -3%;
	margin-left: -5%;
	margin: 0 auto;
}

#event li:nth-child(4) {
	padding-left: 2%;
	margin: 0 auto;
}

.gift img {
	width: 115px;
}

.wallet img {
	width: 115px;
}

.event_title {
	width: 270px;
	margin-top: -5%;
}

.event_title h2 {
	font-weight: bold;
	padding-top: -3%;
	margin-left: -4%;
	font-size: 27px;
}

.event_info {
	padding-top: 20%;
	margin-left: -3%;
	color: white;
}

.kakaotalk_plus {
	background: yellow;
	width: 132%;
	margin: 0 auto;
	height: 210px;
 	margin-left: -14%; 
	margin-top: 10%;
}

.kakaotalk_title h5 {
	font-weight: 900;
	margin-top: 2%;
	float: right;
	padding-right: 2%;
	font-size: 22px;
}

.kakaotalk_icon {
	display: block;
	width: 120px;
	height: 120px;
	margin: 0 auto;
	margin-left: 1%;
	margin-top: 3%;
	position: absolute;
}

.kakaotalk_icon img {
	width: 110px;
 	margin-left: -6%; 
	position: relative;
 	margin-top: -4%; 
	top: 6%;
	padding-top: 4%;
}

.kakaotalk_info {
	width: 225px;
	display: block;
	float: right;
	margin-top: 3%;
	bottom: 48%;
	margin-right: 13.5%;
	position: absolute;
	right: 25.5%;
}

.kakaotalk_info h5 {
	font-weight: bold;
	font-size: 25px;
}

.kakaotalk_go {
	float: right;
	margin: 0 auto;
	top: 70%;
	bottom: -3%;
	right: 34%;
	position: absolute;
}

.kakaotalk_go h6 {
	width: 250px;
	color: black;
	right: 3%;
	float: right;
	margin-right: -6%;
	top: -2%;
	margin-top: 1%;
	padding-top: 1%;
	font-weight: 700;
}

.join_event {
	width: 141%;
	background: #B3F9EB;
	height: 210px;
	margin: 0 auto;
	position: relative;
	margin-top: 10%;
	left: 26%;
}

.join_event_title {
	float: right;
	margin-right: 3%;
	height: 40px;
	margin: 0 auto;
}

.join_event_title h5 {
	font-weight: bold;
	width: 110%;
	right: 2%;
	position: relative;
	margin-top: 2%;
	padding-right: 2%;
	font-size: 22px;
 	margin-right: 2%; 
}

.join_info {
	padding-top: 10%;
	position: relative;
	margin: 0 auto;
	bottom: 8%;
	margin-bottom: 14%;
	padding-bottom: 4%;
	height: 70px;
}

.join_info h4 {
	width: 100%;
	padding-top: 12%;
	font-size: 27px;
	font-weight: bold;
	padding-left: 1%;
	position: absolute;
}

.join_go {
	float: right;
	height: 30px;
	margin: 0 auto;
	position: absolute;
	top: 50%;
	left: 57%;
}

.join_go h6 {
	color: black;
	width: 200px;
	position: relative;
	margin: 0 auto;
	right: -5%;
	top: 200%;
	font-weight: bold;
	padding-top: 8%;
}
</style>
</head>

<body>
	<img src="../img/nature.jpg" class="main-img" alt="tip main">
	<div class="title-container">
        <p class="title">어서오세요</p>
    </div>
    <!-- 배너 영역 -->
    <div class="wrap-center">
    	<div class="banner-container">
    		<div class="img_wrap">
    			<ul class="rolling_imgs" style="height: 500px; padding-bottom: 0px; margin-bottom: 0; margin-top: 0;">
    				<li>
    					<img src="../img/main1_2.png"/>
    					<p class="text">재활용품 쇼핑몰</p>
    				</li>
    				<li>
    					<img src="../img/main2_2.png" />
    					<p class="text">지구지킴의 선두주자!<br></p>
    				</li>
    				<li>
    					<img src="../img/cherryblossom_2.png" />
    					<p class="text">재활용 상품으로 환경 보존하기</p>
    				</li>
    			</ul>
    		</div>
    	</div>
    </div>
    
    <%
		// DB에서 전체 상품 목록을 읽어서 가져오기 
		// popular_pdDAO 객체 생성 
		popular_pdDAO pdao = new popular_pdDAO(); 
	
		// DB에 상품이 있는지 확인 후, 있으면 상품 모두 가져오기. 없으면 가져오지 않기 
		Connection conn = null;
		
		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
		String Id = "root";
		String password = "1234";

		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명
		conn = DriverManager.getConnection(url, Id, password); // 연결 객체생성

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
	
	<!-- 쇼핑 이벤트 레이아웃 -->
	<div class="coupon" id="event">
		<ul>
			<li>
				<span class="gift">
					<img src="../img/shop/gift.png">
				</span> 
				<span class="wallet">
					<img src="../img/shop/wallet_1.png">
				</span>
			</li>
			<li>
				<div class="event_title">
					<h2>즐거운 쇼핑 Tip ★</h2>
				</div>
				<div class="event_info">
					<a href="#" style="font-weight: 700; color: white;" class="btn btn-dark" id="button_info" role="button">
						더 많은 혜택 보러가기 ▶
					</a>
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
							<h6>회원가입 하러가기 > </h6>
						</a>
					</div>
				</div>
			</li>
		</ul>
	</div>

    <script type="text/javascript">    
    let banner = {
    		rollId: null,
    		interval: 2000,
    		
    		// 롤링 배너 초기화
    		rollInit: function (newinterval) {
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
    			document.querySelector('.rolling_imgs li:last-child').classList.add('prevroll');
    			this.rollId = setInterval(this.rollNext, this.interval);	// 롤링 인터벌 호출 
    		},
    		
    		// 다음 배너 롤링 
    		rollNext: function () {
        		if(document.querySelector('.prevroll')){
            	document.querySelector('.prevroll').classList.remove('prevroll');
        	}
        	if(document.querySelector('.currentroll')){
            	document.querySelector('.currentroll').classList.add('prevroll');
            	document.querySelector('.currentroll').classList.remove('currentroll');
        	}
        	if(document.querySelector('.nextroll')){
            	document.querySelector('.nextroll').classList.add('currentroll');
            	document.querySelector('.nextroll').classList.remove('nextroll');
        	}
    		//다음 이미지 있으면 다음 롤링 이미지로 선택, 없으면 첫번째 이미지를 롤링 이미지로 지정
        	if(document.querySelector('.currentroll').nextElementSibling){
            	document.querySelector('.currentroll').nextElementSibling.classList.add('nextroll');
        	}else{
            	document.querySelector('.rolling_imgs li').classList.add('nextroll');
        	}
    	}
    }
    document.addEventListener('DOMContentLoaded', function(){
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

/** 시도한 거 4 / 출처좌표 : https://swimfm.tistory.com/entry/%EC%88%9C%EC%88%98-%EC%9E%90%EB%B0
    %94%EC%8A%A4%ED%81%AC%EB%A6%BD%ED%8A%B8%EB%A1%9C-%EC%9E%90%EB%8F%99-%EC%BA%90%EB%9F%AC%EC%
    85%80-%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C-%EB%A7%8C%EB%93%A4%EA%B8%B0-%EC%98%88%EC%A0%9C%
    EC%99%80-%EB%B0%A9%EB%B2%95-%EA%B0%95%EC%A2%8C
    */
    /** function sliderOn () {
    	 const slides = document.querySelector('.slides'); // 슬라이드뼈대 감지
    	 const Content = document.querySelector('.Thumbnail'); //썸네일 뼈대 감지
    	 const item = slides.getElementsByClassName('slide_item'); // 슬라이드 아이템 획득
    	 const thumbnail = Content.getElementsByClassName('thumbnail_item'); //썸네일 아이템 획득
    	 
    	 const firstEle = item[0]; // 첫번째 슬라이드 아이템
    	 const firstThumb = thumbnail[0]; // 첫번째 썸네일 아이템
    	 firstEle.classList.add('ontheSlide'); //첫번째 슬라이드 아이템에 ontheSlide 클래스 추가
    	  firstThumb.classList.add('ontheThumbnail'); // 첫번째 썸네일 아이템에 ontheThumbnail 클래스 추가
    	  const gogogo = setInterval(sliderGo, 4000);
    	  function sliderGo (isThat) {//isThat을 받아오기
    	    
    	    if (isThat) {//isThat이 지정되어 있다면
    	      var nextOr = 'previous'; //이전 버튼을 누른 것.
    	    }
    	    else { //isThat이 지정되지 않았다면
    	        var nextOr = 'next'; //다음 버튼을 누른 것.
    	    }
    	    
    	    const currentItem = document.querySelector('.ontheSlide');
    	    const currentThumb = document.querySelector('.ontheThumbnail');
    	    currentItem.classList.remove('ontheSlide')
    	    currentThumb.classList.remove('ontheThumbnail')
    	  if (nextOr === 'next'){  // 다음버튼을 눌렀다면
    	  if (!currentItem.nextElementSibling) {//마지막 아이템일 경우
    	      item[0].classList.add('ontheSlide') //처음으로 슬라이드아이템 이동
    	      thumbnail[0].classList.add('ontheThumbnail')//처음으로 썸네일 아이템 이동
    	    }   
    	   else { //그 외의 경우
    	     currentItem.nextElementSibling.classList.add('ontheSlide') //다음으로 슬라이드 아이템 이동
    	     currentThumb.nextElementSibling.classList.add('ontheThumbnail')//다음으로 썸네일 아이템 이동
    	        }   
    	  }
    	   else if (nextOr === 'previous') { // 이전 버튼을 눌렀다면
    	       if (!currentItem.previousElementSibling) { //첫번재 아이템일 경우
    	      item[item.length-1].classList.add('ontheSlide') //마지막 슬라이드로 이동
    	       thumbnail[thumbnail.length-1].classList.add('ontheThumbnail')  //마지막 썸네일로 이동
    	    }   
    	   else { //다른 경우
    	     currentItem.previousElementSibling.classList.add('ontheSlide') //이전 슬라이드 아이템으로 이동
    	     currentThumb.previousElementSibling.classList.add('ontheThumbnail')//이전 썸네일 아이템으로 이동
    	        }   
    	   } 
    	    
    	  }
    	 const nextButton = document.querySelector('.nextButton');//다음버튼 감지
    	 const prevButton = document.querySelector('.prevButton');//이전버튼 감지
    	nextButton.addEventListener('click',function(){//다음 버튼을 누른다면
    	  clearInterval(gogogo)//자동이동을 중지하고
    	  sliderGo();//수동으로 다음이동
    	})
    	prevButton.addEventListener('click',function(){//이전 버튼을 누른다면
    	  clearInterval(gogogo)//자동이동을 중지하고
    	  sliderGo('1');//수동으로 이전 이동
    	})  
    	for (var i=0; i<thumbnail.length; i++) { // 썸네일 갯수만큼 for문 발동  
    	  thumbnail[i].setAttribute('data-number',i); // 썸네일에 data-number를 설정해 몇번째 아이템인지 설정
    		thumbnail[i].addEventListener('click',function(event){ //썸네일 아이템을 클릭한다면
    	  		clearInterval(gogogo) // 자동이동을 멈춘다.
    	   		const currentItem = document.querySelector('.ontheSlide'); //현재 아이템 감지
    	    	const currentThumb = document.querySelector('.ontheThumbnail'); //현재 썸네일 감지
    	    	currentItem.classList.remove('ontheSlide') // 현재 아이템 비활성화
    			currentThumb.classList.remove('ontheThumbnail') // 현재 썸네일 비활성화
    			const number = event.target.getAttribute('data-number') // 몇 번째 썸네일을 클릭했는지 감지
    	  		item[number].classList.add('ontheSlide')   // 썸네일과 같은 숫자의 아이템을 활성화
    	  		event.target.classList.add('ontheThumbnail') // 클릭한 썸네일을 활성화
    	  
    		})  
    	}
 
    }
    sliderOn(); */
    </script> 
    <script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</body>
<footer>
	<div class="footer_bar" style="height: 35px; background-color: black;">		
		<div class="container" style="margin-right: 10px;" >
			<div class="m-0 text-center text-white" style="float:right; top: 2%; color: white;">Copyright &copy; Your Website 2022</div>
			<div style="clear: both;"></div>
		</div>
		<!-- /.container -->
	</div>
</footer>
</html>