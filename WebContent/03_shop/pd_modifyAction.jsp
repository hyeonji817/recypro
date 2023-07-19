<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pd_review.beans.pd_Review" %>
<%@ page import="pd_review.beans.pd_ReviewDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재활용품 전문점 : 리싸이프로 - 상품 리뷰 수정하기 처리과정 페이지</title>
</head>
<body>
	<%
		// 세션에 값이 담겨 있는지 체크 
		String pd_userId = (String) session.getAttribute("id");
	
		if (session.getAttribute("pd_userId") != null) {	// user가 접속이 되어있다면 세션값이 할당되어 있을 경우
			pd_userId = (String) session.getAttribute("pd_userId");
		}
		
		// 로그인하지 않은 사용자가 체크하는 부분
		if (pd_userId == null) {
			PrintWriter pwr = response.getWriter();
			pwr.println("<script>");
			pwr.println("alert('로그인 이후 이용가능한 서비스입니다.')");
			pwr.println("location.href = '../02_account/login.jsp'");
			pwr.println("</script>");
		}
		
		// 글을 수정할 권한이 있는지 확인 
		int pd_reviewId = 0;		// 게시글 번호 
		if (request.getParameter("pd_reviewId") != null) {
			pd_reviewId = Integer.parseInt(request.getParameter("pd_reviewId"));	// 게시글 번호 받아오기 
		}
		
		System.out.println(pd_reviewId);
		
		// 유효한 글인지 체크하는 부분 
		if (pd_reviewId == 0) {
			PrintWriter pwr = response.getWriter();
			pwr.println("<script>");
			pwr.println("alert('유효하지 않은 글입니다.')");
			pwr.println("location. href = '../03_shop/Product_Review.jsp'");	// 다시 게시글 페이지로 이동 
			pwr.println("</script>");
		}
		
		// 현재 작성한 글이 작성한 본인이 한 건지 확인. 수정권한 확인 
		pd_Review pd_review = new pd_ReviewDAO().getPd_Review(pd_reviewId); 
		
		// 작성자와 로그인한 사용자가 같은 사용자인지 확인하는 부분 
		if (!pd_userId.equals(pd_review.getPd_userid())) {
			PrintWriter pwr = response.getWriter();
			pwr.println("<script>");
			pwr.println("alert('수정가능한 권한이 없습니다.')");
			pwr.println("location.href = '../03_shop/Product_Review.jsp'");
			pwr.println("</script>");
		} else {
			// 매개변수로서 글 제목 내용을 넘겨서 빈 공간 확인 
			if (request.getParameter("pd_reviewTitle") == null || request.getParameter("pd_reviewContent") == null || 
					request.getParameter("pd_reviewTitle").equals("") || request.getParameter("pd_reviewContent").equals("")) {
			// if (request.getParameter("pd_reviewTitle") == null || request.getParameter("pd_reviewContent") == null || 
				/**	request.getParameter("pd_reviewTitle").equals("") || request.getParameter("reviewStar").equals("") || 
					request.getParameter("pd_reviewContent").equals("")) { */
				PrintWriter pwr = response.getWriter();
				pwr.println("<script>");
				pwr.println("alert('모든 칸을 입력해주십시오.')");
				pwr.println("history.back()");
				pwr.println("</script>");
			} else {
				// 실제 Data 수정을 위해 수정 함수를 호출하는 부분 
				pd_ReviewDAO pd_reviewDAO = new pd_ReviewDAO();
				int result = pd_reviewDAO.modify(pd_reviewId, request.getParameter("pd_reviewTitle"), request.getParameter("pd_reviewContent"));
				
				if (result == -1) {
					PrintWriter pwr = response.getWriter();
					pwr.println("<script>");
					pwr.println("alert('글 수정에 실패했습니다.')");
					pwr.println("history.back()");
					pwr.println("</script>");
				} else {
					PrintWriter pwr = response.getWriter();
					pwr.println("<script>");
					pwr.println("location.href = '../03_shop/Product_Review.jsp'");
					pwr.println("</script>");
				}
			}
		}
	%>
</body>
</html>