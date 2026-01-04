package Demo.Entity;

import java.util.Date;
import java.math.BigDecimal;

/**
 * 峰谷能耗数据表
 * 参考国标：GB/T 2589-2020
 * 参考文件：发改价格〔2021〕1093 号
 */
public class PeakValleyEnergyData {
    /** 记录编号 - VARCHAR(20) 主键（PK），唯一标识单条峰谷统计数据 */
    private String recordId;
    
    /** 能源类型 - VARCHAR(10) 非空、枚举（水 / 蒸汽 / 天然气），与计量设备能源类型一致 */
    private String energyType;
    
    /** 厂区编号 - VARCHAR(10) 非空、外键（FK→厂区。厂区编号），关联统计的厂区 */
    private String factoryId;
    
    /** 统计日期 - DATE 非空，按日统计的日期 */
    private Date statisticsDate;
    
    /** 尖峰时段能耗 - DECIMAL(10,2) 非空、≥0，单位：kWh/m³/t（与能源类型匹配） */
    private BigDecimal peakEnergy;
    
    /** 高峰时段能耗 - DECIMAL(10,2) 非空、≥0，同上（GB/T 2589-2020，数值≥0，数值精度：保留 2 位小数） */
    private BigDecimal highEnergy;
    
    /** 平段能耗 - DECIMAL(10,2) 非空、≥0，同上 */
    private BigDecimal normalEnergy;
    
    /** 低谷时段能耗 - DECIMAL(10,2) 非空、≥0，同上 */
    private BigDecimal valleyEnergy;
    
    /** 总能耗 - DECIMAL(10,2) 非空、≥0，GB/T 2589-2020，尖峰 + 高峰 + 平段 + 低谷 */
    private BigDecimal totalEnergy;
    
    /** 峰谷电价 - DECIMAL(6,4) 非空、≥0，单位：元 /kWh；发改价格〔2021〕1093 号
     * （1）价差符合要求：峰谷比≥3:1（如谷段 0.4000 元 /kWh，峰段≥1.2000 元 /kWh）；
     * （2）尖峰电价 = 峰段电价 ×(1+20%)（如峰段 1.2000 元 /kWh，尖峰 1.4400 元 /kWh）；
     * （3）精度：保留 4 位小数（与 DECIMAL (6,4) 匹配）
     */
    private BigDecimal peakValleyPrice;
    
    /** 能耗成本 - DECIMAL(12,2) 非空、≥0，发改价格〔2021〕1093 号 + GB/T 2589-2020
     * 1.计算逻辑：
     * （1）电：时段能耗（kWh）× 对应时段电价；
     * （2）水 / 蒸汽 / 天然气：先折算为 kWh，再 × 对应时段电价；
     * （3）精度：保留 2 位小数（与 DECIMAL (12,2) 匹配）
     */
    private BigDecimal energyCost;
    
    // getters and setters
    public String getRecordId() { return recordId; }
    public void setRecordId(String recordId) { this.recordId = recordId; }
    
    public String getEnergyType() { return energyType; }
    public void setEnergyType(String energyType) { this.energyType = energyType; }
    
    public String getFactoryId() { return factoryId; }
    public void setFactoryId(String factoryId) { this.factoryId = factoryId; }
    
    public Date getStatisticsDate() { return statisticsDate; }
    public void setStatisticsDate(Date statisticsDate) { this.statisticsDate = statisticsDate; }
    
    public BigDecimal getPeakEnergy() { return peakEnergy; }
    public void setPeakEnergy(BigDecimal peakEnergy) { this.peakEnergy = peakEnergy; }
    
    public BigDecimal getHighEnergy() { return highEnergy; }
    public void setHighEnergy(BigDecimal highEnergy) { this.highEnergy = highEnergy; }
    
    public BigDecimal getNormalEnergy() { return normalEnergy; }
    public void setNormalEnergy(BigDecimal normalEnergy) { this.normalEnergy = normalEnergy; }
    
    public BigDecimal getValleyEnergy() { return valleyEnergy; }
    public void setValleyEnergy(BigDecimal valleyEnergy) { this.valleyEnergy = valleyEnergy; }
    
    public BigDecimal getTotalEnergy() { return totalEnergy; }
    public void setTotalEnergy(BigDecimal totalEnergy) { this.totalEnergy = totalEnergy; }
    
    public BigDecimal getPeakValleyPrice() { return peakValleyPrice; }
    public void setPeakValleyPrice(BigDecimal peakValleyPrice) { this.peakValleyPrice = peakValleyPrice; }
    
    public BigDecimal getEnergyCost() { return energyCost; }
    public void setEnergyCost(BigDecimal energyCost) { this.energyCost = energyCost; }
}

