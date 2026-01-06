package Demo.Entity;

import java.util.Date;
import java.math.BigDecimal;

/**
 * 光伏发电数据表
 */
public class PvGenerationData {
    /** 数据编号 - VARCHAR(30) 主键（如 SD-GF-20250620-001），非空 */
    private String dataId;
    
    /** 设备编号 - VARCHAR(20) 外键（关联光伏设备信息表。设备编号），非空 */
    private String deviceId;
    
    /** 并网点编号 - VARCHAR(20) 非空 */
    private String gridPointId;
    
    /** 采集时间 - DATETIME 非空 */
    private Date collectTime;
    
    /** 发电量 - DECIMAL(18,2) 非空 */
    private BigDecimal generation;
    
    /** 上网电量 - DECIMAL(18,2) 非空 */
    private BigDecimal gridPower;
    
    /** 自用电量 - DECIMAL(18,2) 非空 */
    private BigDecimal selfConsumption;
    
    /** 汇流箱组串电压（V） - DECIMAL(10,2) 非空 */
    private BigDecimal stringVoltage;
    
    /** 组串电流（A） - DECIMAL(10,2) 非空 */
    private BigDecimal stringCurrent;
    
    /** 逆变器效率 - DECIMAL(5,2) 非空 */
    private BigDecimal inverterEfficiency;
    
    // getters and setters
    public String getDataId() { return dataId; }
    public void setDataId(String dataId) { this.dataId = dataId; }
    
    public String getDeviceId() { return deviceId; }
    public void setDeviceId(String deviceId) { this.deviceId = deviceId; }
    
    public String getGridPointId() { return gridPointId; }
    public void setGridPointId(String gridPointId) { this.gridPointId = gridPointId; }
    
    public Date getCollectTime() { return collectTime; }
    public void setCollectTime(Date collectTime) { this.collectTime = collectTime; }
    
    public BigDecimal getGeneration() { return generation; }
    public void setGeneration(BigDecimal generation) { this.generation = generation; }
    
    public BigDecimal getGridPower() { return gridPower; }
    public void setGridPower(BigDecimal gridPower) { this.gridPower = gridPower; }
    
    public BigDecimal getSelfConsumption() { return selfConsumption; }
    public void setSelfConsumption(BigDecimal selfConsumption) { this.selfConsumption = selfConsumption; }
    
    public BigDecimal getStringVoltage() { return stringVoltage; }
    public void setStringVoltage(BigDecimal stringVoltage) { this.stringVoltage = stringVoltage; }
    
    public BigDecimal getStringCurrent() { return stringCurrent; }
    public void setStringCurrent(BigDecimal stringCurrent) { this.stringCurrent = stringCurrent; }
    
    public BigDecimal getInverterEfficiency() { return inverterEfficiency; }
    public void setInverterEfficiency(BigDecimal inverterEfficiency) { this.inverterEfficiency = inverterEfficiency; }
}

