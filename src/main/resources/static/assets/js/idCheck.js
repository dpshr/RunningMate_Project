$(document).ready(function() {
    // 중복체크 버튼 클릭 시 이벤트 핸들러
    $(".button-check").on("click", function() {
        // 입력된 아이디 값을 가져옴
        var memId = $("#memId").val();
        
        // 아이디 입력란이 비어있는지 확인
        if(memId === "") {
            $("#idCheckResult").text("아이디를 입력해주세요.").css("color", "red");
            return;
        }

        // Ajax 요청을 통해 서버로 중복체크 요청 전송
        $.ajax({
            url: "idCheck", // 아이디 중복 체크를 처리하는 서버 엔드포인트
            type: "GET",               // GET 요청 방식 사용
            data: { memId: memId },    // 요청에 memId 데이터를 포함
            success: function(res) {
                // 서버로부터의 응답이 true이면 아이디 중복
                if (res) {
					console.log(res)
                    $("#idCheckResult").text("이미 사용중인 아이디입니다.").css("color", "red");
                } else {
                    // false이면 사용 가능한 아이디
                    $("#idCheckResult").text("사용 가능한 아이디입니다.").css("color", "green");
                }
            },
            error: function() {
                // 요청 중 오류가 발생한 경우 처리
                $("#idCheckResult").text("중복 체크 중 오류가 발생했습니다.").css("color", "red");
            }
        });
    });
});
