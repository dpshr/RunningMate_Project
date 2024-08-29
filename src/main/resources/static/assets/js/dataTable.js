$.ajax({
	url: 'dataTable',
	type: 'get',
	data: {

	},
	success: function(res) {
		let data = res;
		console.log("데이터",data)
		

		for (let i = 0; i < data.length; i++) {
			let tr = '<tr>';
			tr += '<td>' + data[i].hour + '</td>';
			tr += '<td>' + data[i].powerGeneration.toFixed(2) + '</td>';
			tr += '<td>' + data[i].cumulativePower.toFixed(2) + '</td>';
			tr += '<td>' + data[i].solarRadiation.toFixed(2) + '</td>';
			tr += '<td>' + data[i].temperature.toFixed(2) + '</td>';
			tr += '<td>' + data[i].windSpeed.toFixed(2) + '</td>';
			tr += '<td>' + data[i].hour + '</td>';
			tr += '<td>' + data[i].tm_pg.toFixed(2) + '</td>';
			tr += '<td>' + data[i].tm_cp.toFixed(2) + '</td>';
			tr += '<td>' + data[i].tm_s.toFixed(2) + '</td>';
			tr += '<td>' + data[i].tm_tme.toFixed(2) + '</td>';
			tr += '<td>' + data[i].tm_w.toFixed(2) + '</td>';
			tr += '</tr>';

			$('#data-table').append(tr);
		}
	}
	,
	error: function(e) {
		// 요청이 실패했을 때 실행되는 콜백 함수
		console.log("error");
	}
})
