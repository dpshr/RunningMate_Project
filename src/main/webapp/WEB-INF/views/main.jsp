<%@ page import="java.io.BufferedReader, java.io.InputStreamReader, java.io.IOException, java.net.HttpURLConnection, java.net.URL, java.io.StringReader, javax.xml.parsers.DocumentBuilder, javax.xml.parsers.DocumentBuilderFactory, org.w3c.dom.Document, org.w3c.dom.Element, org.w3c.dom.NodeList, org.xml.sax.InputSource"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SolaPower</title>
<link rel="stylesheet" href="assets/css/main.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
</head>
<body>
   <!-- header.jsp 파일 포함 -->
   <jsp:include page="header.jsp" />
   <main>
      <div class="main-content">
         <h1>인공지능(AI)을 활용하여 최적의 태양광 발전소 운영을 위한 발전량 예측 서비스를 제공받을 수 있습니다.</h1>
         <div class="buttons">
            <div class="button-container">
               <div class="button-text">내 발전소 현황</div>
               <a href="loginon?memId=${user.memId}">
                  <button type="button" class="btn_direct">바로가기</button>
               </a>
            </div>
            <div class="button-container">
               <div class="button-text">전국발전지도</div>
               <div class="d-flex flex-column">
                  <a href="Go_PowerMap">
                     <button type="button" class="btn_direct">바로가기</button>
                  </a>
               </div>
            </div>
         </div>
      </div>

      <div class="market-trend">
         <h2>시장동향</h2>
         <h2>SMP + (REC × 1.0)</h2>
         <div class="main-value">
            <%
            double smpValue = 0;
            double recValue = 0;

            // SMP API 호출
            String serviceKeySMP = "2ge0zGTfTC/p1uEtJys8HdmQZZewxAJxdTxSzt3Kuv0OJDW6FvPFw83YYnAed7xmF4fWhMS1Y/KgZW2XNrDyrg==";
            String apiUrlSMP = "https://openapi.kpx.or.kr/openapi/smp1hToday/getSmp1hToday";
            String pageNoSMP = "1";
            String numOfRowsSMP = "24";
            String tradeDaySMP = "20240822";
            String areaCdSMP = "1";

            String urlStrSMP = apiUrlSMP + "?serviceKey=" + serviceKeySMP + "&pageNo=" + pageNoSMP + "&numOfRows=" + numOfRowsSMP
                  + "&tradeDay=" + tradeDaySMP + "&areaCd=" + areaCdSMP;

            StringBuilder responseBuilderSMP = new StringBuilder();

            try {
               URL urlSMP = new URL(urlStrSMP);
               HttpURLConnection connSMP = (HttpURLConnection) urlSMP.openConnection();
               connSMP.setRequestMethod("GET");

               int responseCodeSMP = connSMP.getResponseCode();

               if (responseCodeSMP == 200) {
                  BufferedReader inSMP = new BufferedReader(new InputStreamReader(connSMP.getInputStream()));
                  String inputLine;

                  while ((inputLine = inSMP.readLine()) != null) {
               responseBuilderSMP.append(inputLine);
                  }
                  inSMP.close();

                  String xmlDataSMP = responseBuilderSMP.toString();

                  // XML 파싱
                  DocumentBuilderFactory factorySMP = DocumentBuilderFactory.newInstance();
                  DocumentBuilder builderSMP = factorySMP.newDocumentBuilder();
                  Document documentSMP = builderSMP.parse(new InputSource(new StringReader(xmlDataSMP)));

                  // XML의 item 노드 추출
                  NodeList itemsSMP = documentSMP.getElementsByTagName("item");

                  // 12시 데이터만 필터링
                  for (int i = 0; i < itemsSMP.getLength(); i++) {
               Element item = (Element) itemsSMP.item(i);
               String tradeHourVal = item.getElementsByTagName("tradeHour").item(0).getTextContent();
               if ("12".equals(tradeHourVal)) {
                  smpValue = Double.parseDouble(item.getElementsByTagName("smp").item(0).getTextContent());
                  break; // 12시 데이터만 필요하므로 반복문 종료
               }
                  }
               } else {
                  out.print("<p>Error: Unable to fetch data from SMP API. Response code: " + responseCodeSMP + "</p>");
               }
            } catch (IOException e) {
               out.print("<p>Error: " + e.getMessage() + "</p>");
            } catch (Exception e) {
               out.print("<p>Error: " + e.getMessage() + "</p>");
            }

            // REC API 호출
            String serviceKeyREC = "06cyzf6guv7ilUPsGDmEtXKdhoSZxQ0G1KTqwkJ%2B6vIs4gP18GLgpbIeXNVwsgTFKOMbbFdtyYWk1VYnoCtt7Q%3D%3D";
            String apiUrlREC = "http://www.iwest.co.kr:8082/openapi-data/service/TradeList/Trade";
            String strDateE = "201505";
            String strDateS = "201505";
            String urlStrREC = apiUrlREC + "?serviceKey=" + serviceKeyREC + "&strDateE=" + strDateE + "&strDateS=" + strDateS;

            StringBuilder responseBuilderREC = new StringBuilder();

            try {
               URL urlREC = new URL(urlStrREC);
               HttpURLConnection connREC = (HttpURLConnection) urlREC.openConnection();
               connREC.setRequestMethod("GET");

               int responseCodeREC = connREC.getResponseCode();

               if (responseCodeREC == 200) {
                  BufferedReader inREC = new BufferedReader(new InputStreamReader(connREC.getInputStream()));
                  String inputLine;

                  while ((inputLine = inREC.readLine()) != null) {
               responseBuilderREC.append(inputLine);
                  }
                  inREC.close();

                  String xmlDataREC = responseBuilderREC.toString();

                  // XML 파싱
                  DocumentBuilderFactory factoryREC = DocumentBuilderFactory.newInstance();
                  DocumentBuilder builderREC = factoryREC.newDocumentBuilder();
                  Document documentREC = builderREC.parse(new InputSource(new StringReader(xmlDataREC)));

                  // XML의 item 노드 추출
                  NodeList itemsREC = documentREC.getElementsByTagName("item");

                  // 첫 번째 REC 데이터 추출
                  if (itemsREC.getLength() > 0) {
               Element item = (Element) itemsREC.item(0);
               recValue = Double.parseDouble(item.getElementsByTagName("recprice").item(0).getTextContent());
                  }
               } else {
                  out.print("<p>Error: Unable to fetch data from REC API. Response code: " + responseCodeREC + "</p>");
               }
            } catch (IOException e) {
               out.print("<p>Error: " + e.getMessage() + "</p>");
            } catch (Exception e) {
               out.print("<p>Error: " + e.getMessage() + "</p>");
            }

            // SMP와 REC의 소수점 자리수를 맞춘 후 더하기
            double combinedValue = smpValue + (recValue / 1000); // 예시: SMP와 REC를 같은 단위로 맞춤

            // 소수점 두 자리와 천 단위 구분 기호 적용
            String formattedMainValue = String.format("%,.2f", combinedValue);
            String formattedSmpValue = String.format("%,.2f", smpValue);
            String formattedRecValue = String.format("%,.0f", recValue); // 소수점 제거
            %>
            <%=formattedMainValue%>
         </div>
         <div class="separator"></div>
         <div class="sub-title">SMP</div>
         <div class="sub-text">오늘 시장가격</div>
         <div class="value"><%=formattedSmpValue%></div>
         <!-- SMP 값이 표시되는 부분 -->
         <div class="sub-title">REC 현물</div>
         <div class="value"><%=formattedRecValue%></div>
         <!-- REC 값이 표시되는 부분 -->
      </div>
   </main>
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.1.5/dist/sweetalert2.all.min.js"></script>
   
   <script type="text/javascript">
      var ms = "${sessionScope.ms}";
      if (ms) {
         Swal.fire({
            text : ms,
            icon : "warning",
            confirmButtonColor : "#6DD66D", // 확인 버튼 색상 설정
            confirmButtonText : "로그인 페이지로 이동"
         }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = 'Go_Login'; // 로그인 페이지로 이동
            }
        });
        <% session.removeAttribute("ms"); %>
    }
   </script>
   <script>
   // 세션에서 메시지를 받아와서 출력하고, 세션에서 삭제
      var msg = "${sessionScope.msg}";
      if (msg) {
         Swal.fire({
            title : "로그인 성공",
            text : msg,
            icon : "success",
            confirmButtonColor : "#6DD66D", // 확인 버튼 색상 설정
            confirmButtonText : "확인"
         });
        
   <%session.removeAttribute("msg");%>
   <!-- 메시지 출력 후 세션에서 제거 -->
      }
     
   </script>
   <script>
   // 카카오톡
      var msgg = "${sessionScope.msgg}";
      if (msgg) {
         Swal.fire({
            title : "로그인 성공",
            text : msgg,
            icon : "success",
            confirmButtonColor : "#6DD66D", // 확인 버튼 색상 설정
            confirmButtonText : "확인"
         });
        
   <%session.removeAttribute("msgg");%>
   <!-- 메시지 출력 후 세션에서 제거 -->
      }
     
   </script>
    <script src="https://code.jquery.com/jquery-3.7.1.js" type="text/javascript"></script>
   <jsp:include page="footer.jsp" />
</body>
</html>