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
            req(); // 기상 탭 클릭 시 데이터를 요청하고 차트를 렌더링
        }
    });

    // 발전소 카드 클릭 시 색상 변경
    $('.plant-card').on('click', function() {
        // 기존의 활성화된 카드에서 active 클래스 제거
        $('.plant-card').removeClass('active');
        
        // 클릭된 카드에 active 클래스 추가
        $(this).addClass('active');
    });

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
    function req() {
        $.ajax({
            url: 'dataTable',
            type: 'get',
            data: {},
            success: function(res) {
                let data = res;

                // 테이블 업데이트
                $('#weather-data-table tbody').empty(); // 기존 테이블 내용 비우기
                let hours = [];
                let solarRadiationData = [];
                let temperatureData = [];
                let windSpeedData = [];
                let tomorrowSolarRadiationData = [];
                let tomorrowTemperatureData = [];
                let tomorrowWindSpeedData = [];

                for (let i = 0; i < data.length; i++) {
                    let tr = '<tr class="hover-effect">'; // 클래스 추가
                    tr += '<td class="custom-background">' + data[i].hour + ':00' + '</td>';
                    tr += '<td>' + data[i].solarRadiation.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].temperature.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].windSpeed.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].humid.toFixed(0) + '</td>';
                    tr += '<td>' + data[i].pres.toFixed(1) + '</td>';
                    tr += '<td class="custom-background">' + data[i].hour + ':00' + '</td>';
                    tr += '<td>' + data[i].tm_s.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].tm_tme.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].tm_w.toFixed(2) + '</td>';
                    tr += '<td>' + data[i].tm_humid.toFixed(0) + '</td>';
                    tr += '<td>' + data[i].tm_pres.toFixed(1) + '</td>';
                    tr += '</tr>';

                    $('#weather-data-table').append(tr);

                    // 오늘 데이터를 위한 수집
                    hours.push(data[i].hour);
                    solarRadiationData.push(data[i].solarRadiation.toFixed(2));
                    temperatureData.push(data[i].temperature.toFixed(2));
                    windSpeedData.push(data[i].windSpeed.toFixed(2));

                    // 내일 데이터를 위한 수집
                    tomorrowSolarRadiationData.push(data[i].tm_s.toFixed(2));
                    tomorrowTemperatureData.push(data[i].tm_tme.toFixed(2));
                    tomorrowWindSpeedData.push(data[i].tm_w.toFixed(2));
                }

                // 기상 차트 렌더링
                renderWeatherDataChart(hours, solarRadiationData, temperatureData, windSpeedData, tomorrowSolarRadiationData, tomorrowTemperatureData, tomorrowWindSpeedData);
            },
            error: function(e) {
                console.log("error");
            }
        });
    }

    function renderWeatherDataChart(hours, solarRadiationData, temperatureData, windSpeedData, tomorrowSolarRadiationData, tomorrowTemperatureData, tomorrowWindSpeedData) {
        var chartWeatherToday = echarts.init(document.getElementById('chart-container-weather-today'));
        var chartWeatherTomorrow = echarts.init(document.getElementById('chart-container-weather-tomorrow'));

        var optionWeatherToday = {
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['일사량', '기온', '풍속']
            },
            xAxis: {
                type: 'category',
                data: hours,
				axisLabel: {
					formatter: function (value, index) {
					// 짝수 인덱스에 해당하는 값만 표시
					return index % 2 === 1 ? value : '';
					}
				}
            },
            yAxis: [
                {
                    type: 'value',
                    name: '일사량 (W/m²)',
                    position: 'left',
					nameLocation: 'middle',
					nameGap: 40,
                },
                {
                    type: 'value',
                    name: '풍속 (m/s)',
                    position: 'right',
		            nameLocation: 'start',
					splitLine: { show: false },
					nameTextStyle: {
				        padding: [0, 0, 0, 50] // 이름의 padding을 사용하여 오른쪽으로 이동 효과
				    },
                },
				{
                    type: 'value',
                    name: '기온 (°C)',
                    position: 'right',
                    offset: 30 ,// 오른쪽 여백 추가
					splitLine: { show: false }
                }
            ],
            series: [
                {
                    name: '일사량',
                    type: 'bar',
                    data: solarRadiationData,
                    yAxisIndex: 0,
                    itemStyle: {
                        color: '#f1af09' // 일사량 차트 색상 (노랑)
                    }
                },
                {
                    name: '기온',
                    type: 'line',
                    data: temperatureData,
                    yAxisIndex: 1,
                    itemStyle: {
                        color: '#28A745' // 기온 차트 색상 (녹색)
                    },
					lineStyle: {
				        type: 'dashed' // 점선으로 설정
				    },
				    smooth: true, // 곡선
					showSymbol: false // 마커 숨기기
                	},
                {
                    name: '풍속',
                    type: 'line',
                    data: windSpeedData,
                    yAxisIndex: 2,
                    itemStyle: {
                    	color: '#1E90FF', // 풍속 차트 색상 (다저블루)
					},
					showSymbol: false // 마커 숨기기
                }
            ]
        };

        var optionWeatherTomorrow = {
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['일사량', '기온', '풍속']
            },
            xAxis: {
                type: 'category',
                data: hours,
				axisLabel: {
		            formatter: function (value, index) {
		                // 짝수 인덱스에 해당하는 값만 표시
		                return index % 2 === 1 ? value : '';
		            }
	        	}
            },
            yAxis: [
                {
                    type: 'value',
                    name: '일사량 (W/m²)',
                    position: 'left',
					nameLocation: 'middle',
					nameGap: 40,
                },
                {
                    type: 'value',
                    name: '풍속 (m/s)',
                    position: 'right',
		            nameLocation: 'start',
					splitLine: { show: false },
					nameTextStyle: {
				        padding: [0, 0, 0, 50] // 이름의 padding을 사용하여 오른쪽으로 이동 효과
				    },
                },
				{
                    type: 'value',
                    name: '기온 (°C)',
                    position: 'right',
                    offset: 30 ,// 오른쪽 여백 추가
					splitLine: { show: false }
                }
            ],
            series: [
                {
                    name: '일사량',
                    type: 'bar',
                    data: tomorrowSolarRadiationData,
                    yAxisIndex: 0,
                    itemStyle: {
                        color: '#f1af09' // 일사량 차트 색상 (노랑)
                    }
                },
                {
                    name: '기온',
                    type: 'line',
                    data: tomorrowTemperatureData,
                    yAxisIndex: 1,
                    itemStyle: {
                        color: '#28A745' // 기온 차트 색상 (초록)
                    },
					lineStyle: {
				        type: 'dashed' // 점선으로 설정
				    },
				    smooth: true, // 곡선
					showSymbol: false // 마커 숨기기
                },
                {
                    name: '풍속',
                    type: 'line',
                    data: tomorrowWindSpeedData,
                    yAxisIndex: 2,
                    itemStyle: {
                        color: '#1E90FF' // 풍속 차트 색상 (다저블루)
                    },
					showSymbol: false // 마커 숨기기
                }
            ]
        };

        chartWeatherToday.setOption(optionWeatherToday);
        chartWeatherTomorrow.setOption(optionWeatherTomorrow);
    }
});
