<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.beans.Notice" %>
<%@ page import="notice.beans.noticeDAO" %>		<!-- notice 데이터베이스 접근 객체 -->
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="notice" class="notice.beans.Notice" scope="page" />
<jsp:setProperty name="notice" property="*" />
<jsp:setProperty name="notice" property="notice_title"/>
<jsp:setProperty name="notice" property="notice_content"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지글 쓰기 진행과정 페이지</title>
</head>
<body>
	<%
		String id = null;
		if (session.getAttribute("id") != null) {		// 사용자가 접속이 되어 있다면 세션값이 할당되어 있을 경우 
			id = (String) session.getAttribute("id");	
			System.out.println("로그인 완료"); 
			System.out.println(id);
		}
		
		System.out.println("notice_Action 테스트");
		System.out.println(id);

		 if (id != null) {		// 로그인이 되어 있는 사용자를 넘김 
			if (notice.getNotice_title() != null && notice.getNotice_content() != null) {		// 빈 공간이 아닌, 실제 입력 받기 
				// 실제 Data 저장을 위해 저장 함수를 호출하는 부분 
				noticeDAO notiDao = new noticeDAO();		// 데이터베이스에 접근 가능한 객체 생성 
				int result = notiDao.write(notice.getNotice_title(), id, notice.getNotice_content()); 
				
				if (result == -1) {		// DB 오류 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");
					System.out.println(result); 
					// System.out.println(notiDao);
				} else {		// 입력 성공 
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = '../06_customer/customer_notice.jsp'");
					script.println("</script>");
				}
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('모든 칸을 입력해 주세요.')");
				script.println("history.back()");	// 뒤로 가기
				script.println("</script>");
			}
		} else {		// 로그인이 되어있지 않을 경우 로그인하라고 안내 
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인 이후 이용가능한 서비스입니다.')");
			script.println("location.href='../02_account/login.jsp'");
			script.println("</script>");
		} 
	%>
</body>
</html>