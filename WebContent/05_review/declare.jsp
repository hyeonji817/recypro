<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="review.beans.Review" %>
<%@ page import="review.beans.ReviewDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %><!-- 게시판의 목록을 출력하기 위해서 필요 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<!-- bootstrap -->
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" /> 
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
<title>재활용품 전문점 : 리싸이프로 - 게시판 : 신고하기</title>
<script type="text/javascript">
	$("body").prepend(html); 
	
	$(".sub_content").hide(); 
	$(".sub_content").fadeIn(); 
	
	// 닫기 
	$(".btn_cancel").off("click"); 
	$(".btn_cancel").on("click", function() {
		closePopup();
	}); 
	
	$(".sub_content").off("click"); 
	$(".sub_content").on("click", function() {
		closePopup();
	}); 
	
	// 신고할 때 
	$("#reportBtn").off("click"); 
	$("#reportBtn").on("click", function() {
		// 자기자신이 신고할 수 없도록 하는 코드 
		var params = $("#declareForm").serialize(); 
		
		$.ajax({
			type : "post", 
			url : "userDeclares",
			dataType : "json", 
			data : params, 
			success : function(result) {
				if (result.msg == "success") {
					closePopup();
				} else if (result.msg == "failed") {
					alert("신고에 실패했습니다."); 
				} else {
					console.log(result); 
					alert("신고 전송 중 문제가 발생했습니다.");
				}
			}, 
			error : function (request, status, error) {
				console.log(error);
			}
		});	// ajax
	});	// 신고하기 버튼 누를 시
	
	// 신고하기 팝업 닫기 
	function closePopup() {
		$(".sub_content").fadeOut(function() {
			$(".sub_content").remove(); 
		}); 
	}
</script>
<style>
.title {
	margin-top: 7%;
	height: 150px;
	margin-bottom: 8%;
}

.display-3 {
	margin-left: 5%;
	color: black;
	position: relative;
	font-weight: bold;
	font-size: 55px;
}

.sub_content {
	margin: 0 auto;
	width: 1000px;
	position: relative;
	min-height: 40%;
	bottom: 10%;
/* 	background-color: #eee; */
}

.declare_user {
	margin: 0 auto; 
	text-align: center; 
	right: 30%; 
	padding-top: 3%; 
	position: relative; 
	display: block; 
	width: 800px;
}

.declare_user h5 {
	font-weight: bold;
	font-size: 24px;
}

.declare_user input {
	display: inline-block; 
	position: relative; 
	left: 42%; 
	bottom: 40px; 
	width: 330px; 
	height: 40px;
}

.declare_location {
	margin: 0 auto; 
	text-align: center; 
	right: 30%; 
	padding-top: 3%; 
	position: relative; 
	display: block; 
	width: 800px;
}

.declare_location h5 {
	font-weight: bold;
	font-size: 24px;
	position: relative; 
	left: 4%;
}

.declare_location input {
	display: inline-block; 
	position: relative; 
	left: 52.5%; 
	bottom: 40px; 
	width: 500px; 
	height: 40px;
}

.declare_reason {
	margin: 0 auto; 
	text-align: center; 
	right: 30%; 
	padding-top: 3%; 
	position: relative; 
	display: block; 
	width: 800px;
}

.declare_reason h5 {
	font-weight: bold;
	font-size: 24px;
	position: relative; 
	left: -2%;
}

.declare_reason select {
	display: inline-block;
	bottom: 40px; 
	width: 300px; 
	height: 40px;
	position: relative; 
	left: 40%;
}

.declare_button {
	position: absolute;
	width: 200px; 
	height: 50px; 
	left: 70%;
}

.declare_button a {
	position: relative; 
	display : block; 
	width: 150px;
	height: 45px;
}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>
	
	<%
		// id값의 존재유무를 통해 로그인 되어 있는지 사전검문
			String id = null;
			PrintWriter script = response.getWriter();
	
			if (session.getAttribute("id") != null) {
				id = (String)session.getAttribute("id");
				script.println("location.href = '../05_review/review.jsp'");
			} 
	
		// 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크 
			String userId = null;
			if (session.getAttribute("userId") != null) {
				userId = (String)session.getAttribute("userId");	// 로그인한 사람들은 해당 아이디가 userId에 저장
			}
			
			// 가장 기본 페이지 1로 설정 
			int pageNumber = 1;
			
			if (request.getParameter("pageNumber") != null) {
				// 정수형으로 타입 변경해주는 부분
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}
			
		 if (id == null) {
	%>
 	<%@ include file="../01_main/index_top.jsp" %> 
	<% 
 			} else {
 	%> 
 	<%@ include file="../01_main/index.jsp" %> 
	<% 
		}
	%> 
	
	<!-- 제목 -->
	<div class="title">
		<div class="container">
			<h1 class="display-3"
				style="font-weight: 700; text-shadow: 1px 1px 5px #bdbdbd;">신고하기</h1>
		</div>
	</div>
	
	<!-- 신고하기 작성 내용 -->
	<div class="sub_content">
		<form action="../declareAction.jsp" method="post" id="declareForm">	<!-- jsp 페이지로 post 방식을 이용해 전송 -->
			<!-- 신고할 유저 -->
			<!-- <div class="declare_user">
				<h5>신고할 유저</h5>
				<div class="tap">
					<input type="text" name="id" class="dc_user" value="" placeholder="아이디를 입력해주세요."/>
				</div>
			</div> -->
		
			<!-- 신고 장소 (페이지) -->
			<div class="declare_location">
				<h5>신고 장소 (페이지)</h5>
				<div class="location">
					<input type="text" name="declarePlace" class="dc_user" value="" placeholder="문제의 장소를 입력해 주세요 ex)게시판 - 10번"/>
				</div>
			</div>
		
			<!-- 신고사유 -->
			<div class="declare_reason">
				<h5>신고사유</h5>
				<select name="declare_reason" id="declare_reason">
					<option value="choose">----- 선택하세요 ------</option>
					<option value="unspeakable_article">비방글</option>
					<option value="rumor">허위사실 유포</option>
					<option value="curse_violence">욕설 및 폭력 조장</option>
					<option value="defraud">사기 목적</option>
					<option value="illegal_publicity">불법 홍보</option>
					<option value="displeasure">불쾌감 조성</option>
				</select>
			</div>
	
	
			<!-- 신고하기 버튼 -->
			<div class="declare_button">
				<a href="../05_review/review.jsp" onclick="alert('신고접수 되었습니다.');" class="btn btn-danger btn-lg pull-right" id="reportBtn" style="color: white; 
				position: relative; right: 10%; font-weight: bold;">
					신고하기
				</a>
				<a href="#" class="btn_cancel">취소</a>
			</div>
		</form>

	</div>	
</body>
</html>