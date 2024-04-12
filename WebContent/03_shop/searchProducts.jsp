<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="product.beans.Product"%>
<%@ page import="product.beans.ProductRepository"%>
<%@ page import="java.util.Calendar"%>
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
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="../js/searchProducts.js'/>" charset="utf-8"></script>

<!-- bootstrap -->
<link rel="stylesheet" href="../css/bootstrap.css" />
<link rel="stylesheet" href="../css/ie10.css" />
<link rel="stylesheet" href="../css/searchProduct.css" />
<link rel="stylesheet" type="text/css" media="screen" href="../css/bootstrap.min.css" /> 
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" />
<title>재활용품 전문점 : 리싸이프로 - 상품목록(검색)</title>
<style>
.title {
	margin-top: 150px;
	height: 140px;
}

.display-3 {
	margin-top: 50px;
	color: black;
	font-weight: 700;
	position: relative;
	margin-left: -30%;
}

/** 검색버튼 시작 */
@import url(https://fonts.googleapis.com/css?family=Open+Sans);

/** 검색 결과 */
.search_result {
	min-height: 400px; 
	margin: 0 0 0 125px; 
	padding: 20px; 
	border-top: 1px solid #fff; 
	border-right: 1px solid #fff;
	border-left: 1px solid #fff; 
	border-bottom: 1px solid #fff;
}

.container {
	margin-top: 10px;
}

</style>
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/scoll_bar.css">
<link rel="stylesheet" type="text/css" href="../css/products.css">
</head>
<body>
<%@ include file="../01_main/index.jsp"%>
	
	<%
		// DB에서 전체 상품 목록을 읽어서 가져오기 
		// ProductRepository 객체 생성 
		ProductRepository pr = new ProductRepository(); 
	
		// DB에 상품이 있는지 확인 후 있으면 상품 모두 가져오기, 없으면 가져오지 않기 : getBoardCount()
		Connection conn = null;

		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul";
		String id = "root";
		String password = "1234";

		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명
		conn = DriverManager.getConnection(url, id, password); // 연결 객체생성

		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from product";

		pstmt = conn.prepareStatement(sql); // Connection 객체에 쿼리문을 넘겨주고 PrepareStatement를 얻음
		rs = pstmt.executeQuery(); // 쿼리문 결과 받아옴 

	%>

	<div class="title">
		<div class="container">
			<h1 class="display-3"
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">상품검색 결과</h1>
		</div>

		<!-- 검색한 결과 내용 -->
		<div class="main-container">	
			<table class="board_list" style="width: 100%">
				<colgroup>
					<col width="100%" />
				</colgroup>
				<thead>
					<tr></tr>
				</thead>
				<tbody></tbody>
			</table>
		</div>
	
		<!--  -->
		<div id="PAGE_NAVI" align="center">
			<input type="hidden" id="keyword" name="keyword" value="${keyword}" />
			<br><br>
		</div>
	
		<form id="commonForm" name="commonForm"></form>
	
	</div>
	<script type="text/javascript">
		function numberWithCommas(x) {
			return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		$(document).ready(function() {
			fn_selectGoodsList(1); 
			
			$("a[name='title']").on("click", function(e) {
				console.log("들어오기 성공");
				e.preventDefault(); 
				fn_openBoardDetail($(this)); 
			});
		});
		
		function fn_selectGoodsListCallback(data) {
			var total = data.TOTAL;
			var body = $(".board_list");
			body.empty(); 
			
			if (total == 0) {
				var str = "<tr>" + "<td colspan='4'>조회된 결과가 없습니다.</td>" + "</tr>";
				
				body.append(str);
			} else {
				var params = {
					divId : "PAGE_NAVI", 
					pageIndex : "PAGE_INDEX", 
					totalCount : total, 
					recordCount : 16, 
					eventName : "fn_selectGoodsList"
				}; 
				gfn_renderPaging(params); 
				
				var str = ""; 
				$.each(data.list, function(key, value) {
					var imgpath = "<img src='../img/shopdetail/"+value.GOODS_THUMBNAIL+"'width='400' height='400'>"
					
					var imgpath1 = value.GOODS_IMAGE_STD.split(','); 
					var img0 = imgpath1[0]; 
					var img1 = imgpath1[1]; 
					
					var Pick = value.GOODS_PICK.split(','); 
					var pick1 = ""; 
					var pick2 = ""; 
					var pick3 = ""; 
					var pick4 = ""; 
					
					var num = ""; 
					
					for (var i=0; i<Pick.length; i++) {
						Pick[i]; 
						
						if (Pick[0] == null) {
							pick1 = "";
						} else {
							pick1 = Pick[0]; 
						}
						
						if (Pick[1] == null) {
							pick2 = Pick[1]; 
						} else {
							pick2 = Pick[1];
						}
						
						if (Pick[2] == null) {
							pick3 = ""; 
						} else {
							pick3 = Pick[2]; 
						}
						
						if (Pick[3] == null) {
							pick4 = ""; 
						} else {
							pick4 = Pick[3]; 
						}
					}
					
					str += "<div class='card'>"; 
						+ 		"<a href='#this' name='title'>";
						+		"<div class='imgswap'>";
						+ 			"<img src='../img/shopdetail/"+img0+"'width='400' height='400'>";
						+			"<img src='../img/shopdetail/"+img1+"'width='400' height='400'>";
						+		"</div>";
						+		"<c:if test='${"+num+" ne "+pick1+"}'>";
						+		"<span style='background-color:#ff80bf; line-height: 27px; border-radius: 10px;'><font color='#ffffff' size='2'>";
						+			pick1 + "</font></span>";
						+		"</c:if>";
						+		"<c:if test='${"+num+" ne "+pick2+"}'";
						+     	"<span style='background-color:#d456dc; line-height: 27px; border-radius: 10px;'><font color='#ffffff' size='2'>";
						+		pick2 + "</font></span>"
						+	  	"</c:if>"
						+     	"<c:if test='${"+num+" ne "+pick3+" }'>"
						+     	"<span style='background-color:#33b7ff; line-height: 27px; border-radius: 10px;'><font color='#ffffff' size='2'> "  
						+       	pick3 + "</font></span>"
						+	  	"</c:if>"
						+     	"<c:if test='${"+num+" ne "+pick4+" }'> "
						+     	"<span style='background-color:#33b7ff; line-height: 27px; border-radius: 10px;'><font color='#ffffff' size='2'> "  
						+       	pick4 + "</font></span>"
						+	  	"</c:if> <br>"
						+	  	"<font class='font1'>"+value.GOODS_NAME+"</font><br>"
						+     	"<font class='font2'>"+numberWithCommas(value.GOODS_SELL_PRICE)+"원</font> "   
						+  	  	"<input type='hidden' id='IDX' name='IDX' value=" + value.GOODS_NO + ">"
						+	  	"</a>"
						+	"</div>";
				});
				body.append(str);
				$("a[name='title']").on("click", function(e) {
					e.preventDefault(); 
					fn_openBoardDetail($(this));
				});
			}
		}
			
			
	</script>
	<script src="../js/html5shiv.js"></script>
	<script src="../js/jquery.min.js"></script>
	<script src="../js/respond.min.js"></script>
	<script src="../js/ie10.css"></script>
	<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
</body>
</html>