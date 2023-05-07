<!-- 별점 구현 팁 : https://velog.io/@hellocdpa/220305-%EB%A6%AC%E
B%B7%B0-%EB%B3%84%EC%A0%90-%EA%B8%B0%EB%8A%A5-%EA%B5%AC%ED%98%84%ED%95%98%EA%B8%B0 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="product.beans.Product" %>
<%@ page import="product.beans.ProductRepository" %>
<%@ page import="order.beans.Order"%>
<%@ page import="order.beans.orderDAO"%>
<%@ page import="pd_review.beans.pd_Review" %>
<%@ page import="pd_review.beans.pd_ReviewDAO" %>
<%@ page errorPage="exceptionNoProductId.jsp" %> <!-- id값이 유효하지 않으면 에러페이지로 이동 -->
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.text.DecimalFormat" %>
<% 
	request.setCharacterEncoding("UTF-8"); 
	DecimalFormat dFormat = new DecimalFormat("###,###");
	String shopping_productId = "";
	// String pd_userId = "";
%>
<!-- 사용할 빈즈클래스 선언(만 함) -->
<jsp:useBean id="user" class="user.beans.User" scope="page" />
<jsp:useBean id="order" class="order.beans.Order" scope="page" />
<jsp:useBean id="product" class="product.beans.Product" scope="page" />

<!-- 호출할 빈즈 클래스가 가진 데이터 -->
<jsp:setProperty name="order" property="*" />
<jsp:setProperty name="product" property="*" />
<jsp:setProperty name="user" property="*" />
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 상품페이지</title>
<link rel="stylesheet" type="text/css" href="../css/product.css">
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.10.1/jquery-ui.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
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
	System.out.println(id); // witch0817
	
%>
<style>
	.title {
		margin-top: 80px;
		height: 100px;
		position: relative;
		left: 10%;
		width: 500px;
		font-weight: 700;
	}
	
	.display-3 {
		top: 17%;
		left: 28%;
		color: black;
		font-weight: 700;
		width: 300px;
		text-shadow: 1px 1px 5px #bdbdbd;
	}
	
	.review {
		position: relative;
		left: 27%;
		width: auto;
		top: 6%;
		margin: 0 auto;
	}
	
	.review td h5 {
		 float: left; 
		 font-size: 16px;
		 padding-left: 1%;
	}
	
	form {
		width: 700px;
	}
	
	/** 별점 구현 */
	#pd_form fieldset {
		display: inline-block; 
		direction: rtl; /** 한 번 알아봐야 겠다 */
		border: 0;
	}
	
	#pd_form fieldset legend {
		text-align: right;	/** 별점 아이콘 위치 */ 
	}
	
	#pd_form input[type=radio] {
		display: none;	/** radio 아이콘 표시 제거 */ 
	}
	
	#pd_form label {
		font-size: 3em; 	/** 별 크기 설정 */
		color: transparent; 	/** 아마 부모요소한테 물려받는 다는 뜻일듯 */
		text-shadow: 0 0 0 #f0f0f0;		/** 별 색상인 듯 */
	}
	
	#pd_form label:hover {
		text-shadow: 0 0 0 rgb(136, 253, 230);	/** 별점을 마우스로 갖다댈 때마다 해당 지정한 색상으로 표시, 일단은 한 별만 적용됨 */ 
	}
	
	#pd_form label:hover ~ label {
		text-shadow: 0 0 0 rgb(136, 253, 230); /** 별점을 오른쪽으로 마우스 갖다댈 때마다 연달아 색상 표시됨 */
	}
	
	#pd_form input[type=radio]:checked ~ label {
		text-shadow: 0 0 0 rgb(136, 253, 230);
	}

	.submit{
		right: -110%;
		position: relative;	
	}
	
	.submit input {
		font-weight: bold;
	}
</style>
</head>
<body>
	<%
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크 
		// String pd_userId = null;
		// 수정본 
		// String pd_userId = request.getParameter("id");
		// String pd_userId = (String)session.getAttribute("id");
		String Shopping_productId = request.getParameter("id");
		System.out.println(Shopping_productId);		// null
		
		String pd_userId = null; 
		
		// 수정본 
		if (session.getAttribute("pd_userId") != null) {
			pd_userId = (String)session.getAttribute("pd_userId"); 	// 로그인한 사람들은 해당 아이디가 pd_userId에 저장 
		} else if (id != null) {
			pd_userId = id; 
			session.setAttribute("pd_userId", pd_userId);
		} else {
			System.out.println("세션에 pd_userId 속성이 설정되어 있지 않습니다.");
		}
		
		System.out.println(pd_userId);
	%>
	
	<div class="title">
		<div class="container">
			<h1 class="display-3">상품 리뷰</h1>
		</div>
	</div>
	

	<div class="review">
		<div class="row" id="review_write">
			<form method="post" action="pd_writeAction.jsp" id="pd_form" name="pd_form">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; width:800px; 
							font-size: 23px; text-align: center;">상품 리뷰쓰기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>
								<%
									int sum = 0;
								

									// 세션 속성의 이름이 cardList인 세션 정보(장바구니에 담긴 물품 목록)를 가져와서 ArrayList에 대입
									ArrayList<Product> cartList = (ArrayList<Product>) session.getAttribute("cartList");
				
									/** cart.jsp 파일에서 전체 상품을 삭제하는 deleteCart.jsp에서 session.invalidate()을 호출하게 되면
									cartList는 null이 되기 때문에 아래와 같은 코드가 반드시 필요함 */
									if (cartList == null) {
										cartList = new ArrayList<Product>();
									}
								
									// 상품리스트 하나씩 출력하기
									for (int i = 0; i < cartList.size(); i++) {
										Product product2 = cartList.get(i);
									
										// 소계 = 가격 * 수량 
										int total = product2.getUnitprice() * product2.getQuantity();
										sum = sum + total;
								%>
							</td>
							<%
								}
							%>
						</tr>
						<tr>
							<td>
<!-- 								<label for="pd_productId">상품명</label> -->
								<input type="text" class="form-control" placeholder="상품명" name="pd_productId" value="<%=Shopping_productId%>" maxlength="50" style="width:1000px" readonly/>
							</td>
						</tr>
						<tr>
							<td>
								<input type="text" class="form-control" placeholder="글 제목" name="pd_reviewTitle" maxlength="50" style="width:1000px">
							</td>
						</tr>
						<!-- <tr>
							<td>
								<h5>평점 매기기</h5>
								<fieldset>
									<input type="radio" name="reviewStar" value="5" id="rate1">
									<label for="rate1">★</label>
									
									<input type="radio" name="reviewStar" value="4" id="rate2">
									<label for="rate2">★</label>
									
									<input type="radio" name="reviewStar" value="3" id="rate3">
									<label for="rate3">★</label>
									
									<input type="radio" name="reviewStar" value="2" id="rate4">
									<label for="rate4">★</label>
									
									<input type="radio" name="reviewStar" value="1" id="rate5">
									<label for="rate5">★</label>
								</fieldset>
							</td>
						</tr> -->
						<tr>
							<td>
								<h5>상품 사진 업로드</h5>
								<div class="col-sm-6" style="position: relative; left: 10%; margin: 0 auto;">
									<input type="file" name="pd_Image" value="등록">
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<textarea class="form-control" placeholder="글 내용" name="pd_reviewContent" maxlength="2048" style="height: 500px; width:1000px;"></textarea>
							</td>
						</tr>
					</tbody>
				</table>
				<span class="submit">
					<input type="submit" class="btn btn-default pull-right" style="background-color: #9FFBF4; color: black; font-weight: bold;" value="글쓰기">
					<a href="history.back();" style="background-color: #9FFBF4;"><input type="submit" class="btn btn-info pull-right" style="font-weight: bold;" value="뒤로가기"></a>
					<%
						PrintWriter script = response.getWriter();
					
						if (session.getAttribute("id") != null) {
							id = (String)session.getAttribute("id");
							System.out.println(id);		// witch0817
							// 원본 (밑에꺼)
							// pd_userId = (String)session.getAttribute("id");	// pd_userId라는 선언했던 클래스 변수에 사용자 이름값이 들어가게 하기 위해 세팅함
						
					%>
					<input type="submit" class="btn btn-default pull-right" style="background-color: #9FFBF4; color: black; font-weight: bold;" value="수정하기">
					<%
						} else {
							script.println("location.href = '../02_account/login.jsp'");
						}
					%>
				</span>
			</form>
		</div>
<!-- Column '컬럼명' cannot be null 에러 : https://okky.kr/articles/184533 -->
	</div>
	<!-- 부트스트랩 참조 영역 -->
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>