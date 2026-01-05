package Demo.Controller;

import Demo.Entity.Alarm;
import Demo.Service.IEnergyService;
import Demo.Dao.AlarmDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.time.LocalDate;

@Controller
@RequestMapping("/alarm")
public class AlarmController {
    
    @Autowired
    private IEnergyService energyService;
    
    @Autowired
    private AlarmDao alarmDao;
    
    // 告警管理页面
    @GetMapping("/manage")
    public String alarmManagement(Model model) {
        List<Alarm> unhandledAlarms = energyService.getAlarmsByStatus("未处理");
        List<Alarm> handlingAlarms = energyService.getAlarmsByStatus("处理中");
        List<Alarm> highLevelAlarms = energyService.getHighLevelUnhandledAlarms();
        
        model.addAttribute("unhandledAlarms", unhandledAlarms);
        model.addAttribute("handlingAlarms", handlingAlarms);
        model.addAttribute("highLevelAlarms", highLevelAlarms);
        
        return "alarm/alarm_manage";
    }
    
    // 获取告警列表API（用于大屏展示）
    @GetMapping("/list")
    @ResponseBody
    public List<Alarm> getAlarmList(
            @RequestParam(required = false, defaultValue = "10") int limit) {
        List<Alarm> allAlarms = energyService.getAlarmsByStatus("未处理");
        // 返回最新的N条告警
        return allAlarms.stream()
                .sorted((a, b) -> b.getOccurTime().compareTo(a.getOccurTime()))
                .limit(limit)
                .collect(java.util.stream.Collectors.toList());
    }
    
    // 获取告警统计API - 修改为可选参数
    @GetMapping("/statistics")
    @ResponseBody
    public Map<String, Object> getAlarmStatistics(
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime) {
        
        // 如果没有提供时间参数，使用默认值（最近30天）
        if (startTime == null || endTime == null) {
            LocalDate endDate = LocalDate.now();
            LocalDate startDate = endDate.minusDays(30);
            startTime = startDate.toString();
            endTime = endDate.toString();
        }
        
        return energyService.getAlarmStatistics(startTime, endTime);
    }
    
    // 更新告警状态
    @PostMapping("/updateStatus")
    @ResponseBody
    public String updateAlarmStatus(@RequestParam String alarmId, @RequestParam String status) {
        alarmDao.updateAlarmStatus(alarmId, status);
        return "success";
    }
    
    // 高等级告警页面
    @GetMapping("/highLevel")
    public String highLevelAlarms(Model model) {
        List<Alarm> highAlarms = energyService.getHighLevelUnhandledAlarms();
        model.addAttribute("highAlarms", highAlarms);
        return "alarm/high_level_alarms";
    }
    
    /**
     * 告警统计页面
     */
    @GetMapping("/statistics/page")
    public String alarmStatisticsPage(Model model) {
        // 为页面设置默认时间范围
        LocalDate endDate = LocalDate.now();
        LocalDate startDate = endDate.minusDays(30);
        model.addAttribute("defaultStartTime", startDate.toString());
        model.addAttribute("defaultEndTime", endDate.toString());
        return "alarm/alarm_statistics";
    }

    /**
     * 告警类型分布统计API - 修改为可选参数
     */
    @GetMapping("/statistics/typeDistribution")
    @ResponseBody
    public Map<String, Object> getAlarmTypeDistribution(
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime) {
        
        // 设置默认时间范围（最近30天）
        if (startTime == null || endTime == null) {
            LocalDate endDate = LocalDate.now();
            LocalDate startDate = endDate.minusDays(30);
            startTime = startDate.toString();
            endTime = endDate.toString();
        }
        
        List<Map<String, Object>> result = energyService.getAlarmTypeDistribution(startTime, endTime);
        Map<String, Object> response = new HashMap<>();
        response.put("data", result);
        response.put("total", result.size());
        return response;
    }

    /**
     * 告警等级分布统计API - 修改为可选参数
     */
    @GetMapping("/statistics/levelDistribution")
    @ResponseBody
    public Map<String, Object> getAlarmLevelDistribution(
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime) {
        
        // 设置默认时间范围（最近30天）
        if (startTime == null || endTime == null) {
            LocalDate endDate = LocalDate.now();
            LocalDate startDate = endDate.minusDays(30);
            startTime = startDate.toString();
            endTime = endDate.toString();
        }
        
        List<Map<String, Object>> result = energyService.getAlarmLevelDistribution(startTime, endTime);
        Map<String, Object> response = new HashMap<>();
        response.put("data", result);
        response.put("total", result.size());
        return response;
    }

    /**
     * 告警处理效率统计API - 修改为可选参数
     */
    @GetMapping("/statistics/handleEfficiency")
    @ResponseBody
    public Map<String, Object> getAlarmHandleEfficiency(
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime) {
        
        // 设置默认时间范围（最近30天）
        if (startTime == null || endTime == null) {
            LocalDate endDate = LocalDate.now();
            LocalDate startDate = endDate.minusDays(30);
            startTime = startDate.toString();
            endTime = endDate.toString();
        }
        
        return energyService.getAlarmHandleEfficiency(startTime, endTime);
    }

    /**
     * 告警趋势分析API（按天统计）- 修改为可选参数
     */
    @GetMapping("/statistics/trendByDay")
    @ResponseBody
    public Map<String, Object> getAlarmTrendByDay(
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime) {
        
        // 设置默认时间范围（最近7天）
        if (startTime == null || endTime == null) {
            LocalDate endDate = LocalDate.now();
            LocalDate startDate = endDate.minusDays(7);
            startTime = startDate.toString();
            endTime = endDate.toString();
        }
        
        List<Map<String, Object>> result = energyService.getAlarmTrendByDay(startTime, endTime);
        Map<String, Object> response = new HashMap<>();
        response.put("data", result);
        response.put("total", result.size());
        return response;
    }
    
    /**
     * 告警与设备关联页面
     */
    @GetMapping("/device/relation/page")
    public String alarmDeviceRelationPage(Model model) {
        // 为页面设置默认时间范围
        LocalDate endDate = LocalDate.now();
        LocalDate startDate = endDate.minusDays(30);
        model.addAttribute("defaultStartTime", startDate.toString());
        model.addAttribute("defaultEndTime", endDate.toString());
        return "alarm/alarm_device_relation";
    }

    /**
     * 频繁告警设备TOP10 API - 修改为可选参数
     */
    @GetMapping("/device/frequentAlarms")
    @ResponseBody
    public Map<String, Object> getFrequentAlarmDevices(
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime,
            @RequestParam(defaultValue = "10") int limit) {
        
        // 设置默认时间范围（最近30天）
        if (startTime == null || endTime == null) {
            LocalDate endDate = LocalDate.now();
            LocalDate startDate = endDate.minusDays(30);
            startTime = startDate.toString();
            endTime = endDate.toString();
        }
        
        List<Map<String, Object>> result = energyService.getFrequentAlarmDevices(startTime, endTime, limit);
        Map<String, Object> response = new HashMap<>();
        response.put("data", result);
        response.put("total", result.size());
        return response;
    }

    /**
     * 设备类型告警分布API - 修改为可选参数
     */
    @GetMapping("/device/typeDistribution")
    @ResponseBody
    public Map<String, Object> getAlarmDeviceTypeDistribution(
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime) {
        
        // 设置默认时间范围（最近30天）
        if (startTime == null || endTime == null) {
            LocalDate endDate = LocalDate.now();
            LocalDate startDate = endDate.minusDays(30);
            startTime = startDate.toString();
            endTime = endDate.toString();
        }
        
        List<Map<String, Object>> result = energyService.getAlarmDeviceTypeDistribution(startTime, endTime);
        Map<String, Object> response = new HashMap<>();
        response.put("data", result);
        response.put("total", result.size());
        return response;
    }

    /**
     * 设备详细告警信息API - 修改为可选参数
     */
    @GetMapping("/device/detail/{deviceId}")
    @ResponseBody
    public Map<String, Object> getDeviceAlarmDetails(
            @PathVariable String deviceId,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime) {
        
        // 设置默认时间范围（最近30天）
        if (startTime == null || endTime == null) {
            LocalDate endDate = LocalDate.now();
            LocalDate startDate = endDate.minusDays(30);
            startTime = startDate.toString();
            endTime = endDate.toString();
        }
        
        return energyService.getDeviceAlarmDetails(deviceId, startTime, endTime);
    }
}