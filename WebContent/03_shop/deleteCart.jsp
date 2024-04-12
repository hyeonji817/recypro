<!-- 참고한 웹 페이지 주소 좌표 : https://kjh95.tistory.com/281?category=941468 -->
<!-- 장바구니 비우기 - 전체 삭제하기 (세션삭제) -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 비우기</title>
</head>
<body>
	<%
		// 모든 상품을 삭제하기 위해 sessionID 값을 얻음 
		String id = request.getParameter("cartId");
		if (id == null || id.trim().equals("")) { 	// trim() 공백
			response.sendRedirect("cart.jsp");
			return;
		}
		
		session.invalidate();	// 세션 삭제(비활성화)
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>