<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="question.beans.Question" %>
<%@ page import="question.beans.questionDAO" %>			<!-- question 데이터베이스 접근 객체 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="question" class="question.beans.Question" scope="page" />
<jsp:setProperty name="question" property="*" />
<jsp:setProperty name="question" property="question_title"/>
<jsp:setProperty name="question" property="question_response"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주묻는질문 쓰기 진행과정 페이지</title>
</head>
<body>
	<%
		String id = null;
		if (session.getAttribute("id") != null) {		// 사용자가 접속이 되어 있다면 세션값이 할당되어 있을 경우 
			id = (String) session.getAttribute("id");	
			System.out.println("로그인 완료"); 
			System.out.println(id);
		}
	
		System.out.println("question_Action 테스트");
		System.out.println(id);
		
		if (id != null) {
			if (question.getQuestion_title() != null && question.getQuestion_response() != null) {
				// 실제 Data 저장을 위해 저장 함수를 호출하는 부분 
				questionDAO queDao = new questionDAO();		// 데이터베이스에 접근 가능한 객체 생성 
				int result = queDao.write(question.getQuestion_title(), question.getQuestion_response()); 
				
				if (result == -1) {
					PrintWriter script = response.getWriter(); 
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')"); 
					script.println("history.back()");
					script.println("</script>");
					System.out.println(result);
				} else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = '../06_customer/customer_question.jsp'");
					script.println("</script>");
				}
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('모든 칸을 입력해 주세요.')");
				script.println("location.href='../02_account/login.jsp'");
				script.println("</script>");
			}
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 이후 이용가능한 서비스입니다.')");
			script.println("location.href='../02_account/login.jsp'");
			script.println("</script>");
		}
	%>
</body>
</html>