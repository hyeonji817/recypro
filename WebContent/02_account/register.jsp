<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.0.1">
<link rel="stylesheet" type="text/css" href="../css/register.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
<title>회원가입</title>
<link rel="canonical" href="https://getbootstrap.com/docs/4.5/examples/sign-in/">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous">
<!-- JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous">
</script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
</script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI" crossorigin="anonymous">
</script>
</head>
<body>
	<div class="login">
		<form method="POST" action="register_action.jsp" role="submit">
		<br>
        <br>
        <br>
        <h1 class="h3 mb-3 font-weight-normal" style="font-family: 'S-CoreDream-7ExtraBold'; font-size: 40px; color: rgb(53, 53, 53);">회원가입</h1>
        <br>
        <br>
        <div style="font-family: 'S-CoreDream-3Light'; width: 300px;">
        	<label for="id" class="user-only">ID</label>
            <input type="text" name="id" id="id" class="form-control" placeholder="username" required autofocus><br>
            
            <label for="password" class="user-only">password</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="password" required><br>
            
            <label for="name" class="user-only">이름</label>
            <input type="text" name="name" id="name" class="form-control" placeholder="성명을 입력하세요" required><br>
            
            <label for="age" class="user-only">나이</label>
            <input type="text" name="age" id="age" class="form-control" placeholder="나이를 입력하세요" required><br>
            
            <label for="gender" class="user-only">성별</label><br>            
            <input type="radio" name="gender" value="male" checked>남성
            <input type="radio" name="gender" value="female">여성            
            <br>
            <br>
            
            <label for="jumin" class="user-only">주민등록번호</label><br>
            <input type="text" name="jumin" id="jumin1" maxlength="6" class="form-control" style="width: 130px;" placeholder="앞자리 입력" required>
            <input type="text" name="jumin" id="jumin2" maxlength="7" class="form-control" style="width: auto;" placeholder="뒷자리 입력" required><br>
            
            <label for="email" class="user-only">이메일</label>
            <input type="email" name="email" id="email" class="form-control" placeholder="ex) abc@gmail.com" required/>
            <br>
            
            <button class="btn btn-lg btn-dark btn-block" type="submit" style="font-size: 18px; background-color: rgb(53, 53, 53);">회원가입</button>
            <button class="btn btn-lg btn-dark btn-block primary" type="submit" style="font-size: 18px; background-color: rgb(53, 53, 53);">
            	<a href="login.jsp">뒤로가기</a>
            </button>
        </div>
    </form>
	</div>
</body>
</html>