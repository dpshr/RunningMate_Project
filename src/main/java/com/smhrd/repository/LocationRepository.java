package com.smhrd.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smhrd.entity.TblLocation;



public interface LocationRepository extends JpaRepository<TblLocation,Integer> {
	
}
