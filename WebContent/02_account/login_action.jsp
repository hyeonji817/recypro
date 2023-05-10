<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login.beans.loginDAO" %>
<%@ page import="user.beans.User" %>
<%@ page import="user.beans.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.beans.User" scope="page"/><!-- id : beans 이름 -->
<jsp:setProperty name="user" property="id"/> <!-- 프로퍼티 : 자바빈에 저장되는 값 / property 값을 '*'로 하면 한꺼번에 저장 -->
<jsp:setProperty name="user" property="password"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리과정</title>
</head>
<body>
<%
	String id = null;	// id 변수값이 비어있음 
	// System.out.println 내용 주석처리 한 거 지웠음
	
	loginDAO loginDAO = new loginDAO();
	// UserDAO 클래스를 객체로 선언 (UserDAO 클래스 내 내용을 전부 갖고 오게 됨)
	int result = loginDAO.login(user.getId(), user.getPassword());	// loginDAO 객체 내 login 메소드함수 호출
// 	System.out.println(loginDAO.login(user.getId(), user.getPassword()));
	
	if (result == 1) {	// 아이디와 패스워드값이 DB에 저장된 내용과 일치할 경우 
		session.setAttribute("id", user.getId());	// 설정한 id변수명에 user.getId()의 값을 삽입		
		id = (String)session.getAttribute("id");
// 		System.out.println(id);
		// PrintWriter : 출력담당 객체. response 변수를 사용하여 응답 스트림에 텍스트 기록 (출력할 내용 보관)
		PrintWriter script = response.getWriter();
		
		if (id.equals("admin")) {
			script.println("<script>");		// java 내 스크립트 시작
			script.println("location.href = '../01_main/login_admin.jsp'");	// 응답에 따라 해당 페이지로 이동
			script.println("</script>");	// java 내 스크립트 끝
		} else {
			script.println("<script>"); // java 내 스크립트 시작		
			script.println("location.href = '../01_main/loginOK.jsp'");	// 응답에 따라 해당 페이지로 이동 
			script.println("</script>"); // java 내 스크립트 끝
		}
		
	} else if(result == 0) { // 패스워드가 불일치할 경우 
		System.out.println("result 0"); 
		PrintWriter script = response.getWriter();	
		// PrintWriter : 출력담당 객체. response 변수를 사용하여 응답 스트림에 텍스트 기록 (출력할 내용 보관)
		script.println("<script>");
		script.println("alert('비밀번호가 일치하지 않습니다.')");	// 알림창 띄움 
		script.println("history.back()");	// 이전 페이지로 이동 
		script.println("</script>");
	} else if(result == -1) {	// 아이디가 불일치할 경우 
		System.out.println("result -1");
		PrintWriter script = response.getWriter();
		// PrintWriter : 출력담당 객체. response 변수를 사용하여 응답 스트림에 텍스트 기록 (출력할 내용 보관)
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다.')");	// 알림창 띄움
		script.println("history.back()");	// 이전 페이지로 이동 
		script.println("</script>");
	} else if(result == -2) {	// DB 연동이 잘못되었을 경우 
		PrintWriter script = response.getWriter();	
		// PrintWriter : 출력담당 객체. response 변수를 사용하여 응답 스트림에 텍스트 기록 (출력할 내용 보관)
		script.println("<script>");
		script.println("alert('데이터베이스 오류가 발생했습니다.')");		// 알림창 띄움
		script.println("history.back()");	// 이전 페이지로 이동 
		script.println("</script>");
	}
	
// 	System.out.println(id);
%>
</body>
</html>