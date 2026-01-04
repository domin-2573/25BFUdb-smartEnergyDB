package Demo.Entity;

import java.util.Date;
import java.math.BigDecimal;

/**
 * 变压器监测数据表
 * 参考国标：《DL/T 572-2010 电力变压器运行规程》
 * 《GB/T 6451-2015 油浸式电力变压器技术参数和要求》
 * 《GB 50053-2013 20kV 及以下变电所设计规范》
 */
public class TransformerData {
    /** 数据编号 - VARCHAR(20) 主键、唯一，按 "变压器编号 + 采集时间戳" 编码，如 "BYSQ-001-202511271430" */
    private String dataId;
    
    /** 配电房编号 - VARCHAR(15) 外键、非空，关联 "配电房信息表" 的配电房编号 */
    private String substationId;
    
    /** 变压器编号 - VARCHAR(10) 非空，如 "BYSQ-001"（参考《DL/T 572-2010 电力变压器运行规程》） */
    private String transformerId;
    
    /** 采集时间 - DATETIME 非空，格式：YYYY-MM-DD HH:MM:SS（采集间隔一般≤15 分钟） */
    private Date collectTime;
    
    /** 负载率（%） - DECIMAL(5,2) 非空，正常≤80%，短期允许≤100%（参考《DL/T 572-2010 电力变压器运行规程》） */
    private BigDecimal loadRate;
    
    /** 绕组温度（℃） - DECIMAL(5,1) 非空，油浸式变压器：正常≤85℃，超 95℃触发告警（参考《GB/T 6451-2015 油浸式电力变压器技术参数和要求》） */
    private BigDecimal windingTemp;
    
    /** 铁芯温度（℃） - DECIMAL(5,1) 非空，一般比绕组温度低 5-10℃ */
    private BigDecimal coreTemp;
    
    /** 环境温度（℃） - DECIMAL(5,1) 非空，配电房内一般 - 5℃~40℃ */
    private BigDecimal ambientTemp;
    
    /** 环境湿度（%） - DECIMAL(5,1) 非空，配电房内一般 30%~70%（参考《GB 50053-2013 20kV 及以下变电所设计规范》） */
    private BigDecimal ambientHumidity;
    
    /** 运行状态 - VARCHAR(5) 非空，"正常""异常"（参考《DL/T 572-2010 电力变压器运行规程》） */
    private String operationStatus;
    
    // getters and setters
    public String getDataId() { return dataId; }
    public void setDataId(String dataId) { this.dataId = dataId; }
    
    public String getSubstationId() { return substationId; }
    public void setSubstationId(String substationId) { this.substationId = substationId; }
    
    public String getTransformerId() { return transformerId; }
    public void setTransformerId(String transformerId) { this.transformerId = transformerId; }
    
    public Date getCollectTime() { return collectTime; }
    public void setCollectTime(Date collectTime) { this.collectTime = collectTime; }
    
    public BigDecimal getLoadRate() { return loadRate; }
    public void setLoadRate(BigDecimal loadRate) { this.loadRate = loadRate; }
    
    public BigDecimal getWindingTemp() { return windingTemp; }
    public void setWindingTemp(BigDecimal windingTemp) { this.windingTemp = windingTemp; }
    
    public BigDecimal getCoreTemp() { return coreTemp; }
    public void setCoreTemp(BigDecimal coreTemp) { this.coreTemp = coreTemp; }
    
    public BigDecimal getAmbientTemp() { return ambientTemp; }
    public void setAmbientTemp(BigDecimal ambientTemp) { this.ambientTemp = ambientTemp; }
    
    public BigDecimal getAmbientHumidity() { return ambientHumidity; }
    public void setAmbientHumidity(BigDecimal ambientHumidity) { this.ambientHumidity = ambientHumidity; }
    
    public String getOperationStatus() { return operationStatus; }
    public void setOperationStatus(String operationStatus) { this.operationStatus = operationStatus; }
}

