package com.smhrd.Controller;

import com.smhrd.entity.HourlyData;
import com.smhrd.repository.HourlyDataRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class MyController {

    @Autowired
    private HourlyDataRepository hourlyDataRepository;

    @GetMapping("/dataTable")
    public List<HourlyData> showHourlyDataTable() {
        // 데이터베이스에서 HourlyData 리스트를 가져옴
        List<HourlyData> hourlyDataList = hourlyDataRepository.findAll();

        // 리스트가 비어있지 않다면 그대로 반환
        if (!hourlyDataList.isEmpty()) {
            return hourlyDataList;
        } else {
            // 데이터가 없을 경우에만 시간 데이터를 기본으로 한 리스트를 생성하여 반환
            for (int hour = 0; hour < 24; hour++) {
                HourlyData data = new HourlyData();
                data.setHour(hour);
                // 필요한 초기 데이터를 설정하거나 기본값을 설정
                data.setPowerGeneration(0);
                data.setCumulativePower(0);
                data.setSolarRadiation(0);
                data.setTemperature(0);
                data.setWindSpeed(0);
                data.setTm_pg(0);
                data.setTm_cp(0);
                data.setTm_s(0);
                data.setTm_tme(0);
                data.setTm_w(0);
                hourlyDataList.add(data);
            }
            return hourlyDataList;
        }
    }
}
