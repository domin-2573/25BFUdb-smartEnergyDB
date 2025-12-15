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
    
    @Insert("INSERT INTO transformer_data (data_id, substation_id, transformer_id, collect_time, " +
            "load_rate, winding_temp, core_temp, ambient_temp, ambient_humidity, operation_status) " +
            "VALUES (#{dataId}, #{substationId}, #{transformerId}, #{collectTime}, " +
            "#{loadRate}, #{windingTemp}, #{coreTemp}, #{ambientTemp}, #{ambientHumidity}, #{operationStatus})")
    int insertTransformerData(TransformerData transformerData);
    
    @Select("SELECT * FROM transformer_data WHERE data_id = #{dataId}")
    TransformerData getTransformerDataById(@Param("dataId") String dataId);
    
    @Select("SELECT * FROM transformer_data WHERE substation_id = #{substationId} " +
            "AND collect_time BETWEEN #{startTime} AND #{endTime} ORDER BY collect_time DESC")
    List<TransformerData> getTransformerDataBySubstationAndTime(
            @Param("substationId") String substationId,
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT * FROM transformer_data WHERE transformer_id = #{transformerId} " +
            "ORDER BY collect_time DESC LIMIT #{limit}")
    List<TransformerData> getLatestTransformerData(
            @Param("transformerId") String transformerId,
            @Param("limit") int limit);
    
    @Select("SELECT * FROM transformer_data WHERE operation_status = '异常' " +
            "AND collect_time >= #{startTime}")
    List<TransformerData> getAbnormalTransformerData(@Param("startTime") String startTime);
    
    @Update("UPDATE transformer_data SET operation_status = #{status} WHERE data_id = #{dataId}")
    int updateTransformerDataStatus(@Param("dataId") String dataId, @Param("status") String status);
    
    @Select("SELECT transformer_id, AVG(load_rate) as avg_load_rate, " +
            "MAX(winding_temp) as max_winding_temp " +
            "FROM transformer_data WHERE substation_id = #{substationId} " +
            "AND collect_time BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY transformer_id")
    List<Map<String, Object>> getTransformerStatistics(
            @Param("substationId") String substationId,
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
}

