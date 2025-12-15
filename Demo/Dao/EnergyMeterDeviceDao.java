package Demo.Dao;

import Demo.Entity.EnergyMeterDevice;
import org.apache.ibatis.annotations.*;
import java.util.List;

/**
 * 能耗计量设备信息DAO
 */
@Mapper
public interface EnergyMeterDeviceDao {
    
    @Insert("INSERT INTO energy_meter_device (device_id, energy_type, install_location, " +
            "pipe_diameter, communication_protocol, operation_status, calibration_cycle, manufacturer) " +
            "VALUES (#{deviceId}, #{energyType}, #{installLocation}, " +
            "#{pipeDiameter}, #{communicationProtocol}, #{operationStatus}, #{calibrationCycle}, #{manufacturer})")
    int insertEnergyMeterDevice(EnergyMeterDevice device);
    
    @Select("SELECT * FROM energy_meter_device WHERE device_id = #{deviceId}")
    EnergyMeterDevice getEnergyMeterDeviceById(@Param("deviceId") String deviceId);
    
    @Select("SELECT * FROM energy_meter_device WHERE energy_type = #{energyType}")
    List<EnergyMeterDevice> getEnergyMeterDevicesByEnergyType(@Param("energyType") String energyType);
    
    @Select("SELECT * FROM energy_meter_device WHERE operation_status = #{status}")
    List<EnergyMeterDevice> getEnergyMeterDevicesByStatus(@Param("status") String status);
    
    @Select("SELECT * FROM energy_meter_device ORDER BY device_id")
    List<EnergyMeterDevice> getAllEnergyMeterDevices();
    
    @Update("UPDATE energy_meter_device SET energy_type = #{energyType}, install_location = #{installLocation}, " +
            "pipe_diameter = #{pipeDiameter}, communication_protocol = #{communicationProtocol}, " +
            "operation_status = #{operationStatus}, calibration_cycle = #{calibrationCycle}, " +
            "manufacturer = #{manufacturer} WHERE device_id = #{deviceId}")
    int updateEnergyMeterDevice(EnergyMeterDevice device);
    
    @Delete("DELETE FROM energy_meter_device WHERE device_id = #{deviceId}")
    int deleteEnergyMeterDevice(@Param("deviceId") String deviceId);
}

