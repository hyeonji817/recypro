<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<meta charset="UTF-8">
<title>페이지 상단</title>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script src="https://kit.fontawesome.com/75e53ee709.js" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="../css/index_top.css">
<link rel="stylesheet" type="text/css" href="../css/main.css">
<style>
.music {
	width: 100%;
	height: 35%;
	float: right;
	position: relative;
	top: 35%;
	right: 22%;
}
</style>
<header class="common top">
	<div class="nav">
            <a class="logo" href="../01_main/main.jsp">리싸이프로</a>
            <!-- <span class="music">
            	<audio src="../media/music.mp3" controls autoplay loop style="width: 22%; height: 100%; right: 10%;">
            		음악듣기
            	</audio>
            </span> -->
            <ul class="nav-right">
                <li>
                    <a class="link" href="../03_shop/Products.jsp">상품</a>
                    <!-- <ul class="submenu">
                    	<li>
                    		<a class="link" href="../03_shop/Products.jsp">상품 목록</a>
                    	</li>
                    	<li>
                    		<a class="link" href="../03_shop/pd_orderList.jsp">주문 조회</a>
                    	</li>
                    	<li>
                    		<a class="link" href="../03_shop/Product_Review.jsp">리뷰확인</a>
                    	</li>
                    </ul> -->
                </li>
                <c:set var="index" value="0" />
                <li>
                    <a class="link" href="../05_review/review.jsp">게시판</a>
                    <ul class="submenu">
                    	<li>
                    		<a class="link" href="../05_review/review.jsp">목록</a>
                    	</li>
                    	<li>
                    		<a class="link" href="../05_review/write.jsp">글쓰기</a>
                    	</li>
                    </ul>
                </li>
                <li>
                	<a class="link" href="../06_customer/customer_main.jsp">고객센터</a>
                	<ul class="submenu">
                		<li>
                			<a class="link" href="../06_customer/customer_notice.jsp">공지사항</a>
                		</li>
                		<li>
                			<a class="link" href="../06_customer/customer_policy.jsp">운영정책</a>
                		</li>
                		<li>
                			<a class="link" href="../06_customer/customer_question.jsp">자주묻는질문</a> 
                		</li>
                		<li>
                			<a class="link" href="../06_customer/customer_consult.jsp">온라인 문의</a>
                		</li>
                		<li>
                			<a class="link" href="../06_customer/customer_declare.jsp">신고하기</a>
                		</li>
                	</ul>
                </li>
                <li>
                    <a class="link" href="../02_account/login.jsp">로그인</a>
                </li>
                <li>
                    <a class="link" href="../02_account/register.jsp">회원가입</a>
                </li>
            </ul>
        </div>
</header>