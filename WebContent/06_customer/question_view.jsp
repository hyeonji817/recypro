<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="question.beans.Question" %>
<%@ page import="question.beans.questionDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 어느 기기에서도 맞춤으로 보이는 반응형 웹에 사용되는 기본 Meta Tag -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,
minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>재활용품 전문점 : 리싸이프로 - 자주묻는질문 글 내용보기</title>
<%@ include file="../01_main/index.jsp"%> <!-- 향후 이 부분 관리자 계정으로 접속했을 때, 관리자 메뉴 보이게끔 구현할 예정 -->
<style>
.row {
	margin-top: 100px;
}

.button {
	position: relative;
	float: right;
	right: -84%;
}

.button a {
	color: white;
}
</style>
</head>
<body>
	<%
		String id = (String) session.getAttribute("id");		// 세션에 연결된 id값 호출 (로그인이 잘 되어 있는지 검문하기 위함)
		String userId = null; 	// 사용자의 아이디 
		System.out.println(id);		
		System.out.println(userId);
	
		// 로그인한 사용자들일 경우, userId에 값이 담기게 됨 
		if (!id.equals(null)) {
			userId = (String) session.getAttribute("id");		// 로그인한 사람들은 해당 아이디가 userId에 저장 
		}
	
		System.out.println(id);
		System.out.println(userId);
		
		int question_num = 0; 
		
		if (request.getParameter("question_num") != null) {
			question_num = Integer.parseInt(request.getParameter("question_num"));		// 질문글 번호 받아오기 
		}
		
		if (question_num == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'customer_question.jsp'");		// 다시 질문글 페이지로 이동 
			script.println("</script>");
		}
		
		Question que = new questionDAO().getQuestion(question_num);		// 유효한 글이라면 구체적인 정보를 que에 담음 
	%>
	
	<!-- 공지글 보이는 부분 -->
	<div class="container">
		<div class="row">
			<table class="table" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">질문 답변글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2">
							<%=que.getQuestion_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
							.replaceAll("\n", "<br>")%>
						</td>
					</tr>
					<tr>
						<td colspan ="2" style="min-height: 300px; text-align: left;">
							<%=que.getQuestion_response().replaceAll(" ", "&nbsp;").replaceAll("<", "&it;")
									.replaceAll(">", "&gt;").replaceAll("\n", "<br>") %>
						</td>
					</tr>
				</tbody>
			</table>
			
			<!-- 버튼 영역 -->
			<div class="button">
				<a href="customer_question.jsp" class="btn btn-default btn-lg" style="background-color: #9FFBF4; float: right; position: relative; color: black; font-weight: bold; right: 240%;">이전페이지</a>
				<% if (id != null) {
            			if (id.equals("admin")) { %>
					<a href="../admin/admin_question.jsp" class="btn btn-default btn-lg" style="background-color: #9FFBF4; color: black; position: relative; right: -440%; bottom: 262%; width: 130px; height: 48px; padding-top: 14%; font-weight: bold;">고객센터 홈</a>
				<%
						}
					}
            	%>
			</div>
		</div>
	</div>
</body>
</html>