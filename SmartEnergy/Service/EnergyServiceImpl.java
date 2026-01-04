package Demo.Service;

import Demo.Dao.*;
import Demo.Entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;
import java.math.BigDecimal;
import java.util.Date;  // 添加 Date 导入

@Service
public class EnergyServiceImpl implements IEnergyService {
    
    @Autowired
    private CircuitDataDao circuitDataDao;
    
    @Autowired
    private AlarmDao alarmDao;
    
    @Autowired
    private PvDeviceDao pvDeviceDao;
    
    @Override
    public List<CircuitData> getCircuitDataByTimeRange(String substationId, String startTime, String endTime) {
        return circuitDataDao.getCircuitDataBySubstationAndTime(substationId, startTime, endTime);
    }
    
    @Override
    public List<CircuitData> getAbnormalCircuitData(String startTime) {
        return circuitDataDao.getAbnormalCircuitData(startTime);
    }
    
    @Override
    public void updateCircuitDataStatus(Long dataId, String status) {
        circuitDataDao.updateDataStatus(String.valueOf(dataId), status);
    }
    
    @Override
    public List<Alarm> getAlarmsByStatus(String status) {
        return alarmDao.getAlarmsByStatus(status);
    }
    
    @Override
    public List<Alarm> getHighLevelUnhandledAlarms() {
        return alarmDao.getHighLevelUnhandledAlarms();
    }
    
    @Override
    public void updateAlarmStatus(Long alarmId, String status) {
        alarmDao.updateAlarmStatus(String.valueOf(alarmId), status);
    }
    
    @Override
    public Map<String, Object> getAlarmStatistics(String startTime, String endTime) {
        List<Map<String, Object>> statistics = alarmDao.getAlarmStatistics(startTime, endTime);
        Map<String, Object> result = new HashMap<>();
        
        int totalAlarms = 0;
        int highLevelAlarms = 0;
        
        for (Map<String, Object> stat : statistics) {
            String level = (String) stat.get("alarm_level");
            Long count = (Long) stat.get("alarm_count");
            totalAlarms += count;
            if ("高".equals(level)) {
                highLevelAlarms = count.intValue();
            }
        }
        
        result.put("totalAlarms", totalAlarms);
        result.put("highLevelAlarms", highLevelAlarms);
        result.put("statistics", statistics);
        
        return result;
    }
    
    @Override
    public List<PvDevice> getPvDevicesByStatus(String status) {
        return pvDeviceDao.getPvDevicesByStatus(status);
    }
    
    @Override
    public Map<String, Object> getPvDeviceSummary() {
        List<Map<String, Object>> summary = pvDeviceDao.getPvDeviceSummary();
        Map<String, Object> result = new HashMap<>();
        
        int totalDevices = 0;
        BigDecimal totalCapacity = BigDecimal.ZERO;
        
        for (Map<String, Object> item : summary) {
            Long count = (Long) item.get("count");
            BigDecimal capacity = (BigDecimal) item.get("total_capacity");
            totalDevices += count;
            if (capacity != null) {
                totalCapacity = totalCapacity.add(capacity);
            }
        }
        
        result.put("totalDevices", totalDevices);
        result.put("totalCapacity", totalCapacity);
        result.put("deviceTypeSummary", summary);
        
        return result;
    }
    
    @Override
    public void updatePvDeviceStatus(String deviceId, String status) {
        pvDeviceDao.updateDeviceStatus(deviceId, status);
    }
    
    @Override
    public Map<String, Object> getDashboardSummary() {
        Map<String, Object> dashboard = new HashMap<>();
        
        // 获取实时数据
        List<Alarm> highAlarms = getHighLevelUnhandledAlarms();
        Map<String, Object> pvSummary = getPvDeviceSummary();
        
        dashboard.put("highAlarmCount", highAlarms.size());
        dashboard.put("pvDeviceCount", pvSummary.get("totalDevices"));
        dashboard.put("pvTotalCapacity", pvSummary.get("totalCapacity"));
        dashboard.put("unhandledAlarms", getAlarmsByStatus("未处理").size());
        
        return dashboard;
    }
    
    @Override
    public Map<String, Object> getEnergyTrend(String energyType, String period) {
        // 模拟能耗趋势数据
        Map<String, Object> trend = new HashMap<>();
        List<String> dates = Arrays.asList("01-01", "01-02", "01-03", "01-04", "01-05");
        List<BigDecimal> values = Arrays.asList(
            new BigDecimal("1250.5"), new BigDecimal("1320.8"), 
            new BigDecimal("1180.3"), new BigDecimal("1420.6"), 
            new BigDecimal("1280.9")
        );
        
        trend.put("dates", dates);
        trend.put("values", values);
        trend.put("energyType", energyType);
        trend.put("period", period);
        
        return trend;
    }
}