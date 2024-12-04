package com.smhrd.entity;


import org.hibernate.annotations.DynamicUpdate;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.Data;

@Entity // 해당 클래스가 Scan이 되어지고, Entity역할로써 기능하기 위한 어노테이션
@Data
@DynamicUpdate
public class TblPlant {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer plantId;
	private String memId;
	private String mpName;
	private String mpDel="N";
}