<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="javax.mail.Transport" %>
<%@ page import="javax.mail.Message" %>
<%@ page import="javax.mail.Address" %>
<%@ page import="javax.mail.internet.InternetAddress" %>
<%@ page import="javax.mail.internet.MimeMessage" %>
<%@ page import="javax.mail.Session" %>
<%@ page import="javax.mail.Authenticator" %>
<%@ page import="java.util.Properties" %>
<%@ page import="user.beans.UserDAO" %>
<%@ page import="user.beans.SHA256" %>	<!-- 이게 뭔지 한 번 알아봐야 할 듯 -->
<%@ page import="user.beans.Gmail" %>
<%@ page import="java.io.PrintWriter" %>
<%
	UserDAO ud = new UserDAO(); 
	String id = null; 
	
	if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id"); 	// 로그인 시, 아이디를 입력했을 때, 입력한 아이디값이 변수 id에 저장하여 호출
	}
	
	if (id == null) {
		PrintWriter script = response.getWriter(); 
		script.println("<script>");
		script.println("alert('로그인을 해 주세요.')");
		script.println("location.href = '../02_account/login.jsp'");
		script.println("</script>"); 
		script.close();		// 스크립트 태그가 끝났으면 반드시 닫아줘야 함 
		return; 
	}
	
	request.setCharacterEncoding("UTF-8"); 
	String declarePlace = null; 	// input 관련 태그 안의 name 값을 호출할 변수 선언하는 듯
	String declare_reason = null; 
	
	if (request.getParameter("declarePlace") != null) {
		declarePlace = request.getParameter("declarePlace"); // 신고장소가 입력되었을 경우(선택되거나), 선택된 해당값을 변수에 대입하여 호출 
	}
	
	if (request.getParameter("declare_reason") != null) {
		declare_reason = request.getParameter("declare_reason"); // 신고사유가 입력되었을 경우, 해당값을 변수에 대입하여 호출하는 듯
	}
	
	String host = "http://localhost:8080/recypro/"; 
	String from = "yourEmail@gmail.com";	// 당신의 이메일 
	String to = "yourEmail@naver.com";		// 당신의 이메일 
	String subject = "게시판 페이지에서 접수된 신고 메일입니다."; 
	String content = "신고자: " + id + "<br>신고장소: " + declarePlace + "<br>신고사유: " + declare_reason;
	
	Properties p = new Properties(); 
	p.put("mail.smtp.user", from); 
	p.put("mail.smtp.host", "smtp.googlemail.com");
	p.put("mail.smtp.post", "456"); 
	p.put("mail.smtp.starttls.enable", "true"); 
	p.put("mail.smtp.auth", "true"); 
	p.put("mail.smtp.debug", "true"); 
	p.put("mail.smtp.socketFactory.port", "465"); 
	p.put("mail.smtp.socketFactory.class", "javax.mail.ssl.SSLSocketFactory"); 
	p.put("mail.smtp.socketFactory.fallback", "false"); 
	
	try {
		   Authenticator auth = new Gmail();
		   Session ses = Session.getInstance(p, auth);
		   ses.setDebug(true);
		   MimeMessage msg = new MimeMessage(ses);
		   msg.setSubject(subject);
		   Address fromAddr = new InternetAddress(from);
		   msg.setFrom(fromAddr);
		   Address toAddr = new InternetAddress(to);
		   msg.addRecipient(Message.RecipientType.TO, toAddr);
		   msg.setContent(content, "text/html;charset=UTF8");
		   Transport.send(msg);   
	   } catch (Exception e) {
		   e.printStackTrace();
		   PrintWriter script = response.getWriter();
		   script.println("<script>");
		   script.println("alert('오류가 발생했습니다..');");
		   script.println("history.back();");
		   script.println("</script>");
		   script.close();
		   return;
	   }
	   PrintWriter script = response.getWriter();
	   script.println("<script>");
	   script.println("alert('정상적으로 신고되었습니다.');");
	   script.println("history.back();");
	   script.println("</script>");
	   script.close();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>