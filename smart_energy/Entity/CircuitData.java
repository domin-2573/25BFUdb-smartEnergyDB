package Demo.Entity;

import java.util.Date;
import java.math.BigDecimal;

/**
 * 回路监测数据表
 * 参考国标：《DL/T 5137-2012 电测量及电能计量装置设计技术规程》
 * 《GB/T 12325-2020 电能质量 供电电压偏差》
 * 《DL/T 428-2015 电力系统功率因数调整电费办法》
 * 《GB/T 12706.1-2020 额定电压 1kV (Um=1.2kV) 到 35kV (Um=40.5kV) 挤包绝缘电力电缆及附件》
 * 《GB/T 11024.1-2010 标称电压 1kV 以上交流电力系统用并联电容器》
 */
public class CircuitData {
    /** 数据编号 - VARCHAR(20) 主键、唯一，按 "回路编号 + 采集时间戳" 编码，如 "HL-001-202511271430" */
    private String dataId;
    
    /** 配电房编号 - VARCHAR(15) 外键、非空，关联 "配电房信息表" 的配电房编号 */
    private String substationId;
    
    /** 回路编号 - VARCHAR(10) 非空，如 "L1""L2"（参考《DL/T 5137-2012 电测量及电能计量装置设计技术规程》） */
    private String circuitId;
    
    /** 采集时间 - DATETIME 非空，格式：YYYY-MM-DD HH:MM:SS（采集间隔一般≤5 分钟） */
    private Date collectTime;
    
    /** 电压（kV） - DECIMAL(5,2) 非空，35kV 回路：34.5-36.7kV；0.4kV 回路：0.38-0.42kV（参考《GB/T 12325-2020 电能质量 供电电压偏差》） */
    private BigDecimal voltage;
    
    /** 电流（A） - DECIMAL(8,2) 非空，0.4kV 回路一般≤630A（常见断路器额定电流） */
    private BigDecimal current;
    
    /** 有功功率（kW） - DECIMAL(10,2) 非空，0.4kV 回路：0 - 400kW（按 S=√3UI 计算） */
    private BigDecimal activePower;
    
    /** 无功功率（kVar） - DECIMAL(10,2) 非空，与有功功率匹配，功率因数≥0.9 时，无功≤有功 ×0.48 */
    private BigDecimal reactivePower;
    
    /** 功率因数 - DECIMAL(4,2) 非空，0.85 - 1.00（参考《DL/T 428-2015 电力系统功率因数调整电费办法》） */
    private BigDecimal powerFactor;
    
    /** 正向有功电量（kWh） - DECIMAL(12,2) 非空，累计值，无上限 */
    private BigDecimal forwardActiveEnergy;
    
    /** 反向有功电量（kWh） - DECIMAL(12,2) 非空，一般≤正向电量的 5%（分布式光伏并网场景可能更高） */
    private BigDecimal reverseActiveEnergy;
    
    /** 开关状态 - VARCHAR(5) 非空，"分闸""合闸"（符合《DL/T 587-2010 微机继电保护装置运行管理规程》） */
    private String switchStatus;
    
    /** 电缆头温度（℃） - DECIMAL(5,1) 非空，正常≤90℃，超 100℃触发告警（参考《GB/T 12706.1-2020 额定电压 1kV (Um=1.2kV) 到 35kV (Um=40.5kV) 挤包绝缘电力电缆及附件》） */
    private BigDecimal cableTemp;
    
    /** 电容器温度（℃） - DECIMAL(5,1) 非空，正常≤65℃，超 75℃触发告警（参考《GB/T 11024.1-2010 标称电压 1kV 以上交流电力系统用并联电容器》） */
    private BigDecimal capacitorTemp;
    
    // getters and setters
    public String getDataId() { return dataId; }
    public void setDataId(String dataId) { this.dataId = dataId; }
    
    public String getSubstationId() { return substationId; }
    public void setSubstationId(String substationId) { this.substationId = substationId; }
    
    public String getCircuitId() { return circuitId; }
    public void setCircuitId(String circuitId) { this.circuitId = circuitId; }
    
    public Date getCollectTime() { return collectTime; }
    public void setCollectTime(Date collectTime) { this.collectTime = collectTime; }
    
    public BigDecimal getVoltage() { return voltage; }
    public void setVoltage(BigDecimal voltage) { this.voltage = voltage; }
    
    public BigDecimal getCurrent() { return current; }
    public void setCurrent(BigDecimal current) { this.current = current; }
    
    public BigDecimal getActivePower() { return activePower; }
    public void setActivePower(BigDecimal activePower) { this.activePower = activePower; }
    
    public BigDecimal getReactivePower() { return reactivePower; }
    public void setReactivePower(BigDecimal reactivePower) { this.reactivePower = reactivePower; }
    
    public BigDecimal getPowerFactor() { return powerFactor; }
    public void setPowerFactor(BigDecimal powerFactor) { this.powerFactor = powerFactor; }
    
    public BigDecimal getForwardActiveEnergy() { return forwardActiveEnergy; }
    public void setForwardActiveEnergy(BigDecimal forwardActiveEnergy) { this.forwardActiveEnergy = forwardActiveEnergy; }
    
    public BigDecimal getReverseActiveEnergy() { return reverseActiveEnergy; }
    public void setReverseActiveEnergy(BigDecimal reverseActiveEnergy) { this.reverseActiveEnergy = reverseActiveEnergy; }
    
    public String getSwitchStatus() { return switchStatus; }
    public void setSwitchStatus(String switchStatus) { this.switchStatus = switchStatus; }
    
    public BigDecimal getCableTemp() { return cableTemp; }
    public void setCableTemp(BigDecimal cableTemp) { this.cableTemp = cableTemp; }
    
    public BigDecimal getCapacitorTemp() { return capacitorTemp; }
    public void setCapacitorTemp(BigDecimal capacitorTemp) { this.capacitorTemp = capacitorTemp; }
}