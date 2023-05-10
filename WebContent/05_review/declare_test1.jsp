<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="review.beans.Review"%>
<%@ page import="review.beans.ReviewDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="java.util.ArrayList"%><!-- 게시판의 목록을 출력하기 위해서 필요 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />

<!-- javascript -->
<script type="text/javascript">
	$("body").prepend(html);

	$(".background_r").hide();
	$(".ctts_r").hide();
	$(".background_r").fadeIn();
	$(".ctts_r").fadeIn();

	// 닫기 
	$(".btn_cancel").off("click");
	$(".btn_cancel").on("click", function() {
		closePopup();
	});

	$(".background_r").off("click");
	$(".background_r").on("click", function() {
		closePopup();
	});

	// 신고하기 textarea 글자 수 제한 
	$("#reportCtt").on("keyup", function() {
		$("#cttCnt").html($(this).val().length + 500); // 확실하지 않으니, 만약 기능 구현이 안 되면 변경될 예정

		if ($(this).val().length > 500) {
			$(this).val($(this).val().substring(0, 500));
			$("#cttCnt").html("(500/500)");
		}
	});

	// 체크박스 값 보내기 
	$(".btn_rot").on("click", function() {
		$("#checkArr").val("");
		$(".checkbox_div [type='checkbox']:checked").each(function() {
			$("#checkArr").val($("#checkArr").val() + $(this).val());
		});

		console.log("#checkArr값: " + $("#checkArr").val());
	});

	// 신고할 때 
	$("#btn_rot").off("click");
	$("#btn_rot").on("click", function() {
		// 자기자신이 신고할 수 없도록 하는 코드 
		var params = $("#reportForm").serialize();

		$.ajax({
			type : "post",
			url : "userReports",
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
			error : function(request, status, error) {
				console.log(error);
			}
		}); // ajax
	}); // 신고하기 버튼 누르면 

	// 신고하기 팝업 닫기 
	function closePopup() {
		$(".background_r").fadeOut(function() {
			$(".background_r").remove();
		});

		$(".ctts_r").fadeOut(function() {
			$(".ctts_r").remove();
		});
	}
</script>

<!-- bootstrap -->
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css">
<title>신고하기 테스트</title>
<style>
@charset "UTF-8";

.font-red {
	color: red;
}

.background_r {
	width: 100%;
	height: 100%;
	position: absolute;
	background-color: #000000;
	opacity: 0.3;
	z-index: 300;
}

.ctts_r {
	display: inline-block;
	width: 800px;
	height: 714px;
	position: absolute;
	top: 50%;
	left: 50%;
	margin-top: -350px;
	margin-left: -420px;
	background-color: #FFFFFF;
	border: 1px solid #999999;
	border-radius: 5px;
	z-index: 400;
	border-radius: 16px;
	font-size: 16px;
}

.top_ctt {
	margin-left: 20px;
}

.top_ctt1 {
	display: block;
	position: absolute;
	height: 50px;
	width: 760px;
	background-color: black;
	text-align: left;
	color: white;
	margin-top: 20px;
	top: 0px;
}

.top_ctt1>div {
	display: inline-block;
	margin: 14px;
	font-size: 18px;
}

.top_ctt2 {
	display: block;
	position: absolute;
	height: 24px;
	width: 746px;
	background-color: #f7f7f7;
	text-align: left;
	top: 70px;
	padding-left: 14px;
	line-height: 30px;
}

.top_ctt3 {
	display: block;
	position: absolute;
	height: 40px;
	width: 746px;
	background-color: #f7f7f7;
	text-align: left;
	top: 94px;
	padding-left: 14px;
	line-height: 40px;
}

.top_ctt4 {
	display: block;
	position: absolute;
	height: 190px;
	width: 758px;
	border: 1px solid #cccccc;
	text-align: left;
	top: 134px;
}

.top_ctt4-1 {
	display: inline-block;
	position: absolute;
	top: 0px;
	width: 190px;
	text-align: center;
	height: 192px;
	background-color: white;
	margin-left: 3px;
	line-height: 184px;
}

.checkbox_div {
	display: inline-block;
	position: absolute;
	top: 0px;
	right: 0px;
	width: 602px;
	text-align: center;
	height: 192px;
	background-color: white;
	overflow: auto;
}

.checkbox_div>div:nth-child(n) {
	display: inline-block;
	position: relative;
	margin: auto;
	width: 180px;
	height: 22px;
	float: left;
	text-align: left;
	margin-top: 14px;
	margin-left: 60px
}

.checkbox_div>div:nth-child(2n) {
	display: inline-block;
	position: relative;
	margin: auto;
	width: 300px;
	height: 22px;
	float: left;
	text-align: left;
	margin-top: 14px;
	margin-left: 30px;
}

.report_content textarea {
	border-style: none;
}

.report_content textarea:focus {
	outline: none;
}

#cttCnt {
	display: inline-block;
	width: 100px;
	height: 50px;
	position: absolute;
	bottom: 87px;
	left: 46px;
}

.r_content_div {
	display: block;
	position: absolute;
	height: 158px;
	width: 758px;
	border: 1px solid #cccccc;
	text-align: left;
	bottom: 228px;
	line-height: 48px;
}

.r_content-1 {
	display: inline-block;
	position: absolute;
	top: 0px;
	width: 190px;
	text-align: center;
	height: 100%;
	background-color: white;
	margin-left: 3px;
	line-height: 156px;
}

.report_content {
	display: inline-block;
	position: absolute;
	top: 0px;
	right: 0px;
	width: 570px;
	text-align: center;
	height: 100%;
	background-color: white;
	overflow: auto;
	border: 1px solid #cccccc;
}

.btm-ctt {
	display: block;
	position: absolute;
	height: 200px;
	width: 800px;
	text-align: left;
	bottom: 28px;
}

.btm-ctt1 {
	display: block;
	position: absolute;
	width: 800px;
	text-align: left;
	margin-top: 20px;
	margin-left: 10px;
	bottom: 60px;
}

.btm-ctt2 {
	position: absolute;
	text-align: center;
	bottom: 0px;
	margin-left: 330px;
}

.btm-ctt3 {
	display: inline-block;
}

.btn_rot {
	display: inline-block;
	background-color: #f7f7f7;
	color: black;
	width: 76px;
	height: 32px;
	padding-top: 10px;
	text-align: center;
	cursor: pointer;
	bottom: -8px;
	border-radius: 6px;
}

.btn_rot:hover {
	color: #fff;
	background-color: #EF6C33;
}

.btn_cancel {
	display: inline-block;
	background-color: #f7f7f7;
	color: black;
	width: 76px;
	height: 32px;
	padding-top: 10px;
	text-align: center;
	cursor: pointer;
	bottom: -8px;
	border-radius: 6px;
}

.btn_cancel:hover {
	color: #fff;
	background-color: #EF6C33;
}

.declare_button a {
	display: block;
	position: relative;
	float: right;
	margin-top: 10%;
	left: -17%;
	bottom: 17%;
	margin-bottom: 20%;
	font-weight: bold;
	margin: 0 auto;
}
</style>
</head>
<body>
	<%@ include file="../01_main/index.jsp"%>

	<!-- 신고하기 페이지 영역 -->
	<div class="background_r">
		<div class="ctts_r">
			<form id="reportForm">
				<input type="hidden" name="" value="" /> <input type="hidden"
					name="" value="" /> <input type="hidden" name="checkArr"
					id="checkArr" />

				<div class="top_ctt">
					<!-- 소제목 -->
					<div class="top_ctt1">
						<div>신고하기</div>
					</div>
					<div class="top_ctt2">
						<b>신고합니다.</b>
					</div>
					<div class="top_ctt3">아래 내용을 제출합니다.</div>
					<div class="top_ctt4">
						<!-- 신고사유 리스트 -->
						<div class="top_ctt4_1">신고사유</div>
						<div class="checkbox_div">
							<div>
								<input type="checkbox" name="checkR" id="c1" value="1"
									class="check_one" /> 
								<label for="c1">홍보, 영리목적</label>
							</div>
							<div>
								<input type="checkbox" name="checkR" id="c2" value="2"
									class="check_one" /> 
								<label for="c2">부적절한 홍보</label>
							</div>
							<div>
								<input type="checkbox" name="checkR" id="c3" value="3"
									class="check_one" /> 
								<label for="c3">불법정보</label>
							</div>
							<div>
								<input type="checkbox" name="checkR" id="c4" value="4"
									class="check_one" /> 
								<label for="c4">음란 또는 청소년에게 한 내용</label>
							</div>
							<div>
								<input type="checkbox" name="checkR" id="c5" value="5"
									class="check_one" /> 
								<label for="c5">욕설비방 차별혐오</label>
							</div>
							<div>
								<input type="checkbox" name="checkR" id="c6" value="6"
									class="check_one" /> 
								<label for="c6">도배 스팸</label>
							</div>
							<div>
								<input type="checkbox" name="checkR" id="c7" value="7"
									class="check_one" /> 
								<label for="c7">개인정보 노출거래</label>
							</div>
							<div>
								<input type="checkbox" name="checkR" id="c8" value="8"
									class="check_one" /> 
								<label for="c8">저작권 및 명예훼손</label>
							</div>
							<div>
								<input type="checkbox" name="checkR" id="c9" value="9"
									class="check_one" /> 
								<label for="c9">기타</label>
							</div>
						</div>
					</div>
					
					<!-- 내용 입력란 -->
					<div class="r_content_div">
						<div class="r_content-1">
							내용<br /> <span id="cttCnt"></span>
						</div>
						<div class="report_content">
							<textarea rows="16" cols="78" name="reportCtt" id="reportCtt"></textarea>
						</div>
					</div>
				</div>
				<!-- top-ctt -->
				<!-- 주의사항 -->
				<div class="btn-ctt">
					<div class="btm-ctt1">
						<ul>
							<li><span class="font-red">허위신고</span>일 경우 신고자에 대한 제재가 있을 수
								있습니다.</li>
							<li>신고내용의 사유에 따라 사용자를 처벌하는 시간이 다소 걸릴 수 있습니다.</li>
							<li>이 글이 신고사유에 해당하는 글인지 다시 한 번 <span class="font-red">확인</span>하시길
								바랍니다.<br /></li>
							<li>신고하게 된 이유를 자세히 써 주시면 운영자의 관련 결정에 도움이 됩니다.</li>
							<li>신고기능은 글 작성자에게 <span class="font-red">피해</span>를 줄 수 있으며,
								<span class="font-red">3회</span> 부정신고 시 <span class="font-red">영구적</span>으로
								이용이 제한됩니다.
							</li>
						</ul>
					</div>
					<div class="btm-ctt2">
						<div class="btm-ctt3">
							<div class="btn_rot">
								<a href="#" onclick="alert('신고접수 되었습니다.');">신고</a>
							</div>
							<div class="btn_cancel">취소</div>
						</div>
					</div>
				</div>
			</form>
			<!-- form 태그 끝 -->
		</div>
	</div>

	<!-- 버튼 영역 -->
	<div class="declare_button">
		<a class="btn btn-warning btn-lg" id="btnShare2">공유</a> 
		<a class="btn btn-info btn-lg" id="btnDot12">메뉴1</a> 
		<a class="btn btn-primary btn-lg" id="btnDot22">메뉴2</a>
		<a class="btn btn-danger btn-lg" id="btnDeclation2">신고</a>
	</div>

	<script src="../js/html5shiv.js"></script>
	<script src="../js/respond.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<script src="../js/jquery.min.js"></script>
	<script src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</body>
</html>