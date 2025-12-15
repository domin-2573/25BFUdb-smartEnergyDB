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
    
    @Insert("INSERT INTO history_trend_data (trend_id, energy_type, statistics_period, " +
            "statistics_date, energy_value, year_over_year_growth, month_over_month_growth, industry_average) " +
            "VALUES (#{trendId}, #{energyType}, #{statisticsPeriod}, " +
            "#{statisticsDate}, #{energyValue}, #{yearOverYearGrowth}, #{monthOverMonthGrowth}, #{industryAverage})")
    int insertHistoryTrendData(HistoryTrendData data);
    
    @Select("SELECT * FROM history_trend_data WHERE trend_id = #{trendId}")
    HistoryTrendData getHistoryTrendDataById(@Param("trendId") String trendId);
    
    @Select("SELECT * FROM history_trend_data WHERE energy_type = #{energyType} " +
            "AND statistics_period = #{period} AND statistics_date BETWEEN #{startDate} AND #{endDate} " +
            "ORDER BY statistics_date")
    List<HistoryTrendData> getHistoryTrendDataByTypeAndPeriod(
            @Param("energyType") String energyType,
            @Param("period") String period,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Select("SELECT * FROM history_trend_data WHERE statistics_period = #{period} " +
            "AND statistics_date BETWEEN #{startDate} AND #{endDate} " +
            "ORDER BY statistics_date, energy_type")
    List<HistoryTrendData> getHistoryTrendDataByPeriod(
            @Param("period") String period,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Select("SELECT energy_type, statistics_period, " +
            "AVG(year_over_year_growth) as avg_yoy_growth, " +
            "AVG(month_over_month_growth) as avg_mom_growth " +
            "FROM history_trend_data " +
            "WHERE statistics_date BETWEEN #{startDate} AND #{endDate} " +
            "GROUP BY energy_type, statistics_period")
    List<Map<String, Object>> getTrendGrowthStatistics(
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
}

