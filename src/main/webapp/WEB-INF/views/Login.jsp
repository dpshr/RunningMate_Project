<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.io.IOException, java.net.HttpURLConnection, java.net.URL" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="assets/css/login.css">
<!-- SweetAlert2와 Bootstrap CSS 로드 -->
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">  -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.5/dist/sweetalert2.min.css">
<title>Login</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<!-- 이미지 컨테이너 -->
	<div class="image-container">
		<img src="assets/img/login.png" alt="loginBanner">
		<!-- 이미지 위에 표시될 텍스트 -->
		<div class="image-text">로그인</div>
	</div>

	<form action="Real_Login" method="post">
		<div class="container">
			<div class="login-form">
				<h2>로그인</h2>
				<p>
					태양광 발전량 예측에 오신 것을 환영합니다.<br>로그인을 하시면 모든 서비스를 더욱 편리하게 이용하실 수
					있습니다.
				</p>
				<input name="memId" type="text" placeholder="아이디를 입력해주세요.">
				<input name="memPw" type="password" placeholder="비밀번호를 입력해주세요.">
				<button type="submit">로그인</button>
			</div>
			
	</form>

	<div class="social-login">
		<h2>SNS 소셜로그인</h2>
		<p>SNS 계정으로 간편하게 로그인 하실 수 있습니다.</p>
		<button type="button" class="kakao" onclick="kakaoLogin()">
			<img src="assets/img/kakao.png" class="icon"> 카카오 로그인
		</button>
		<button type="button" class="naver">
			<img src="assets/img/naver.png" class="icon"> 네이버 로그인
		</button>
		<button type="button" class="google">
			<img src="assets/img/google.png" class="icon"> Google 로그인
		</button>
	</div>
	</div>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
			<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
			<script src="assets/js/kakaoLogin.js"></script>

	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="assets/js/kakaoLogin.js"></script>
	 <!-- 로그인 결과에 따라 SweetAlert2를 사용하여 alert 표시 -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.5/dist/sweetalert2.all.min.js"></script>
<script>
    // 세션에서 메시지를 받아와서 출력하고, 세션에서 삭제
    var msg = "${sessionScope.msg}";
    if (msg) {
        Swal.fire({
            title: "로그인 실패",
            text: msg,
            icon: "error",
            confirmButtonColor: "#6DD66D", // 확인 버튼 색상 설정
            confirmButtonText: "확인"
        });
        <% session.removeAttribute("msg"); %> <!-- 메시지 출력 후 세션에서 제거 -->
    }
</script>
<jsp:include page="footer.jsp" />
</body>
</html>