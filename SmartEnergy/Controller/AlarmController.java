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
    
    // 获取告警统计API
    @GetMapping("/statistics")
    @ResponseBody
    public Map<String, Object> getAlarmStatistics(
            @RequestParam String startTime,
            @RequestParam String endTime) {
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
}
