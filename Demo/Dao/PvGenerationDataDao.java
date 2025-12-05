package Demo.Dao;

import Demo.Entity.PvGenerationData;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

/**
 * 光伏发电数据DAO
 */
@Mapper
public interface PvGenerationDataDao {
    
    @Insert("INSERT INTO pv_generation_data (data_id, device_id, grid_point_id, collect_time, " +
            "generation, grid_power, self_consumption, string_voltage, string_current, inverter_efficiency) " +
            "VALUES (#{dataId}, #{deviceId}, #{gridPointId}, #{collectTime}, " +
            "#{generation}, #{gridPower}, #{selfConsumption}, #{stringVoltage}, #{stringCurrent}, #{inverterEfficiency})")
    int insertPvGenerationData(PvGenerationData pvGenerationData);
    
    @Select("SELECT * FROM pv_generation_data WHERE data_id = #{dataId}")
    PvGenerationData getPvGenerationDataById(@Param("dataId") String dataId);
    
    @Select("SELECT * FROM pv_generation_data WHERE device_id = #{deviceId} " +
            "AND collect_time BETWEEN #{startTime} AND #{endTime} ORDER BY collect_time DESC")
    List<PvGenerationData> getPvGenerationDataByDeviceAndTime(
            @Param("deviceId") String deviceId,
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT * FROM pv_generation_data WHERE grid_point_id = #{gridPointId} " +
            "AND DATE(collect_time) = #{date} ORDER BY collect_time")
    List<PvGenerationData> getPvGenerationDataByGridPointAndDate(
            @Param("gridPointId") String gridPointId,
            @Param("date") String date);
    
    @Select("SELECT DATE(collect_time) as date, SUM(generation) as total_generation, " +
            "SUM(grid_power) as total_grid_power, SUM(self_consumption) as total_self_consumption " +
            "FROM pv_generation_data WHERE collect_time BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY DATE(collect_time) ORDER BY date")
    List<Map<String, Object>> getDailyPvGenerationSummary(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT * FROM pv_generation_data WHERE inverter_efficiency < 0.85 " +
            "AND collect_time >= #{startTime}")
    List<PvGenerationData> getLowEfficiencyPvData(@Param("startTime") String startTime);
}

