<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 삭제</title>
</head>
<body>
	<%
		// 모든 상품을 삭제하기 위해서 sessionID값을 얻음
		String id = request.getParameter("cartId");
		if (id == null || id.trim().equals("")){	// trim() 공백
			response.sendRedirect("cart.jsp");
			return;
		}
		
		// 장바구니에 등록된 모든 상품을 삭제
		session.invalidate();
		
		// cart.jsp로 되돌아가기 
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>