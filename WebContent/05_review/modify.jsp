<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="review.beans.Review"%>
<%@ page import="review.beans.ReviewDAO"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 어느 기기에서도 맞춤으로 보이는 반응형 웹에 사용되는 기본 Meta tag -->
<meta name="viewport" content="width-device-width" , initial-scale="1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<title>게시판 수정페이지</title>
</head>
<body>
<%@ include file="../01_main/index.jsp"%>
	<%
		String userId = request.getParameter("viewvalueforward");		// 이전 페이지의 name 속성값을 호출하여 userId에 저장 (name 속성값이 소속된 태그의 내용을 불러들이기 위함)
		System.out.println("여기는 modify.jsp 페이지");
		System.out.println(userId);
		System.out.println("있는지 확인");
		// 로그인한 사용자들일 경우, userId에 값이 담기게 됨
		if (session.getAttribute("userId") != null) {
			userId = (String) session.getAttribute("userId");
		}

		if (userId == null) { // 로그인이 되지 않았을 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인이 필요합니다.')");
			script.println("location.href = '../02_account/login.jsp'"); // 다시 로그인 페이지로 이동
			script.println("</script>");
		}

		int reviewId = 0; // 게시글 번호
		if (request.getParameter("reviewId") != null) {
			reviewId = Integer.parseInt(request.getParameter("reviewId")); // 게시글 번호 받아오기
		}

		if (reviewId == 0) { // 게시글이 존재하지 않는다는 얘기
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'review.jsp'"); // 다시 게시글 페이지로 이동
			script.println("</script>");
		}

		// 현재 작성한 글이 작성한 본인이 한 건지 확인
		// 해당 reviewId에 대한 게시글을 가져온 다음, 세션을 통하여 작성자 본인이 맞는지 체크 
		Review review = new ReviewDAO().getReview(reviewId);

		if (!userId.equals(review.getUserId())) { // !userId 세션값과 review.getUserId 작성한 사람이 동일한지의 여부
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정가능한 권한이 없습니다.')");
			script.println("location.href = 'review.jsp'"); // 다시 게시글 페이지로 이동
			script.println("</script>");
		}
	%>

	<!-- 게시판 글쓰기 양식 부분 -->
	<div class="container">
		<div class="row">
			<form method="post" action="modifyAction.jsp?reviewId=<%=reviewId %>" style="width: 1000px; padding-top: 20%; margin: auto 0;">
				<!-- 데이터를 액션페이지로, 실제로 글 수정 -->
				<table class="table table-striped"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글 수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="reviewTitle" maxlength="50"
								value="<%=review.getReviewTitle()%>"></input></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="reviewContent" maxlength="3000" style="height: 350px;"><%=review.getReviewContent()%></textarea></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-default pull-right" style="float: right; background-color: #b6f5f5; color: black; font-weight: bold;" value="수정하기"></input>
			</form>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>