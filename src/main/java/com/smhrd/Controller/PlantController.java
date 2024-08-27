package com.smhrd.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.smhrd.entity.TblLocation;
import com.smhrd.entity.TblPlant;
import com.smhrd.repository.LocationRepository;
import com.smhrd.service.LocationService;
import com.smhrd.service.PlantService;

import jakarta.servlet.http.HttpSession;


@Controller
public class PlantController {
	
	@Autowired
	LocationRepository LocationRepo;
	@Autowired
	LocationService locationService;
	@Autowired
	PlantService plantService;
	// 발전소 등록
	@PostMapping("/plantRegister")
	public String plantRegister(HttpSession session,TblPlant plant,TblLocation location) {
		
		// tbl_plant 테이블에 받아온 데이터 저장
		plantService.setPlantRepo(plant);
		
		String memId = plant.getMemId();
		
		int plantId= plantService.GetPlantId(memId);
		
		location.setPlantId(plantId);
		
		locationService.setPlantId(location);
		
		
		return "redirect:loginon";
	}
		
	
	
}
