package Demo.Dao;

import Demo.Entity.Alarm;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface AlarmDao {
    
    @Insert("INSERT INTO `告警信息表` (`告警编号`, `告警类型`, `关联设备编号`, `发生时间`, `告警等级`, `告警内容`, " +
            "`处理状态`, `告警触发阈值`) VALUES (#{alarmId}, #{alarmType}, #{deviceId}, #{occurTime}, " +
            "#{alarmLevel}, #{alarmContent}, #{handleStatus}, #{triggerThreshold})")
    int insertAlarm(Alarm alarm);
    
    @Select("SELECT `告警编号` AS alarmId, `告警类型` AS alarmType, `关联设备编号` AS deviceId, `发生时间` AS occurTime, " +
            "`告警等级` AS alarmLevel, `告警内容` AS alarmContent, `处理状态` AS handleStatus, `告警触发阈值` AS triggerThreshold " +
            "FROM `告警信息表` WHERE `处理状态` = #{status} ORDER BY `发生时间` DESC")
    List<Alarm> getAlarmsByStatus(@Param("status") String status);
    
    @Select("SELECT `告警编号` AS alarmId, `告警类型` AS alarmType, `关联设备编号` AS deviceId, `发生时间` AS occurTime, " +
            "`告警等级` AS alarmLevel, `告警内容` AS alarmContent, `处理状态` AS handleStatus, `告警触发阈值` AS triggerThreshold " +
            "FROM `告警信息表` WHERE `告警等级` = '高' AND `处理状态` = '未处理'")
    List<Alarm> getHighLevelUnhandledAlarms();
    
    @Update("UPDATE `告警信息表` SET `处理状态` = #{status} WHERE `告警编号` = #{alarmId}")
    int updateAlarmStatus(@Param("alarmId") String alarmId, @Param("status") String status);
    
    @Select("SELECT `告警等级`, COUNT(*) as alarm_count FROM `告警信息表` " +
            "WHERE `发生时间` BETWEEN #{start} AND #{end} " +
            "GROUP BY `告警等级`")
    List<Map<String, Object>> getAlarmStatistics(@Param("start") String start, @Param("end") String end);

    /**
     * 告警类型分布统计
     */
    @Select("SELECT `告警类型`, COUNT(*) as count " +
            "FROM `告警信息表` " +
            "WHERE `发生时间` BETWEEN #{start} AND #{end} " +
            "GROUP BY `告警类型` " +
            "ORDER BY count DESC")
    List<Map<String, Object>> getAlarmTypeDistribution(@Param("start") String start, @Param("end") String end);

    /**
     * 告警等级分布统计
     */
    @Select("SELECT `告警等级`, COUNT(*) as count " +
            "FROM `告警信息表` " +
            "WHERE `发生时间` BETWEEN #{start} AND #{end} " +
            "GROUP BY `告警等级` " +
            "ORDER BY FIELD(`告警等级`, '高', '中', '低')")
    List<Map<String, Object>> getAlarmLevelDistribution(@Param("start") String start, @Param("end") String end);

    /**
     * 获取已处理告警数量
     */
    @Select("SELECT COUNT(*) as count " +
            "FROM `告警信息表` " +
            "WHERE `发生时间` BETWEEN #{start} AND #{end} " +
            "AND `处理状态` IN ('处理中', '已结案')")
    int getHandledAlarmsCount(@Param("start") String start, @Param("end") String end);

    /**
     * 获取平均响应时间
     */
    @Select("SELECT AVG(TIMESTAMPDIFF(MINUTE, a.`发生时间`, wo.`响应时间`)) as avg_time " +
            "FROM `告警信息表` a " +
            "JOIN `运维工单数据表` wo ON a.`告警编号` = wo.`告警编号` " +
            "WHERE a.`发生时间` BETWEEN #{start} AND #{end} " +
            "AND wo.`响应时间` IS NOT NULL")
    Double getAvgResponseTime(@Param("start") String start, @Param("end") String end);

    /**
     * 告警趋势分析（按天）
     */
    @Select("SELECT DATE(`发生时间`) as date, COUNT(*) as alarm_count, " +
            "COUNT(CASE WHEN `告警等级` = '高' THEN 1 END) as high_count, " +
            "COUNT(CASE WHEN `告警等级` = '中' THEN 1 END) as medium_count, " +
            "COUNT(CASE WHEN `告警等级` = '低' THEN 1 END) as low_count " +
            "FROM `告警信息表` " +
            "WHERE `发生时间` BETWEEN #{start} AND #{end} " +
            "GROUP BY DATE(`发生时间`) " +
            "ORDER BY date")
    List<Map<String, Object>> getAlarmTrendByDay(@Param("start") String start, @Param("end") String end);

    /**
     * 获取频繁告警设备TOP10
     */
    @Select("SELECT `关联设备编号` as device_id, COUNT(*) as alarm_count, " +
            "COUNT(CASE WHEN `告警等级` = '高' THEN 1 END) as high_count, " +
            "COUNT(CASE WHEN `告警等级` = '中' THEN 1 END) as medium_count, " +
            "COUNT(CASE WHEN `告警等级` = '低' THEN 1 END) as low_count, " +
            "MAX(`发生时间`) as last_alarm_time " +
            "FROM `告警信息表` " +
            "WHERE `发生时间` BETWEEN #{start} AND #{end} " +
            "GROUP BY `关联设备编号` " +
            "ORDER BY alarm_count DESC " +
            "LIMIT #{limit}")
    List<Map<String, Object>> getFrequentAlarmDevices(@Param("start") String start, 
                                                      @Param("end") String end, 
                                                      @Param("limit") int limit);

    /**
     * 获取设备类型告警分布
     */
    @Select("SELECT el.`设备类型`, COUNT(*) as alarm_count " +
            "FROM `告警信息表` a " +
            "LEFT JOIN `设备台账数据表` el ON a.`关联设备编号` = el.`台账编号` " +
            "WHERE a.`发生时间` BETWEEN #{start} AND #{end} " +
            "GROUP BY el.`设备类型` " +
            "ORDER BY alarm_count DESC")
    List<Map<String, Object>> getAlarmDeviceTypeDistribution(@Param("start") String start, @Param("end") String end);

    /**
     * 获取设备基本信息
     */
    @Select("SELECT `台账编号`, `设备名称`, `设备类型`, `型号规格`, `安装时间`, `报废状态` " +
            "FROM `设备台账数据表` " +
            "WHERE `台账编号` = #{deviceId}")
    Map<String, Object> getDeviceInfo(@Param("deviceId") String deviceId);

    /**
     * 获取设备告警列表
     */
    @Select("SELECT `告警编号`, `告警类型`, `告警等级`, `发生时间`, `告警内容`, `处理状态` " +
            "FROM `告警信息表` " +
            "WHERE `关联设备编号` = #{deviceId} " +
            "AND `发生时间` BETWEEN #{start} AND #{end} " +
            "ORDER BY `发生时间` DESC")
    List<Map<String, Object>> getDeviceAlarms(@Param("deviceId") String deviceId, 
                                              @Param("start") String start, 
                                              @Param("end") String end);

    /**
     * 获取设备告警统计
     */
    @Select("SELECT COUNT(*) as total_alarms, " +
            "COUNT(CASE WHEN `告警等级` = '高' THEN 1 END) as high_alarms, " +
            "COUNT(CASE WHEN `告警等级` = '中' THEN 1 END) as medium_alarms, " +
            "COUNT(CASE WHEN `告警等级` = '低' THEN 1 END) as low_alarms, " +
            "COUNT(CASE WHEN `处理状态` IN ('处理中', '已结案') THEN 1 END) as handled_alarms, " +
            "MIN(`发生时间`) as first_alarm_time, " +
            "MAX(`发生时间`) as last_alarm_time " +
            "FROM `告警信息表` " +
            "WHERE `关联设备编号` = #{deviceId} " +
            "AND `发生时间` BETWEEN #{start} AND #{end}")
    Map<String, Object> getDeviceAlarmStats(@Param("deviceId") String deviceId, 
                                            @Param("start") String start, 
                                            @Param("end") String end);

    /**
     * 新增：校验设备是否存在（确保告警关联具体设备）
     */
    @Select("SELECT `台账编号` FROM `设备台账数据表` WHERE `台账编号` = #{deviceId} LIMIT 1")
    String verifyDeviceExists(@Param("deviceId") String deviceId);

    @Select("SELECT `告警编号` AS alarmId, `告警类型` AS alarmType, `关联设备编号` AS deviceId, `发生时间` AS occurTime, " +
            "`告警等级` AS alarmLevel, `告警内容` AS alarmContent, `处理状态` AS handleStatus, `告警触发阈值` AS triggerThreshold " +
            "FROM `告警信息表` WHERE `告警等级` = '高' " +
            "AND (`处理状态` = '未处理' OR `处理状态` = '处理中') " +
            "ORDER BY `发生时间` DESC")
    List<Alarm> getHighLevelAlarms();
}
