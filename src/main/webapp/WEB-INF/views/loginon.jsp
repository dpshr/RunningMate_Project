<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.smhrd.HourlyData"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SolaPower</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="assets/css/loginon.css">
<link rel="stylesheet" href="assets/css/modal.css">
<!-- 모달 CSS 파일 -->
<link rel="stylesheet" href="assets/css/chart.css">
<!-- 차트 CSS 파일 -->
<script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- jQuery 추가 -->
<script src="assets/js/chart.js"></script>
<!-- 차트 관련 JavaScript 파일 포함 -->
<script>
	$(document).ready(
			function() {
				// 탭 버튼 클릭 시 해당 탭 내용만 표시
				$('.tab-button').on('click', function() {
					var target = $(this).attr('onclick').split("'")[1];
					$('.tab-content').removeClass('active');
					$('#' + target).addClass('active');
					$('.tab-button').removeClass('active');
					$(this).addClass('active');
				});

				// 차트 초기화
				function initCharts() {
					var chartToday = echarts.init(document
							.getElementById('chart-container-today'));
					var chartTomorrow = echarts.init(document
							.getElementById('chart-container-tomorrow'));

					var optionToday = {
					// 차트 옵션 설정
					};
					var optionTomorrow = {
					// 차트 옵션 설정
					};

					chartToday.setOption(optionToday);
					chartTomorrow.setOption(optionTomorrow);
				}

				initCharts();
			});
</script>
</head>
<body>

    <jsp:include page="header.jsp" />
	<div class="banner">
		<img src="assets/img/sola2.png" alt="배너 이미지">
	</div>

	<main>
		<div class="container">
			<aside class="sidebar">
				<div class="plant">
					<p>발전소_01</p>
					<p>ID : 123456</p>
					<button>삭제</button>
				</div>
				<div class="plant">
					<p>발전소_02</p>
					<p>ID : 000000</p>
					<button>삭제</button>
				</div>
				<div class="plant">
					<p>발전소_03</p>
					<p>ID : 7891011</p>
					<button>삭제</button>
				</div>
				<button class="add-plant">발전소 등록 +</button>
			</aside>

			<section class="main-content">
				<div class="plant-info">
					<h3>발전소_01</h3>
					<div class="info">
						<div class="item">
							<p>오늘의 SMP 수익</p>
							<i class="bi bi-coin"> 131,021원</i>
						</div>
						<div class="item">
							<p>오늘의 발전 시간</p>
							<i class="bi bi-clock"> 5.25시간</i>
						</div>
					</div>
				</div>

				<!-- 탭 추가 -->
				<div class="tabs">
					<button class="tab-button active" onclick="showTab('generation')">발전량</button>
					<button class="tab-button" onclick="showTab('weather')">기상</button>
				</div>

				<!-- CSV 다운로드 버튼 추가 -->
				<div>
					<button id="excelDownload">Excel 다운로드</button>
				</div>

				<div id="generation" class="tab-content active">
                <!-- 발전량 테이블 -->
                <table class="chart-table">
                    <thead>
                        <tr>
                            <th>오늘 발전량</th>
                            <th>내일 발전량</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td style="width: 50%">
                                <div id="chart-container-today" class="chart" style="height: 400px; width: 100%;"></div>
                            </td>
                            <td>
                                <div id="chart-container-tomorrow" class="chart" style="height: 400px; width: 100%;"></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

				<div id="weather" class="tab-content">
					<!-- 기상 테이블 -->
					<table id="data-table">
						<thead>
							<tr>
								<th colspan="6">오늘</th>
								<th colspan="6">내일</th>
							</tr>
							<tr>
								<th>시간</th>
								<th>발전량 (kW)</th>
								<th>누적 발전량 (kW)</th>
								<th>일사량 (W/m²)</th>
								<th>기온 (°C)</th>
								<th>풍속 (m/s)</th>
								<th>시간</th>
								<th>발전량 (kW)</th>
								<th>누적 발전량 (kW)</th>
								<th>일사량 (W/m²)</th>
								<th>기온 (°C)</th>
								<th>풍속 (m/s)</th>
							</tr>
						</thead>
						<tbody>
							<%
							// 오늘과 내일의 발전량 데이터를 가져온다고 가정
							List<HourlyData> todayDataList = (List<HourlyData>) request.getAttribute("todayDataList");
							List<HourlyData> tomorrowDataList = (List<HourlyData>) request.getAttribute("tomorrowDataList");

							// 시간대 배열 생성
							String[] hours = new String[24];
							for (int i = 0; i < 24; i++) {
								hours[i] = String.format("%02d:00", i); // 시간대 형식화 (예: 00:00, 01:00, ...)
							}

							for (int i = 0; i < 24; i++) {
								HourlyData todayData = (todayDataList != null && i < todayDataList.size()) ? todayDataList.get(i) : null;
								HourlyData tomorrowData = (tomorrowDataList != null && i < tomorrowDataList.size())
								? tomorrowDataList.get(i)
								: null;
							%>
							<tr>
								<td><%=todayData != null ? todayData.getHour() : hours[i]%></td>
								<td><%=todayData != null ? todayData.getPowerGeneration() : ""%></td>
								<td><%=todayData != null ? todayData.getCumulativePower() : ""%></td>
								<td><%=todayData != null ? todayData.getSolarRadiation() : ""%></td>
								<td><%=todayData != null ? todayData.getTemperature() : ""%></td>
								<td><%=todayData != null ? todayData.getWindSpeed() : ""%></td>
								<td><%=tomorrowData != null ? tomorrowData.getHour() : hours[i]%></td>
								<td><%=tomorrowData != null ? tomorrowData.getPowerGeneration() : ""%></td>
								<td><%=tomorrowData != null ? tomorrowData.getCumulativePower() : ""%></td>
								<td><%=tomorrowData != null ? tomorrowData.getSolarRadiation() : ""%></td>
								<td><%=tomorrowData != null ? tomorrowData.getTemperature() : ""%></td>
								<td><%=tomorrowData != null ? tomorrowData.getWindSpeed() : ""%></td>
							</tr>
							<%
							}
							%>
						</tbody>
					</table>
				</div>
			</section>
		</div>
	</main>

	<!-- 모달 구조 추가 -->
	<div id="plant-modal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<h2>
				발전소 등록 <i class="bi bi-brightness-high-fill"></i>
			</h2>
			<form id="plant-form">
				<label for="plant-name">발전소 이름:</label> <input type="text"
					id="plant-name" name="plant-name" required><br>
				<br> <label for="plant-id">발전소 ID:</label> <input type="text"
					id="plant-id" name="plant-id" required><br>
				<br> <label for="plant-address">발전소 주소:</label> <input
					type="text" id="plant-address" name="plant-address" required><br>
				<br>
				<button type="submit">등록</button>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		// 모달 관련 변수
		var modal = document.getElementById("plant-modal");
		var btn = document.querySelector(".add-plant");
		var span = document.getElementsByClassName("close")[0];

		// 발전소 등록 버튼 클릭 시 모달 열기
		btn.onclick = function() {
			modal.style.display = "block";
		}

		// 모달의 X 버튼 클릭 시 모달 닫기
		span.onclick = function() {
			modal.style.display = "none";
		}

		// 모달 외부 클릭 시 모달 닫기
		window.onclick = function(event) {
			if (event.target == modal) {
				modal.style.display = "none";
			}
		}

		// 탭 버튼 클릭 시 탭 내용 표시
		function showTab(tabId) {
			var tabs = document.querySelectorAll('.tab-content');
			var buttons = document.querySelectorAll('.tab-button');

			tabs.forEach(function(tab) {
				tab.classList.remove('active');
			});

			buttons.forEach(function(button) {
				button.classList.remove('active');
			});

			document.getElementById(tabId).classList.add('active');
			event.currentTarget.classList.add('active');
		}

		// CSV 다운로드 버튼 클릭 시 CSV 생성 및 다운로드
		$("#excelDownload").click(function() {
			let filename = "generation_data.csv";
			getCSV(filename);
		});

		function getCSV(filename) {
			var csv = [];
			var row = [];

			// 테이블 헤더
			row.push("시간", "오늘 발전량 (kW)", "오늘 누적 발전량 (kW)", "오늘 일사량 (W/m²)",
					"오늘 기온 (°C)", "오늘 풍속 (m/s)", "시간", "내일 발전량 (kW)",
					"내일 누적 발전량 (kW)", "내일 일사량 (W/m²)", "내일 기온 (°C)",
					"내일 풍속 (m/s)");
			csv.push(row.join(","));

			// 테이블 데이터
			$('#data-table tbody tr').each(function() {
				row = [];
				$(this).find('td').each(function() {
					row.push($(this).text().trim());
				});
				csv.push(row.join(","));
			});

			downloadCSV(csv.join("\n"), filename);
		}

		function downloadCSV(csv, filename) {
			var csvFile;
			var downloadLink;

			// 한글 처리를 해주기 위해 BOM 추가하기
			const BOM = "\uFEFF";
			csv = BOM + csv;

			csvFile = new Blob([ csv ], {
				type : "text/csv"
			});
			downloadLink = document.createElement("a");
			downloadLink.download = filename;
			downloadLink.href = window.URL.createObjectURL(csvFile);
			downloadLink.style.display = "none";
			document.body.appendChild(downloadLink);
			downloadLink.click();
		}
	</script>

</body>
</html>
