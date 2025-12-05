package Demo.Dao;

import  Demo.Entity.PvDevice;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface PvDeviceDao {
    
    @Insert("INSERT INTO pv_device (device_id, device_type, install_location, capacity, " +
            "operation_time, calibration_cycle, operation_status, communication_protocol) " +
            "VALUES (#{deviceId}, #{deviceType}, #{installLocation}, #{capacity}, " +
            "#{operationTime}, #{calibrationCycle}, #{operationStatus}, #{communicationProtocol})")
    int insertPvDevice(PvDevice pvDevice);
    
    @Select("SELECT * FROM pv_device WHERE operation_status = #{status}")
    List<PvDevice> getPvDevicesByStatus(@Param("status") String status);
    
    @Update("UPDATE pv_device SET operation_status = #{status} WHERE device_id = #{deviceId}")
    int updateDeviceStatus(@Param("deviceId") String deviceId, @Param("status") String status);
    
    @Select("SELECT device_type, COUNT(*) as count, SUM(capacity) as total_capacity " +
            "FROM pv_device GROUP BY device_type")
    List<Map<String, Object>> getPvDeviceSummary();
}