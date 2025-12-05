package Demo.Service;

import Demo.Entity.EnergyMeterDevice;
import Demo.Entity.EnergyMonitorData;
import Demo.Entity.PeakValleyEnergyData;
import java.util.List;
import java.util.Map;

/**
 * 综合能耗管理服务接口
 */
public interface IEnergyMonitorService {
    
    // 能耗计量设备管理
    int insertEnergyMeterDevice(EnergyMeterDevice device);
    EnergyMeterDevice getEnergyMeterDeviceById(String deviceId);
    List<EnergyMeterDevice> getEnergyMeterDevicesByEnergyType(String energyType);
    List<EnergyMeterDevice> getEnergyMeterDevicesByStatus(String status);
    int updateEnergyMeterDevice(EnergyMeterDevice device);
    
    // 能耗监测数据管理
    int insertEnergyMonitorData(EnergyMonitorData data);
    List<EnergyMonitorData> getEnergyMonitorDataByDeviceAndTime(String deviceId, String startTime, String endTime);
    List<EnergyMonitorData> getEnergyMonitorDataByFactoryAndTime(String factoryId, String startTime, String endTime);
    List<EnergyMonitorData> getPoorQualityData(String startTime);
    List<Map<String, Object>> getFactoryEnergySummary(String startTime, String endTime);
    int updateDataQuality(String dataId, String quality);
    
    // 峰谷能耗数据管理
    int insertPeakValleyEnergyData(PeakValleyEnergyData data);
    List<PeakValleyEnergyData> getPeakValleyEnergyDataByFactoryAndDate(String factoryId, String startDate, String endDate);
    List<PeakValleyEnergyData> getPeakValleyEnergyDataByEnergyTypeAndDate(String energyType, String startDate, String endDate);
    List<Map<String, Object>> getFactoriesWithLowValleyRatio(String startDate, String endDate);
    List<Map<String, Object>> getDailyEnergyCostReport(String startDate, String endDate);
}

