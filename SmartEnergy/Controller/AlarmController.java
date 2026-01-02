package Demo.Controller;

import Demo.Entity.Alarm;
import Demo.Service.IEnergyService;
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
    
    // �澯����ҳ��
    @GetMapping("/manage")
    public String alarmManagement(Model model) {
        List<Alarm> unhandledAlarms = energyService.getAlarmsByStatus("δ����");
        List<Alarm> handlingAlarms = energyService.getAlarmsByStatus("������");
        List<Alarm> highLevelAlarms = energyService.getHighLevelUnhandledAlarms();
        
        model.addAttribute("unhandledAlarms", unhandledAlarms);
        model.addAttribute("handlingAlarms", handlingAlarms);
        model.addAttribute("highLevelAlarms", highLevelAlarms);
        
        return "alarm/alarm_manage";
    }
    
    // ��ȡ�澯ͳ��API
    @GetMapping("/statistics")
    @ResponseBody
    public Map<String, Object> getAlarmStatistics(
            @RequestParam String startTime,
            @RequestParam String endTime) {
        return energyService.getAlarmStatistics(startTime, endTime);
    }
    
    // ���¸澯״̬
    @PostMapping("/updateStatus")
    @ResponseBody
    public String updateAlarmStatus(@RequestParam Long alarmId, @RequestParam String status) {
        energyService.updateAlarmStatus(alarmId, status);
        return "success";
    }
    
    // �ߵȼ��澯ҳ��
    @GetMapping("/highLevel")
    public String highLevelAlarms(Model model) {
        List<Alarm> highAlarms = energyService.getHighLevelUnhandledAlarms();
        model.addAttribute("highAlarms", highAlarms);
        return "alarm/high_level_alarms";
    }
}