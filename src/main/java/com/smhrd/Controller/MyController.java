package com.smhrd.Controller;

import com.smhrd.HourlyData;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
public class MyController {

    @GetMapping("/dataTable")
    public String showHourlyDataTable(Model model) {
        List<HourlyData> hourlyDataList = new ArrayList<>();

        // Sample data (replace this with actual data fetching logic)
        for (int hour = 0; hour < 24; hour++) {
            HourlyData data = new HourlyData();
            data.setHour(hour);
            data.setPowerGeneration(Math.random() * 10);
            data.setCumulativePower(Math.random() * 100);
            data.setSolarRadiation(Math.random() * 1000);
            data.setTemperature(Math.random() * 35);
            data.setWindSpeed(Math.random() * 15);
            hourlyDataList.add(data);
        }

        model.addAttribute("hourlyDataList", hourlyDataList);
        return "dataTable";
    }
}
