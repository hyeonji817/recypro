<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.beans.UserDAO" %>
<%@ page import="user.beans.User" %>
<%@ page import="java.io.PrintWriter" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!-- 액션태그 사용 : 전달된 정보를 저장 (아이디, 비번, 이름, 나이, 성별, 이메일) -->
<jsp:useBean id="user" class="user.beans.User" />
<%-- <jsp:useBean id="user" class="user.beans.UserDAO" /> --%>
<!-- 파라미터 값 저장 -->
<jsp:setProperty property="*" name="user"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정페이지</title>
</head>
<body>
	<%
		// 실험용
		// 입력 양식에서 전달받은 데이터를 받음 
		String id = (String) session.getAttribute("id");
	
		// 한글처리 & 로그인 여부체크 -> 로그인 페이지로 이동 
		request.setCharacterEncoding("UTF-8");
		
		if (id == null) {
			response.sendRedirect("../02_account/login.jsp");
		}
	%>
	
	
	<%
		// UserDAO 객체 생성 (UserDAO 메소드 객체 내 메소드 기능들을 호출하기 위함)		
		UserDAO userDAO = new UserDAO();
	
		// 회원정보 처리과정 (userDAO)		
		int result = userDAO.updateUser(user);
		

		// 회원정보 수정 결과 
		// 데이터처리 : 1-수정완료, 0-비번오류, -1-아이디없음
		if (result == 1) {
			%>
			<script type="text/javascript">
				alert("회원정보 수정 성공");
				history.back();
			</script>
			<%
			response.sendRedirect("../01_main/loginOK.jsp");
		} else if(result == 0) {
			%>
			<script type="text/javascript">
				alert("비밀번호 오류로 회원정보 수정실패");
				history.back();
			</script>
			<%
		} else {
			%>
			<script type="text/javascript">
				alert("존재하지 않는 아이디입니다.");
				history.back();
			</script>
			<% 
		}
	%>
</body>
</html>