<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.io.IOException, java.net.HttpURLConnection, java.net.URL" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="assets/css/login.css">
<title>Login</title>
</head>
<body>
	<jsp:include page="header.jsp" />

	<form action="Real_Login" method="post">
		<!-- 배너 이미지 추가 -->
		<img src="assets/img/login.png">
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

	<jsp:include page="footer.jsp" />
			<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
			<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
			<script src="assets/js/kakaoLogin.js"></script>
			<script>
        document.addEventListener("DOMContentLoaded", function() {
            if (typeof xmlData1 !== 'undefined') {
                var parser1 = new DOMParser();
                var xmlDoc1 = parser1.parseFromString(xmlData1, "text/xml");

                // TradeList API에서 관련 데이터를 추출합니다.
                var items1 = xmlDoc1.getElementsByTagName("item");
                if (items1.length > 0) {
                    var recprice = items1[0].getElementsByTagName("recprice")[0].textContent;

                    // 추출한 데이터로 HTML 업데이트
                    document.getElementById("recValue").textContent = recprice; // REC 값이 이곳에 표시됩니다.
                }
            }
        });
    </script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="assets/js/kakaoLogin.js"></script>
	 <!-- 로그인 결과에 따라 alert 표시 -->
	<script>
	
		// 세션에서 메시지를 받아와서 출력하고, 세션에서 삭제
		
    	var msg = "${sessionScope.msg}";
    	if (msg) {
       		alert(msg);
       	 <% session.removeAttribute("msg"); %> <!-- 메시지 출력 후 세션에서 제거 -->
    	}
    </script>
</body>
</html>
