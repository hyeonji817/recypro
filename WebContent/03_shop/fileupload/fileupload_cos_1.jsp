<!-- 파일을 업로드하는 서비스를 제공하는 페이지 -->
<!-- 파일 업로드 : 웹 브라우저에서 서버로 파일을 전송하여 서버에 저장하는 것 -->
<!-- 서버로 업로드할 수 있는 파일 -->
<!-- 웹 브라우저에서 서버로 파일을 전송하기 위해 JSP 페이지에 폼 태그 사용 -->
<!-- 전송된 파일을 서버에 저장하기 위해 오픈 라이브버리를 이용 -->
<!-- cos.jar : 웹 to 웹으로 전송하는 간단한 데이터 라이브러리 -->
<!-- Apache commons upload : 일반적인 파일 업로드 기능 외에, 파일명 또는 저장되어야 할 위치에 대한 설정 가능한 라이브러리 -->
<!-- 출처좌표 : https://kjh95.tistory.com/258?category=941468 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>파일 업로드(cos.jar 이용)</title>
</head>
<body>
	<!-- enctype 속성 : 전송타입 설정, 파일을 전송하기 위해서는 반드시 multipart/form-data로 지정 -->
	<form action="fileupload_cos_1_process.jsp" name="fileForm" method="post" enctype="multipart/form-data">
		<p><b>이  름 : </b><input type="text" name="name" /></p>
		<p><b>제  목 : </b><input type="text" name="title" /></p>
		<p><b>파  일 : </b><input type="file" name="filename" /></p>
		
		<p><input type="submit" value="파일 업로드" /></p>
	</form>
</body>
</html>