package Demo.Entity;

import java.util.Date;
import java.math.BigDecimal;

/**
 * 实时汇总数据表
 */
public class RealtimeSummaryData {
    /** 汇总编号 - varchar(15) 主键（001..002）自增 */
    private String summaryId;
    
    /** 统计时间 - DATETIME */
    private Date statisticsTime;
    
    /** 总用电量 - DECIMAL(18,2) kWh */
    private BigDecimal totalElectricity;
    
    /** 总用水量 - DECIMAL(18,2) m³ */
    private BigDecimal totalWater;
    
    /** 总蒸汽消耗量 - DECIMAL(18,2) t */
    private BigDecimal totalSteam;
    
    /** 总天然气消耗量 - DECIMAL(18,2) m³ */
    private BigDecimal totalGas;
    
    /** 光伏总发电量 - DECIMAL(18,2) kWh */
    private BigDecimal totalPvGeneration;
    
    /** 光伏自用电量 - DECIMAL(18,2) kWh */
    private BigDecimal totalPvSelfConsumption;
    
    /** 总告警次数 - INT */
    private Integer totalAlarmCount;
    
    /** 高等级告警数 - INT */
    private Integer highLevelAlarmCount;
    
    /** 中等级告警数 - INT */
    private Integer mediumLevelAlarmCount;
    
    /** 低等级告警数 - INT */
    private Integer lowLevelAlarmCount;
    
    // getters and setters
    public String getSummaryId() { return summaryId; }
    public void setSummaryId(String summaryId) { this.summaryId = summaryId; }
    
    public Date getStatisticsTime() { return statisticsTime; }
    public void setStatisticsTime(Date statisticsTime) { this.statisticsTime = statisticsTime; }
    
    public BigDecimal getTotalElectricity() { return totalElectricity; }
    public void setTotalElectricity(BigDecimal totalElectricity) { this.totalElectricity = totalElectricity; }
    
    public BigDecimal getTotalWater() { return totalWater; }
    public void setTotalWater(BigDecimal totalWater) { this.totalWater = totalWater; }
    
    public BigDecimal getTotalSteam() { return totalSteam; }
    public void setTotalSteam(BigDecimal totalSteam) { this.totalSteam = totalSteam; }
    
    public BigDecimal getTotalGas() { return totalGas; }
    public void setTotalGas(BigDecimal totalGas) { this.totalGas = totalGas; }
    
    public BigDecimal getTotalPvGeneration() { return totalPvGeneration; }
    public void setTotalPvGeneration(BigDecimal totalPvGeneration) { this.totalPvGeneration = totalPvGeneration; }
    
    public BigDecimal getTotalPvSelfConsumption() { return totalPvSelfConsumption; }
    public void setTotalPvSelfConsumption(BigDecimal totalPvSelfConsumption) { this.totalPvSelfConsumption = totalPvSelfConsumption; }
    
    public Integer getTotalAlarmCount() { return totalAlarmCount; }
    public void setTotalAlarmCount(Integer totalAlarmCount) { this.totalAlarmCount = totalAlarmCount; }
    
    public Integer getHighLevelAlarmCount() { return highLevelAlarmCount; }
    public void setHighLevelAlarmCount(Integer highLevelAlarmCount) { this.highLevelAlarmCount = highLevelAlarmCount; }
    
    public Integer getMediumLevelAlarmCount() { return mediumLevelAlarmCount; }
    public void setMediumLevelAlarmCount(Integer mediumLevelAlarmCount) { this.mediumLevelAlarmCount = mediumLevelAlarmCount; }
    
    public Integer getLowLevelAlarmCount() { return lowLevelAlarmCount; }
    public void setLowLevelAlarmCount(Integer lowLevelAlarmCount) { this.lowLevelAlarmCount = lowLevelAlarmCount; }
}

