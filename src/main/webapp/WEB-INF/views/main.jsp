<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SolaPower</title>
    <link rel="stylesheet" href="assets/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
</head>
<body>

    <!-- header.jsp 파일 포함 -->
    <jsp:include page="header.jsp" />
    <main>
        <div class="main-content">
            <h1>인공지능(AI)을 활용하여 최적의 태양광 발전소 운영을 위한 발전량 예측 서비스를 제공받을 수 있습니다.</h1>
            <div class="buttons">
                <div class="button-container">
                    <div class="button-text">내 발전소 현황</div>
                    <a href="loginon">
                        <button type="button" class="btn_direct">바로가기</button>
                    </a>
                </div>

		<div class="sv">
			<a href="#">발전지도</a>
		</div>
		<div class="sv">
			<a href="#">관련소식</a>
		</div>
		<div class="sv">
			<a href="#">테스트용</a>
			


			<c:choose>
				
				<c:when test="${!empty user_nick}">
					<!-- 카카로 로그인했을 경우 -->		
					${user_nick}
					<a href="Logout">로그아웃</a>
				</c:when>
				<c:when test="${!empty user.memId}">
					<!-- 일반 로그인했을 경우 -->					
					${user.memName}님 
					<a href="Logout">로그아웃</a>
				</c:when>
				<c:otherwise>
					<!-- 로그인하지 않았을 경우 -->
					<div>
						<button id="openLoginModal">로그인</button>
					</div>
					<a href="Go_Real_Join">회원가입</a>
				</c:otherwise>
			</c:choose>

			<!-- 로그인 모달 -->
			<div id="loginModal" class="modal">
				<div class="modal-content">
					<span class="close">&times;</span>
					<div class="container">
						<div class="login-container">
							<!-- 로그인 폼 코드 삽입 -->
							<table>
								<tr>
									<td>
										<div class="login-text">
											<div class="login-title">로그인</div>
											<div class="login-message">SolarPower에 오신 것을 환영합니다</div>
											<div class="login-message">로그인을 하시면</div>
											<div class="login-message">모든 서비스를 더욱 편리하게 이용하실 수 있습니다</div>
											<form action="Real_Login" method="post">
												<label for="username"></label> <input type="text"
													id="username" name="memId" required
													placeholder="아이디를 입력해주세요"> <label for="password"></label>
												<input type="password" id="password" name="memPw" required
													required placeholder="비밀번호를 입력해주세요"> <input
													type="submit" value="로그인">
												<button type="button" class="signup-button"
													onclick="location.href='Go_Real_Join'">회원가입</button>
											</form>
										</div>
									</td>
								</tr>
							</table>
						</div>
						<div class="social-login-container">
							<table>
								<tr>
									<td>
										<p>SNS 소셜 로그인</p>
										<div class="login-message">SNS 계정으로 간편하게 로그인 하실 수 있습니다</div>
										<ul>
											<li><button class="social-login-button naver-button">Naver
													로그인</button></li>
											<li onclick="kakaoLogin();"><a href="javascript:void(0)">
													<span>카카오 로그인</span>
											</a></li> 
											<li onclick="kakaoLogout();"><a
												href="javascript:void(0)"> <span>카카오 로그아웃</span>
											</a></li>
											<li><button class="social-login-button google-button">Google
													로그인</button></li>
											</ul>
									</td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>

			<script>
				// JavaScript 코드로 모달 제어
				var modal = document.getElementById("loginModal");
				var btn = document.getElementById("openLoginModal");
				var span = document.getElementsByClassName("close")[0];

				// 로그인 버튼을 클릭하면 모달이 열림
				btn.onclick = function() {
					modal.style.display = "block";
				}

				// 닫기 버튼을 클릭하면 모달이 닫힘
				span.onclick = function() {
					modal.style.display = "none";
				}

				// 모달 외부를 클릭하면 모달이 닫힘
				window.onclick = function(event) {
					if (event.target == modal) {
						modal.style.display = "none";
					}
				}
			</script>				
			<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
			<script src="assets/js/kakaoLogin.js"></script>
                <div class="button-container">
                    <div class="button-text">전국발전지도</div>
                    <div class="d-flex flex-column">
                        <a href="#">
                            <button type="button" class="btn_direct">바로가기</button>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <div class="market-trend">
            <h2>시장동향</h2>
            <h2>SMP + (REC × 1.0)</h2>
            <div class="main-value">226.72</div>
            <div class="separator"></div>
            <div class="sub-title">SMP</div>
            <div class="sub-text">오늘 시장가격</div>
            <div class="value">148.62</div>
            <div class="sub-title">REC 현물</div>
            <div class="value">78,100</div>
        </div>
    </main>
   	<!-- footer.jsp 파일 포함 -->
    <jsp:include page="footer.jsp" /> 
</body>
</html>