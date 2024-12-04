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

    <!-- 이미지 컨테이너 -->
    <div class="image-container">
        <img src="assets/img/mypage.png" alt="My Page Banner">
        <!-- 이미지 위에 표시될 텍스트 -->
        <div class="image-text">마이페이지</div>
    </div>

    <!-- 폼 컨테이너 -->
    <div class="form-container">
        <h1>회원정보 수정</h1>
        <hr>
        <form id="modifyForm" method="post">
            <label for="memId">아이디</label>
            <input type="text" name="memId" id="memId" value="${user.memId}" readonly>
            <label for="memPw">비밀번호</label>
            <input type="password" name="memPw" id="memPw" value="${user.memPw}">
            <label for="memName">이름</label>
            <input type="text" name="memName" id="memName" value="${user.memName}">
            <label for="memEmail">이메일</label>
            <input type="email" name="memEmail" id="memEmail" value="${user.memEmail}">
            <label class="gender-label">성별</label><br>
            <div class="radio-group">
                <input type="radio" name="memGender" value="M" id="male"
                    <c:if test="${user.memGender eq 'M'}">checked="checked"</c:if>
                    onclick="return false;">
                <label for="male">남자</label>
                <input type="radio" name="memGender" value="W" id="female"
                    <c:if test="${user.memGender eq 'W'}">checked="checked"</c:if>
                    onclick="return false;">
                <label for="female">여성</label>
            </div>
            <label for="memBirth" class="birth-label">생년월일</label><br>
            <input type="date" name="memBirth" id="memBirth" value="${user.memBirth}" readonly>
            <br>
            <!-- 버튼 컨테이너 -->
            <div class="button-container">
                <input type="button" value="수정완료" class="btn1" onclick="confirmModify()">
                <input type="button" value="회원탈퇴" class="btn2" onclick="confirmDelete()">
            </div>
        </form>
    </div>
    <jsp:include page="footer.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.5/dist/sweetalert2.all.min.js"></script>
    <script>
        function confirmModify() {
            // 알림창 표시 후, 사용자가 확인 버튼을 눌렀을 때 폼을 제출
            Swal.fire({
                title: "회원정보수정 완료",
                text: "회원정보가 수정되었습니다.",
                icon: "success",
                confirmButtonColor: "#6DD66D",
                confirmButtonText: "확인"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById("modifyForm").setAttribute("action", "M_modify");
                    document.getElementById("modifyForm").submit();
                }
            });
        }

        function confirmDelete() {
            // 탈퇴 확인 메시지
            Swal.fire({
                title: "정말로 탈퇴하시겠습니까?",
                text: "탈퇴 후에는 계정을 복구할 수 없습니다.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "탈퇴",
                cancelButtonText: "취소"
            }).then((result) => {
                if (result.isConfirmed) {
                    // 탈퇴 확인 후 알림창
                    Swal.fire({
                        title: "회원 탈퇴 완료",
                        text: "탈퇴 처리가 완료되었습니다.",
                        icon: "success",
                        confirmButtonColor: "#6DD66D",
                        confirmButtonText: "확인"
                    }).then((result) => {
                        if (result.isConfirmed) {
                            document.getElementById("modifyForm").setAttribute("action", "M_delete");
                            document.getElementById("modifyForm").submit();
                        }
                    });
                }
            });
        }
        <% session.removeAttribute("msg"); %>
    </script>
</body>
</html>
