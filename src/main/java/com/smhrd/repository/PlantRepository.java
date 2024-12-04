package com.smhrd.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.smhrd.entity.TblPlant;

public interface PlantRepository extends JpaRepository<TblPlant,Integer>{
}
