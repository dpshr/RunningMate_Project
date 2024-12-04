<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="assets/css/Real_join.css">
<title>Join</title>
<!-- jQuery 라이브러리 참조 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 외부 JavaScript 파일 참조 -->
<script src="assets/js/idCheck.js"></script>
</head>
<body>
	<jsp:include page="header.jsp" />

	<!-- 이미지 컨테이너 -->
	<div class="image-container">
		<img src="assets/img/login.png" alt="joinBanner">
		<!-- 이미지 위에 표시될 텍스트 -->
		<div class="image-text">회원가입</div>
	</div>

	<!-- 폼 컨테이너 추가 -->
	<div class="form-container">

		<h1>사용자 정보입력</h1>
		<hr>
		<!-- 가로선 추가 -->
		<form action="Real_Join" method="post" id="joinForm">
			<label for="memId">아이디</label><br>
			<div class="input-group">
				<input type="text" name="memId" id="memId">
				<button type="button" class="button-check">중복체크</button>
			</div>
			<!-- 결과를 표시할 요소 추가 -->
			<span id="idCheckResult" style="color: red; font-size: 17px;"></span>
			<br> <br> <label for="memPw">비밀번호</label><br> <input
				type="password" name="memPw" id="memPw"><br> <br>
			<label for="memName">이름</label><br> <input type="text"
				name="memName" id="memName"><br> <br> <label
				for="memEmail">이메일</label><br> <input type="email"
				name="memEmail" id="memEmail"><br> <br> <label>성별</label><br>
			<div class="radio-group">
				<input type="radio" name="memGender" value="M" id="male"> <label
					for="male">남자</label> <input type="radio" name="memGender"
					value="W" id="female"> <label for="female">여성</label>
			</div>
			<br> <label for="memBirth">생년월일</label><br> <input
				type="date" name="memBirth" id="memBirth"><br> <br>
			<!-- 버튼들을 가로로 배치하기 위한 컨테이너 -->
			<div class="button-container">
				<input type="button" value="가입취소" class="btn"> 
				<input type="submit" value="가입요청" class="btn" onclick="submitJoinForm()">
			</div>
		</form>
	</div>
	<jsp:include page="footer.jsp" />
	    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.5/dist/sweetalert2.all.min.js"></script>
    <script>
    	function submitJoinForm() {
        	event.preventDefault(); // 기본 폼 제출 동작을 막습니다.

        	Swal.fire({
            	title: "회원가입 완료",
            	icon: "success",
            	confirmButtonColor: "#6DD66D",
            	confirmButtonText: "확인"
        	}).then((result) => {
            	if (result.isConfirmed) {
            		document.getElementById("joinForm").submit();
            	}
        	});
    	}
    </script>
</body>
</html>
