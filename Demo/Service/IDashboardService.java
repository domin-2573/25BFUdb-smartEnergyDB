package Demo.Service;

import Demo.Entity.DashboardConfig;
import Demo.Entity.RealtimeSummaryData;
import Demo.Entity.HistoryTrendData;
import java.util.List;
import java.util.Map;

/**
 * 大屏数据展示服务接口
 */
public interface IDashboardService {
    
    // 大屏展示配置管理
    int insertDashboardConfig(DashboardConfig config);
    DashboardConfig getDashboardConfigById(String configId);
    List<DashboardConfig> getDashboardConfigsByPermissionLevel(String permissionLevel);
    List<DashboardConfig> getDashboardConfigsByDisplayModule(String displayModule);
    int updateDashboardConfig(DashboardConfig config);
    
    // 实时汇总数据管理
    int insertRealtimeSummaryData(RealtimeSummaryData data);
    RealtimeSummaryData getLatestRealtimeSummaryData();
    List<RealtimeSummaryData> getRealtimeSummaryDataByTimeRange(String startTime, String endTime);
    List<Map<String, Object>> getDailyAverageSummary(String startTime, String endTime);
    
    // 历史趋势数据管理
    int insertHistoryTrendData(HistoryTrendData data);
    List<HistoryTrendData> getHistoryTrendDataByTypeAndPeriod(String energyType, String period, String startDate, String endDate);
    List<HistoryTrendData> getHistoryTrendDataByPeriod(String period, String startDate, String endDate);
    List<Map<String, Object>> getTrendGrowthStatistics(String startDate, String endDate);
}

