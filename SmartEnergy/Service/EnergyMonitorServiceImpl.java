package Demo.Service;

import Demo.Dao.*;
import Demo.Entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

/**
 * 综合能耗管理服务实现
 */
@Service
public class EnergyMonitorServiceImpl implements IEnergyMonitorService {
    
    @Autowired
    private EnergyMeterDeviceDao energyMeterDeviceDao;
    
    @Autowired
    private EnergyMonitorDataDao energyMonitorDataDao;
    
    @Autowired
    private PeakValleyEnergyDataDao peakValleyEnergyDataDao;
    
    // 能耗计量设备管理
    @Override
    public int insertEnergyMeterDevice(EnergyMeterDevice device) {
        return energyMeterDeviceDao.insertEnergyMeterDevice(device);
    }
    
    @Override
    public EnergyMeterDevice getEnergyMeterDeviceById(String deviceId) {
        return energyMeterDeviceDao.getEnergyMeterDeviceById(deviceId);
    }
    
    @Override
    public List<EnergyMeterDevice> getEnergyMeterDevicesByEnergyType(String energyType) {
        return energyMeterDeviceDao.getEnergyMeterDevicesByEnergyType(energyType);
    }
    
    @Override
    public List<EnergyMeterDevice> getEnergyMeterDevicesByStatus(String status) {
        return energyMeterDeviceDao.getEnergyMeterDevicesByStatus(status);
    }
    
    @Override
    public int updateEnergyMeterDevice(EnergyMeterDevice device) {
        return energyMeterDeviceDao.updateEnergyMeterDevice(device);
    }
    
    // 能耗监测数据管理
    @Override
    public int insertEnergyMonitorData(EnergyMonitorData data) {
        return energyMonitorDataDao.insertEnergyMonitorData(data);
    }
    
    @Override
    public List<EnergyMonitorData> getEnergyMonitorDataByDeviceAndTime(String deviceId, String startTime, String endTime) {
        return energyMonitorDataDao.getEnergyMonitorDataByDeviceAndTime(deviceId, startTime, endTime);
    }
    
    @Override
    public List<EnergyMonitorData> getEnergyMonitorDataByFactoryAndTime(String factoryId, String startTime, String endTime) {
        return energyMonitorDataDao.getEnergyMonitorDataByFactoryAndTime(factoryId, startTime, endTime);
    }
    
    @Override
    public List<EnergyMonitorData> getPoorQualityData(String startTime) {
        return energyMonitorDataDao.getPoorQualityData(startTime);
    }
    
    @Override
    public List<Map<String, Object>> getFactoryEnergySummary(String startTime, String endTime) {
        return energyMonitorDataDao.getFactoryEnergySummary(startTime, endTime);
    }
    
    @Override
    public int updateDataQuality(String dataId, String quality) {
        return energyMonitorDataDao.updateDataQuality(dataId, quality);
    }
    
    // 峰谷能耗数据管理
    @Override
    public int insertPeakValleyEnergyData(PeakValleyEnergyData data) {
        return peakValleyEnergyDataDao.insertPeakValleyEnergyData(data);
    }
    
    @Override
    public List<PeakValleyEnergyData> getPeakValleyEnergyDataByFactoryAndDate(String factoryId, String startDate, String endDate) {
        return peakValleyEnergyDataDao.getPeakValleyEnergyDataByFactoryAndDate(factoryId, startDate, endDate);
    }
    
    @Override
    public List<PeakValleyEnergyData> getPeakValleyEnergyDataByEnergyTypeAndDate(String energyType, String startDate, String endDate) {
        return peakValleyEnergyDataDao.getPeakValleyEnergyDataByEnergyTypeAndDate(energyType, startDate, endDate);
    }
    
    @Override
    public List<Map<String, Object>> getFactoriesWithLowValleyRatio(String startDate, String endDate) {
        return peakValleyEnergyDataDao.getFactoriesWithLowValleyRatio(startDate, endDate);
    }
    
    @Override
    public List<Map<String, Object>> getDailyEnergyCostReport(String startDate, String endDate) {
        return peakValleyEnergyDataDao.getDailyEnergyCostReport(startDate, endDate);
    }
}

