<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SolaPower</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<style>
header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 5px 110px;
	background-color: white;
}

.logo-container {
	display: flex;
	align-items: center;
	width: 100%; /* 전체 너비를 차지하도록 설정 */
}

.logo {
	background: linear-gradient(to right, #F6890D, #1A9CE5);
	-webkit-background-clip: text;
	-webkit-text-fill-color: transparent;
	font-size: 45px;
	font-weight: bold;
	margin-left: 10px;
	
}

.bi-brightness-alt-high {
	font-size: 60px;
	color: #F6890D;
}

.bi-person {
	font-size: 35px;
	margin-right: 30px;
}

.dropdown {
	position: relative;
	display: inline-block;
	margin-left: auto;
	margin-right: 120px;
	cursor: pointer;
}

.dropdown-content {
	display: none;
	position: absolute;
	right: 0;
	background-color: white;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
	z-index: 1;
	border-radius: 5px;
}

.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	border-bottom: 1px solid #ddd;
}

.dropdown-content a:last-child {
	border-bottom: none;
}

.dropdown-content a:hover {
	background-color: #f1f1f1;
}

.dropdown:hover .dropdown-content {
	display: block;
}
a {
	text-decoration: none; /* 밑줄 제거 */
}
</style>
</head>
<body>
	<header>
		<a href="main">
			<div class="logo-container">
				<i class="bi bi-brightness-alt-high"></i> 
				<span class="logo">SolaPower</span>
			</div>
		</a>
		<div class="dropdown">
			<i class="bi bi-person"></i>
			<c:choose>
				<c:when test="${!empty user_nick}">
					<!-- 카카오 로그인했을 경우 -->
					<div class="dropdown-content">
						<i class="bi bi-person"></i> <span>${user_nick}님</span>
						<a href="Go_Mypage">마이페이지</a>
						<a href="Logout">로그아웃</a>
					</div>
				</c:when>
				<c:when test="${!empty user}">
					<!-- 일반 로그인했을 경우 -->
					<div class="dropdown-content">
						<i class="bi bi-person"></i> <span>${user.memName}님</span>
						<a href="Go_Mypage">마이페이지</a>
						<a href="Logout">로그아웃</a>
					</div>
				</c:when>
				<c:otherwise>
					<!-- 로그인하지 않았을 경우 -->
					<div class="dropdown-content">
						<a href="Go_Login" id="openLoginModal">로그인</a>
						<a href="Go_Real_Join">회원가입</a>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</header>
</body>
</html>
