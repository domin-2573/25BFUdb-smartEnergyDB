package Demo.Entity;

import java.util.Date;
import java.math.BigDecimal;

/**
 * 能耗监测数据表
 */
public class EnergyMonitorData {
    /** 数据编号 - VARCHAR(20) 主键（PK），唯一标识单条监测数据 */
    private String dataId;
    
    /** 设备编号 - VARCHAR(20) 外键（FK→能耗计量设备。设备编号），关联对应的计量设备 */
    private String deviceId;
    
    /** 采集时间 - DATETIME 非空，数据采集的精确时间 */
    private Date collectTime;
    
    /** 能耗值 - DECIMAL(10,2) 非空、≥0，能耗具体数值 */
    private BigDecimal energyValue;
    
    /** 单位 - VARCHAR(5) 非空、枚举（m³/t），水 / 天然气：m³；蒸汽：t */
    private String unit;
    
    /** 数据质量 - VARCHAR(5) 非空、枚举（优 / 良 / 中 / 差），数据可靠性评级 */
    private String dataQuality;
    
    /** 所属厂区编号 - VARCHAR(10) 非空，关联具体厂区（如真旺厂 / 豆果厂 / A3 厂区） */
    private String factoryId;
    
    // getters and setters
    public String getDataId() { return dataId; }
    public void setDataId(String dataId) { this.dataId = dataId; }
    
    public String getDeviceId() { return deviceId; }
    public void setDeviceId(String deviceId) { this.deviceId = deviceId; }
    
    public Date getCollectTime() { return collectTime; }
    public void setCollectTime(Date collectTime) { this.collectTime = collectTime; }
    
    public BigDecimal getEnergyValue() { return energyValue; }
    public void setEnergyValue(BigDecimal energyValue) { this.energyValue = energyValue; }
    
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    
    public String getDataQuality() { return dataQuality; }
    public void setDataQuality(String dataQuality) { this.dataQuality = dataQuality; }
    
    public String getFactoryId() { return factoryId; }
    public void setFactoryId(String factoryId) { this.factoryId = factoryId; }
}

