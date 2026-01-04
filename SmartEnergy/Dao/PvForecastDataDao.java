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
    
    @Insert("INSERT INTO `光伏预测数据` (`预测编号`, `并网点编号`, `预测日期`, " +
            "`预测时段`, `预测发电量`, `实际发电量`, `偏差率`, `预测模型版本`) " +
            "VALUES (#{forecastId}, #{gridPointId}, #{forecastDate}, " +
            "#{forecastPeriod}, #{forecastGeneration}, #{actualGeneration}, #{deviationRate}, #{modelVersion})")
    int insertPvForecastData(PvForecastData pvForecastData);
    
    @Select("SELECT `预测编号` AS forecastId, `并网点编号` AS gridPointId, `预测日期` AS forecastDate, " +
            "`预测时段` AS forecastPeriod, `预测发电量` AS forecastGeneration, `实际发电量` AS actualGeneration, " +
            "`偏差率` AS deviationRate, `预测模型版本` AS modelVersion " +
            "FROM `光伏预测数据` WHERE `预测编号` = #{forecastId}")
    PvForecastData getPvForecastDataById(@Param("forecastId") String forecastId);
    
    @Select("SELECT `预测编号` AS forecastId, `并网点编号` AS gridPointId, `预测日期` AS forecastDate, " +
            "`预测时段` AS forecastPeriod, `预测发电量` AS forecastGeneration, `实际发电量` AS actualGeneration, " +
            "`偏差率` AS deviationRate, `预测模型版本` AS modelVersion " +
            "FROM `光伏预测数据` WHERE `并网点编号` = #{gridPointId} " +
            "AND `预测日期` = #{forecastDate} ORDER BY `预测时段`")
    List<PvForecastData> getPvForecastDataByGridPointAndDate(
            @Param("gridPointId") String gridPointId,
            @Param("forecastDate") String forecastDate);
    
    @Select("SELECT `预测编号` AS forecastId, `并网点编号` AS gridPointId, `预测日期` AS forecastDate, " +
            "`预测时段` AS forecastPeriod, `预测发电量` AS forecastGeneration, `实际发电量` AS actualGeneration, " +
            "`偏差率` AS deviationRate, `预测模型版本` AS modelVersion " +
            "FROM `光伏预测数据` WHERE ABS(`偏差率`) > 15 " +
            "AND `预测日期` >= #{startDate} ORDER BY `预测日期` DESC")
    List<PvForecastData> getHighDeviationForecastData(@Param("startDate") String startDate);
    
    @Select("SELECT `预测日期`, AVG(ABS(`偏差率`)) as avg_deviation_rate, " +
            "COUNT(*) as forecast_count " +
            "FROM `光伏预测数据` WHERE `并网点编号` = #{gridPointId} " +
            "AND `预测日期` BETWEEN #{startDate} AND #{endDate} " +
            "GROUP BY `预测日期` ORDER BY `预测日期`")
    List<Map<String, Object>> getForecastDeviationStatistics(
            @Param("gridPointId") String gridPointId,
            @Param("startDate") String startDate,
            @Param("endDate") String endDate);
    
    @Update("UPDATE `光伏预测数据` SET `实际发电量` = #{actualGeneration}, " +
            "`偏差率` = #{deviationRate} WHERE `预测编号` = #{forecastId}")
    int updatePvForecastData(PvForecastData pvForecastData);
}

