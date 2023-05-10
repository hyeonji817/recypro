<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="user.beans.User"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 수정페이지</title>
</head>
<body>
	<%
		// 한글처리 & 로그인 여부체크 -> 로그인 페이지로 이동 
		request.setCharacterEncoding("UTF-8");
		String id = (String) session.getAttribute("id");
		if (id == null) {
			response.sendRedirect("../02_account/login.jsp");
		}
	%>

	<!-- 액션태그 사용 : 전달된 정보를 저장 (아이디, 비번, 이름, 나이, 성별, 이메일) -->
	<jsp:useBean id="user" class="user.beans.User" />
	<!-- 파라미터 값 저장 -->
	<jsp:setProperty property="*" name="user" />

	<%
		// UserDAO 객체 생성 
		UserDAO userDAO = new UserDAO();
		// 데이터처리 : 1-수정완료, 0-비번오류, -1-아이디없음		
		int result2 = userDAO.passwordchange(user);

		// 비밀번호 수정 처리과정
		if (result2 == 1) {
	%>
	<script type="text/javascript">
		alert("변경 비밀번호가 동일합니다.");
		history.back();
	</script>
	<%
		} else if (result2 == 0) {
	%>
	<script type="text/javascript">
		alert("변경 비밀번호가 동일하지 않습니다.");
		history.back();
	</script>
	<%
		} else {
	%>
	<script type="text/javascript">
		alert("그 외의 요인으로 실패.");
		history.back();
	</script>
	<%
		}
	%>
</body>
</html>