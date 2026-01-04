package Demo.Entity;

import java.util.Date;

/**
 * 光伏预测数据表对应的实体类
 */
public class PvForecastData {
    // 预测编号（主键）
    private String forecastId;
    // 并网点编号（关联并网点表）
    private String gridConnectionId;
    // 预测日期
    private Date forecastDate;
    // 预测时段
    private String forecastPeriod;
    // 预测发电量（单位：kWh）
    private Double forecastPower;
    // 实际发电量（单位：kWh）
    private Double actualPower;
    // 偏差率（%）
    private Double deviationRate;
    // 预测模型版本
    private String modelVersion;

    // 无参构造函数
    public PvForecastData() {
    }

    // 全参构造函数
    public PvForecastData(String forecastId, String gridConnectionId, Date forecastDate, String forecastPeriod,
                          Double forecastPower, Double actualPower, Double deviationRate, String modelVersion) {
        this.forecastId = forecastId;
        this.gridConnectionId = gridConnectionId;
        this.forecastDate = forecastDate;
        this.forecastPeriod = forecastPeriod;
        this.forecastPower = forecastPower;
        this.actualPower = actualPower;
        this.deviationRate = deviationRate;
        this.modelVersion = modelVersion;
    }

    // Getter & Setter
    public String getForecastId() {
        return forecastId;
    }

    public void setForecastId(String forecastId) {
        this.forecastId = forecastId;
    }

    public String getGridConnectionId() {
        return gridConnectionId;
    }

    public void setGridConnectionId(String gridConnectionId) {
        this.gridConnectionId = gridConnectionId;
    }

    public Date getForecastDate() {
        return forecastDate;
    }

    public void setForecastDate(Date forecastDate) {
        this.forecastDate = forecastDate;
    }

    public String getForecastPeriod() {
        return forecastPeriod;
    }

    public void setForecastPeriod(String forecastPeriod) {
        this.forecastPeriod = forecastPeriod;
    }

    public Double getForecastPower() {
        return forecastPower;
    }

    public void setForecastPower(Double forecastPower) {
        this.forecastPower = forecastPower;
    }

    public Double getActualPower() {
        return actualPower;
    }

    public void setActualPower(Double actualPower) {
        this.actualPower = actualPower;
    }

    public Double getDeviationRate() {
        return deviationRate;
    }

    public void setDeviationRate(Double deviationRate) {
        this.deviationRate = deviationRate;
    }

    public String getModelVersion() {
        return modelVersion;
    }

    public void setModelVersion(String modelVersion) {
        this.modelVersion = modelVersion;
    }
}