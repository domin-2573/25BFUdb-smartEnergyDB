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
    
    @Insert("INSERT INTO realtime_summary_data (summary_id, statistics_time, total_electricity, " +
            "total_water, total_steam, total_gas, total_pv_generation, total_pv_self_consumption, " +
            "total_alarm_count, high_level_alarm_count, medium_level_alarm_count, low_level_alarm_count) " +
            "VALUES (#{summaryId}, #{statisticsTime}, #{totalElectricity}, " +
            "#{totalWater}, #{totalSteam}, #{totalGas}, #{totalPvGeneration}, #{totalPvSelfConsumption}, " +
            "#{totalAlarmCount}, #{highLevelAlarmCount}, #{mediumLevelAlarmCount}, #{lowLevelAlarmCount})")
    int insertRealtimeSummaryData(RealtimeSummaryData data);
    
    @Select("SELECT * FROM realtime_summary_data WHERE summary_id = #{summaryId}")
    RealtimeSummaryData getRealtimeSummaryDataById(@Param("summaryId") String summaryId);
    
    @Select("SELECT * FROM realtime_summary_data ORDER BY statistics_time DESC LIMIT 1")
    RealtimeSummaryData getLatestRealtimeSummaryData();
    
    @Select("SELECT * FROM realtime_summary_data WHERE statistics_time BETWEEN #{startTime} AND #{endTime} " +
            "ORDER BY statistics_time DESC")
    List<RealtimeSummaryData> getRealtimeSummaryDataByTimeRange(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT DATE(statistics_time) as date, " +
            "AVG(total_electricity) as avg_electricity, " +
            "AVG(total_water) as avg_water, " +
            "AVG(total_pv_generation) as avg_pv_generation " +
            "FROM realtime_summary_data " +
            "WHERE statistics_time BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY DATE(statistics_time) ORDER BY date")
    List<Map<String, Object>> getDailyAverageSummary(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
}

