package com.smhrd.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Data;

@Data
@Entity
public class HourlyData {
   
   @Id
   private int idx;
    private int hour;
    private double powerGeneration;
    private double cumulativePower;
    private double solarRadiation;
    private double temperature;
    private double windSpeed;
    private double tm_pg;
    private double tm_cp;
    private double tm_s;
    private double tm_tme;
    private double tm_w;
    private int humid;
    private int tm_humid;
    private int pres;
    private int tm_pres;


}
