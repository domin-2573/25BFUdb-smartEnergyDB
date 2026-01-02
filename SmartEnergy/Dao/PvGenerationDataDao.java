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
    
    @Insert("INSERT INTO `光伏发电数据` (`数据编号`, `设备编号`, `并网点编号`, `采集时间`, " +
            "`发电量`, `上网电量`, `自用电量`, `汇流箱组串电压V`, `组串电流A`, `逆变器效率`) " +
            "VALUES (#{dataId}, #{deviceId}, #{gridPointId}, #{collectTime}, " +
            "#{generation}, #{gridPower}, #{selfConsumption}, #{stringVoltage}, #{stringCurrent}, #{inverterEfficiency})")
    int insertPvGenerationData(PvGenerationData pvGenerationData);
    
    @Select("SELECT `数据编号` AS dataId, `设备编号` AS deviceId, `并网点编号` AS gridPointId, `采集时间` AS collectTime, " +
            "`发电量` AS generation, `上网电量` AS gridPower, `自用电量` AS selfConsumption, " +
            "`汇流箱组串电压V` AS stringVoltage, `组串电流A` AS stringCurrent, `逆变器效率` AS inverterEfficiency " +
            "FROM `光伏发电数据` WHERE `数据编号` = #{dataId}")
    PvGenerationData getPvGenerationDataById(@Param("dataId") String dataId);
    
    @Select("SELECT `数据编号` AS dataId, `设备编号` AS deviceId, `并网点编号` AS gridPointId, `采集时间` AS collectTime, " +
            "`发电量` AS generation, `上网电量` AS gridPower, `自用电量` AS selfConsumption, " +
            "`汇流箱组串电压V` AS stringVoltage, `组串电流A` AS stringCurrent, `逆变器效率` AS inverterEfficiency " +
            "FROM `光伏发电数据` WHERE `设备编号` = #{deviceId} " +
            "AND `采集时间` BETWEEN #{startTime} AND #{endTime} ORDER BY `采集时间` DESC")
    List<PvGenerationData> getPvGenerationDataByDeviceAndTime(
            @Param("deviceId") String deviceId,
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT `数据编号` AS dataId, `设备编号` AS deviceId, `并网点编号` AS gridPointId, `采集时间` AS collectTime, " +
            "`发电量` AS generation, `上网电量` AS gridPower, `自用电量` AS selfConsumption, " +
            "`汇流箱组串电压V` AS stringVoltage, `组串电流A` AS stringCurrent, `逆变器效率` AS inverterEfficiency " +
            "FROM `光伏发电数据` WHERE `并网点编号` = #{gridPointId} " +
            "AND DATE(`采集时间`) = #{date} ORDER BY `采集时间`")
    List<PvGenerationData> getPvGenerationDataByGridPointAndDate(
            @Param("gridPointId") String gridPointId,
            @Param("date") String date);
    
    @Select("SELECT DATE(`采集时间`) as date, SUM(`发电量`) as total_generation, " +
            "SUM(`上网电量`) as total_grid_power, SUM(`自用电量`) as total_self_consumption " +
            "FROM `光伏发电数据` WHERE `采集时间` BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY DATE(`采集时间`) ORDER BY date")
    List<Map<String, Object>> getDailyPvGenerationSummary(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Select("SELECT `数据编号` AS dataId, `设备编号` AS deviceId, `并网点编号` AS gridPointId, `采集时间` AS collectTime, " +
            "`发电量` AS generation, `上网电量` AS gridPower, `自用电量` AS selfConsumption, " +
            "`汇流箱组串电压V` AS stringVoltage, `组串电流A` AS stringCurrent, `逆变器效率` AS inverterEfficiency " +
            "FROM `光伏发电数据` WHERE `逆变器效率` < 0.85 " +
            "AND `采集时间` >= #{startTime}")
    List<PvGenerationData> getLowEfficiencyPvData(@Param("startTime") String startTime);
}
