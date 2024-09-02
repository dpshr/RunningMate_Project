$(document).ready(function () {
    $.ajax({
        url: 'dataTable', // 데이터를 가져올 API 엔드포인트
        type: 'get', // GET 요청 방식 사용
        success: function (res) {
            let data = res;

            // 모든 데이터를 그대로 사용
            let hours = data.map(item => item.hour);
            let todayPowerGeneration = data.map(item => item.powerGeneration.toFixed(2));
            let tomorrowPowerGeneration = data.map(item => item.tm_pg.toFixed(2));
            let cumulativePower = data.map(item => item.cumulativePower.toFixed(2));
            let tomorrowCumulativePower = data.map(item => item.tm_cp.toFixed(2));

            // ECharts 초기화 및 옵션 설정
            var chartToday = echarts.init(document.getElementById('chart-container-today'));
            var chartTomorrow = echarts.init(document.getElementById('chart-container-tomorrow'));

            var optionToday = {
                legend: {
                    data: ['발전량', '누적 발전량']
                },
                xAxis: {
                    type: 'category',
					name: '시간',
                    data: hours,
                    axisLabel: {
                        formatter: function (value) {
                            // 짝수 시간만 출력, 나머지는 공백으로 처리
                            return value % 2 === 0 ? value : '';
                        }
                    },
					nameLocation: 'middle',
					nameGap: 30,
                },
                yAxis: {
                    type: 'value',
					name: '태양광발전량(KWh)',
					nameLocation: 'middle',
					nameGap: 40,
                },
                series: [
                    {
                        name: '발전량',
                        data: todayPowerGeneration,
                        type: 'line',
                        smooth: true
                    },
                    {
                        name: '누적 발전량',
                        data: cumulativePower,
                        type: 'bar'
                    }
                ]
            };

            var optionTomorrow = {
                legend: {
                    data: ['발전량', '누적 발전량']
                },
                xAxis: {
                    type: 'category',
					name: '시간',
                    data: hours,
                    axisLabel: {
                        formatter: function (value) {
                            // 짝수 시간만 출력, 나머지는 공백으로 처리
                            return value % 2 === 0 ? value : '';
                        }
                    },
					nameLocation: 'middle',
					nameGap: 30,
                },
                yAxis: {
                    type: 'value',
					name: '태양광발전량(KWh)',
					nameLocation: 'middle',
					nameGap: 40,
                },
                series: [
                    {
                        name: '발전량',
                        data: tomorrowPowerGeneration,
                        type: 'line',
                        smooth: true
						
                    },
                    {
                        name: '누적 발전량',
                        data: tomorrowCumulativePower,
                        type: 'bar'
                    }
                ]
            };

            // 차트에 옵션 적용
            chartToday.setOption(optionToday);
            chartTomorrow.setOption(optionTomorrow);

            // 테이블 생성
            let tableBody = $('#data-table tbody');

            data.forEach(item => {
                let tr = '<tr class="hover-effect">'; // 클래스 추가
                tr += '<td class="custom-background">' + item.hour + ':00' + '</td>';
                tr += '<td>' + item.powerGeneration.toFixed(2) + '</td>';
                tr += '<td>' + item.cumulativePower.toFixed(2) + '</td>';
                tr += '<td>' + item.solarRadiation.toFixed(2) + '</td>';
                tr += '<td>' + item.temperature.toFixed(2) + '</td>';
                tr += '<td>' + item.windSpeed.toFixed(2) + '</td>';
                tr += '<td class="custom-background">' + item.hour + ':00' + '</td>';
                tr += '<td>' + item.tm_pg.toFixed(2) + '</td>';
                tr += '<td>' + item.tm_cp.toFixed(2) + '</td>';
                tr += '<td>' + item.tm_s.toFixed(2) + '</td>';
                tr += '<td>' + item.tm_tme.toFixed(2) + '</td>';
                tr += '<td>' + item.tm_w.toFixed(2) + '</td>';
                tr += '</tr>';

                tableBody.append(tr);
            });
        },
        error: function (e) {
            console.log("Error: ", e);
        }
    });
});
