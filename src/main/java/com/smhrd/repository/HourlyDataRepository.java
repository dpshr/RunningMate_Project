package com.smhrd.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.smhrd.entity.HourlyData;

public interface HourlyDataRepository extends JpaRepository<HourlyData,Integer>{
}
