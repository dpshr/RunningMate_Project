package com.smhrd;

public class HourlyWeatherData {
    private String hour;            // 시간
    private double solarRadiation;  // 일사량 (W/m²)
    private double temperature;     // 기온 (°C)
    private double windSpeed;       // 풍속 (m/s)
    private double humidity;        // 습도 (%)
    private double pressure;        // 기압 (hPa)

    // 기본 생성자
    public HourlyWeatherData() {
    }

    // 매개변수가 있는 생성자
    public HourlyWeatherData(String hour, double solarRadiation, double temperature, 
                              double windSpeed, double humidity, double pressure) {
        this.hour = hour;
        this.solarRadiation = solarRadiation;
        this.temperature = temperature;
        this.windSpeed = windSpeed;
        this.humidity = humidity;
        this.pressure = pressure;
    }

    // Getter 및 Setter 메서드
    public String getHour() {
        return hour;
    }

    public void setHour(String hour) {
        this.hour = hour;
    }

    public double getSolarRadiation() {
        return solarRadiation;
    }

    public void setSolarRadiation(double solarRadiation) {
        this.solarRadiation = solarRadiation;
    }

    public double getTemperature() {
        return temperature;
    }

    public void setTemperature(double temperature) {
        this.temperature = temperature;
    }

    public double getWindSpeed() {
        return windSpeed;
    }

    public void setWindSpeed(double windSpeed) {
        this.windSpeed = windSpeed;
    }

    public double getHumidity() {
        return humidity;
    }

    public void setHumidity(double humidity) {
        this.humidity = humidity;
    }

    public double getPressure() {
        return pressure;
    }

    public void setPressure(double pressure) {
        this.pressure = pressure;
    }

    @Override
    public String toString() {
        return "HourlyWeatherData{" +
                "hour='" + hour + '\'' +
                ", solarRadiation=" + solarRadiation +
                ", temperature=" + temperature +
                ", windSpeed=" + windSpeed +
                ", humidity=" + humidity +
                ", pressure=" + pressure +
                '}';
    }
}
