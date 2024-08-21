<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="resources/css/join.css">
    <title>회원가입</title>
</head>
<body>
    <div class="header">
        <a href="main"><img alt="logo" src="resources/img/sp.png" style="height: 90px;"/></a> 
        <div class="sv">
            <a href="chart">내 발전소</a>
        </div>
        <div class="sv">
            <a href="map">발전지도</a>
        </div>
        <div class="sv">
            <a href="#">관련소식</a> 
        </div>
        <div class="sv">
            <a href="#">게시판</a> 
        </div>
    </div>

    <div class="container">
        <img src="https://static.wixstatic.com/media/11062b_24095eb285b9463d89099b1c33fe57ea~mv2.jpg/v1/fill/w_551,h_710,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/11062b_24095eb285b9463d89099b1c33fe57ea~mv2.jpg" alt="이미지">
        <div class="join">
            <h1>회원가입</h1>
            <form action="">
                아이디 <br>
                <input type="text" name="id" placeholder="아이디를 입력하세요"><br><br>
                비밀번호 <br>
                <input type="text" name="pw" placeholder="비밀번호를 입력하세요"><br><br>
                이름 <br>
                <input type="text" name="name" placeholder="이름을 입력하세요"><br><br>
                전화번호 <br>
                <input type="text" name="phone" placeholder="전화번호를 입력하세요"><br><br>
                <input type="submit" value="가입완료" class="btn">
            </form>
        </div>
    </div>
</body>
</html>
