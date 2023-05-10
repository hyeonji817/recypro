<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import = "java.sql.*" %>
<%@ page import = "user.beans.User" %>
<%@ page import = "user.beans.UserDAO" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<script src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport" content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
<meta name="author" content="">

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" 
integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" 
crossorigin="anonymous">
<title>재활용품 전문점 : 리싸이프로 - 비밀번호 찾기</title>
<style>
@import url("http://fonts.googleapis.com/earlyaccess/nanumgothic.css");

html {
	height: 100%; 
}

body {
	width: 100%; 
	height: 100%; 
	margin: 0;
	padding-top: 200px; 
	padding-bottom: 40px; 
	font-family: "Nanum Gothic", arial, helvetica, sans-serif;
	background-repeat: no-repeat;
}

.card {
	margin: 0 auto;		/** Added */ 
	float: none;		/** Added */
	margin-bottom: 10px;	/** Added */ 
}

#btn-Yes {
/* 	background-color: #e4932b; */
	border: none; 
	font-weight: 700;
}

.form-signin .form-control {
	position: relative;
	height: auto; 
	-webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
         box-sizing: border-box;
  	padding: 10px;
  	font-size: 16px;
}

.card-title {
	text-align: center;
/* 	margin-left: 30px; */
}

a {
	color: #000;
	text-decoration: none;
}

.links {
	text-align: center;
	margin-bottom: 10px; 
}

.checks {
	color: red;
}
</style>
</head>
<body cellpadding="0" cellspacing="0" marginleft="0" margintop="0" width="100%" height="100%" 
align="center">
	<div class="card align-middle" style="width:25rem;">
		<div class="card-title" style="margin-top:30px;">
			<h2 class="card-title" style="color:#f58b34;">
				<img src="../img/recypro_logo.png"/>
			</h2>
		</div>
        
        <!-- 참고한 웹 페이지 주소좌표 (정보 값 전달 유효기간) : https://broship.tistory.com/74 -->
		<div class="card-body">
      		<form action="findPw_action.jsp" class="form-signin" method="POST" name="pwsearch">
        		<input type="text" name="id" id="id" class="form-control" 
        		placeholder="아이디" required><br>
        		<input type="text" name="name" id="name" class="form-control" placeholder="이름" 
        		required><BR>
        		<input type="email" name="email" id="email" class="form-control" 
        		placeholder="이메일" required><br>
        		<p class="checks" id="checks">${findpw_checkf}</p><br/>
        		<button id="btn-Yes" class="btn btn-lg btn-primary btn-block" onclick="checkinfo()"><!-- type="submit" -->
        		비밀번호 찾기</button>

      		</form>
		</div>
        <div class="links">
            <a href="find_id.jsp">아이디 찾기</a> | <a href="login.jsp">로그인</a> | 
            <a href="register.jsp">회원가입</a>
        </div>
        

        
	</div>
</body>
<script type="text/javascript">
	//아이디 정규식
	// 참고자료 : https://www.codingfactory.net/10419 
	var idJ = /^[a-z0-9]{5,20}$/;

	/** 참고자료 : https://hianna.tistory.com/411 */
	/** 내장각체, Form 유효성 검사 및 예제 : https://tadaktadak-it.tistory.com/m/89 */
	function checkinfo() {
		document.pwsearch.submit();
	}
	
	$("#id").focusout(function(){
 		if($('#id').val() == "") {
			$('#checks').text('아이디를 입력해주세요.');
	  		$('#checks').css('color', 'red');
	  		
		} 
	 });
	
	$("#id").focusout(function(){
		if(!idJ.test($(this).val())){
			$('#checks').text('5~20자의 영문 소문자, 숫자만 사용가능합니다');
			$('#checks').css('color', 'red');
		}
	 });
	
	$("#name").focusout(function(){
 		if($('#name').val() == ""){
			$('#checks').text('이름을 입력해주세요.');
	  		$('#checks').css('color', 'red');
 		}
 
	$("#email").focusout(function(){
 		if($('#email').val() == ""){
			$('#checks').text('이메일을 입력해주세요');
	  		$('#checks').css('color', 'red');
 		}
 	});
</script>
</html>