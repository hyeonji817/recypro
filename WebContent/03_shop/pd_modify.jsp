<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="pd_review.beans.pd_Review"%>
<%@ page import="pd_review.beans.pd_ReviewDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 어느 기기에서도 맞춤으로 보이는 반응형 웹에 사용되는 기본 Meta tag -->
<meta name="viewport" content="width-device-width" , initial-scale="1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>재활용품 전문점 : 리싸이프로 - 상품리뷰 수정페이지</title>
<style>
#pd_form h5 {
	width: 350px;
	float: left;  
	position: relative; 
	padding-top: 3%; 
	padding-right: 22%;
}

#pd_form h6 {
	float: left; 
	position: relative; 
	right: -2%;
	padding-top: 3.5%;
}

#pd_Image input {
	position: relative; 
	margin: 0 auto; 
	top: -80%;
}

/** 별점 구현 */
#pd_form fieldset {
	display: inline-block;
	direction: rtl; /** 한 번 알아봐야 겠다 */
	border: 0;
	position: relative; 
	right: 3%;
}

#pd_form fieldset legend {
	text-align: right; /** 별점 아이콘 위치 */
}

#pd_form input[type=radio] {
	display: none; /** radio 아이콘 표시 제거 */
}

#pd_form label {
	font-size: 3em; /** 별 크기 설정 */
	color: transparent; /** 아마 부모요소한테 물려받는 다는 뜻일듯 */
	text-shadow: 0 0 0 #f0f0f0; /** 별 색상인 듯 */
}

#pd_form label:hover {
	text-shadow: 0 0 0 rgb(136, 253, 230);
	/** 별점을 마우스로 갖다댈 때마다 해당 지정한 색상으로 표시, 일단은 한 별만 적용됨 */
}

#pd_form label:hover ~ label {
	text-shadow: 0 0 0 rgb(136, 253, 230);
	/** 별점을 오른쪽으로 마우스 갖다댈 때마다 연달아 색상 표시됨 */
}

#pd_form input[type=radio]:checked ~ label {
	text-shadow: 0 0 0 rgb(136, 253, 230);
}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>
	<%
		String pd_userId = request.getParameter("pd_viewvalue");

		// 로그인한 사용자들일 경우, userId에 값이 담기게 됨
		if (session.getAttribute("pd_userId") != null) {
			pd_userId = (String) session.getAttribute("pd_userId");
		}

		if (pd_userId == null) { // 로그인이 되지 않았을 경우
			PrintWriter pr = response.getWriter();
			pr.println("<script>");
			pr.println("alert('로그인이 필요합니다.')");
			pr.println("location.href = '../02_account/login.jsp'"); // 다시 로그인 페이지로 이동
			pr.println("</script>");
		}

		int pd_reviewId = 0; // 게시글 번호
		if (request.getParameter("pd_reviewId") != null) {
			pd_reviewId = Integer.parseInt(request.getParameter("pd_reviewId")); // 게시글 번호 받아오기
		}

		if (pd_reviewId == 0) { // 게시글이 존재하지 않는다는 얘기
			PrintWriter pr = response.getWriter();
			pr.println("<script>");
			pr.println("alert('유효하지 않은 글입니다.')");
			pr.println("location.href = '../03_shop/Product_Review.jsp'"); // 다시 게시글 페이지로 이동
			pr.println("</script>");
		}

		// 현재 작성한 글이 작성한 본인이 한 건지 확인
		pd_Review pd_review = new pd_ReviewDAO().getPd_Review(pd_reviewId);

		if (!pd_userId.equals(pd_review.getPd_userid())) { // !userId 세션값과 review.getUserId 작성한 사람이 동일한지의 여부
			PrintWriter pr = response.getWriter();
			pr.println("<script>");
			pr.println("alert('수정가능한 권한이 없습니다.')");
			pr.println("location.href = '../03_shop/Product_Review.jsp'"); // 다시 게시글 페이지로 이동
			pr.println("</script>");
		}
	%>

	<!-- 게시판 글쓰기 양식 부분 -->
	<div class="container">
		<div class="row">
			<form method="post"
				action="pd_modifyAction.jsp?pd_reviewId=<%=pd_reviewId%>" id="pd_form" name="pd_form">
				<!-- 데이터를 액션페이지로, 실제로 글 수정 -->
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd; position: relative; top: 22%; margin: 0 auto; width: 800px; left: 17%; right: 5%;">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">상품리뷰
								글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="pd_reviewTitle" maxlength="50"
								value="<%=pd_review.getPd_reviewTitle()%>"></input></td>
						</tr>
						<!-- <tr>
							<td>
								<h6>평점 매기기</h6>
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
						<!-- <tr>
							<td>
								<h5>상품 사진 업로드</h5>
								<div class="col-sm-6" id="pd_Image" style="position: relative; left: 10%; margin: 0 auto; height: 50px;">
									<input type="file" name="pd_Image" value="등록" class="pd_Image">
								</div>
							</td>
						</tr> -->
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="pd_reviewContent" maxlength="3000" style="height: 350px;"><%=pd_review.getPd_reviewContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-default pull-right" value="수정하기" style="position: relative; float: right; right: -17%; top: 26%; font-weight: bold; background-color: rgb(136, 253, 230);"></input>
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>