<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PowerMap</title>
<style>
.divider {
   border: 0;
   height: 1px;
   background-color: #ccc;
   margin: 1px;
}

.image-container {
   position: relative;
   margin: 0 auto;
}

.image-container img {
   width: 100%;
   height: auto;
   display: block;
}

.image-text {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    color: white;
    font-size: 40px;
    font-weight: bold;
    text-align: center;
    text-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);
    letter-spacing: 2px;
}

.image-text p {
   font-size: 20px; 
   margin-top: 10px; 
}

.wrapper {
   display: flex;
   justify-content: center;
   align-items: flex-start;
   margin: 100px auto;
   width: 1600px; /* 전체 너비를 1600px로 설정 */
}

.map-container {
   width: 800px;
   padding: 10px;
   background-color: #98c9f4;
   display: flex;
   justify-content: center;
   border-radius: 10px;
}

#map {
   width: 100%;
   height: 600px;
}

.chart-container {
    border: 1px solid #333333;
    margin: 0 5px;
    padding: 10px;
    border-radius: 10px;
}


#chart {
   width: 800px;
   height: 600px;
   margin-left: 20px;
}
</style>
<script src="https://cdn.jsdelivr.net/npm/echarts/dist/echarts.min.js"></script>
</head>
<body>
   <jsp:include page="header.jsp" />
   <hr class="divider">
   <div class="image-container">
      <img src="assets/img/sub_top.png">
      <!-- 이미지 위에 표시될 텍스트 -->
      <div class="image-text">
         발전지도
         <p>전국 태양광 발전량을 확인할 수 있습니다.</p>
      </div>
   </div>
   <div class="wrapper">
      <div class="map-container">
         <div id="map"></div>
      </div>
      <div class="chart-container">
         <div id="chart"></div>
      </div>
   </div>

   <jsp:include page="footer.jsp" />
   <script src="assets/js/koreaMap.js"></script>
</body>
</html>
