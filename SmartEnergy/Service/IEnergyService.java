package Demo.Service;

import Demo.Entity.*;
import java.util.List;
import java.util.Map;

public interface IEnergyService {
    
    // Circuit monitoring business
    List<CircuitData> getCircuitDataByTimeRange(String substationId, String startTime, String endTime);
    List<CircuitData> getAbnormalCircuitData(String startTime);
    void updateCircuitDataStatus(Long dataId, String status);
    
    // PV device business
    List<PvDevice> getPvDevicesByStatus(String status);
    Map<String, Object> getPvDeviceSummary();
    void updatePvDeviceStatus(String deviceId, String status);
    
    // Alarm management business
    List<Alarm> getAlarmsByStatus(String status);
    List<Alarm> getHighLevelUnhandledAlarms();
    void updateAlarmStatus(Long alarmId, String status);
    Map<String, Object> getAlarmStatistics(String startTime, String endTime);
    
    // Dashboard display
    Map<String, Object> getDashboardSummary();
    Map<String, Object> getEnergyTrend(String energyType, String period);
}
