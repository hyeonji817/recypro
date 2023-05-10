<!-- 참고한 웹 페이지 주소좌표 : https://kjh95.tistory.com/258 -->
<!-- 파일 업로드 : 웹 브라우저에서 서버로 파일을 전송하여 서버에 저장하는 것 -->
<!-- 서버로 업로드할 수 있는 파일 -->
<!-- 웹 브라우저에서 서버로 파일을 전송하기 위해 JSP 페이지에 폼 태그 사용 -->
<!-- 전송된 파일을 서버에 저장하기 위해 오픈 라이브버리를 이용 -->
<!-- cos.jar : 웹 to 웹으로 전송하는 간단한 데이터 라이브러리 -->
<!-- Apache commons upload : 일반적인 파일 업로드 기능 외에, 파일명 또는 저장되어야 할 위치에 대한 설정 가능한 라이브러리 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드(commons)</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
	
	 	// 업로드를 할 서버의 경로 지정함(PC의 특정위치)
	 	String fileUploadPath = "D:\\upload";
	 	
	 	DiskFileUpload upload = new DiskFileUpload();
	 	// 요청된 파라미터를 전달받기 위해서 parseRequest() 호출 
	 	List items = upload.parseRequest(request);
	 	
	 	Iterator params = items.iterator();
	 	
	 	while(params.hasNext()) {
	 		FileItem fileItem = (FileItem)params.next();
	 		
	 		// isFormField() : 요청한 파라미터가 파일이 아니라 일반데이터인 경우 true 리턴 
	 		// false = 파일이라는 의미 
	 		if (!fileItem.isFormField()) {
	 			String fileName = fileItem.getName();
	 			// 경로출력 
	 			out.println("1 : " + fileName + "<br/>");
	 			
	 			/** 파일명 앞에 있는 경로를 제거해서 파일명에 저장. 
	 			+1을 하는 이유 : lastIndexOf()를 찾지 못하면 -1을 리턴 
	 			=> 0값을 만들어주기 위해서 +1 한다. 
	 			*/
	 			// D:\\upload\\파일이름 => 파일이름만 추출 
	 			fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
	 			
	 			File file = new File(fileUploadPath + "/" + fileName);
	 			fileItem.write(file);
	 			
	 			out.println("파일이름 : " + fileName + "<br/>");
	 			out.println("파일 저장 경로 : " + file.getPath() + "<br/>");
	 		}
	 	}
	%>
</body>
</html>