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
<!-- <link rel="stylesheet" type="text/css" href="../css/main.css"> -->
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