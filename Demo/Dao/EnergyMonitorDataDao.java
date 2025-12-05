package Demo.Dao;

import Demo.Entity.EnergyMonitorData;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

/**
 * 能耗监测数据DAO
 */
@Mapper
public interface EnergyMonitorDataDao {
    
    @Insert("INSERT INTO energy_monitor_data (data_id, device_id, collect_time, " +
            "energy_value, unit, data_quality, factory_id) " +
            "VALUES (#{dataId}, #{deviceId}, #{collectTime}, " +
            "#{energyValue}, #{unit}, #{dataQuality}, #{factoryId})")
    int insertEnergyMonitorData(EnergyMonitorData data);
    
    @Select("SELECT * FROM energy_monitor_data WHERE data_id = #{dataId}")
    EnergyMonitorData getEnergyMonitorDataById(@Param("dataId") String dataId);
    
    @Select("SELECT * FROM energy_monitor_data WHERE device_id = #{deviceId} " +
            "AND collect_time BETWEEN #{startTime} AND #{endTime} ORDER BY collect_time DESC")
    List<EnergyMonitorData> getEnergyMonitorDataByDeviceAndTime(
            @Param("deviceId") String deviceId,
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT * FROM energy_monitor_data WHERE factory_id = #{factoryId} " +
            "AND collect_time BETWEEN #{startTime} AND #{endTime} ORDER BY collect_time DESC")
    List<EnergyMonitorData> getEnergyMonitorDataByFactoryAndTime(
            @Param("factoryId") String factoryId,
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT * FROM energy_monitor_data WHERE data_quality IN ('中', '差') " +
            "AND collect_time >= #{startTime}")
    List<EnergyMonitorData> getPoorQualityData(@Param("startTime") String startTime);
    
    @Select("SELECT factory_id, SUM(energy_value) as total_energy, unit " +
            "FROM energy_monitor_data WHERE collect_time BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY factory_id, unit")
    List<Map<String, Object>> getFactoryEnergySummary(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Update("UPDATE energy_monitor_data SET data_quality = #{quality} WHERE data_id = #{dataId}")
    int updateDataQuality(@Param("dataId") String dataId, @Param("quality") String quality);
}

