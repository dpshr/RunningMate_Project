<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.smhrd.HourlyData" %> 

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="resources/css/hd.css">
    <title>Hourly Data Table</title>
</head>
<body>
    <div class="container">
        <h1>발전량 데이터</h1>
        <table>
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

                    // 데이터가 존재할 경우 출력
                    int maxRows = Math.max(todayDataList != null ? todayDataList.size() : 0, 
                                           tomorrowDataList != null ? tomorrowDataList.size() : 0);

                    for (int i = 0; i < maxRows; i++) {
                        HourlyData todayData = (todayDataList != null && i < todayDataList.size()) ? todayDataList.get(i) : null;
                        HourlyData tomorrowData = (tomorrowDataList != null && i < tomorrowDataList.size()) ? tomorrowDataList.get(i) : null;
                %>
                <tr>
                    <td><%= todayData != null ? todayData.getHour() : "" %></td>
                    <td><%= todayData != null ? todayData.getPowerGeneration() : "" %></td>
                    <td><%= todayData != null ? todayData.getCumulativePower() : "" %></td>
                    <td><%= todayData != null ? todayData.getSolarRadiation() : "" %></td>
                    <td><%= todayData != null ? todayData.getTemperature() : "" %></td>
                    <td><%= todayData != null ? todayData.getWindSpeed() : "" %></td>
                    <td><%= tomorrowData != null ? tomorrowData.getHour() : "" %></td>
                    <td><%= tomorrowData != null ? tomorrowData.getPowerGeneration() : "" %></td>
                    <td><%= tomorrowData != null ? tomorrowData.getCumulativePower() : "" %></td>
                    <td><%= tomorrowData != null ? tomorrowData.getSolarRadiation() : "" %></td>
                    <td><%= tomorrowData != null ? tomorrowData.getTemperature() : "" %></td>
                    <td><%= tomorrowData != null ? tomorrowData.getWindSpeed() : "" %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>
