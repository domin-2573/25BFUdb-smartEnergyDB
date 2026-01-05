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
    
    /**
     * 获取告警类型分布
     */
    List<Map<String, Object>> getAlarmTypeDistribution(String startTime, String endTime);

    /**
     * 获取告警等级分布
     */
    List<Map<String, Object>> getAlarmLevelDistribution(String startTime, String endTime);

    /**
     * 获取告警处理效率统计
     */
    Map<String, Object> getAlarmHandleEfficiency(String startTime, String endTime);

    /**
     * 获取告警趋势分析（按天）
     */
    List<Map<String, Object>> getAlarmTrendByDay(String startTime, String endTime);

    /**
     * 获取频繁告警设备TOP10
     */
    List<Map<String, Object>> getFrequentAlarmDevices(String startTime, String endTime, int limit);

    /**
     * 获取设备类型告警分布
     */
    List<Map<String, Object>> getAlarmDeviceTypeDistribution(String startTime, String endTime);

    /**
     * 获取设备详细告警信息
     */
    Map<String, Object> getDeviceAlarmDetails(String deviceId, String startTime, String endTime);
    
}
