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