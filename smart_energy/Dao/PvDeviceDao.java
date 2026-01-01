package Demo.Dao;

import  Demo.Entity.PvDevice;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface PvDeviceDao {
    
    @Insert("INSERT INTO `光伏设备信息` (`设备编号`, `设备类型`, `安装位置`, `装机容量`, " +
            "`投运时间`, `校准周期`, `运行状态`, `通信协议`) " +
            "VALUES (#{deviceId}, #{deviceType}, #{installLocation}, #{capacity}, " +
            "#{operationTime}, #{calibrationCycle}, #{operationStatus}, #{communicationProtocol})")
    int insertPvDevice(PvDevice pvDevice);
    
    @Select("SELECT `设备编号` AS deviceId, `设备类型` AS deviceType, `安装位置` AS installLocation, " +
            "`装机容量` AS capacity, `投运时间` AS operationTime, `校准周期` AS calibrationCycle, " +
            "`运行状态` AS operationStatus, `通信协议` AS communicationProtocol " +
            "FROM `光伏设备信息` WHERE `运行状态` = #{status}")
    List<PvDevice> getPvDevicesByStatus(@Param("status") String status);
    
    @Update("UPDATE `光伏设备信息` SET `运行状态` = #{status} WHERE `设备编号` = #{deviceId}")
    int updateDeviceStatus(@Param("deviceId") String deviceId, @Param("status") String status);
    
    @Select("SELECT `设备类型`, COUNT(*) as count, SUM(CAST(`装机容量` AS DECIMAL(10,2))) as total_capacity " +
            "FROM `光伏设备信息` GROUP BY `设备类型`")
    List<Map<String, Object>> getPvDeviceSummary();
}