package com.smhrd.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.smhrd.entity.TblLocation;
import com.smhrd.entity.TblPlant;
import com.smhrd.repository.LocationRepository;
import com.smhrd.repository.PlantRepository;

import jakarta.transaction.Transactional;



@Service
public class LocationService {

	    @Autowired
	    private LocationRepository locationRepository;
	    

	    public void setPlantId(TblLocation location) {
			locationRepository.save(location);
		}




}
	
	
	
	


