Kakao.init('5c16e628454a15e99a4a135f8848b906');

kakaoLogout(); // 로그인 페이지 접속시 로그아웃 시켜준다
//카카오로그인
function kakaoLogin() {
	Kakao.Auth
		.login({
			success: function(response) {
				Kakao.API
					.request({
						url: '/v2/user/me',
						success: function(response) {
							console.log(response)
							//(선택적) 이메일 필수 입력을 위한 코드 짜준다
							let nickname = response.kakao_account.profile.nickname;

							if (nickname == ''
								|| nickname == undefined) {
								alert("전체 동의하기 또는 카카오계정(이메일)을 필수 선택해주세요")
								kakaoLogout();
							} else {
								alert("로그인에 성공하셨습니다.")
								LoginSuccess(nickname)
							}

						},
						fail: function(error) {
							console.log(error)
							
						},
					})
			},
			fail: function(error) {
				console.log(error)
			},
		})
}

//카카오로그아웃  
function kakaoLogout() {
	if (Kakao.Auth.getAccessToken()) {
		Kakao.API.request({
			url: '/v1/user/unlink',
			success: function(response) {
				console.log(response)
			},
			fail: function(error) {
				console.log(error)
			},
		})
		Kakao.Auth.setAccessToken(undefined)
	}
}

function LoginSuccess(nickname){
	$.ajax({
		url: 'KakaoLogSuc',
		type: 'post',
		data: {
			"nickname": nickname
		},
		success: function(res) {
			window.location.href = "KakaoLogSuc?nickname="+nickname;
		},
		error: function(e) {
			console.log("error")
		}
	})
}
