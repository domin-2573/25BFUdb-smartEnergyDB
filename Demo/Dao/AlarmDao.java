package Demo.Dao;

import Demo.Entity.Alarm;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface AlarmDao {
    
    @Insert("INSERT INTO alarm (alarm_type, device_id, occur_time, alarm_level, alarm_content, " +
            "handle_status, trigger_threshold) VALUES (#{alarmType}, #{deviceId}, #{occurTime}, " +
            "#{alarmLevel}, #{alarmContent}, #{handleStatus}, #{triggerThreshold})")
    @Options(useGeneratedKeys = true, keyProperty = "alarmId")
    int insertAlarm(Alarm alarm);
    
    @Select("SELECT * FROM alarm WHERE handle_status = #{status} ORDER BY occur_time DESC")
    List<Alarm> getAlarmsByStatus(@Param("status") String status);
    
    @Select("SELECT * FROM alarm WHERE alarm_level = '∏ﬂ' AND handle_status = 'Œ¥¥¶¿Ì'")
    List<Alarm> getHighLevelUnhandledAlarms();
    
    @Update("UPDATE alarm SET handle_status = #{status} WHERE alarm_id = #{alarmId}")
    int updateAlarmStatus(@Param("alarmId") Long alarmId, @Param("status") String status);
    
    @Select("SELECT a.*, COUNT(*) as alarm_count FROM alarm a " +
            "WHERE a.occur_time BETWEEN #{start} AND #{end} " +
            "GROUP BY a.alarm_level")
    List<Map<String, Object>> getAlarmStatistics(@Param("start") String start, @Param("end") String end);
}
