package Demo.Service;

import Demo.Entity.*;
import java.util.List;
import java.util.Map;

public interface IEnergyService {
    
    // 配电网监测业务
    List<CircuitData> getCircuitDataByTimeRange(String substationId, String startTime, String endTime);
    List<CircuitData> getAbnormalCircuitData(String startTime);
    void updateCircuitDataStatus(Long dataId, String status);
    
    // 光伏管理业务
    List<PvDevice> getPvDevicesByStatus(String status);
    Map<String, Object> getPvDeviceSummary();
    void updatePvDeviceStatus(String deviceId, String status);
    
    // 告警管理业务
    List<Alarm> getAlarmsByStatus(String status);
    List<Alarm> getHighLevelUnhandledAlarms();
    void updateAlarmStatus(Long alarmId, String status);
    Map<String, Object> getAlarmStatistics(String startTime, String endTime);
    
    // 大屏数据展示
    Map<String, Object> getDashboardSummary();
    Map<String, Object> getEnergyTrend(String energyType, String period);
}