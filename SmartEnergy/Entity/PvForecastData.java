package Demo.Entity;

import java.util.Date;
import java.math.BigDecimal;

/**
 * 光伏预测数据表
 */
public class PvForecastData {
    /** 预测编号 - VARCHAR(30) 主键（如 SD-YC-20250621-001），非空 */
    private String forecastId;
    
    /** 并网点编号 - VARCHAR(20) 非空 */
    private String gridPointId;
    
    /** 预测日期 - DATE 非空 */
    private Date forecastDate;
    
    /** 预测时段 - VARCHAR(20) 非空（如 08:00-09:00） */
    private String forecastPeriod;
    
    /** 预测发电量 - DECIMAL(18,2) 非空 */
    private BigDecimal forecastGeneration;
    
    /** 实际发电量 - DECIMAL(18,2) 非空 */
    private BigDecimal actualGeneration;
    
    /** 偏差率 - DECIMAL(8,2) 非空 */
    private BigDecimal deviationRate;
    
    /** 预测模型版本 - VARCHAR(20) 非空（如 CNN-XGBoost V2.1） */
    private String modelVersion;
    
    // getters and setters
    public String getForecastId() { return forecastId; }
    public void setForecastId(String forecastId) { this.forecastId = forecastId; }
    
    public String getGridPointId() { return gridPointId; }
    public void setGridPointId(String gridPointId) { this.gridPointId = gridPointId; }
    
    public Date getForecastDate() { return forecastDate; }
    public void setForecastDate(Date forecastDate) { this.forecastDate = forecastDate; }
    
    public String getForecastPeriod() { return forecastPeriod; }
    public void setForecastPeriod(String forecastPeriod) { this.forecastPeriod = forecastPeriod; }
    
    public BigDecimal getForecastGeneration() { return forecastGeneration; }
    public void setForecastGeneration(BigDecimal forecastGeneration) { this.forecastGeneration = forecastGeneration; }
    
    public BigDecimal getActualGeneration() { return actualGeneration; }
    public void setActualGeneration(BigDecimal actualGeneration) { this.actualGeneration = actualGeneration; }
    
    public BigDecimal getDeviationRate() { return deviationRate; }
    public void setDeviationRate(BigDecimal deviationRate) { this.deviationRate = deviationRate; }
    
    public String getModelVersion() { return modelVersion; }
    public void setModelVersion(String modelVersion) { this.modelVersion = modelVersion; }
}

