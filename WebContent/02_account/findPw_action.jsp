<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="login.beans.loginDAO"%>
<%@ page import="user.beans.User"%>
<%@ page import="user.beans.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.Connection"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="user" class="user.beans.User" scope="page" /><!-- id : beans 이름 -->
<jsp:setProperty name="user" property="id" />
<!-- 프로퍼티 : 자바빈에 저장되는 값 / property 값을 '*'로 하면 한꺼번에 저장 -->
<jsp:setProperty name="user" property="password" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리과정</title>
</head>
<body>
	<%
		Connection conn = null;
		String url = "jdbc:mysql://localhost:3306/recypro?useUnicode=true&serverTimezone=Asia/Seoul"; // db 연결할 url 서버주소
		String userid = "root"; // db에 입력할 id
		String password = "1234"; // db에 입력할 패스워드		
		String checkingID = null;
		PrintWriter script = response.getWriter();
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");

		Class.forName("com.mysql.cj.jdbc.Driver"); // 드라이버명, 자바코드와 db를 연결할 드라이버(연결다리)
		conn = DriverManager.getConnection(url, userid, password); // 연결 객체생성     

		UserDAO udao = new UserDAO();
		// 이놈이 문제 // 이놈이 문제 // 이놈이 문제
		String findpwinfo = udao.checkpwinfo(id, name, email); // 아이디를 DB에서 가져옴. 실패 시 Null 처리

		PreparedStatement pstmt = null;
		ResultSet rs = null; // select의 결과를 저장하는 객체, 명령에 대한 반환값 
		String sql = "select * from user where id = ?";
		pstmt = conn.prepareStatement(sql); // 연결 객체의 prepareStatement객체를 통해 해당 sql의 내용 호출
		pstmt.setString(1, findpwinfo);
		rs = pstmt.executeQuery();

		if (rs.next()) // rs 선언 후 rs.함수를 사용하려면 if 문 rs.next()를 한번 돌려줘야한다. 아니면 javax.servlet.ServletException: java.sql.SQLException: Illegal operation on empty result set. 에러발생함
		{
			checkingID = rs.getString("id");
		}

		if (id.equals(checkingID)) // 참고한 웹 페이지 주소좌표 : https://okky.kr/articles/181688 (String과 equals과의 상관관계)
		{
	%>
	<!-- 클릭없이 자동으로 submit 및 페이지 이동	https://m.blog.naver.com/PostView.naver?isHttpsRedirect=true&blogId=parkcs84&logNo=40041399055 -->
	<!-- form tag를 사용하여 입력값 넘기기 : https://chlee21.tistory.com/153 -->
	<!-- JSP 페이지 넘어갈 때 값 전달하기 : https://broship.tistory.com/74 -->
	<form name="help" method="post" action="findPw_result.jsp">

		<input type="hidden" name="id" value="<%=id%>"> <input
			type="hidden" name="name" value="<%=name%>"> <input
			type="hidden" name="email" value="<%=email%>">
	</form>
	<script>
		document.help.submit();
	</script>
	<%
		} else {
			// PrintWriter : 출력담당 객체. response 변수를 사용하여 응답 스트림에 텍스트 기록 (출력할 내용 보관)
			script.println("<script>");
			script.println("alert('입력한 ID가 존재하지 않습니다.')"); // 알림창 띄움 
			script.println("history.back()"); // 이전 페이지로 이동 
			script.println("</script>");
		}
	%>
</body>
</html>