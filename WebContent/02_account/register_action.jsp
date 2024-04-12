<!-- 참고했던 웹 페이지 출처좌표 : https://happy-inside.tistory.com/entry/JSP-JSP-%EA%B2%8C%EC%8B%9C%ED%8C%90-%EB%A7%
8C%EB%93%A4%EA%B8%B0-6%EA%B0%95-%ED%9A%8C%EC%9B%90%EA%B0%80%EC%9E%85-%EA%B8%B0%EB%8A%A5-%EA%B5%AC%ED%98%84%ED%95%9
8%EA%B8%B0 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "user.beans.User" %>
<%@ page import = "user.beans.UserDAO" %>
<%@ page import = "register.beans.RegisterDAO"%>
<%@ page import = "java.io.PrintWriter"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="User" class="user.beans.User" scope="page"/> 
<!-- 회원가입 페이지에서 받아오는 데이터를 다 받아와야 하기 때문에 회원 정보 요소를 모두 추가한다. -->
<jsp:setProperty name="User" property="*"/>
<jsp:setProperty name="User" property="id"/> 
<jsp:setProperty name="User" property="password"/> 
<jsp:setProperty name="User" property="name"/>
<jsp:setProperty name="User" property="age"/>
<jsp:setProperty name="User" property="gender"/>
<jsp:setProperty name="User" property="email"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원가입 처리과정</title>
</head>
<body>
<%
	String id = request.getParameter("id");	// 입력할 id를 호출할 변수 선언 
	String password = request.getParameter("password");	// 입력할 password를 호출할 변수 선언 
	String name = request.getParameter("name");	// 입력할 name을 호출할 변수 선언
	String age = request.getParameter("age");
	String gender = request.getParameter("gender");		// 입력할 gender를 호출할 변수 선언
	String email = request.getParameter("email");	// 입력할 email을 호출할 변수 선언

// 	if (session.getAttribute("id") != null); {	// 입력한 변수 id의 값이 비어있지 않을 때,(입력값이 있을 때)
// 		id = (String) session.getAttribute("id");	// 선택한 id의 속성값을 가져옴 (입력한 id값 가져온다는 뜻)
// 	}

	System.out.println("getparameter는 name 태그에서 값을 가져옴");
	System.out.println(id);
	System.out.println(password);
	System.out.println(name);
	System.out.println(age);
	System.out.println(gender);
	System.out.println(email);
	System.out.println("다시 시작");
	System.out.println(User.getId());
	System.out.println(User.getPassword());
	System.out.println(User.getName());
	System.out.println(User.getAge());
	System.out.println(User.getGender());
	System.out.println(User.getEmail());
	System.out.println("설마 이것도? 끝");

	// user 빈즈 내의 (입력될) id 변수값 또는 password 변수값이 비어있을 때 
	// -1 : 서버 오류 / 0 : 이미 존재하는 아이디 / 1 : 성공 
	if (id == null || password == null || name == null || age == null || gender == null || email == null) {	 // 수정완료 20221106 224300
		PrintWriter script = response.getWriter();	
		// PrintWriter : 문자 출력담당 객체. response 변수를 사용하여 응답 스트림에 텍스트 기록. 
		// PrintWriter : 바이트 및 문자 출력 스트림을 가지고 객체를 생성할 수 있는 클래스 
		script.println("<script>");	// 스트림에 텍스트를 기록 
		script.println("alert('입력이 되지 않은 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		//UserDAO userDAO = new UserDAO();	// 데이터베이스에 접근 가능한 객체 생성
		//int result = userDAO.join(user);
		// RegisterDAO RegisterDAO = new RegisterDAO();	// UserDAO 클래스를 객체로 선언 (UserDAO 클래스 내 내용을 전부 갖고 오게 됨)
		UserDAO userDAO = new UserDAO();
		
		int result = userDAO.join(User);	// userDAO 객체 내 join 메소드함수 호출
		System.out.println(result);
		
		if (result == -1) {		// 아이디 값이 일치하지 않을 때
			PrintWriter script = response.getWriter();	// response 변수를 사용하여 응답 스트림에 텍스트 기록 (출력할 내용 보관)
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");		// 알림창 호출 
			script.println("history.back()");	// 이전 페이지로 이동 
			script.println("</script>");
		} else  {
			session.setAttribute("id", User.getId());	// 설정한 id변수명에 user.getId()의 값을 삽입 
			// setAttribute() : 선택한 요소의 속성값을 정함 
			// session.setAttribute("설정한 세션아이디", 세션에 넣을 값) : 설정한 세션아이디명에 세션에 넣을 값을 투입 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../02_account/login.jsp'");	// 해당 페이지로 이동 
			script.println("</script>");
		}
	}
	 
	// 주소좌표 : https://velog.io/@jsw4215/%ED%9A%8C%EC%9B%90%EA%B0%80%EC%9E%85
%>
</body>
</html>