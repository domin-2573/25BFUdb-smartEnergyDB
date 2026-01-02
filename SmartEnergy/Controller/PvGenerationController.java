package Demo.Controller;

import Demo.Entity.PvGenerationData;
import Demo.Service.IPvGenerationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * 光伏发电数据控制器
 */
@Controller
@RequestMapping("/pv/generation")
public class PvGenerationController {
    
    @Autowired
    private IPvGenerationService pvGenerationService;
    
    /**
     * 光伏发电数据列表页面
     */
    @GetMapping("/list")
    public String pvGenerationList(
            @RequestParam(required = false) String deviceId,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime,
            Model model) {
        List<PvGenerationData> dataList;
        if (deviceId != null && startTime != null && endTime != null) {
            dataList = pvGenerationService.getPvGenerationDataByDeviceAndTime(
                    deviceId, startTime, endTime);
        } else {
            dataList = pvGenerationService.getLowEfficiencyPvData(
                    java.time.LocalDateTime.now().minusDays(1).toString());
        }
        model.addAttribute("dataList", dataList);
        return "pv/generation_list";
    }
    
    /**
     * 获取光伏发电数据API
     */
    @GetMapping("/data")
    @ResponseBody
    public List<PvGenerationData> getPvGenerationData(
            @RequestParam String deviceId,
            @RequestParam String startTime,
            @RequestParam String endTime) {
        return pvGenerationService.getPvGenerationDataByDeviceAndTime(deviceId, startTime, endTime);
    }
    
    /**
     * 获取日发电量汇总
     */
    @GetMapping("/dailySummary")
    @ResponseBody
    public List<Map<String, Object>> getDailyPvGenerationSummary(
            @RequestParam String startTime,
            @RequestParam String endTime) {
        return pvGenerationService.getDailyPvGenerationSummary(startTime, endTime);
    }
    
    /**
     * 获取低效率光伏数据
     */
    @GetMapping("/lowEfficiency")
    @ResponseBody
    public List<PvGenerationData> getLowEfficiencyPvData(@RequestParam String startTime) {
        return pvGenerationService.getLowEfficiencyPvData(startTime);
    }
    
    /**
     * 添加光伏发电数据
     */
    @PostMapping("/add")
    @ResponseBody
    public String addPvGenerationData(@RequestBody PvGenerationData data) {
        int result = pvGenerationService.insertPvGenerationData(data);
        return result > 0 ? "success" : "failed";
    }
}

