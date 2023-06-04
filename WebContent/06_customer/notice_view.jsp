<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="notice.beans.Notice" %>
<%@ page import="notice.beans.noticeDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- 어느 기기에서도 맞춤으로 보이는 반응형 웹에 사용되는 기본 Meta Tag -->
<meta name="viewport"
	content="width=device-width, initial-scale=1.0,
minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<link rel="stylesheet" href="../css/bootstrap.css">
<title>재활용품 전문점 : 리싸이프로 - 공지사항 글 내용보기</title>
<%@ include file="../01_main/index.jsp"%>
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
		int notice_num = 0;
		
		if (request.getParameter("notice_num") != null) {
			notice_num = Integer.parseInt(request.getParameter("notice_num"));		// 공지글 번호 받아오기 
		}
		
		if (notice_num == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'customer_notice.jsp'"); // 다시 게시글 페이지로 이동
			script.println("</script>");
		}
		
		Notice noti = new noticeDAO().getNotice(notice_num);	// 유효한 글이라면 구체적인 정보를 noti에 담음 
	%>
	
	<!-- 공지글 보이는 부분 -->
	<div class="container">
		<div class="row">
			<table class="table" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="3" style="background-color: #eeeeee; text-align: center;">공지사항 상세글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td colspan="2">
							<%=noti.getNotice_title().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;")
							.replaceAll("\n", "<br>;")%>
						</td>
					</tr>
				</tbody>
			</table>
			<div class="button">
				<a href="review.jsp" class="btn btn-default btn-lg" style="background-color: #9FFBF4; float: right; position: relative; color: black; font-weight: bold; right: 240%;">목록</a>
				
				<%
					if (id != null) {
				%>
				<form name="NoticeModify" id="NoticeModify" action="../admin/notice_modify.jsp?notice_num=<%=notice_num%>" style="float: right; position: relative; right: 135%;" method="post">		
						<a>
						<button id="Noticemodify" class="btn btn-default" name="notice_forward" value="<%=notice_num%>" onclick="ClickModify()" style="width: 72px; height: 48px; background-color: #9FFBF4; font-size: 20px; padding-top: 10%; font-weight: bold; color: black;">
						수정</a>
				</form>
				<%
					}
				%>
				<a href="#" class="btn btn-default btn-lg" style="background-color: #9FFBF4; color: black; position: relative; right: -440%; bottom: 262%; width: 130px; height: 48px; padding-top: 14%; font-weight: bold;">삭제하기</a>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		function ClickModify() {
			document.NoticeModify.submit();
		}
	</script>
</body>
</html>