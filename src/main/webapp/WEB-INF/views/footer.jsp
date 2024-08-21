<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Footer Example</title>
<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

main {
	flex: 1;
	background-size: cover;
	background-position: center;
	padding-bottom: 250px; /* footer와의 간격을 위해 추가 */
}

footer {
	background-color: #f0f0f0; /* 밝은 회색 배경 */
	color: #333; /* 텍스트를 어두운 회색으로 변경 */
	padding: 20px 0;
	text-align: center;
	width: 100%;
	/* footer를 페이지 하단에 고정 */
}

.footer-container {
	display: flex;
	justify-content: flex-start; /* 왼쪽 정렬 */
	align-items: center;
	padding: 0 30px;
	max-width: 1200px;
	margin: 0 auto;
}

.footer-info {
    text-align: left;
    margin-right: 100px; /* 오른쪽 여백 자동으로 설정하여 왼쪽 정렬 고정 */
}

.footer-info p {
	margin: 5px 0;
	line-height: 1.6;
	color: #555; /* 텍스트를 조금 더 밝은 회색으로 변경 */
}

.footer-info p strong {
	display: block;
	font-weight: bold;
	color: #333; /* 중요한 텍스트는 어두운 회색 */
}

.footer-copyright {
	margin-top: 10px;
	font-size: 0.9em;
	color: #777; /* 저작권 텍스트를 중간 밝기의 회색으로 */
}

.scroll-to-top {
    position: fixed;
    bottom: 20px; /* 화면 하단에서의 위치 설정 */
    right: 20px; /* 화면 오른쪽에서의 위치 설정 */
    color: black;
    font-size: 20px;
    padding: 10px 20px; /* 버튼의 내부 여백 설정 */
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 1000; /* 다른 요소 위에 표시되도록 설정 */
}
</style>
</head>
<body>
	<!-- 기타 콘텐츠 -->
	<footer>
    <div class="footer-container">
        <div class="footer-info">
            <p>본사: 전라남도 목포시 석현로 46, 목포벤처지원센터 301호 TEL: 061-282-0580</p>
            <p>나주: 전라남도 나주시 우정로 10, 406호 TEL: 061-282-0580</p>
            <p class="footer-copyright">Copyright © 소유하신 도메인. All rights reserved.</p>
        </div>
        <!-- 여기에 다른 요소가 있을 경우 그 요소가 오른쪽에 위치하도록 설정 -->
    </div>
</footer>
	

	<div class="scroll-to-top" onclick="scrollToTop()">
		TOP <i class="bi bi-arrow-up-circle"></i>
	</div>

	<script>
        function scrollToTop() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    </script>
</body>
</html>
