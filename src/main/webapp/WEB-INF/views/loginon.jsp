<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.smhrd.entity.HourlyData"%>
<%@ page import="com.smhrd.HourlyWeatherData"%>
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
<script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="assets/js/loginon.js"></script>

<!-- 통합된 스크립트 파일 -->
</head>
<body>
   <jsp:include page="header.jsp" />
   <hr class="divider">
   <main>
      <div class="container">
         <aside class="sidebar">
            <div class="plant-list">
               <c:forEach var="plant" items="${PlnatList}">
                  <c:if test="${'N' eq plant.mp_del}">
                     <div class="plant-card" id="${plant.plant_id}">
                        <p>
                           <strong>발전소 이름:</strong> ${plant.mp_name}
                        </p>
                        <p>
                           <strong>우편번호:</strong> ${plant.zip_code}
                        </p>
                        <p>
                           <strong>주소:</strong> ${plant.p_address}
                        </p>
                        <p>
                           <strong>상세주소:</strong> ${plant.p_detail}
                        </p>
                        <a href="plantDel?plantId=${plant.plant_id}">
                           <button>삭제</button>
                        </a>
                     </div>
                  </c:if>
               </c:forEach>
            </div>
            <button class="add-plant">발전소 등록 +</button>
         </aside>
         <section class="main-content">
            <div class="plant-info">
			    <p id="myplant">솔라파워 발전기 1호</p>
			    <div class="flex-container">
			        <div class="span-container">
			            <span id="address">전라남도 나주시 빛가람동</span>
			            <span><i class="bi bi-brightness-low-fill"></i> 맑음</span>
			            <span><i class="bi bi-thermometer-half"></i> 31℃</span>
			        </div>
			            <%
			                double smpValue = 131021; // 예시 SMP 값 (원)
			                double generationHours = 5.25; // 예시 발전 시간 (시간)
			
			                // SMP 수익과 발전 시간을 곱하여 총 수익을 계산
			                double totalEarnings = smpValue * generationHours;
			
			                // 포맷팅: 천 단위 구분 기호와 소수점 두 자리
			                String formattedSmpValue = String.format("%,.0f", smpValue);
			                String formattedTotalEarnings = String.format("%,.0f", totalEarnings);
			            %>
			            <div class="item">
			                <p>오늘의 SMP 수익</p>
			                <span class="spans"><i class="bi bi-currency-exchange"></i> <%=formattedTotalEarnings%>원</span>
			                <p>오늘의 발전 시간</p>
			                <span class="spans"><i class="bi bi-clock-history"></i> <%=generationHours%>시간</span>
			            </div>
			    </div>
			</div>
         
            <!-- 탭 추가 -->
            <div class="tabs">
               <button class="tab-button active" id="pd" onclick="showTab('generation')">발전량</button>
               <button class="tab-button" id="wd" onclick="showTab('weather')">기상</button>


               <!-- CSV 다운로드 버튼 추가 -->
               <button id="excelDownload">
                  <img alt="Excel" src="assets/img/excel_btn.png">
               </button>
            </div>

            <!-- 발전량 탭 콘텐츠 -->
            <div id="generation" class="tab-content active">
               <!-- 발전량 차트 -->
               <table class="chart-table">
                  <thead>
                     <tr>
                        <th class="th-color">오늘 발전량</th>
                        <th class="th-color">내일 발전량</th>
                     </tr>
                  </thead>
                  <tbody>
                     <tr>
                        <td style="width: 50%">
                           <div id="chart-container-today" class="chart"
                              style="height: 400px; width: 100%;"></div>
                        </td>
                        <td>
                           <div id="chart-container-tomorrow" class="chart"
                              style="height: 400px; width: 100%;"></div>
                        </td>
                     </tr>
                  </tbody>
               </table>

               <!-- 발전량 표 -->
               <table id="data-table">
                  <thead>
                     <tr>
                        <th colspan="6">오늘</th>
                        <th colspan="6">내일</th>
                     </tr>
                     <tr>
                        <th>시간</th>
                        <th>오늘 발전량 (kW)</th>
                        <th>오늘 누적 발전량 (kW)</th>
                        <th>오늘 일사량 (W/m²)</th>
                        <th>오늘 기온 (°C)</th>
                        <th>오늘 풍속 (m/s)</th>
                        <th>시간</th>
                        <th>내일 발전량 (kW)</th>
                        <th>내일 누적 발전량 (kW)</th>
                        <th>내일 일사량 (W/m²)</th>
                        <th>내일 기온 (°C)</th>
                        <th>내일 풍속 (m/s)</th>
                     </tr>
                  </thead>
                  <tbody>
                     
                     <tr class="powerData">

                     </tr>
                  </tbody>
               </table>
            </div>
            <!-- 모달 구조 추가 -->
            <div id="plant-modal" class="modal">
               <div class="modal-content">
                  <span class="close">&times;</span>
                  <h2>
                     발전소 등록 <i class="bi bi-brightness-high-fill"></i>
                  </h2>
                  <form id="plant-form" action="plantRegister" method="post">
                     <label for="plant-name">발전소 이름</label> <input type="text"
                        id="plant-name" name="mpName" required><br> <br>
                     <label for="plant-postcode">우편번호</label> 
                     <div class="postcode-container">
	                     <input type="text" id="plant-postcode" name="zipCode" required><br><br>
	                     <input type="button" onclick="findPost()" value="우편번호 찾기"><br>
                     </div>
                     <label for="plant-address">발전소 주소</label> <input type="text"
                        id="plant-address" name="pAddress" required><br> <br>
                     <label for="plant-detail">상세주소</label> <input type="text"
                        id="plant-detail" name="pDetail" required><br> <br>
                     <input name="memId" value="${user.memId}" type="hidden">
                     <button type="submit">등록</button>
                  </form>
               </div>
            </div>
            <!-- 기상 탭 콘텐츠 -->
            <div id="weather" class="tab-content">
               <!-- 기상 차트 -->
               <table class="chart-table">
                  <thead>
                     <tr>
                        <th class="th-color">오늘 기상</th>
                        <th class="th-color">내일 기상</th>
                     </tr>
                  </thead>
                  <tbody>
                     <tr>
                        <td style="width: 50%">
                           <div id="chart-container-weather-today" class="chart"
                              style="height: 400px; width: 100%;"></div>
                        </td>
                        <td>
                           <div id="chart-container-weather-tomorrow" class="chart"
                              style="height: 400px; width: 100%;"></div>
                        </td>
                     </tr>
                  </tbody>
               </table>

               <!-- 기상 표 -->
               <table id="weather-data-table">
                  <thead>
                     <tr>
                        <th colspan="6">오늘</th>
                        <th colspan="6">내일</th>
                     </tr>
                     <tr>
                        <th>시간</th>
                        <th>일사량 (W/m²)</th>
                        <th>기온 (°C)</th>
                        <th>풍속 (m/s)</th>
                        <th>습도 (%)</th>
                        <th>기압 (hPa)</th>
                        <th>시간</th>
                        <th>일사량 (W/m²)</th>
                        <th>기온 (°C)</th>
                        <th>풍속 (m/s)</th>
                        <th>습도 (%)</th>
                        <th>기압 (hPa)</th>
                     </tr>
                  </thead>

                  <!-- 시간별 기상 데이터 -->
                  <tbody>
                     <%
                     String[] hoursArray = new String[24];
                     for (int i = 0; i < 24; i++) {
                        hoursArray[i] = String.format("%02d:00", i);
                     }
                     %>
                     <tr>
                        
                     </tr>
                  </tbody>
               </table>
            </div>
         </section>
      </div>
   </main>
   <script src="assets/js/dataTable.js"></script>
   <script src="assets/js/popup_2.js"></script>
   <jsp:include page="footer.jsp" />
</body>

</html>