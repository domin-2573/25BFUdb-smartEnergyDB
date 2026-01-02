package Demo.Dao;

import Demo.Entity.HistoryTrendData;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

/**
 * 历史趋势数据DAO
 */
@Mapper
public interface HistoryTrendDataDao {
    
    @Insert("INSERT INTO `历史趋势数据表` (`趋势编号`, `能源类型`, `统计周期`, " +
            "`统计时间`, `能耗发电量数值`, `同比增长率`, `环比增长率`, `行业均值`) " +
            "VALUES (#{trendId}, #{energyType}, #{statisticsPeriod}, " +
            "#{statisticsDate}, #{energyValue}, #{yearOverYearGrowth}, #{monthOverMonthGrowth}, #{industryAverage})")
    int insertHistoryTrendData(HistoryTrendData data);
    
    @Select("SELECT `趋势编号` AS trendId, `能源类型` AS energyType, `统计周期` AS statisticsPeriod, " +
            "`统计时间` AS statisticsDate, `能耗发电量数值` AS energyValue, " +
            "`同比增长率` AS yearOverYearGrowth, `环比增长率` AS monthOverMonthGrowth, `行业均值` AS industryAverage " +
            "FROM `历史趋势数据表` WHERE `趋势编号` = #{trendId}")
    HistoryTrendData getHistoryTrendDataById(@Param("trendId") String trendId);
    
    @Select("SELECT `趋势编号` AS trendId, `能源类型` AS energyType, `统计周期` AS statisticsPeriod, " +
            "`统计时间` AS statisticsDate, `能耗发电量数值` AS energyValue, " +
            "`同比增长率` AS yearOverYearGrowth, `环比增长率` AS monthOverMonthGrowth, `行业均值` AS industryAverage " +
            "FROM `历史趋势数据表` WHERE `能源类型` = #{energyType} " +
            "AND `统计周期` = #{period} AND `统计时间` BETWEEN #{startDate} AND #{endDate} " +
            "ORDER BY `统计时间`")
    List<HistoryTrendData> getHistoryTrendDataByTypeAndPeriod(
            @Param("energyType") String energyType,
            @Param("period") String period,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Select("SELECT `趋势编号` AS trendId, `能源类型` AS energyType, `统计周期` AS statisticsPeriod, " +
            "`统计时间` AS statisticsDate, `能耗发电量数值` AS energyValue, " +
            "`同比增长率` AS yearOverYearGrowth, `环比增长率` AS monthOverMonthGrowth, `行业均值` AS industryAverage " +
            "FROM `历史趋势数据表` WHERE `统计周期` = #{period} " +
            "AND `统计时间` BETWEEN #{startDate} AND #{endDate} " +
            "ORDER BY `统计时间`, `能源类型`")
    List<HistoryTrendData> getHistoryTrendDataByPeriod(
            @Param("period") String period,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Select("SELECT `能源类型`, `统计周期`, " +
            "AVG(`同比增长率`) as avg_yoy_growth, " +
            "AVG(`环比增长率`) as avg_mom_growth " +
            "FROM `历史趋势数据表` " +
            "WHERE `统计时间` BETWEEN #{startDate} AND #{endDate} " +
            "GROUP BY `能源类型`, `统计周期`")
    List<Map<String, Object>> getTrendGrowthStatistics(
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
}

