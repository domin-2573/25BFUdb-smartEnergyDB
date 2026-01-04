package Demo.Service;

import Demo.Dao.*;
import Demo.Entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

/**
 * 大屏数据展示服务实现
 */
@Service
public class DashboardServiceImpl implements IDashboardService {
    
    @Autowired
    private DashboardConfigDao dashboardConfigDao;
    
    @Autowired
    private RealtimeSummaryDataDao realtimeSummaryDataDao;
    
    @Autowired
    private HistoryTrendDataDao historyTrendDataDao;
    
    // 大屏展示配置管理
    @Override
    public int insertDashboardConfig(DashboardConfig config) {
        return dashboardConfigDao.insertDashboardConfig(config);
    }
    
    @Override
    public DashboardConfig getDashboardConfigById(String configId) {
        return dashboardConfigDao.getDashboardConfigById(configId);
    }
    
    @Override
    public List<DashboardConfig> getDashboardConfigsByPermissionLevel(String permissionLevel) {
        return dashboardConfigDao.getDashboardConfigsByPermissionLevel(permissionLevel);
    }
    
    @Override
    public List<DashboardConfig> getDashboardConfigsByDisplayModule(String displayModule) {
        return dashboardConfigDao.getDashboardConfigsByDisplayModule(displayModule);
    }
    
    @Override
    public int updateDashboardConfig(DashboardConfig config) {
        return dashboardConfigDao.updateDashboardConfig(config);
    }
    
    // 实时汇总数据管理
    @Override
    public int insertRealtimeSummaryData(RealtimeSummaryData data) {
        return realtimeSummaryDataDao.insertRealtimeSummaryData(data);
    }
    
    @Override
    public RealtimeSummaryData getLatestRealtimeSummaryData() {
        RealtimeSummaryData data = realtimeSummaryDataDao.getLatestRealtimeSummaryData();
        // 如果数据库中没有数据，返回一个默认的空数据对象，避免前端显示null
        if (data == null) {
            data = new RealtimeSummaryData();
            data.setSummaryId("DEFAULT");
            data.setStatisticsTime(new java.util.Date());
            data.setTotalElectricity(java.math.BigDecimal.ZERO);
            data.setTotalWater(java.math.BigDecimal.ZERO);
            data.setTotalSteam(java.math.BigDecimal.ZERO);
            data.setTotalGas(java.math.BigDecimal.ZERO);
            data.setTotalPvGeneration(java.math.BigDecimal.ZERO);
            data.setTotalPvSelfConsumption(java.math.BigDecimal.ZERO);
            data.setTotalAlarmCount(0);
            data.setHighLevelAlarmCount(0);
            data.setMediumLevelAlarmCount(0);
            data.setLowLevelAlarmCount(0);
        }
        return data;
    }
    
    @Override
    public List<RealtimeSummaryData> getRealtimeSummaryDataByTimeRange(String startTime, String endTime) {
        return realtimeSummaryDataDao.getRealtimeSummaryDataByTimeRange(startTime, endTime);
    }
    
    @Override
    public List<Map<String, Object>> getDailyAverageSummary(String startTime, String endTime) {
        return realtimeSummaryDataDao.getDailyAverageSummary(startTime, endTime);
    }
    
    // 历史趋势数据管理
    @Override
    public int insertHistoryTrendData(HistoryTrendData data) {
        return historyTrendDataDao.insertHistoryTrendData(data);
    }
    
    @Override
    public List<HistoryTrendData> getHistoryTrendDataByTypeAndPeriod(String energyType, String period, String startDate, String endDate) {
        return historyTrendDataDao.getHistoryTrendDataByTypeAndPeriod(energyType, period, startDate, endDate);
    }
    
    @Override
    public List<HistoryTrendData> getHistoryTrendDataByPeriod(String period, String startDate, String endDate) {
        return historyTrendDataDao.getHistoryTrendDataByPeriod(period, startDate, endDate);
    }
    
    @Override
    public List<Map<String, Object>> getTrendGrowthStatistics(String startDate, String endDate) {
        return historyTrendDataDao.getTrendGrowthStatistics(startDate, endDate);
    }
}

