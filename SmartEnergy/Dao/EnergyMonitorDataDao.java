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
    
    @Insert("INSERT INTO `能耗监测数据` (`数据编号`, `设备编号`, `采集时间`, " +
            "`能耗值`, `单位`, `数据质量`, `所属厂区编号`) " +
            "VALUES (#{dataId}, #{deviceId}, #{collectTime}, " +
            "#{energyValue}, #{unit}, #{dataQuality}, #{factoryId})")
    int insertEnergyMonitorData(EnergyMonitorData data);
    
    @Select("SELECT `数据编号` AS dataId, `设备编号` AS deviceId, `采集时间` AS collectTime, " +
            "`能耗值` AS energyValue, `单位` AS unit, `数据质量` AS dataQuality, `所属厂区编号` AS factoryId " +
            "FROM `能耗监测数据` WHERE `数据编号` = #{dataId}")
    EnergyMonitorData getEnergyMonitorDataById(@Param("dataId") String dataId);
    
    @Select("SELECT `数据编号` AS dataId, `设备编号` AS deviceId, `采集时间` AS collectTime, " +
            "`能耗值` AS energyValue, `单位` AS unit, `数据质量` AS dataQuality, `所属厂区编号` AS factoryId " +
            "FROM `能耗监测数据` WHERE `设备编号` = #{deviceId} " +
            "AND `采集时间` BETWEEN #{startTime} AND #{endTime} ORDER BY `采集时间` DESC")
    List<EnergyMonitorData> getEnergyMonitorDataByDeviceAndTime(
            @Param("deviceId") String deviceId,
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT `数据编号` AS dataId, `设备编号` AS deviceId, `采集时间` AS collectTime, " +
            "`能耗值` AS energyValue, `单位` AS unit, `数据质量` AS dataQuality, `所属厂区编号` AS factoryId " +
            "FROM `能耗监测数据` WHERE `所属厂区编号` = #{factoryId} " +
            "AND `采集时间` BETWEEN #{startTime} AND #{endTime} ORDER BY `采集时间` DESC")
    List<EnergyMonitorData> getEnergyMonitorDataByFactoryAndTime(
            @Param("factoryId") String factoryId,
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT `数据编号` AS dataId, `设备编号` AS deviceId, `采集时间` AS collectTime, " +
            "`能耗值` AS energyValue, `单位` AS unit, `数据质量` AS dataQuality, `所属厂区编号` AS factoryId " +
            "FROM `能耗监测数据` WHERE `数据质量` IN ('中', '差') " +
            "AND `采集时间` >= #{startTime}")
    List<EnergyMonitorData> getPoorQualityData(@Param("startTime") String startTime);
    
    @Select("SELECT `所属厂区编号`, SUM(`能耗值`) as total_energy, `单位` " +
            "FROM `能耗监测数据` WHERE `采集时间` BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY `所属厂区编号`, `单位`")
    List<Map<String, Object>> getFactoryEnergySummary(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Update("UPDATE `能耗监测数据` SET `数据质量` = #{quality} WHERE `数据编号` = #{dataId}")
    int updateDataQuality(@Param("dataId") String dataId, @Param("quality") String quality);
}

