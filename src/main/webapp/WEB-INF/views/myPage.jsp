<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="assets/css/myPage.css">
<title>MyPage</title>
</head>
<body>
	<jsp:include page="header.jsp" />

	<!-- 배너 이미지 -->
	<img src="assets/img/mypage.png" alt="My Page Banner">

	<!-- 폼 컨테이너 -->
	<div class="form-container">
		<h1>회원정보 수정</h1>
		<hr>
		<form method="post">
			<label for="memId">아이디</label> <input type="text" name="memId"
				id="memId" value="${user.memId}" readonly> <label
				for="memPw">비밀번호</label> <input type="password" name="memPw"
				id="memPw" value="${user.memPw}"> <label for="memName">이름</label>
			<input type="text" name="memName" id="memName"
				value="${user.memName}"> <label for="memEmail">이메일</label> <input
				type="email" name="memEmail" id="memEmail" value="${user.memEmail}">
			<label for="memBirth">생년월일</label><br> <input type="date"
				name="memBirth" id="memBirth" value="${user.memBirth}"> <label>성별</label><br>
			<div class="radio-group">
				<input type="radio" name="memGender" value="M" id="male"
					<c:if test="${user.memGender eq 'M'}">checked="checked"</c:if>> <label
					for="male">남자</label> <input type="radio" name="memGender"
					value="W" id="female"
					<c:if test="${user.memGender eq 'W'}">checked="checked"</c:if>> <label
					for="female">여성</label>
			</div>
			<br>
			<!-- 버튼 컨테이너 -->
			<div class="button-container">
				<input type="submit" value="수정완료" class="btn1" formaction="M_modify">
				<input type="submit" value="회원탈퇴" class="btn2" formaction="M_delete">
			</div>
		</form>
	</div>
	<jsp:include page="footer.jsp" />

</body>
</html>
