<!-- 파일 업로드하는 과정을 처리하는 페이지 -->
<!-- 파일 업로드 : 웹 브라우저에서 서버로 파일을 전송하여 서버에 저장하는 것 -->
<!-- 서버로 업로드할 수 있는 파일 -->
<!-- 웹 브라우저에서 서버로 파일을 전송하기 위해 JSP 페이지에 폼 태그 사용 -->
<!-- 전송된 파일을 서버에 저장하기 위해 오픈 라이브버리를 이용 -->
<!-- cos.jar : 웹 to 웹으로 전송하는 간단한 데이터 라이브러리 -->
<!-- Apache commons upload : 일반적인 파일 업로드 기능 외에, 파일명 또는 저장되어야 할 위치에 대한 설정 가능한 라이브러리 -->
<!-- 출처좌표 : https://kjh95.tistory.com/258?category=941468 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드 처리</title>
</head>
<body>
	<%
		MultipartRequest multi = new MultipartRequest(request, "D:\\upload", 
				10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
		Enumeration params = multi.getParameterNames();
		
		while(params.hasMoreElements()) {
			String name = (String)params.nextElement();
			String value = multi.getParameter(name);
			out.println(name + "=" + value + "<br>");
		}
		
		out.println("-------------------------------------------<br/>");
		Enumeration files = multi.getFileNames();
		while(files.hasMoreElements()) {
			String name = (String)files.nextElement();
			String filename = multi.getFilesystemName(name);	// 파일이름 얻기 
			
			String original = multi.getOriginalFileName(name);	// 이전 파일이름 얻기 
			String type = multi.getContentType(name);	// 파일 타입(mp3, image...)
			File file = multi.getFile(name);	// 파일의 참조를 얻음. 
			
			out.println("요청이 들어온 파라미터 이름 : " + name + "<br/>");
			out.println("저장 파일 이름 : " + filename + "<br/>");
			out.println("실제 파일 이름 : " + original + "<br/>");
			out.println("파일 컨텐츠 유형 : " + type + "<br/>");
			
			if(file != null) {
				out.println("파일 크기 : " + file.length() + "<br/>");
				out.println("파일 경로 : " + file.getPath() + "<br/>");
			}
		}
	%>
</body>
</html>