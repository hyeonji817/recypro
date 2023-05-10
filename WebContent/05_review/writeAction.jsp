<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="review.beans.Review" %>
<%@ page import="review.beans.ReviewDAO" %> <!-- review 데이터베이스 접근 객체 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="review" class="review.beans.Review" scope="page"/>
<jsp:setProperty name="review" property="reviewTitle"/>
<jsp:setProperty name="review" property="reviewContent"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 쓰기 진행과정 페이지</title>
</head>
<body>
	<%
		String id = null;
		if (session.getAttribute("id") != null) {	// user가 접속이 되어있다면 세션값이 할당되어 있을 경우
			id = (String) session.getAttribute("id");
			System.out.println("로그인 완료");
			System.out.println(id);
		} 
	
		System.out.println("writeAction 테스트");	
		System.out.println(id);
		if (id == null) {	// 로그인이 안 되어 있으면 로그인하라고 안내
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 이후 이용가능한 서비스입니다.')");
			script.println("location.href='../02_account/login.jsp'");
			script.println("</script>");
		}
		else {	// 로그인이 되어있는 사람을 넘김
			// 빈 공간에 대한 처리, 입력 안 했을 때
			if (review.getReviewTitle() == null || review.getReviewContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('모든 칸을 입력해 주세요.')");
				script.println("history.back()");	// 뒤로 가기
				script.println("</script>");
			}
			else {	// 빈 공간이 아닌, 실제 입력 받기
				// 실제 Data 저장을 위해 저장 함수를 호출하는 부분 
				ReviewDAO reviewDAO = new ReviewDAO();	// 데이터베이스에 접근 가능한 객체 생성
				int result = reviewDAO.write(review.getReviewTitle(), id, review.getReviewContent());
			
				if (result == -1) {	// -1일 경우 데이터베이스 오류
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
				} else {	// 입력 성공
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'review.jsp'");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>