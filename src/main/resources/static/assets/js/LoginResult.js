document.addEventListener("DOMContentLoaded", function () {
    if (loginSuccess === "true") {
        alert("로그인에 성공하였습니다.");
    } else if (loginSuccess === "false") {
        alert("로그인에 실패하였습니다. 아이디와 비밀번호를 확인해주세요.");
    }
});