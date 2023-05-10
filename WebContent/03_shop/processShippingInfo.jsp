<!-- 참고한 웹 사이트 주소좌표 : https://kjh95.tistory.com/284?category=941468 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%
	request.setCharacterEncoding("utf-8");

	/** 이 페이지에서 로직을 처리하고 다 수행하고 난 뒤에 다른 페이지로 이동하기에
	한 번 더 문자셋을 맞추어 주기 위해서 URLEncoder 클래스를 사용하여 다시 인코딩함 */
	Cookie cartId = new Cookie("Shopping_cartId", URLEncoder.encode(request.getParameter("cartId"), "utf-8"));
	Cookie name = new Cookie("Shopping_name", URLEncoder.encode(request.getParameter("name"), "utf-8"));
	Cookie shoppingDate = new Cookie("Shopping_date", URLEncoder.encode(request.getParameter("shoppingDate"), "utf-8"));
	Cookie country = new Cookie("Shopping_country", URLEncoder.encode(request.getParameter("country"), "utf-8"));
	Cookie zipCode = new Cookie("Shopping_zipCode", URLEncoder.encode(request.getParameter("zipCode"), "utf-8"));
	Cookie addressName = new Cookie("Shopping_addressName", URLEncoder.encode(request.getParameter("addressName"), "utf-8"));
	
	// 각 쿠키에 유효시간 설정 (하루)
	cartId.setMaxAge(60*60*24);
	name.setMaxAge(60*60*24);
	shoppingDate.setMaxAge(60*60*24);
	country.setMaxAge(60*60*24);
	zipCode.setMaxAge(60*60*24);
	addressName.setMaxAge(60*60*24);
	
	// 응답객체에 추가 
	response.addCookie(cartId);
	response.addCookie(name);
	response.addCookie(shoppingDate);
	response.addCookie(country);
	response.addCookie(zipCode);
	response.addCookie(addressName);
	
	// 주문 정보 확인 위해 orderConfirmation.jsp 파일로 이동 
	response.sendRedirect("orderConfirmation.jsp");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>