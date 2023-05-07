<!-- 주소좌표 : https://kjh95.tistory.com/260 -->
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
<%@ page import="org.apache.commons.fileupload.FileItem" %>
<%@ page import="java.util.List" %>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드(commons)</title>
</head>
<body>	
	<%
		request.setCharacterEncoding("UTF-8");
	
		String path = "D:\\upload";
		String fileName = "";
		
		// 넘겨온 파일의 형태가 "multipart/form-data"인지 확인 
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		
		if(isMultipart) {
			// 메모리나 파일로 업로드할 때 파일을 보관하는 역할을 하는 fileItem의 factory 설정 
			DiskFileItemFactory factory = new DiskFileItemFactory();
			// 업로드 요청처리하는 ServletFileUpload 객체 생성.
			ServletFileUpload upload = new ServletFileUpload(factory);
			// 업로드의 요청이 들어올 때 파싱해서 FileItem 목록 구하는 코드 
			List<FileItem> items = upload.parseRequest(request);
			// 반복자를 얻음
			Iterator<FileItem> iterator = items.iterator();
			
			while(iterator.hasNext()) {
				FileItem item = iterator.next(); 
				// 파일인지 여부 확인하는 부분 
				// 텍스트 일 경우
				if(item.isFormField()) {
					String name = item.getFieldName();	// 태그 속성이 name
					String value = item.getString("UTF-8");
					out.println("일반 폼 필드 : " + name + "-" + value);
				}
				// 파일일 경우 
				else {
					String fileFieldName = item.getFieldName();	// 태그 속성이 name
					String contentType = item.getContentType();	
					boolean isinMemory = item.isInMemory();		// 메모리상 할당되어 있다면 true
					long sizeInBytes = item.getSize();		// 파일 용량 
					
					fileName = item.getName();	
					fileName = fileName.substring(fileName.lastIndexOf("\\")+1);
					
					File file = new File(path + "/" + fileName);
					
					// 파일이 이미 존재한다면 
					if (file.exists()) {
						for (int i = 0; true; i++) {
							file = new File(path + "/" + "(" + i + ")" + fileName);
							
							// 빠져나가는 경우(같은 파일이 존재하지 않는 경우)
							if(!(file.exists()) == true) {
								fileName = "(" + i + ")" + fileName;
								break;
							}
						}
					}	// if 
					item.write(file);
					out.println("<br/>----------------------------------------");
					out.println("저장 파일 이름 : " + fileName + "<br/>");
					out.println("요청 파라미터 이름 : " + fileFieldName + "<br/>");
					out.println("요청 콘텐츠 유형 : " + contentType + "<br/>");
					out.println("파일 크기 : " + sizeInBytes + "<br/>");
					out.println("파일 경로 : " + path + "<br/>");
				}	// else
			}	// while
		}	// if
	%>
	저장된 이미지
	<img alt="사진" src="D://upload//<%=fileName %>">
</body>
</html>