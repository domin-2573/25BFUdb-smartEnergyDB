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
    
    @Insert("INSERT INTO peak_valley_energy_data (record_id, energy_type, factory_id, statistics_date, " +
            "peak_energy, high_energy, normal_energy, valley_energy, total_energy, peak_valley_price, energy_cost) " +
            "VALUES (#{recordId}, #{energyType}, #{factoryId}, #{statisticsDate}, " +
            "#{peakEnergy}, #{highEnergy}, #{normalEnergy}, #{valleyEnergy}, #{totalEnergy}, #{peakValleyPrice}, #{energyCost})")
    int insertPeakValleyEnergyData(PeakValleyEnergyData data);
    
    @Select("SELECT * FROM peak_valley_energy_data WHERE record_id = #{recordId}")
    PeakValleyEnergyData getPeakValleyEnergyDataById(@Param("recordId") String recordId);
    
    @Select("SELECT * FROM peak_valley_energy_data WHERE factory_id = #{factoryId} " +
            "AND statistics_date BETWEEN #{startDate} AND #{endDate} ORDER BY statistics_date DESC")
    List<PeakValleyEnergyData> getPeakValleyEnergyDataByFactoryAndDate(
            @Param("factoryId") String factoryId,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Select("SELECT * FROM peak_valley_energy_data WHERE energy_type = #{energyType} " +
            "AND statistics_date BETWEEN #{startDate} AND #{endDate} ORDER BY statistics_date DESC")
    List<PeakValleyEnergyData> getPeakValleyEnergyDataByEnergyTypeAndDate(
            @Param("energyType") String energyType,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Select("SELECT factory_id, energy_type, " +
            "SUM(peak_energy + high_energy) as peak_high_total, " +
            "SUM(valley_energy) as valley_total, " +
            "SUM(total_energy) as total, " +
            "ROUND(SUM(valley_energy) / SUM(total_energy) * 100, 2) as valley_ratio " +
            "FROM peak_valley_energy_data " +
            "WHERE statistics_date BETWEEN #{startDate} AND #{endDate} " +
            "GROUP BY factory_id, energy_type " +
            "HAVING valley_ratio < 30")
    List<Map<String, Object>> getFactoriesWithLowValleyRatio(
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Select("SELECT factory_id, statistics_date, " +
            "SUM(energy_cost) as daily_cost " +
            "FROM peak_valley_energy_data " +
            "WHERE statistics_date BETWEEN #{startDate} AND #{endDate} " +
            "GROUP BY factory_id, statistics_date " +
            "ORDER BY daily_cost DESC")
    List<Map<String, Object>> getDailyEnergyCostReport(
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
}

