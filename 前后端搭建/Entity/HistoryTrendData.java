package Demo.Entity;

import java.util.Date;
import java.math.BigDecimal;

/**
 * 历史趋势数据表
 */
public class HistoryTrendData {
    /** 趋势编号 - varchar(15) 非空，主键 自增（001、002...） */
    private String trendId;
    
    /** 能源类型 - VARCHAR(20) 非空，电 / 水 / 蒸汽 / 天然气 / 光伏 */
    private String energyType;
    
    /** 统计周期 - VARCHAR(20) 非空，日 / 周 / 月 */
    private String statisticsPeriod;
    
    /** 统计时间 - DATE 非空 */
    private Date statisticsDate;
    
    /** 能耗 / 发电量数值 - DECIMAL(18,2) 非空 */
    private BigDecimal energyValue;
    
    /** 同比增长率 - DECIMAL(8,2) % 可空 */
    private BigDecimal yearOverYearGrowth;
    
    /** 环比增长率 - DECIMAL(8,2) % 可空 */
    private BigDecimal monthOverMonthGrowth;
    
    /** 行业均值 - VARCHAR(20) 可空 */
    private String industryAverage;
    
    // getters and setters
    public String getTrendId() { return trendId; }
    public void setTrendId(String trendId) { this.trendId = trendId; }
    
    public String getEnergyType() { return energyType; }
    public void setEnergyType(String energyType) { this.energyType = energyType; }
    
    public String getStatisticsPeriod() { return statisticsPeriod; }
    public void setStatisticsPeriod(String statisticsPeriod) { this.statisticsPeriod = statisticsPeriod; }
    
    public Date getStatisticsDate() { return statisticsDate; }
    public void setStatisticsDate(Date statisticsDate) { this.statisticsDate = statisticsDate; }
    
    public BigDecimal getEnergyValue() { return energyValue; }
    public void setEnergyValue(BigDecimal energyValue) { this.energyValue = energyValue; }
    
    public BigDecimal getYearOverYearGrowth() { return yearOverYearGrowth; }
    public void setYearOverYearGrowth(BigDecimal yearOverYearGrowth) { this.yearOverYearGrowth = yearOverYearGrowth; }
    
    public BigDecimal getMonthOverMonthGrowth() { return monthOverMonthGrowth; }
    public void setMonthOverMonthGrowth(BigDecimal monthOverMonthGrowth) { this.monthOverMonthGrowth = monthOverMonthGrowth; }
    
    public String getIndustryAverage() { return industryAverage; }
    public void setIndustryAverage(String industryAverage) { this.industryAverage = industryAverage; }
}

