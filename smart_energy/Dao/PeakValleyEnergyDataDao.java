package Demo.Dao;

import Demo.Entity.PeakValleyEnergyData;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

/**
 * 峰谷能耗数据DAO
 */
@Mapper
public interface PeakValleyEnergyDataDao {
    
    @Insert("INSERT INTO `峰谷能耗数据` (`记录编号`, `能源类型`, `厂区编号`, `统计日期`, " +
            "`尖峰时段能耗`, `高峰时段能耗`, `平段能耗`, `低谷时段能耗`, `总能耗`, `峰谷电价`, `能耗成本`) " +
            "VALUES (#{recordId}, #{energyType}, #{factoryId}, #{statisticsDate}, " +
            "#{peakEnergy}, #{highEnergy}, #{normalEnergy}, #{valleyEnergy}, #{totalEnergy}, #{peakValleyPrice}, #{energyCost})")
    int insertPeakValleyEnergyData(PeakValleyEnergyData data);
    
    @Select("SELECT `记录编号` AS recordId, `能源类型` AS energyType, `厂区编号` AS factoryId, `统计日期` AS statisticsDate, " +
            "`尖峰时段能耗` AS peakEnergy, `高峰时段能耗` AS highEnergy, `平段能耗` AS normalEnergy, " +
            "`低谷时段能耗` AS valleyEnergy, `总能耗` AS totalEnergy, `峰谷电价` AS peakValleyPrice, `能耗成本` AS energyCost " +
            "FROM `峰谷能耗数据` WHERE `记录编号` = #{recordId}")
    PeakValleyEnergyData getPeakValleyEnergyDataById(@Param("recordId") String recordId);
    
    @Select("SELECT `记录编号` AS recordId, `能源类型` AS energyType, `厂区编号` AS factoryId, `统计日期` AS statisticsDate, " +
            "`尖峰时段能耗` AS peakEnergy, `高峰时段能耗` AS highEnergy, `平段能耗` AS normalEnergy, " +
            "`低谷时段能耗` AS valleyEnergy, `总能耗` AS totalEnergy, `峰谷电价` AS peakValleyPrice, `能耗成本` AS energyCost " +
            "FROM `峰谷能耗数据` WHERE `厂区编号` = #{factoryId} " +
            "AND `统计日期` BETWEEN #{startDate} AND #{endDate} ORDER BY `统计日期` DESC")
    List<PeakValleyEnergyData> getPeakValleyEnergyDataByFactoryAndDate(
            @Param("factoryId") String factoryId,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Select("SELECT `记录编号` AS recordId, `能源类型` AS energyType, `厂区编号` AS factoryId, `统计日期` AS statisticsDate, " +
            "`尖峰时段能耗` AS peakEnergy, `高峰时段能耗` AS highEnergy, `平段能耗` AS normalEnergy, " +
            "`低谷时段能耗` AS valleyEnergy, `总能耗` AS totalEnergy, `峰谷电价` AS peakValleyPrice, `能耗成本` AS energyCost " +
            "FROM `峰谷能耗数据` WHERE `能源类型` = #{energyType} " +
            "AND `统计日期` BETWEEN #{startDate} AND #{endDate} ORDER BY `统计日期` DESC")
    List<PeakValleyEnergyData> getPeakValleyEnergyDataByEnergyTypeAndDate(
            @Param("energyType") String energyType,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Select("SELECT `厂区编号`, `能源类型`, " +
            "SUM(`尖峰时段能耗` + `高峰时段能耗`) as peak_high_total, " +
            "SUM(`低谷时段能耗`) as valley_total, " +
            "SUM(`总能耗`) as total, " +
            "ROUND(SUM(`低谷时段能耗`) / SUM(`总能耗`) * 100, 2) as valley_ratio " +
            "FROM `峰谷能耗数据` " +
            "WHERE `统计日期` BETWEEN #{startDate} AND #{endDate} " +
            "GROUP BY `厂区编号`, `能源类型` " +
            "HAVING valley_ratio < 30")
    List<Map<String, Object>> getFactoriesWithLowValleyRatio(
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Select("SELECT `厂区编号`, `统计日期`, " +
            "SUM(`能耗成本`) as daily_cost " +
            "FROM `峰谷能耗数据` " +
            "WHERE `统计日期` BETWEEN #{startDate} AND #{endDate} " +
            "GROUP BY `厂区编号`, `统计日期` " +
            "ORDER BY daily_cost DESC")
    List<Map<String, Object>> getDailyEnergyCostReport(
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
}

