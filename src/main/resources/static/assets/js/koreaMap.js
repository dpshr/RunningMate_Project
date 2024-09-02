// 지도와 차트 초기화
var myChart = echarts.init(document.getElementById('map'));
var barChart = echarts.init(document.getElementById('chart'));

// 공공 데이터 API 요청 URL 구성
const serviceKey = '06cyzf6guv7ilUPsGDmEtXKdhoSZxQ0G1KTqwkJ%2B6vIs4gP18GLgpbIeXNVwsgTFKOMbbFdtyYWk1VYnoCtt7Q%3D%3D';
const pageNo = 700;
const perPage = 700; // 요청할 데이터 개수
const returnType = 'JSON';  // JSON 데이터 반환

// API 요청을 위한 엔드포인트 URL
const apiUrl = `https://api.odcloud.kr/api/15065269/v1/uddi:ce8e9486-0b70-46af-8319-9108bef9d8b1?page=${pageNo}&perPage=${perPage}&returnType=${returnType}&serviceKey=${serviceKey}`;

// 지역 이름 매핑
const regionMapping = {
    '강원도': '강원',
    '경기도': '경기',
    '경상남도': '경남',
    '경상북도': '경북',
    '광주시': '광주',
    '대구시': '대구',
    '대전시': '대전',
    '부산시': '부산',
    '서울시': '서울',
    '세종시': '세종',
    '울산시': '울산',
    '인천시': '인천',
    '전라남도': '전남',
    '전라북도': '전북',
    '제주도': '제주도',
    '충청남도': '충남',
    '충청북도': '충북'
};

// 한국 지도 데이터 불러오기
fetch('assets/json/koreaMap.json')
    .then(response => response.json())
    .then(geoJson => {
        echarts.registerMap('korea', geoJson);

        // 초기 지도 옵션 설정
        var mapOption = {
            tooltip: {
                trigger: 'item',
                formatter: function(params) {
                    const regionName = regionMapping[params.name] || params.name;
                    const avgPower = avgPowerData[regionName] || 0;
                    return `${params.name}<br>평균 발전량: ${avgPower} MWh`; // 소수점 자리를 직접 지정하지 않음
                }
            },
            series: [
                {
                   type: 'map',
                            map: 'korea',
                            label: {
                            show: true, // 라벨 표시
                            color: '#000000',
                            fontSize: 14,
                            fontWeight: 'bold', 
                            hideOverlap: true // 라벨이 겹치면 자동으로 숨기기
                        },
                            itemStyle: {
                                areaColor: '#cccccc',
                                borderColor: '#333333'
                            },
                            emphasis: {
                                label: {
                                    show: true,
                           color: '#000000',
                                fontSize: 14, 
                                },
                        itemStyle: {
                                borderColor: '#565656', 
                                borderWidth: 2
                            }
                            },
                      labelLayout: {
                            hideOverlap: true // 겹치는 라벨 숨기기
                        }
                }
            ]
        };

        myChart.setOption(mapOption);

        // 지역 클릭 이벤트 리스너 추가
        myChart.on('click', function(params) {
            var regionName = params.name;
            updateBarChart(regionName);
            scrollToChart();  // 차트로 스크롤
        });

        // 공공 데이터 API 요청
        fetch(apiUrl)
            .then(response => response.json())
            .then(data => {
                processApiData(data);
            })
            .catch(error => {
            });
    })
    .catch(error => {
    });

// 데이터 처리 함수
let regionData = {};
let avgPowerData = {};

// 데이터 처리 함수
function processApiData(data) {
    const items = data.data;  // JSON 구조에 맞게 'data' 필드 사용
    regionData = {}; // 데이터 초기화
    avgPowerData = {}; // 평균 발전량 데이터 초기화

    items.forEach(item => {

        // 지역 이름을 매핑된 이름으로 변환
        const regionName = regionMapping[item.지역.trim()] || item.지역.trim();

        if (!regionData[regionName]) {
            regionData[regionName] = Array(24).fill(0); // 24시간 데이터 초기화
        }
        // 시간에 맞게 인덱스를 찾고 태양광 발전량을 배열에 저장
        const hour = parseInt(item.거래시간, 10) - 1; // 거래시간을 인덱스로 변환 (1~24 시간)
        if (hour >= 0 && hour < 24) {
            const solarPower = parseFloat(item.발전량) / 1000; // kWh를 MWh로 변환
            if (!isNaN(solarPower)) {
                regionData[regionName][hour] += solarPower; // 발전량을 배열에 추가
            }
        }
    });

    // 평균 발전량 계산
    for (const [regionName, data] of Object.entries(regionData)) {
        const totalPower = data.reduce((sum, value) => sum + value, 0);
        avgPowerData[regionName] = (totalPower / 24).toFixed(2); // 평균 발전량 계산
    }

}

// 차트 업데이트 함수
function updateBarChart(regionName) {

    const hours = ['1시', '2시', '3시', '4시', '5시', '6시', '7시', '8시', '9시', '10시', '11시', '12시', 
        '13시', '14시', '15시', '16시', '17시', '18시', '19시', '20시', '21시', '22시', '23시', '24시'];

    // 데이터 소수점 두 자리까지 포맷
    const formattedData = (regionData[regionName] || Array(hours.length).fill(0)).map(value => value.toFixed(2));

    const barOption = {
      title: {
                  text: `▣ ${regionName} 시간대별 발전량`,
                  left: 'left',
                  top: 'top', 
                  textStyle: {
                      fontSize: 22, 
                      fontWeight: 'bold', 
                      color: '#00479d'
                  }
      },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'shadow'
            }
        },
        grid: {
            left: '3%',
            right: '4%',
            bottom: '3%',
            containLabel: true
        },
        xAxis: [
            {
                type: 'category',
                data: hours,
                axisTick: {
                    alignWithLabel: true
                },
                name: '시간', // x축 이름을 '시간'으로 설정
                nameLocation: 'middle',
                nameGap: 25
            }
        ],
        yAxis: [
		    {
		        type: 'value',
		        name: '태양광발전량(MWh)',
		        nameLocation: 'middle',
		        nameGap: 40,
		        min: 0,   // y축의 최소값을 0으로 고정
		        max: 2000 // y축의 최대값을 100으로 고정
		    }
		],

        series: [
            {
                name: regionName,
                type: 'bar',
                barWidth: '60%',
                data: formattedData, // 소수점 두 자리로 포맷된 데이터 사용
            itemStyle: {
                          color: '#f1af09' // 막대 색상 노랑
                      }
            }
        ]
    };

    barChart.setOption(barOption);
}
