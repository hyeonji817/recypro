<!-- 파일을 다중으로 업로드 처리하는 과정을 담은 페이지 -->
<!-- 참고한 웹 페이지 주소좌표 : https://kjh95.tistory.com/258 -->
<!-- 파일 업로드 : 웹 브라우저에서 서버로 파일을 전송하여 서버에 저장하는 것 -->
<!-- 서버로 업로드할 수 있는 파일 -->
<!-- 웹 브라우저에서 서버로 파일을 전송하기 위해 JSP 페이지에 폼 태그 사용 -->
<!-- 전송된 파일을 서버에 저장하기 위해 오픈 라이브버리를 이용 -->
<!-- cos.jar : 웹 to 웹으로 전송하는 간단한 데이터 라이브러리 -->
<!-- Apache commons upload : 일반적인 파일 업로드 기능 외에, 파일명 또는 저장되어야 할 위치에 대한 설정 가능한 라이브러리 -->
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 다중 업로드 처리</title>
</head>
<body>
	<%
		MultipartRequest multi = new MultipartRequest(request, "D:\\upload",
				1000*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
	
		// 업로드된 이름과 제목을 가져온다. 
		String name1 = multi.getParameter("name1");
		String title1 = multi.getParameter("title1");
		
		String name2 = multi.getParameter("name2");
		String title2 = multi.getParameter("title2");
		
		String name3 = multi.getParameter("name3");
		String title3 = multi.getParameter("title3");
		
		Enumeration files = multi.getFileNames();
		
		// 표로 출력 
		// 역순으로 업로드된 파일의 이름을 가져온다. 
		String file3 = (String)files.nextElement();
		String filename3 = multi.getFilesystemName(file3);	// 파일의 이름 
		
		String file2 = (String)files.nextElement();
		String filename2 = multi.getFilesystemName(file2);	// 파일의 이름 
		
		String file1 = (String)files.nextElement();
		String filename1 = multi.getFilesystemName(file1);	// 파일의 이름 
	%>
	
	<table border = "1">
		<tr>
			<th width="100">이름</th>
			<th width="100">제목</th>
			<th width="100">파일</th>
		</tr>
		<%
			out.print("<tr><td>" + name1 + "</td>");
			out.print("<td>" + title1 + "</td>");
			out.print("<td>" + filename1 + "</td></tr>");
			
			out.print("<tr><td>" + name2 + "</td>");
			out.print("<td>" + title2 + "</td>");
			out.print("<td>" + filename2 + "</td></tr>");
			
			out.print("<tr><td>" + name1 + "</td>");
			out.print("<td>" + title1 + "</td>");
			out.print("<td>" + filename1 + "</td></tr>");
		%>
	</table>
	<%
		out.println("---------------------------------------------<br/>");
		Enumeration files1 = multi.getFileNames();
		while(files1.hasMoreElements()) {
			String name = (String)files1.nextElement();
			String filename = multi.getFilesystemName(name);	// 파일이름 얻기 
			
			String original = multi.getOriginalFileName(name);	// 이전 파일이름 얻기 
			String type = multi.getContentType(name);	// 파일 타입(mp3, image)
			File file = multi.getFile(name);	// 파일의 참조를 얻음 
			
			out.println("요청 들어온 파라미터 이름 : " + name + "<br/>");
			out.println("저장 파일 이름 : " + filename + "<br/>");
			out.println("실제 파일 이름 : " + original + "<br/>");
			out.println("파일 컨텐츠 유형 : " + type + "<br/>");
			
			if (file != null) {
				out.println("파일 크기 : " + file.length() + "<br/>");
				out.println("파일 경로 : " + file.getPath() + "<br/>");
			}
		}
	%>
</body>
</html>