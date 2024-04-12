<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="coupon.beans.Coupon" %>
<%@ page import="coupon.beans.couponDAO" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="coupon" class="coupon.beans.Coupon" scope="page" />
<jsp:setProperty name="coupon" property="*" />
<jsp:setProperty name="coupon" property="coupon_title" />
<jsp:setProperty name="coupon" property="coupon_period" />
<jsp:setProperty name="coupon" property="coupon_start" />
<jsp:setProperty name="coupon" property="coupon_end" />
<jsp:setProperty name="coupon" property="coupon_extend" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰글 등록 진행과정 페이지</title>
</head>
<body>
	<%
		String id = null; 
		if (session.getAttribute("id") != null) {
			id = (String) session.getAttribute("id");
			System.out.println("로그인 완료"); 
			System.out.println(id);
		}
		
		System.out.println("coupon_Action 테스트");
		System.out.println(id);
		
		if (id != null) {
			if (coupon.getCoupon_title() != null && coupon.getCoupon_period() != null && coupon.getCoupon_start() != null && coupon.getCoupon_end() != null && coupon.getCoupon_expend() != null) {
				// 실제 Data 저장을 위해 저장 함수를 호출하는 부분 
				couponDAO cpDao = new couponDAO(); 		// 데이터베이스에 접근 가능한 객체 생성 
				int result = cpDao.register(coupon.getCoupon_title(), coupon.getCoupon_period(), coupon.getCoupon_start(), coupon.getCoupon_end(), coupon.getCoupon_expend());
				
				if (result == -1) {
					PrintWriter pw = response.getWriter();
					pw.println("<script>");
					pw.println("alert('등록에 실패했습니다."); 
					pw.println("history.back()");
					pw.println("</script>"); 
					System.out.println(result); 
				} else {
					PrintWriter pw = response.getWriter();
					pw.println("<script>");
					pw.println("location.href = '../04_mypage/coupon_list.jsp'");
					pw.println("</script>");
				}
			} else {
				PrintWriter pw = response.getWriter(); 
				pw.println("<script>");
				pw.println("alert('모든 칸을 입력해 주세요.')"); 
				pw.println("history.back()");
				pw.println("</script>");
			}
		} else {
			PrintWriter pw = response.getWriter(); 
			pw.println("<script>"); 
			pw.println("alert('로그인 이후 이용가능한 서비스입니다.')"); 
			pw.println("location.href = '../02_account/login.jsp'");
			pw.println("</script>");
		}
	%>
</body>
</html>