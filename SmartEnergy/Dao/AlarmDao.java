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
}
