package Demo.Dao;

import Demo.Entity.Substation;
import org.apache.ibatis.annotations.*;
import java.util.List;

/**
 * 配电房信息DAO
 */
@Mapper
public interface SubstationDao {
    
    @Insert("INSERT INTO `配电房信息表` (`配电房编号`, `名称`, `位置描述`, `电压等级`, " +
            "`变压器数量`, `投运时间`, `负责人ID`, `联系方式`) " +
            "VALUES (#{substationId}, #{name}, #{location}, #{voltageLevel}, " +
            "#{transformerCount}, #{operationTime}, #{managerId}, #{contact})")
    int insertSubstation(Substation substation);
    
    @Select("SELECT `配电房编号` AS substationId, `名称` AS name, `位置描述` AS location, `电压等级` AS voltageLevel, " +
            "`变压器数量` AS transformerCount, `投运时间` AS operationTime, `负责人ID` AS managerId, `联系方式` AS contact " +
            "FROM `配电房信息表` WHERE `配电房编号` = #{substationId}")
    Substation getSubstationById(@Param("substationId") String substationId);
    
    @Select("SELECT `配电房编号` AS substationId, `名称` AS name, `位置描述` AS location, `电压等级` AS voltageLevel, " +
            "`变压器数量` AS transformerCount, `投运时间` AS operationTime, `负责人ID` AS managerId, `联系方式` AS contact " +
            "FROM `配电房信息表` ORDER BY `投运时间` DESC")
    List<Substation> getAllSubstations();
    
    @Select("SELECT `配电房编号` AS substationId, `名称` AS name, `位置描述` AS location, `电压等级` AS voltageLevel, " +
            "`变压器数量` AS transformerCount, `投运时间` AS operationTime, `负责人ID` AS managerId, `联系方式` AS contact " +
            "FROM `配电房信息表` WHERE `电压等级` = #{voltageLevel}")
    List<Substation> getSubstationsByVoltageLevel(@Param("voltageLevel") String voltageLevel);
    
    @Update("UPDATE `配电房信息表` SET `名称` = #{name}, `位置描述` = #{location}, " +
            "`电压等级` = #{voltageLevel}, `变压器数量` = #{transformerCount}, " +
            "`投运时间` = #{operationTime}, `负责人ID` = #{managerId}, `联系方式` = #{contact} " +
            "WHERE `配电房编号` = #{substationId}")
    int updateSubstation(Substation substation);
    
    @Delete("DELETE FROM `配电房信息表` WHERE `配电房编号` = #{substationId}")
    int deleteSubstation(@Param("substationId") String substationId);
}

