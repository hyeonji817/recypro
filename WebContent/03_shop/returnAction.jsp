<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="orderlist1.beans.orderlist1" %>
<%@ page import="orderlist1.beans.orderlist1DAO" %>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>returnAction.jsp 페이지(반품신청 처리과정)</title>
</head>
<body>
	<%
		String id = null; 
		if (session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
			System.out.println(id);
		}
		
		System.out.println("returnAction 테스트"); 
		System.out.println(id); 
		
		if (id == null) {
			PrintWriter sct = response.getWriter(); 
			sct.println("<script>"); 
			sct.println("alert('로그인 이후 이용 가능한 서비스입니다.')"); 
			sct.println("location.href='../02_account/login.jsp'"); 
			sct.println("</script>"); 
		} else {
			if (orderlist1.getShopping_num() == null || orderlist1.getReturn_reason() == null) {
				PrintWriter sct = response.getWriter(); 
				sct.println("<script>"); 
				sct.println("alert('모든 칸을 입력해 주세요.')"); 
				sct.println("history.back()");
				sct.println("</script>"); 
			} else {	// 빈 공간이 아닌, 실제 입력 받기 
				// 실제 Data 저장을 위해 저장 함수를 호출하는 부분 
				orderlist1DAO odao1 = new orderlist1DAO(); 	// 데이터베이스에 접근 가능한 객체 생성 
				int result = odao1.order1(orderlist1.getShopping_num(), id, orderlist1.getReturn_reason());
				
				if (result == -1) {
					PrintWriter sct = response.getWriter(); 
					sct.println("<script>"); 
					sct.println("alert('글쓰기에 실패했습니다.')"); 
					sct.println("history.back()");
					sct.println("</script>"); 
				} else {
					PrintWriter sct = response.getWriter(); 
					sct.println("<script>");
					sct.println("location.href = 'return_after.jsp'"); 
					sct.println("</script>"); 
				}
			}
		}
	%>
</body>
</html>