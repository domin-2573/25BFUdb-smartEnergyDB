package Demo.Dao;

import Demo.Entity.TransformerData;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

/**
 * 变压器监测数据DAO
 */
@Mapper
public interface TransformerDataDao {
    
    @Insert("INSERT INTO `变压器监测数据表` (`数据编号`, `配电房编号`, `变压器编号`, `采集时间`, " +
            "`负载率`, `绕组温度`, `铁芯温度`, `环境温度`, `环境湿度`, `运行状态`) " +
            "VALUES (#{dataId}, #{substationId}, #{transformerId}, #{collectTime}, " +
            "#{loadRate}, #{windingTemp}, #{coreTemp}, #{ambientTemp}, #{ambientHumidity}, #{operationStatus})")
    int insertTransformerData(TransformerData transformerData);
    
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `变压器编号` AS transformerId, `采集时间` AS collectTime, " +
            "`负载率` AS loadRate, `绕组温度` AS windingTemp, `铁芯温度` AS coreTemp, `环境温度` AS ambientTemp, " +
            "`环境湿度` AS ambientHumidity, `运行状态` AS operationStatus " +
            "FROM `变压器监测数据表` WHERE `数据编号` = #{dataId}")
    TransformerData getTransformerDataById(@Param("dataId") String dataId);
    
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `变压器编号` AS transformerId, `采集时间` AS collectTime, " +
            "`负载率` AS loadRate, `绕组温度` AS windingTemp, `铁芯温度` AS coreTemp, `环境温度` AS ambientTemp, " +
            "`环境湿度` AS ambientHumidity, `运行状态` AS operationStatus " +
            "FROM `变压器监测数据表` WHERE `配电房编号` = #{substationId} " +
            "AND `采集时间` BETWEEN #{startTime} AND #{endTime} ORDER BY `采集时间` DESC")
    List<TransformerData> getTransformerDataBySubstationAndTime(
            @Param("substationId") String substationId,
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `变压器编号` AS transformerId, `采集时间` AS collectTime, " +
            "`负载率` AS loadRate, `绕组温度` AS windingTemp, `铁芯温度` AS coreTemp, `环境温度` AS ambientTemp, " +
            "`环境湿度` AS ambientHumidity, `运行状态` AS operationStatus " +
            "FROM `变压器监测数据表` WHERE `变压器编号` = #{transformerId} " +
            "ORDER BY `采集时间` DESC LIMIT #{limit}")
    List<TransformerData> getLatestTransformerData(
            @Param("transformerId") String transformerId,
            @Param("limit") int limit);
    
    @Select("SELECT `数据编号` AS dataId, `配电房编号` AS substationId, `变压器编号` AS transformerId, `采集时间` AS collectTime, " +
            "`负载率` AS loadRate, `绕组温度` AS windingTemp, `铁芯温度` AS coreTemp, `环境温度` AS ambientTemp, " +
            "`环境湿度` AS ambientHumidity, `运行状态` AS operationStatus " +
            "FROM `变压器监测数据表` WHERE `运行状态` = '异常' " +
            "AND `采集时间` >= #{startTime}")
    List<TransformerData> getAbnormalTransformerData(@Param("startTime") String startTime);
    
    @Update("UPDATE `变压器监测数据表` SET `运行状态` = #{status} WHERE `数据编号` = #{dataId}")
    int updateTransformerDataStatus(@Param("dataId") String dataId, @Param("status") String status);
    
    @Select("SELECT `变压器编号`, AVG(`负载率`) as avg_load_rate, " +
            "MAX(`绕组温度`) as max_winding_temp " +
            "FROM `变压器监测数据表` WHERE `配电房编号` = #{substationId} " +
            "AND `采集时间` BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY `变压器编号`")
    List<Map<String, Object>> getTransformerStatistics(
            @Param("substationId") String substationId,
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
}

