<!-- 참고한 웹 페이지 주소좌표 : https://kjh95.tistory.com/281?category=941468 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="product.beans.Product" %>
<%@ page import="product.beans.ProductRepository" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품주문</title>
</head>
<body>
	<%
		System.out.println("TEST ADDCART");	
		// 전송된 상품 id
		String id = request.getParameter("id");		// 여기에 콘솔로 실행해 보니 null이 뜬 걸로 보아, 문제가 생긴 구간인듯
	
		// 아이디가 없으면? 상품 id가 넘어오지 않았을 때 강제로 products.jsp 이동시키고 종료 
		if (id != null || id.trim().equals("")) {
			// products.jsp로 되돌아간다. 
			response.sendRedirect("Products.jsp");
		} 
		
		// 상품 저장소 객체 생성, 상품 데이터 접근 클래스의 인스턴스 생성 
		ProductRepository dao = ProductRepository.getInstance();
		
		// 상품 아이디에 해당하는 정보를 얻어보기 
		// 해당 id 값을 이용해서 상품 상세정보를 얻어오는 코드 ()
		Product product = dao.getProductById(id);
		System.out.println(product);
		// id의 값이 P9999 이런 경우 상품이 없다. 
		if (product == null) {	// 해당 상품이 없을 경우 
			response.sendRedirect("exceptionNoProductId.jsp");
		}
		
		// 모든 상품을 가져오기 
		ArrayList<Product> goodList = dao.getAllProducts();
		Product goods = new Product();
		for (int i=0; i<goodList.size(); i++) {
			// 상품리스트 중에서 사용자 주문을 한 해당 상품의 id가 일치하는 코드를 얻어서 Product에 대입 
			goods = goodList.get(i);
			if (goods.getProductId().equals(id)) {
				break;
			}
		}
		
		// 세션 속성의 이름이 cartList인 session정보 (장바구니에 담겨져 있는 물품 목록)를 가져와서 ArrayList에 대입
		ArrayList<Product> list = (ArrayList<Product>) session.getAttribute("cartList");
		out.print("list의 크기 : " + list);
		
		// cartList 값이 null이라면 새로운 ArrayList를 만들고 
		// 세션에 ArrayList를 만들고 세션에 cartList 이름으로 list라는 값을 대입 
		if (list == null) {
			list = new ArrayList<Product>();
		}
		
		// 사용자가 주문한 상품이 장바구니에 이미 담긴 물품인지 검색해서 있다면 수량을 증가 
		// 장바구니에 담긴 상품 목록 
		int cnt = 0;
		Product goodsQnt = new Product();
		for (int i=0; i<list.size(); i++) {
			goodsQnt = list.get(i);
			if (goodsQnt.getProductId().equals(id)) {
				cnt++;
				int orderQuantity = goodsQnt.getQuantity() + 1;
				goodsQnt.setQuantity(orderQuantity);
			}
		}
		
		// 사용자가 주문한 상품이 장바구니에 없다면 수량을 1로 바꿔주고 
		// 장바구니 역할을 하고 있는 ArrayList에 추가함 
		// 요청 파라미터 아이디의 상품이 장바구니에 없다면 해당상품의 수량을 1로 처리 
		if (cnt == 0) {
			goods.setQuantity(1);
			list.add(goods);
		}
		session.setAttribute("cartList", list);
		session.getAttribute("cartList"); 
	%>
</body>
</html>