package Demo.Controller;

import Demo.Entity.Substation;
import Demo.Entity.Alarm;
import Demo.Service.ISubstationService;
import Demo.Dao.SubstationDao;
import Demo.Dao.AlarmDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Date;
import java.text.SimpleDateFormat;

/**
 * 配电房信息管理控制器
 */
@Controller
@RequestMapping("/substation")
public class SubstationController {
    
    @Autowired
    private ISubstationService substationService;
    
    @Autowired
    private SubstationDao substationDao;
    
    @Autowired
    private AlarmDao alarmDao;
    
    /**
     * 配电房列表页面
     */
    @GetMapping("/list")
    public String substationList(Model model) {
        List<Substation> substations = substationService.getAllSubstations();
        model.addAttribute("substations", substations);
        return "substation/list";
    }
    
    /**
     * 配电房详情页面
     */
    @GetMapping("/detail/{substationId}")
    public String substationDetail(@PathVariable String substationId, Model model) {
        Substation substation = substationService.getSubstationById(substationId);
        model.addAttribute("substation", substation);
        return "substation/detail";
    }
    
    /**
     * 添加配电房页面
     */
    @GetMapping("/add")
    public String addSubstationPage() {
        return "substation/add";
    }
    
    /**
     * 添加配电房
     */
    @PostMapping("/add")
    @ResponseBody
    public String addSubstation(@RequestBody Substation substation) {
        int result = substationService.insertSubstation(substation);
        return result > 0 ? "success" : "failed";
    }
    
    /**
     * 更新配电房
     */
    @PostMapping("/update")
    @ResponseBody
    public String updateSubstation(@RequestBody Substation substation) {
        int result = substationService.updateSubstation(substation);
        return result > 0 ? "success" : "failed";
    }
    
    /**
     * 删除配电房
     */
    @PostMapping("/delete/{substationId}")
    @ResponseBody
    public String deleteSubstation(@PathVariable String substationId) {
        int result = substationService.deleteSubstation(substationId);
        return result > 0 ? "success" : "failed";
    }
    
    /**
     * 按电压等级查询配电房
     */
    @GetMapping("/byVoltageLevel")
    @ResponseBody
    public List<Substation> getSubstationsByVoltageLevel(@RequestParam String voltageLevel) {
        return substationService.getSubstationsByVoltageLevel(voltageLevel);
    }
    
    /**
     * 检查配电房信息完整性并生成告警
     */
    @PostMapping("/checkCompleteness")
    @ResponseBody
    public Map<String, Object> checkSubstationCompleteness() {
        List<Substation> substations = substationService.getAllSubstations();
        int alarmCount = 0;
        List<String> missingSubstations = new ArrayList<>();
        
        for (Substation substation : substations) {
            // 检查关键信息是否缺失
            boolean hasMissingInfo = false;
            String missingFields = "";
            
            if (substation.getName() == null || substation.getName().trim().isEmpty()) {
                hasMissingInfo = true;
                missingFields += "名称、";
            }
            if (substation.getLocation() == null || substation.getLocation().trim().isEmpty()) {
                hasMissingInfo = true;
                missingFields += "位置描述、";
            }
            if (substation.getVoltageLevel() == null || substation.getVoltageLevel().trim().isEmpty()) {
                hasMissingInfo = true;
                missingFields += "电压等级、";
            }
            if (substation.getManagerId() == null || substation.getManagerId().trim().isEmpty()) {
                hasMissingInfo = true;
                missingFields += "负责人ID、";
            }
            if (substation.getContact() == null || substation.getContact().trim().isEmpty()) {
                hasMissingInfo = true;
                missingFields += "联系方式、";
            }
            
            if (hasMissingInfo) {
                missingSubstations.add(substation.getSubstationId());
                
                // 检查是否已有相同告警（检查最近24小时内的告警）
                List<Alarm> existingAlarms = alarmDao.getAlarmsByStatus("未处理");
                boolean alarmExists = existingAlarms.stream()
                    .anyMatch(a -> {
                        // 检查设备ID匹配且告警内容包含信息缺失
                        boolean deviceMatch = a.getDeviceId() != null && 
                            a.getDeviceId().equals(substation.getSubstationId());
                        boolean contentMatch = a.getAlarmContent() != null && 
                            a.getAlarmContent().contains("信息缺失");
                        // 检查告警时间在24小时内
                        long timeDiff = System.currentTimeMillis() - a.getOccurTime().getTime();
                        boolean recentAlarm = timeDiff < 24 * 60 * 60 * 1000;
                        return deviceMatch && contentMatch && recentAlarm;
                    });
                
                if (!alarmExists) {
                    // 生成告警
                    Alarm alarm = new Alarm();
                    // 告警编号格式：ALM + 时间戳(MMddHHmmss) + 设备编号后2位，总长度不超过20
                    // ALM(3) + 时间(10) + 后缀(2) = 15字符，符合VARCHAR(20)限制
                    SimpleDateFormat sdf = new SimpleDateFormat("MMddHHmmss");
                    String timeStr = sdf.format(new Date());
                    String substationId = substation.getSubstationId();
                    // 取设备编号后2位，如果不足2位则补0
                    String suffix;
                    if (substationId.length() >= 2) {
                        suffix = substationId.substring(substationId.length() - 2);
                    } else {
                        // 如果长度不足2位，提取数字部分或使用默认值
                        String digits = substationId.replaceAll("[^0-9]", "");
                        suffix = digits.length() >= 2 ? digits.substring(digits.length() - 2) : 
                                (digits.length() == 1 ? "0" + digits : "00");
                    }
                    alarm.setAlarmId("ALM" + timeStr + suffix);
                    alarm.setAlarmType("通讯故障");
                    alarm.setDeviceId(substation.getSubstationId());
                    alarm.setOccurTime(new Date());
                    alarm.setAlarmLevel("中");
                    String content = "配电房" + substation.getSubstationId() + "信息缺失：" + 
                        missingFields.substring(0, missingFields.length() - 1);
                    alarm.setAlarmContent(content);
                    alarm.setHandleStatus("未处理");
                    alarm.setTriggerThreshold("信息完整性检查");
                    
                    try {
                        alarmDao.insertAlarm(alarm);
                        alarmCount++;
                    } catch (Exception e) {
                        // 如果插入失败（可能是ID重复），继续处理下一个
                        System.err.println("插入告警失败: " + e.getMessage());
                    }
                }
            }
        }
        
        Map<String, Object> result = new HashMap<>();
        result.put("success", true);
        result.put("alarmCount", alarmCount);
        result.put("missingSubstations", missingSubstations);
        result.put("message", "检查完成，共发现 " + missingSubstations.size() + " 个配电房信息缺失，生成 " + alarmCount + " 条告警");
        return result;
    }
}
