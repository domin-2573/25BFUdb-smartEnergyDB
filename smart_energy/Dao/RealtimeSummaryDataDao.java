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
    
    @Insert("INSERT INTO `实时汇总数据` (`汇总编号`, `统计时间`, `总用电量`, " +
            "`总用水量`, `总蒸汽消耗量`, `总天然气消耗量`, `光伏总发电量`, `光伏自用电量`, " +
            "`总告警次数`, `高等级告警数`, `中等级告警数`, `低等级告警数`) " +
            "VALUES (#{summaryId}, #{statisticsTime}, #{totalElectricity}, " +
            "#{totalWater}, #{totalSteam}, #{totalGas}, #{totalPvGeneration}, #{totalPvSelfConsumption}, " +
            "#{totalAlarmCount}, #{highLevelAlarmCount}, #{mediumLevelAlarmCount}, #{lowLevelAlarmCount})")
    int insertRealtimeSummaryData(RealtimeSummaryData data);
    
    @Select("SELECT `汇总编号` AS summaryId, `统计时间` AS statisticsTime, `总用电量` AS totalElectricity, " +
            "`总用水量` AS totalWater, `总蒸汽消耗量` AS totalSteam, `总天然气消耗量` AS totalGas, " +
            "`光伏总发电量` AS totalPvGeneration, `光伏自用电量` AS totalPvSelfConsumption, " +
            "`总告警次数` AS totalAlarmCount, `高等级告警数` AS highLevelAlarmCount, " +
            "`中等级告警数` AS mediumLevelAlarmCount, `低等级告警数` AS lowLevelAlarmCount " +
            "FROM `实时汇总数据` WHERE `汇总编号` = #{summaryId}")
    RealtimeSummaryData getRealtimeSummaryDataById(@Param("summaryId") String summaryId);
    
    @Select("SELECT `汇总编号` AS summaryId, `统计时间` AS statisticsTime, `总用电量` AS totalElectricity, " +
            "`总用水量` AS totalWater, `总蒸汽消耗量` AS totalSteam, `总天然气消耗量` AS totalGas, " +
            "`光伏总发电量` AS totalPvGeneration, `光伏自用电量` AS totalPvSelfConsumption, " +
            "`总告警次数` AS totalAlarmCount, `高等级告警数` AS highLevelAlarmCount, " +
            "`中等级告警数` AS mediumLevelAlarmCount, `低等级告警数` AS lowLevelAlarmCount " +
            "FROM `实时汇总数据` ORDER BY `统计时间` DESC LIMIT 1")
    RealtimeSummaryData getLatestRealtimeSummaryData();
    
    @Select("SELECT `汇总编号` AS summaryId, `统计时间` AS statisticsTime, `总用电量` AS totalElectricity, " +
            "`总用水量` AS totalWater, `总蒸汽消耗量` AS totalSteam, `总天然气消耗量` AS totalGas, " +
            "`光伏总发电量` AS totalPvGeneration, `光伏自用电量` AS totalPvSelfConsumption, " +
            "`总告警次数` AS totalAlarmCount, `高等级告警数` AS highLevelAlarmCount, " +
            "`中等级告警数` AS mediumLevelAlarmCount, `低等级告警数` AS lowLevelAlarmCount " +
            "FROM `实时汇总数据` WHERE `统计时间` BETWEEN #{startTime} AND #{endTime} " +
            "ORDER BY `统计时间` DESC")
    List<RealtimeSummaryData> getRealtimeSummaryDataByTimeRange(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT DATE(`统计时间`) as date, " +
            "AVG(`总用电量`) as avg_electricity, " +
            "AVG(`总用水量`) as avg_water, " +
            "AVG(`光伏总发电量`) as avg_pv_generation " +
            "FROM `实时汇总数据` " +
            "WHERE `统计时间` BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY DATE(`统计时间`) ORDER BY date")
    List<Map<String, Object>> getDailyAverageSummary(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
}

