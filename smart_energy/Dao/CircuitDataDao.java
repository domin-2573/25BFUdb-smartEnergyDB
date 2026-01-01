package Demo.Dao;

import Demo.Entity.CircuitData;
import org.apache.ibatis.annotations.*;
import java.util.List;

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
}
