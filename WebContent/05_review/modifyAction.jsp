<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="review.beans.Review"%>
<%@ page import="review.beans.ReviewDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정하기 처리과정 페이지</title>
</head>
<body>
	<%
		// 세션에 값이 담겨있는지 체크 
		String userId = (String) session.getAttribute("id");
		if (session.getAttribute("userId") != null) { // user가 접속이 되어있다면 세션값이 할당되어 있을 경우
			userId = (String) session.getAttribute("userId");
		}

		// 로그인하지 않은 사용자가 체크하는 부분
		if (userId == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 이후 이용가능한 서비스 입니다.')");
			script.println("location.href = '../02_account/login.jsp'");
			script.println("</script>");
		}

		// 글을 수정할 권한이 있는지 확인
		int reviewId = 0; // 게시글 번호
		if (request.getParameter("reviewId") != null) {
			reviewId = Integer.parseInt(request.getParameter("reviewId")); // 게시글 번호 받아오기
		}

		// 유효한 글인지 체크하는 부분
		if (reviewId == 0) { // 게시글이 존재하지 않는다는 얘기
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'review.jsp'"); // 다시 게시글 페이지로 이동
			script.println("</script>");
		}

		// 현재 작성한 글이 작성한 본인이 한 건지 확인. 수정권한 확인
		Review review = new ReviewDAO().getReview(reviewId);

		// 작성자와 로그인한 사용자가 같은 사용자인지 확인하는 부분
		if (!userId.equals(review.getUserId())) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('수정가능한 권한이 없습니다.')");
			script.println("location.href = 'review.jsp'");
			script.println("</script>");
		} else {
			// 매개변수로서 글 제목 내용을 넘겨서 빈 공간 확인
			if (request.getParameter("reviewTitle") == null || request.getParameter("reviewContent") == null
					|| request.getParameter("reviewTitle").equals("")
					|| request.getParameter("reviewContent").equals("")) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('모든 칸을 입력해주십시오.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				// 실제 Data 수정을 위해 수정 함수를 호출하는 부분
				ReviewDAO reviewDAO = new ReviewDAO();
				int result = reviewDAO.modify(reviewId, request.getParameter("reviewTitle"),
						request.getParameter("reviewContent"));

				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 수정에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('권한이 없습니다')");
					script.println("location.href = 'review.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>