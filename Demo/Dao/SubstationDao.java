package Demo.Dao;

import Demo.Entity.Substation;
import org.apache.ibatis.annotations.*;
import java.util.List;

/**
 * 配电房信息DAO
 */
@Mapper
public interface SubstationDao {
    
    @Insert("INSERT INTO substation (substation_id, name, location, voltage_level, " +
            "transformer_count, operation_time, manager_id, contact) " +
            "VALUES (#{substationId}, #{name}, #{location}, #{voltageLevel}, " +
            "#{transformerCount}, #{operationTime}, #{managerId}, #{contact})")
    int insertSubstation(Substation substation);
    
    @Select("SELECT * FROM substation WHERE substation_id = #{substationId}")
    Substation getSubstationById(@Param("substationId") String substationId);
    
    @Select("SELECT * FROM substation ORDER BY operation_time DESC")
    List<Substation> getAllSubstations();
    
    @Select("SELECT * FROM substation WHERE voltage_level = #{voltageLevel}")
    List<Substation> getSubstationsByVoltageLevel(@Param("voltageLevel") String voltageLevel);
    
    @Update("UPDATE substation SET name = #{name}, location = #{location}, " +
            "voltage_level = #{voltageLevel}, transformer_count = #{transformerCount}, " +
            "operation_time = #{operationTime}, manager_id = #{managerId}, contact = #{contact} " +
            "WHERE substation_id = #{substationId}")
    int updateSubstation(Substation substation);
    
    @Delete("DELETE FROM substation WHERE substation_id = #{substationId}")
    int deleteSubstation(@Param("substationId") String substationId);
}

