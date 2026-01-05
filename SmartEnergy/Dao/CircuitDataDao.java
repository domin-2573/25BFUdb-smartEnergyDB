package Demo.Dao;

import Demo.Entity.CircuitData;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface CircuitDataDao {
    
    @Insert("INSERT INTO `回路监测数据表` (`数据编号`, `配电房编号`, `回路编号`, `采集时间`, `电压kV`, `电流A`, " +
            "`有功功率kW`, `无功功率kVar`, `功率因数`, `正向有功电量kWh`, `反向有功电量kWh`, " +
            "`开关状态`, `电缆头温度`, `电容器温度`) " +
            "VALUES (#{dataId}, #{substationId}, #{circuitId}, #{collectTime}, #{voltage}, #{current}, " +
            "#{activePower}, #{reactivePower}, #{powerFactor}, #{forwardActiveEnergy}, #{reverseActiveEnergy}, " +
            "#{switchStatus}, #{cableTemp}, #{capacitorTemp})")
    int insertCircuitData(CircuitData circuitData);
    
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `回路编号` AS circuitId, `采集时间` AS collectTime, " +
            "`电压kV` AS voltage, `电流A` AS current, `有功功率kW` AS activePower, `无功功率kVar` AS reactivePower, " +
            "`功率因数` AS powerFactor, `正向有功电量kWh` AS forwardActiveEnergy, `反向有功电量kWh` AS reverseActiveEnergy, " +
            "`开关状态` AS switchStatus, `电缆头温度` AS cableTemp, `电容器温度` AS capacitorTemp " +
            "FROM `回路监测数据表` WHERE `配电房编号` = #{substationId} AND `采集时间` BETWEEN #{start} AND #{end}")
    List<CircuitData> getCircuitDataBySubstationAndTime(@Param("substationId") String substationId, 
                                                       @Param("start") String start, 
                                                       @Param("end") String end);
    
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `回路编号` AS circuitId, `采集时间` AS collectTime, " +
            "`电压kV` AS voltage, `电流A` AS current, `有功功率kW` AS activePower, `无功功率kVar` AS reactivePower, " +
            "`功率因数` AS powerFactor, `正向有功电量kWh` AS forwardActiveEnergy, `反向有功电量kWh` AS reverseActiveEnergy, " +
            "`开关状态` AS switchStatus, `电缆头温度` AS cableTemp, `电容器温度` AS capacitorTemp " +
            "FROM `回路监测数据表` WHERE `采集时间` >= #{startTime}")
    List<CircuitData> getAbnormalCircuitData(@Param("startTime") String startTime);
    
    @Update("UPDATE `回路监测数据表` SET `开关状态` = #{status} WHERE `数据编号` = #{dataId}")
    int updateDataStatus(@Param("dataId") String dataId, @Param("status") String status);
    
    /**
     * 根据时间范围获取回路数据（兼容IEnergyService接口）
     */
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `回路编号` AS circuitId, `采集时间` AS collectTime, " +
            "`电压kV` AS voltage, `电流A` AS current, `有功功率kW` AS activePower, `无功功率kVar` AS reactivePower, " +
            "`功率因数` AS powerFactor, `正向有功电量kWh` AS forwardActiveEnergy, `反向有功电量kWh` AS reverseActiveEnergy, " +
            "`开关状态` AS switchStatus, `电缆头温度` AS cableTemp, `电容器温度` AS capacitorTemp " +
            "FROM `回路监测数据表` WHERE `配电房编号` = #{substationId} AND `采集时间` BETWEEN #{startTime} AND #{endTime}")
    List<CircuitData> getCircuitDataByTimeRange(@Param("substationId") String substationId, 
                                                @Param("startTime") String startTime, 
                                                @Param("endTime") String endTime);
    
    /**
     * 更新回路数据状态（兼容IEnergyService接口）
     */
    @Update("UPDATE `回路监测数据表` SET `开关状态` = #{status} WHERE `数据编号` = #{dataId}")
    int updateCircuitDataStatus(@Param("dataId") Long dataId, @Param("status") String status);
    
    /**
     * 获取所有回路数据
     */
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `回路编号` AS circuitId, `采集时间` AS collectTime, " +
            "`电压kV` AS voltage, `电流A` AS current, `有功功率kW` AS activePower, `无功功率kVar` AS reactivePower, " +
            "`功率因数` AS powerFactor, `正向有功电量kWh` AS forwardActiveEnergy, `反向有功电量kWh` AS reverseActiveEnergy, " +
            "`开关状态` AS switchStatus, `电缆头温度` AS cableTemp, `电容器温度` AS capacitorTemp " +
            "FROM `回路监测数据表` ORDER BY `采集时间` DESC")
    List<CircuitData> getAllCircuitData();
    
    /**
     * 根据回路编号获取数据
     */
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `回路编号` AS circuitId, `采集时间` AS collectTime, " +
            "`电压kV` AS voltage, `电流A` AS current, `有功功率kW` AS activePower, `无功功率kVar` AS reactivePower, " +
            "`功率因数` AS powerFactor, `正向有功电量kWh` AS forwardActiveEnergy, `反向有功电量kWh` AS reverseActiveEnergy, " +
            "`开关状态` AS switchStatus, `电缆头温度` AS cableTemp, `电容器温度` AS capacitorTemp " +
            "FROM `回路监测数据表` WHERE `回路编号` = #{circuitId} ORDER BY `采集时间` DESC")
    List<CircuitData> getCircuitDataByCircuitId(@Param("circuitId") String circuitId);
    
    /**
     * 获取最新的回路数据
     */
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `回路编号` AS circuitId, `采集时间` AS collectTime, " +
            "`电压kV` AS voltage, `电流A` AS current, `有功功率kW` AS activePower, `无功功率kVar` AS reactivePower, " +
            "`功率因数` AS powerFactor, `正向有功电量kWh` AS forwardActiveEnergy, `反向有功电量kWh` AS reverseActiveEnergy, " +
            "`开关状态` AS switchStatus, `电缆头温度` AS cableTemp, `电容器温度` AS capacitorTemp " +
            "FROM `回路监测数据表` ORDER BY `采集时间` DESC LIMIT #{limit}")
    List<CircuitData> getLatestCircuitData(@Param("limit") int limit);
    
    /**
     * 获取异常回路数据（基于阈值判断）
     */
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `回路编号` AS circuitId, `采集时间` AS collectTime, " +
            "`电压kV` AS voltage, `电流A` AS current, `有功功率kW` AS activePower, `无功功率kVar` AS reactivePower, " +
            "`功率因数` AS powerFactor, `正向有功电量kWh` AS forwardActiveEnergy, `反向有功电量kWh` AS reverseActiveEnergy, " +
            "`开关状态` AS switchStatus, `电缆头温度` AS cableTemp, `电容器温度` AS capacitorTemp " +
            "FROM `回路监测数据表` WHERE " +
            "(`电压kV` > 250 OR `电压kV` < 200 OR " +  // 电压异常：正常范围 200-250kV
            "`电流A` > 1000 OR " +  // 电流过高
            "`电缆头温度` > 80 OR " +  // 温度过高
            "`电容器温度` > 75 OR " +  // 电容器温度过高
            "`功率因数` < 0.8) " +  // 功率因数过低
            "AND `采集时间` >= #{startTime} " +
            "ORDER BY `采集时间` DESC")
    List<CircuitData> getAbnormalDataByThreshold(@Param("startTime") String startTime);
    
    /**
     * 获取回路数据统计
     */
    @Select("SELECT COUNT(*) as total_count, " +
            "COUNT(CASE WHEN `开关状态` = '闭合' THEN 1 END) as closed_count, " +
            "COUNT(CASE WHEN `开关状态` = '断开' THEN 1 END) as open_count, " +
            "COUNT(CASE WHEN `电缆头温度` > 70 THEN 1 END) as high_temp_count, " +
            "AVG(`电压kV`) as avg_voltage, " +
            "AVG(`电流A`) as avg_current, " +
            "MAX(`采集时间`) as latest_collect_time, " +
            "MIN(`采集时间`) as earliest_collect_time " +
            "FROM `回路监测数据表` " +
            "WHERE `采集时间` BETWEEN #{startTime} AND #{endTime}")
    Map<String, Object> getCircuitDataStatistics(@Param("startTime") String startTime, 
                                                 @Param("endTime") String endTime);
    
    /**
     * 获取配电房回路统计
     */
    @Select("SELECT `配电房编号` as substation_id, COUNT(*) as circuit_count, " +
            "COUNT(CASE WHEN `开关状态` = '闭合' THEN 1 END) as closed_count, " +
            "ROUND(AVG(`电压kV`), 2) as avg_voltage, " +
            "ROUND(AVG(`电流A`), 2) as avg_current, " +
            "ROUND(SUM(`有功功率kW`), 2) as total_power " +
            "FROM `回路监测数据表` " +
            "WHERE `采集时间` BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY `配电房编号` " +
            "ORDER BY total_power DESC")
    List<Map<String, Object>> getSubstationCircuitStats(@Param("startTime") String startTime, 
                                                        @Param("endTime") String endTime);
    
    /**
     * 删除回路数据
     */
    @Delete("DELETE FROM `回路监测数据表` WHERE `数据编号` = #{dataId}")
    int deleteCircuitData(@Param("dataId") String dataId);
    
    /**
     * 批量插入回路数据
     */
    @Insert("<script>" +
            "INSERT INTO `回路监测数据表` (`数据编号`, `配电房编号`, `回路编号`, `采集时间`, `电压kV`, `电流A`, " +
            "`有功功率kW`, `无功功率kVar`, `功率因数`, `正向有功电量kWh`, `反向有功电量kWh`, " +
            "`开关状态`, `电缆头温度`, `电容器温度`) VALUES " +
            "<foreach collection='list' item='item' separator=','>" +
            "(#{item.dataId}, #{item.substationId}, #{item.circuitId}, #{item.collectTime}, " +
            "#{item.voltage}, #{item.current}, #{item.activePower}, #{item.reactivePower}, " +
            "#{item.powerFactor}, #{item.forwardActiveEnergy}, #{item.reverseActiveEnergy}, " +
            "#{item.switchStatus}, #{item.cableTemp}, #{item.capacitorTemp})" +
            "</foreach>" +
            "</script>")
    int batchInsertCircuitData(@Param("list") List<CircuitData> circuitDataList);
}