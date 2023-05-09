<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="product.beans.Product" %>
<%@ page import="product.beans.ProductRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>해당상품 삭제</title>
</head>
<body>
	<%
		String id = request.getParameter("id");	// 삭제할 상품 id
		
		// 상품 id가 넘어오지 않았을 때 강제로 products.jsp로 이동시키고 종료 
		if (id == null || id.trim().equals("")) {
			response.sendRedirect("products.jsp");
			return;
		}
		
		// 상품 데이터 접근 클래스의 인스턴스 생성
		ProductRepository dao = ProductRepository.getInstance();
		
		// 해당 id값을 이용해서 상품 상세정보를 얻어오는 코드
		Product product = dao.getProductById(id);
		if (product == null) {
			response.sendRedirect("exceptionNoProductId.jsp");
		}
		
		ArrayList<Product> cartList = (ArrayList<Product>)session.getAttribute("cartList");
		Product goodQnt = new Product();
		for (int i=0; i<cartList.size(); i++) {
			goodQnt = cartList.get(i);
			if (goodQnt.getProductId().equals(id)) {
				cartList.remove(goodQnt);
			}
		}
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>