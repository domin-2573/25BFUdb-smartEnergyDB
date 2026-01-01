package Demo.Dao;

import Demo.Entity.EnergyMeterDevice;
import org.apache.ibatis.annotations.*;
import java.util.List;

/**
 * 能耗计量设备信息DAO
 */
@Mapper
public interface EnergyMeterDeviceDao {
    
    @Insert("INSERT INTO `能耗计量设备信息` (`设备编号`, `能源类型`, `安装位置`, " +
            "`管径规格`, `通信协议`, `运行状态`, `校准周期`, `生产厂家`) " +
            "VALUES (#{deviceId}, #{energyType}, #{installLocation}, " +
            "#{pipeDiameter}, #{communicationProtocol}, #{operationStatus}, #{calibrationCycle}, #{manufacturer})")
    int insertEnergyMeterDevice(EnergyMeterDevice device);
    
    @Select("SELECT `设备编号` AS deviceId, `能源类型` AS energyType, `安装位置` AS installLocation, " +
            "`管径规格` AS pipeDiameter, `通信协议` AS communicationProtocol, `运行状态` AS operationStatus, " +
            "`校准周期` AS calibrationCycle, `生产厂家` AS manufacturer " +
            "FROM `能耗计量设备信息` WHERE `设备编号` = #{deviceId}")
    EnergyMeterDevice getEnergyMeterDeviceById(@Param("deviceId") String deviceId);
    
    @Select("SELECT `设备编号` AS deviceId, `能源类型` AS energyType, `安装位置` AS installLocation, " +
            "`管径规格` AS pipeDiameter, `通信协议` AS communicationProtocol, `运行状态` AS operationStatus, " +
            "`校准周期` AS calibrationCycle, `生产厂家` AS manufacturer " +
            "FROM `能耗计量设备信息` WHERE `能源类型` = #{energyType}")
    List<EnergyMeterDevice> getEnergyMeterDevicesByEnergyType(@Param("energyType") String energyType);
    
    @Select("SELECT `设备编号` AS deviceId, `能源类型` AS energyType, `安装位置` AS installLocation, " +
            "`管径规格` AS pipeDiameter, `通信协议` AS communicationProtocol, `运行状态` AS operationStatus, " +
            "`校准周期` AS calibrationCycle, `生产厂家` AS manufacturer " +
            "FROM `能耗计量设备信息` WHERE `运行状态` = #{status}")
    List<EnergyMeterDevice> getEnergyMeterDevicesByStatus(@Param("status") String status);
    
    @Select("SELECT `设备编号` AS deviceId, `能源类型` AS energyType, `安装位置` AS installLocation, " +
            "`管径规格` AS pipeDiameter, `通信协议` AS communicationProtocol, `运行状态` AS operationStatus, " +
            "`校准周期` AS calibrationCycle, `生产厂家` AS manufacturer " +
            "FROM `能耗计量设备信息` ORDER BY `设备编号`")
    List<EnergyMeterDevice> getAllEnergyMeterDevices();
    
    @Update("UPDATE `能耗计量设备信息` SET `能源类型` = #{energyType}, `安装位置` = #{installLocation}, " +
            "`管径规格` = #{pipeDiameter}, `通信协议` = #{communicationProtocol}, " +
            "`运行状态` = #{operationStatus}, `校准周期` = #{calibrationCycle}, " +
            "`生产厂家` = #{manufacturer} WHERE `设备编号` = #{deviceId}")
    int updateEnergyMeterDevice(EnergyMeterDevice device);
    
    @Delete("DELETE FROM `能耗计量设备信息` WHERE `设备编号` = #{deviceId}")
    int deleteEnergyMeterDevice(@Param("deviceId") String deviceId);
}

