package Demo.Dao;

import Demo.Entity.PvDevice;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface PvDeviceDao {
    
    @Insert("INSERT INTO `光伏设备信息表` (`设备编号`, `设备类型`, `安装位置`, `装机容量`, " +
            "`投运时间`, `校准周期`, `运行状态`, `通信协议`) " +
            "VALUES (#{deviceId}, #{deviceType}, #{installLocation}, #{capacity}, " +
            "#{operationTime}, #{calibrationCycle}, #{operationStatus}, #{communicationProtocol})")
    int insertPvDevice(PvDevice pvDevice);
    
    @Select("SELECT `设备编号` AS deviceId, `设备类型` AS deviceType, `安装位置` AS installLocation, " +
            "`装机容量` AS capacity, `投运时间` AS operationTime, `校准周期` AS calibrationCycle, " +
            "`运行状态` AS operationStatus, `通信协议` AS communicationProtocol " +
            "FROM `光伏设备信息表` WHERE `运行状态` = #{status}")
    List<PvDevice> getPvDevicesByStatus(@Param("status") String status);
    
    @Update("UPDATE `光伏设备信息表` SET `运行状态` = #{status} WHERE `设备编号` = #{deviceId}")
    int updateDeviceStatus(@Param("deviceId") String deviceId, @Param("status") String status);
    
    @Select("SELECT `设备类型`, COUNT(*) as count, SUM(CAST(`装机容量` AS DECIMAL(10,2))) as total_capacity " +
            "FROM `光伏设备信息表` GROUP BY `设备类型`")
    List<Map<String, Object>> getPvDeviceSummary();
    
    /**
     * 获取所有光伏设备
     */
    @Select("SELECT `设备编号` AS deviceId, `设备类型` AS deviceType, `安装位置` AS installLocation, " +
            "`装机容量` AS capacity, `投运时间` AS operationTime, `校准周期` AS calibrationCycle, " +
            "`运行状态` AS operationStatus, `通信协议` AS communicationProtocol " +
            "FROM `光伏设备信息表` ORDER BY `投运时间` DESC")
    List<PvDevice> getAllPvDevices();
    
    /**
     * 根据设备编号获取设备信息
     */
    @Select("SELECT `设备编号` AS deviceId, `设备类型` AS deviceType, `安装位置` AS installLocation, " +
            "`装机容量` AS capacity, `投运时间` AS operationTime, `校准周期` AS calibrationCycle, " +
            "`运行状态` AS operationStatus, `通信协议` AS communicationProtocol " +
            "FROM `光伏设备信息表` WHERE `设备编号` = #{deviceId}")
    PvDevice getPvDeviceById(@Param("deviceId") String deviceId);
    
    /**
     * 根据设备类型获取设备
     */
    @Select("SELECT `设备编号` AS deviceId, `设备类型` AS deviceType, `安装位置` AS installLocation, " +
            "`装机容量` AS capacity, `投运时间` AS operationTime, `校准周期` AS calibrationCycle, " +
            "`运行状态` AS operationStatus, `通信协议` AS communicationProtocol " +
            "FROM `光伏设备信息表` WHERE `设备类型` = #{deviceType} ORDER BY `投运时间` DESC")
    List<PvDevice> getPvDevicesByType(@Param("deviceType") String deviceType);
    
    /**
     * 根据安装位置获取设备
     */
    @Select("SELECT `设备编号` AS deviceId, `设备类型` AS deviceType, `安装位置` AS installLocation, " +
            "`装机容量` AS capacity, `投运时间` AS operationTime, `校准周期` AS calibrationCycle, " +
            "`运行状态` AS operationStatus, `通信协议` AS communicationProtocol " +
            "FROM `光伏设备信息表` WHERE `安装位置` LIKE CONCAT('%', #{location}, '%') ORDER BY `投运时间` DESC")
    List<PvDevice> getPvDevicesByLocation(@Param("location") String location);
    
    /**
     * 获取设备状态统计
     */
    @Select("SELECT `运行状态` as status, COUNT(*) as count, " +
            "ROUND(SUM(CAST(`装机容量` AS DECIMAL(10,2))), 2) as total_capacity " +
            "FROM `光伏设备信息表` GROUP BY `运行状态`")
    List<Map<String, Object>> getDeviceStatusStatistics();
    
    /**
     * 获取安装位置分布
     */
    @Select("SELECT `安装位置` as location, COUNT(*) as device_count, " +
            "ROUND(SUM(CAST(`装机容量` AS DECIMAL(10,2))), 2) as total_capacity, " +
            "COUNT(CASE WHEN `运行状态` = '正常运行' THEN 1 END) as normal_count " +
            "FROM `光伏设备信息表` GROUP BY `安装位置` ORDER BY total_capacity DESC")
    List<Map<String, Object>> getLocationDistribution();
    
    /**
     * 获取投运时间分布
     */
    @Select("SELECT YEAR(`投运时间`) as year, COUNT(*) as device_count, " +
            "ROUND(SUM(CAST(`装机容量` AS DECIMAL(10,2))), 2) as yearly_capacity " +
            "FROM `光伏设备信息表` GROUP BY YEAR(`投运时间`) ORDER BY year DESC")
    List<Map<String, Object>> getOperationYearStatistics();
    
    /**
     * 获取需要校准的设备（按校准周期）
     */
    @Select("SELECT `设备编号` AS deviceId, `设备类型` AS deviceType, `安装位置` AS installLocation, " +
            "`装机容量` AS capacity, `投运时间` AS operationTime, `校准周期` AS calibrationCycle, " +
            "`运行状态` AS operationStatus, `通信协议` AS communicationProtocol, " +
            "DATE_ADD(`投运时间`, INTERVAL CAST(`校准周期` AS UNSIGNED) MONTH) as next_calibration_date " +
            "FROM `光伏设备信息表` " +
            "WHERE DATE_ADD(`投运时间`, INTERVAL CAST(`校准周期` AS UNSIGNED) MONTH) <= DATE_ADD(NOW(), INTERVAL 1 MONTH) " +
            "ORDER BY next_calibration_date ASC")
    List<Map<String, Object>> getDevicesNeedCalibration();
    
    /**
     * 更新设备信息
     */
    @Update("<script>" +
            "UPDATE `光伏设备信息表` " +
            "<set>" +
            "<if test='deviceType != null'>`设备类型` = #{deviceType},</if>" +
            "<if test='installLocation != null'>`安装位置` = #{installLocation},</if>" +
            "<if test='capacity != null'>`装机容量` = #{capacity},</if>" +
            "<if test='calibrationCycle != null'>`校准周期` = #{calibrationCycle},</if>" +
            "<if test='operationStatus != null'>`运行状态` = #{operationStatus},</if>" +
            "<if test='communicationProtocol != null'>`通信协议` = #{communicationProtocol},</if>" +
            "</set>" +
            "WHERE `设备编号` = #{deviceId}" +
            "</script>")
    int updatePvDevice(PvDevice pvDevice);
    
    /**
     * 批量更新设备状态
     */
    @Update("<script>" +
            "UPDATE `光伏设备信息表` SET `运行状态` = #{status} " +
            "WHERE `设备编号` IN " +
            "<foreach collection='deviceIds' item='id' open='(' separator=',' close=')'>" +
            "#{id}" +
            "</foreach>" +
            "</script>")
    int batchUpdateDeviceStatus(@Param("deviceIds") List<String> deviceIds, @Param("status") String status);
    
    /**
     * 删除设备
     */
    @Delete("DELETE FROM `光伏设备信息表` WHERE `设备编号` = #{deviceId}")
    int deletePvDevice(@Param("deviceId") String deviceId);
    
    /**
     * 批量插入设备
     */
    @Insert("<script>" +
            "INSERT INTO `光伏设备信息表` (`设备编号`, `设备类型`, `安装位置`, `装机容量`, " +
            "`投运时间`, `校准周期`, `运行状态`, `通信协议`) VALUES " +
            "<foreach collection='list' item='item' separator=','>" +
            "(#{item.deviceId}, #{item.deviceType}, #{item.installLocation}, #{item.capacity}, " +
            "#{item.operationTime}, #{item.calibrationCycle}, #{item.operationStatus}, #{item.communicationProtocol})" +
            "</foreach>" +
            "</script>")
    int batchInsertPvDevices(@Param("list") List<PvDevice> pvDeviceList);
    
    /**
     * 搜索设备（多条件）
     */
    @Select("<script>" +
            "SELECT `设备编号` AS deviceId, `设备类型` AS deviceType, `安装位置` AS installLocation, " +
            "`装机容量` AS capacity, `投运时间` AS operationTime, `校准周期` AS calibrationCycle, " +
            "`运行状态` AS operationStatus, `通信协议` AS communicationProtocol " +
            "FROM `光伏设备信息表` " +
            "WHERE 1=1 " +
            "<if test='deviceType != null and deviceType != \"\"'>" +
            "AND `设备类型` LIKE CONCAT('%', #{deviceType}, '%') " +
            "</if>" +
            "<if test='location != null and location != \"\"'>" +
            "AND `安装位置` LIKE CONCAT('%', #{location}, '%') " +
            "</if>" +
            "<if test='status != null and status != \"\"'>" +
            "AND `运行状态` = #{status} " +
            "</if>" +
            "<if test='minCapacity != null'>" +
            "AND CAST(`装机容量` AS DECIMAL(10,2)) >= #{minCapacity} " +
            "</if>" +
            "<if test='maxCapacity != null'>" +
            "AND CAST(`装机容量` AS DECIMAL(10,2)) &lt;= #{maxCapacity} " +
            "</if>" +
            "ORDER BY `投运时间` DESC" +
            "</script>")
    List<PvDevice> searchPvDevices(@Param("deviceType") String deviceType,
                                   @Param("location") String location,
                                   @Param("status") String status,
                                   @Param("minCapacity") Double minCapacity,
                                   @Param("maxCapacity") Double maxCapacity);
}