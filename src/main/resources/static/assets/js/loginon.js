$(document).ready(function() {
    // 탭 버튼 클릭 시 해당 탭 내용만 표시
    $('.tab-button').on('click', function() {
        var target = $(this).attr('onclick').split("'")[1];
        $('.tab-content').removeClass('active');
        $('#' + target).addClass('active');
        $('.tab-button').removeClass('active');
        $(this).addClass('active');

        // 각 탭에 따른 차트 렌더링
        if (target === 'generation') {
            renderGenerationChart();
        } else if (target === 'weather') {
            renderWeatherChart();
        }
    });
    
    // 발전소 카드 클릭 시 색상 변경
    $('.plant-card').on('click', function() {
        // 기존의 활성화된 카드에서 active 클래스 제거
        $('.plant-card').removeClass('active');
        
        // 클릭된 카드에 active 클래스 추가
        $(this).addClass('active');
    });

    // 발전량 차트 초기화 및 렌더링
    function renderGenerationChart() {
        var chartToday = echarts.init(document.getElementById('chart-container-today'));
        var chartTomorrow = echarts.init(document.getElementById('chart-container-tomorrow'));

        var optionToday = {
            xAxis: {
                type: 'category',
                data: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00'] // 시간 데이터
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: [820, 932, 901, 934, 1290, 1330, 1320, 1500, 1450, 1430, 1420, 1350, 1250, 1150, 1100, 1080, 1040, 1000, 960, 920, 880, 850, 820, 790], // 발전량 데이터
                type: 'bar',
                itemStyle: {
                    color: '#33C3FF' // 발전량 차트 색상 (파랑색)
                }
            }]
        };

        var optionTomorrow = {
            xAxis: {
                type: 'category',
                data: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00'] // 시간 데이터
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: [620, 732, 701, 734, 1090, 1130, 1120, 1300, 1250, 1230, 1220, 1150, 1050, 950, 900, 880, 840, 800, 760, 720, 680, 650, 620, 590], // 발전량 데이터
                type: 'bar',
                itemStyle: {
                    color: '#ff8f00' // 내일 발전량 차트 색상 (주황색)
                }
            }]
        };

        chartToday.setOption(optionToday);
        chartTomorrow.setOption(optionTomorrow);
    }

    // 기상 차트 초기화 및 렌더링
    function renderWeatherChart() {
        var chartWeatherToday = echarts.init(document.getElementById('chart-container-weather-today'));
        var chartWeatherTomorrow = echarts.init(document.getElementById('chart-container-weather-tomorrow'));

        var optionWeatherToday = {
            xAxis: {
                type: 'category',
                data: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00'] // 시간 데이터
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: [15, 14, 13, 13, 12, 12, 11, 12, 13, 14, 15, 16, 17, 18, 18, 19, 19, 18, 17, 16, 15, 14, 13, 12], // 기온 데이터
                type: 'line',
                itemStyle: {
                    color: '#28A745' // 기상 차트 색상 (녹색)
                }
            }]
        };

        var optionWeatherTomorrow = {
            xAxis: {
                type: 'category',
                data: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00', '07:00', '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00', '19:00', '20:00', '21:00', '22:00', '23:00'] // 시간 데이터
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                data: [10, 12, 11, 11, 10, 10, 9, 10, 11, 12, 13, 14, 15, 16, 16, 17, 17, 16, 15, 14, 13, 12, 11, 10], // 기온 데이터
                type: 'line',
                itemStyle: {
                    color: '#FFC107' // 내일 기상 차트 색상 (노랑색)
                }
            }]
        };

        chartWeatherToday.setOption(optionWeatherToday);
        chartWeatherTomorrow.setOption(optionWeatherTomorrow);
    }

    // 초기 차트 렌더링
    renderGenerationChart();

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

        csvFile = new Blob([ csv ], { type : "text/csv" });
        downloadLink = document.createElement("a");
        downloadLink.download = filename;
        downloadLink.href = window.URL.createObjectURL(csvFile);
        downloadLink.style.display = "none";
        document.body.appendChild(downloadLink);
        downloadLink.click();
    }

    // 모달 관련 코드
    var modal = document.getElementById("plant-modal");
    var btn = document.querySelector(".add-plant");
    var span = document.getElementsByClassName("close")[0];

    btn.onclick = function() {
        modal.style.display = "block";
    }

    span.onclick = function() {
        modal.style.display = "none";
    }

    window.onclick = function(event) {
        if (event.target == modal) {
            modal.style.display = "none";
        }
    }

    // 데이터 요청 및 테이블 업데이트
    $('#wd').on('click', function() {
        req();
    });

    function req() {
        $.ajax({
            url: 'dataTable',
            type: 'get',
            data: {},
            success: function(res) {
                let data = res;
                console.log("데이터", data);

                for (let i = 0; i < data.length; i++) {
                    let tr = '<tr>';
                    tr += '<td>' + data[i].hour + '</td>';
                    tr += '<td>' + data[i].solarRadiation.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].temperature.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].windSpeed.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].hour + '</td>';
                    tr += '<td>' + data[i].tm_s.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].tm_tme.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].tm_w.toFixed(2) + '</td>';
                    tr += '</tr>';

                    $('#weather-data-table').append(tr);
                }
            },
            error: function(e) {
                console.log("error");
            }
        });
    }
});
