package Demo.Dao;

import Demo.Entity.CircuitData;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface CircuitDataDao {
    
    @Insert("INSERT INTO circuit_data (substation_id, circuit_id, collect_time, voltage, current, " +
            "active_power, reactive_power, power_factor, forward_active_energy, reverse_active_energy, " +
            "switch_status, cable_temp, capacitor_temp, data_status) " +
            "VALUES (#{substationId}, #{circuitId}, #{collectTime}, #{voltage}, #{current}, " +
            "#{activePower}, #{reactivePower}, #{powerFactor}, #{forwardActiveEnergy}, #{reverseActiveEnergy}, " +
            "#{switchStatus}, #{cableTemp}, #{capacitorTemp}, #{dataStatus})")
    @Options(useGeneratedKeys = true, keyProperty = "dataId")
    int insertCircuitData(CircuitData circuitData);
    
    @Select("SELECT * FROM circuit_data WHERE substation_id = #{substationId} AND collect_time BETWEEN #{start} AND #{end}")
    List<CircuitData> getCircuitDataBySubstationAndTime(@Param("substationId") String substationId, 
                                                       @Param("start") String start, 
                                                       @Param("end") String end);
    
    @Select("SELECT * FROM circuit_data WHERE data_status = 'Òì³£' AND collect_time >= #{startTime}")
    List<CircuitData> getAbnormalCircuitData(@Param("startTime") String startTime);
    
    @Update("UPDATE circuit_data SET data_status = #{status} WHERE data_id = #{dataId}")
    int updateDataStatus(@Param("dataId") Long dataId, @Param("status") String status);
}
