<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author"
	content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Jekyll v4.0.1">
<title>로그인</title>
<link rel="canonical"
	href="https://getbootstrap.com/docs/4.5/examples/sign-in/">
<!-- CSS only -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="../css/login.css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script src="https://kit.fontawesome.com/75e53ee709.js"
	crossorigin="anonymous"></script>
<!-- JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
	integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
	crossorigin="anonymous">
</script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
	integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
	crossorigin="anonymous">
</script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
	integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
	crossorigin="anonymous">
</script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- Bootstrap core CSS -->
</head>
<body>
	<div class="login">
		<h1 class="logo">
			<a href="../01_main/main.jsp">리싸이프로</a>
		</h1>
		<form method="POST" action="../02_account/login_action.jsp">
			<br> <br> <br> <br> <br> <br>
			<h1 class="h3 font-weight-normal;" id="login_title"
				style="font-size: 30px; text-shadow: 1px 1px 5px #bdbdbd; font-weight: 700px;">로그인</h1>
			<br>
		</form>
		<div class="login_body">
			<form action="login_action.jsp" method="post">
				<input type="text" name="id" id="id" class="form-control"
					placeholder="아이디" required autofocus> <input
					type="password" name="password" id="password" class="form-control"
					placeholder="비밀번호" required> <br>
				<button class="btn btn-lg btn-dark btn-block" type="submit"
					style="font-size: 18px; background-color: rgb(53, 53, 53);">
					로그인</button>
				<div class="text-center">
					<br> <a href="register.jsp" id="login">회원가입하기</a> <br> 
					<a href="find_id.jsp" id="login">아이디 찾기</a> <br> 
					<a href="find_pw.jsp" id="login">비밀번호 찾기</a>
				</div>

				<!-- 카카오 로그인 API 연동 -->
				<div class="button-login" align="center">
					<a href="javascript:kakaoLogin();" id="kakaoLogin"> 
					<img src="//k.kakaocdn.net/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg"
						alt="카카오계정 로그인" width="83%" height="50px" />
					</a>
					<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
					<script>
        				function saveToDos(token) { //item을 localStorage에 저장합니다. 
            				typeof(Storage) !== 'undefined' && sessionStorage.setItem('AccessKEY', JSON.stringify(token)); 
        				};

        				window.Kakao.init('18eb1e4319b12694d70014e147f4dbb3');
        
        				function kakaoLogin() {
            				window.Kakao.Auth.login({
                				scope: 'profile_nickname, profile_image, account_email', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
                				success: function(response) {
                    			saveToDos(response.access_token)  // 로그인 성공하면 사용자 엑세스 토큰 sessionStorage에 저장
                    			window.Kakao.API.request({ // 사용자 정보 가져오기 
                        		url: '/v2/user/me',
                        		success: (res) => {
                            		const kakao_account = res.kakao_account;
                            		alert('로그인 성공');
                            		window.location.href='/01_account/loginOK.jsp'
                        		}
                    		});
                		},
                		fail: function(error) {
                    		console.log(error);
                		}
            		});
        		};

        			const login = document.querySelector('#kakaoLogin');
        			login.addEventListener('click', kakaoLogin);
    				</script>
				</div>
			</form>
		</div>
	</div>
</body>
<script type="text/javascript">
window.Kakao.init('18eb1e4319b12694d70014e147f4dbb3'); 

function kakaoLogin() {
    window.Kakao.Auth.login({
        scope: 'profile_nickname, profile_image, account_email', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
        success: function(response) {
            console.log(response) // 로그인 성공하면 받아오는 데이터
            window.Kakao.API.request({ // 사용자 정보 가져오기 
                url: '/v2/user/me',
                success: (res) => {
                    const kakao_account = res.kakao_account;
                    console.log(kakao_account)
                }
            });
            window.location.href='../01_main/loginOK.jsp';
            // window.location.href='/ex/kakao_login.html' //리다이렉트 되는 코드
        },
        fail: function(error) {
            console.log(error);
        }
    });
}

// 카카오톡 로그아웃
window.Kakao.init('18eb1e4319b12694d70014e147f4dbb3');
function kakaoLogout() {
	if (!Kakao.Auth.getAccessToken()) {
	    console.log('Not logged in.');
	    return;
    }
    Kakao.Auth.logout(function(response) {
		alert(response +' logout');
	    window.location.href='/'
    });
};

// 카카오톡 회원 탈퇴 (연결 끊기)
function secession() {
	Kakao.API.request({
    	url: '/v1/user/unlink',
    	success: function(response) {
    		console.log(response);
    		//callback(); //연결끊기(탈퇴)성공시 서버에서 처리할 함수
    		window.location.href='/'
    	},
    	fail: function(error) {
    		console.log('탈퇴 미완료')
    		console.log(error);
    	},
	});
};

Kakao.Auth.authorize({
  redirectUri: '../02_account/login.jsp',
  prompts: 'none',		// 간편 로그인 요청 시 prompts 파라미터 값을 none으로 지정
  scope: 'profile_nickname, profile_image, account_email',
  serviceTerms: 'account_email'		// 등록된 서비스 약관 중, 특정 서비스 약관을 지정해 동의받고자 할 때 사용, 
});

</script>
</html>