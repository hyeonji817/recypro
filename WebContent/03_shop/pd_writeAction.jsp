<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="order.beans.Order"%>
<%@ page import="order.beans.orderDAO"%>
<%@ page import="pd_review.beans.pd_Review" %>
<%@ page import="pd_review.beans.pd_ReviewDAO" %>
<%@ page import="product.beans.Product" %>
<%@ page import="product.beans.ProductRepository" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="pd_Review" class="pd_review.beans.pd_Review" scope="page"/>
<jsp:useBean id="product" class="product.beans.Product" />
<jsp:setProperty name="pd_Review" property="*"/>
<jsp:setProperty name="pd_Review" property="pd_reviewTitle" />
<jsp:setProperty name="pd_Review" property="pd_reviewContent" />
<jsp:setProperty name="product" property="*"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 리뷰 쓰기 진행과정 페이지</title>
</head>
<body>
	<%
	String id = (String) session.getAttribute("id");
	String pd_userId = (String) session.getAttribute("pd_userId");		// pd_userId라는 선언했던 클래스 변수에 사용자 이름값이 들어가게 하기 위해 세팅함 (그래야 사용자이름값이 출력될 가능성 높음)
	String pd_productId = request.getParameter("pd_productId");	// 이전 페이지(Product_write.jsp)에 선언했던 input 태그 내 name 요소 값을 Parameter로 호출함
	String pd_reviewTitle = request.getParameter("pd_reviewTitle");
	String pd_reviewContent = request.getParameter("pd_reviewContent"); 
	
	if (session.getAttribute("id") != null) {	// user가 접속이 되어있다면 세션값이 할당되어 있을 경우
		id = (String) session.getAttribute("id");
		System.out.println("pd_writeAction1");
	} 

	System.out.println(pd_userId);
	System.out.println("dadada");
	
	
	if (id == null) {	// 로그인이 안 되어 있으면 로그인하라고 안내
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 이후 이용가능한 서비스입니다.')");
		script.println("location.href='../02_account/login.jsp'");
		script.println("</script>");
	}
	else {	// 로그인이 되어있는 사람을 넘김
		// 빈 공간에 대한 처리, 입력 안 했을 때
		if (pd_Review.getPd_reviewTitle() == null  || pd_Review.getPd_reviewContent() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 칸을 입력해 주세요.')");
			script.println("history.back()");	// 뒤로 가기
			script.println("</script>");
		}
		else {	// 빈 공간이 아닌, 실제 입력 받기
			// 실제 Data 저장을 위해 저장 함수를 호출하는 부분 
			pd_ReviewDAO pd_Dao = new pd_ReviewDAO();	// 데이터베이스에 접근 가능한 객체 생성
			// int result = pd_Dao.write(pd_Review.getPd_productId(), pd_Review.getPd_reviewTitle(), pd_Review.getPd_userid(), pd_Review.getPd_reviewContent());
			int result = pd_Dao.write(pd_productId, pd_reviewTitle, pd_userId, pd_reviewContent);
			
			PrintWriter sct = response.getWriter();
			sct.println("nanana");
			sct.println(pd_Review.getPd_userid());
			
			if (result == -1) {	// -1일 경우 데이터베이스 오류
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {	// 입력 성공
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = '../03_shop/Product_Review.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>