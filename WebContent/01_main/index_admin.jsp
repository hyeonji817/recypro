<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>서브메뉴</title>
<!-- CSS static -->
<link rel="stylesheet" type="text/css" href="../css/index.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script src="https://kit.fontawesome.com/75e53ee709.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../css/index.css">
<style>
	.nav-right a {
		font-weight: 700;
		position: relative;
	}
	
	.submenu a {
		font-weight: 700;
		position: relative;
	}
</style>
</head>
<body>
	<div class="wrapper"></div>
    <!-- navbar -->
    <header>
        <div class="nav">
            <a class="logo" href="../01_main/loginOK.jsp">리싸이프로</a>
            <ul class="nav-right">
                <li>
                    <a class="link" href="../03_shop/Products.jsp">상품</a>
                </li>
                <%
                // 로그인 되어 있을 때, admin일 경우 admin 페이지로 이동 
                	String id = (String)session.getAttribute("id");
                
                	if (id != null) {
                		if (id.equals("admin")) {
                %>
                <li>
                	<a class="link" href="../admin/admin_index.jsp">관리자 페이지</a>
                </li>
                <%
                		}
                	}
                %>
                <li>
                    <a class="link" href="../05_review/review.jsp">게시판</a>
                </li>
                <li>
                	<a class="link" href="../06_customer/customer_main.jsp">고객센터</a>
                </li>
                <li>
                	<img src="../img/user.png" width="30" height="30" alt="logo" class="user-img">
                	<!-- 옆에 아이디명이나 닉네임명을 구현해야 하는데 어케 하지... -->
                    <ul class="submenu">
                    	<li>
                            <a class="link" href="../03_shop/cart.jsp">장바구니</a>
                        </li>
                        <li>
                            <a class="link" href="../04_mypage/mypage.jsp">마이페이지</a>
                        </li>
                        <li>
                            <a class="link" href="../02_account/logoutAction.jsp">로그아웃</a>
                        </li>
                    </ul>
                </li>
            </ul>
       </div>
       </header>
</body>
</html>