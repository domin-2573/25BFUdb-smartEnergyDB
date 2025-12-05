package Demo.Dao;

import Demo.Entity.PvForecastData;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

/**
 * 光伏预测数据DAO
 */
@Mapper
public interface PvForecastDataDao {
    
    @Insert("INSERT INTO pv_forecast_data (forecast_id, grid_point_id, forecast_date, " +
            "forecast_period, forecast_generation, actual_generation, deviation_rate, model_version) " +
            "VALUES (#{forecastId}, #{gridPointId}, #{forecastDate}, " +
            "#{forecastPeriod}, #{forecastGeneration}, #{actualGeneration}, #{deviationRate}, #{modelVersion})")
    int insertPvForecastData(PvForecastData pvForecastData);
    
    @Select("SELECT * FROM pv_forecast_data WHERE forecast_id = #{forecastId}")
    PvForecastData getPvForecastDataById(@Param("forecastId") String forecastId);
    
    @Select("SELECT * FROM pv_forecast_data WHERE grid_point_id = #{gridPointId} " +
            "AND forecast_date = #{forecastDate} ORDER BY forecast_period")
    List<PvForecastData> getPvForecastDataByGridPointAndDate(
            @Param("gridPointId") String gridPointId,
            @Param("forecastDate") String forecastDate);
    
    @Select("SELECT * FROM pv_forecast_data WHERE ABS(deviation_rate) > 15 " +
            "AND forecast_date >= #{startDate} ORDER BY forecast_date DESC")
    List<PvForecastData> getHighDeviationForecastData(@Param("startDate") String startDate);
    
    @Select("SELECT forecast_date, AVG(ABS(deviation_rate)) as avg_deviation_rate, " +
            "COUNT(*) as forecast_count " +
            "FROM pv_forecast_data WHERE grid_point_id = #{gridPointId} " +
            "AND forecast_date BETWEEN #{startDate} AND #{endDate} " +
            "GROUP BY forecast_date ORDER BY forecast_date")
    List<Map<String, Object>> getForecastDeviationStatistics(
            @Param("gridPointId") String gridPointId,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Update("UPDATE pv_forecast_data SET actual_generation = #{actualGeneration}, " +
            "deviation_rate = #{deviationRate} WHERE forecast_id = #{forecastId}")
    int updatePvForecastData(PvForecastData pvForecastData);
}

