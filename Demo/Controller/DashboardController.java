package Demo.Controller;

import Demo.Entity.DashboardConfig;
import Demo.Entity.RealtimeSummaryData;
import Demo.Entity.HistoryTrendData;
import Demo.Service.IDashboardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * 大屏数据展示控制器
 */
@Controller
@RequestMapping("/dashboard")
public class DashboardController {
    
    @Autowired
    private IDashboardService dashboardService;
    
    // ========== 大屏展示配置管理 ==========
    
    /**
     * 大屏展示配置列表页面
     */
    @GetMapping("/config/list")
    public String dashboardConfigList(
            @RequestParam(required = false) String permissionLevel,
            Model model) {
        List<DashboardConfig> configList;
        if (permissionLevel != null) {
            configList = dashboardService.getDashboardConfigsByPermissionLevel(permissionLevel);
        } else {
            configList = dashboardService.getDashboardConfigsByPermissionLevel("管理员");
        }
        model.addAttribute("configList", configList);
        return "dashboard/config_list";
    }
    
    /**
     * 更新大屏展示配置
     */
    @PostMapping("/config/update")
    @ResponseBody
    public String updateDashboardConfig(@RequestBody DashboardConfig config) {
        int result = dashboardService.updateDashboardConfig(config);
        return result > 0 ? "success" : "failed";
    }
    
    // ========== 实时汇总数据管理 ==========
    
    /**
     * 实时汇总数据大屏展示
     */
    @GetMapping("/realtime")
    public String realtimeDashboard(Model model) {
        RealtimeSummaryData latestData = dashboardService.getLatestRealtimeSummaryData();
        model.addAttribute("latestData", latestData);
        return "dashboard/realtime";
    }
    
    /**
     * 获取最新实时汇总数据API
     */
    @GetMapping("/realtime/latest")
    @ResponseBody
    public RealtimeSummaryData getLatestRealtimeSummaryData() {
        return dashboardService.getLatestRealtimeSummaryData();
    }
    
    /**
     * 获取日平均汇总数据
     */
    @GetMapping("/realtime/dailyAverage")
    @ResponseBody
    public List<Map<String, Object>> getDailyAverageSummary(
            @RequestParam String startTime,
            @RequestParam String endTime) {
        return dashboardService.getDailyAverageSummary(startTime, endTime);
    }
    
    // ========== 历史趋势数据管理 ==========
    
    /**
     * 历史趋势数据展示页面
     */
    @GetMapping("/trend")
    public String historyTrend(
            @RequestParam(required = false) String energyType,
            @RequestParam(required = false) String period,
            Model model) {
        List<HistoryTrendData> trendList;
        if (energyType != null && period != null) {
            trendList = dashboardService.getHistoryTrendDataByTypeAndPeriod(
                    energyType, period,
                    java.time.LocalDate.now().minusMonths(1).toString(),
                    java.time.LocalDate.now().toString());
        } else {
            trendList = dashboardService.getHistoryTrendDataByPeriod(
                    "日",
                    java.time.LocalDate.now().minusMonths(1).toString(),
                    java.time.LocalDate.now().toString());
        }
        model.addAttribute("trendList", trendList);
        return "dashboard/trend";
    }
    
    /**
     * 获取历史趋势数据API
     */
    @GetMapping("/trend/data")
    @ResponseBody
    public List<HistoryTrendData> getHistoryTrendData(
            @RequestParam String energyType,
            @RequestParam String period,
            @RequestParam String startDate,
            @RequestParam String endDate) {
        return dashboardService.getHistoryTrendDataByTypeAndPeriod(
                energyType, period, startDate, endDate);
    }
    
    /**
     * 获取趋势增长统计
     */
    @GetMapping("/trend/growthStatistics")
    @ResponseBody
    public List<Map<String, Object>> getTrendGrowthStatistics(
            @RequestParam String startDate,
            @RequestParam String endDate) {
        return dashboardService.getTrendGrowthStatistics(startDate, endDate);
    }
}

