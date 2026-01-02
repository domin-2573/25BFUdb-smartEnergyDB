package Demo.Dao;

import Demo.Entity.RealtimeSummaryData;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

/**
 * 实时汇总数据DAO
 */
@Mapper
public interface RealtimeSummaryDataDao {
    
    @Insert("INSERT INTO `实时汇总数据表` (`汇总编号`, `统计时间`, `总用电量kWh`, " +
            "`总用水量m3`, `总蒸汽消耗量t`, `总天然气消耗量m3`, `光伏总发电量kWh`, `光伏自用电量kWh`, " +
            "`总告警次数`, `高等级告警数`, `中等级告警数`, `低等级告警数`) " +
            "VALUES (#{summaryId}, #{statisticsTime}, #{totalElectricity}, " +
            "#{totalWater}, #{totalSteam}, #{totalGas}, #{totalPvGeneration}, #{totalPvSelfConsumption}, " +
            "#{totalAlarmCount}, #{highLevelAlarmCount}, #{mediumLevelAlarmCount}, #{lowLevelAlarmCount})")
    int insertRealtimeSummaryData(RealtimeSummaryData data);
    
    @Select("SELECT `汇总编号` AS summaryId, `统计时间` AS statisticsTime, `总用电量kWh` AS totalElectricity, " +
            "`总用水量m3` AS totalWater, `总蒸汽消耗量t` AS totalSteam, `总天然气消耗量m3` AS totalGas, " +
            "`光伏总发电量kWh` AS totalPvGeneration, `光伏自用电量kWh` AS totalPvSelfConsumption, " +
            "`总告警次数` AS totalAlarmCount, `高等级告警数` AS highLevelAlarmCount, " +
            "`中等级告警数` AS mediumLevelAlarmCount, `低等级告警数` AS lowLevelAlarmCount " +
            "FROM `实时汇总数据表` WHERE `汇总编号` = #{summaryId}")
    RealtimeSummaryData getRealtimeSummaryDataById(@Param("summaryId") String summaryId);
    
    @Select("SELECT `汇总编号` AS summaryId, `统计时间` AS statisticsTime, `总用电量kWh` AS totalElectricity, " +
            "`总用水量m3` AS totalWater, `总蒸汽消耗量t` AS totalSteam, `总天然气消耗量m3` AS totalGas, " +
            "`光伏总发电量kWh` AS totalPvGeneration, `光伏自用电量kWh` AS totalPvSelfConsumption, " +
            "`总告警次数` AS totalAlarmCount, `高等级告警数` AS highLevelAlarmCount, " +
            "`中等级告警数` AS mediumLevelAlarmCount, `低等级告警数` AS lowLevelAlarmCount " +
            "FROM `实时汇总数据表` ORDER BY `统计时间` DESC LIMIT 1")
    RealtimeSummaryData getLatestRealtimeSummaryData();
    
    @Select("SELECT `汇总编号` AS summaryId, `统计时间` AS statisticsTime, `总用电量kWh` AS totalElectricity, " +
            "`总用水量m3` AS totalWater, `总蒸汽消耗量t` AS totalSteam, `总天然气消耗量m3` AS totalGas, " +
            "`光伏总发电量kWh` AS totalPvGeneration, `光伏自用电量kWh` AS totalPvSelfConsumption, " +
            "`总告警次数` AS totalAlarmCount, `高等级告警数` AS highLevelAlarmCount, " +
            "`中等级告警数` AS mediumLevelAlarmCount, `低等级告警数` AS lowLevelAlarmCount " +
            "FROM `实时汇总数据表` WHERE `统计时间` BETWEEN #{startTime} AND #{endTime} " +
            "ORDER BY `统计时间` DESC")
    List<RealtimeSummaryData> getRealtimeSummaryDataByTimeRange(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT DATE(`统计时间`) as date, " +
            "AVG(`总用电量kWh`) as avg_electricity, " +
            "AVG(`总用水量m3`) as avg_water, " +
            "AVG(`光伏总发电量kWh`) as avg_pv_generation " +
            "FROM `实时汇总数据表` " +
            "WHERE `统计时间` BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY DATE(`统计时间`) ORDER BY date")
    List<Map<String, Object>> getDailyAverageSummary(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
}

