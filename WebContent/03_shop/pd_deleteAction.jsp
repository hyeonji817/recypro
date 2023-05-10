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
<meta http-equiv="Content-Type" content="text/html"; charset="UTF-8">
<title>상품 리뷰 삭제 기능 페이지</title>
</head>
<body>
	<%
		String pd_userId = null; 
		if (session.getAttribute("pd_userId") != null) {
			pd_userId = (String) session.getAttribute("pd_userId"); 
		}
		
		// 로그인 안 한 사용자 체크하는 부분 
// 		if (pd_userId == null) {
// 			PrintWriter prt = response.getWriter();
// 			prt.println("<script>");
// 			prt.println("alert('로그인 이후 이용가능한 서비스 입니다.')"); 
// 			prt.println("location.href = '../02_account/login.jsp'");
// 			prt.println("</script>");
// 		}
		
		int pd_reviewId = 0; 
		if (request.getParameter("pd_reviewId") != null) {
			pd_reviewId = Integer.parseInt(request.getParameter("pd_reviewId")); 
		}
		
		// 유효한 글인지 체크하는 부분 
		if (pd_reviewId == 0) {
			PrintWriter prt = response.getWriter();
			prt.println("<script>");
			prt.println("alert('유효하지 않은 글입니다.')");
			prt.println("location.href = '../03_shop/Product_Review.jsp'"); 
			prt.println("</script>"); 
		}
		
		pd_Review pdr = new pd_ReviewDAO().getPd_Review(pd_reviewId); 
		
		// 작성자와 로그인한 사용자가 같은 사용자인지 확인하는 부분 
		if (!pd_userId.equals(pdr.getPd_userid())) {
			PrintWriter prt = response.getWriter(); 
			prt.println("<script>");
			prt.println("alert('삭제 가능한 권한이 없습니다.')");
			prt.println("location.href = '../03_shop/Product_Review.jsp'");
			prt.println("</script>");
		} else {
			// 실제 Data 삭제를 위해 삭제 함수를 호출하는 부분 
			pd_ReviewDAO pd_rv = new pd_ReviewDAO(); 
			int result = pd_rv.delete(pd_reviewId);
			
			if (result >= 0) {
				PrintWriter prt = response.getWriter(); 
				prt.println("<script>");
				prt.println("alert('성공적으로 글을 삭제하였습니다.')"); 
				prt.println("location.href = '../03_shop/Product_Review.jsp'");
				prt.println("</script>");
			} else if (result == -1) {
				PrintWriter prt = response.getWriter(); 
				prt.println("<script>"); 
				prt.println("alert('글 삭제에 실패하였습니다.')"); 
				prt.println("history.back()"); 
				prt.println("</script>"); 
			}
		}
	%>
</body>
</html>