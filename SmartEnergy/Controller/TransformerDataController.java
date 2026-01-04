package Demo.Controller;

import Demo.Entity.TransformerData;
import Demo.Service.ITransformerDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * 变压器监测数据控制器
 */
@Controller
@RequestMapping("/transformer")
public class TransformerDataController {
    
    @Autowired
    private ITransformerDataService transformerDataService;
    
    /**
     * 变压器监测数据列表页面
     */
    @GetMapping("/monitor")
    public String transformerMonitor(
            @RequestParam(required = false) String substationId,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime,
            Model model) {
        List<TransformerData> dataList;
        if (substationId != null && startTime != null && endTime != null) {
            dataList = transformerDataService.getTransformerDataBySubstationAndTime(
                    substationId, startTime, endTime);
        } else {
            dataList = transformerDataService.getAbnormalTransformerData(
                    java.time.LocalDateTime.now().minusDays(1).toString());
        }
        model.addAttribute("dataList", dataList);
        return "transformer/monitor";
    }
    
    /**
     * 获取变压器监测数据API
     */
    @GetMapping("/data")
    @ResponseBody
    public List<TransformerData> getTransformerData(
            @RequestParam String substationId,
            @RequestParam String startTime,
            @RequestParam String endTime) {
        return transformerDataService.getTransformerDataBySubstationAndTime(
                substationId, startTime, endTime);
    }
    
    /**
     * 获取异常变压器数据
     */
    @GetMapping("/abnormal")
    @ResponseBody
    public List<TransformerData> getAbnormalTransformerData(@RequestParam String startTime) {
        return transformerDataService.getAbnormalTransformerData(startTime);
    }
    
    /**
     * 获取变压器统计数据
     */
    @GetMapping("/statistics")
    @ResponseBody
    public List<Map<String, Object>> getTransformerStatistics(
            @RequestParam String substationId,
            @RequestParam String startTime,
            @RequestParam String endTime) {
        return transformerDataService.getTransformerStatistics(substationId, startTime, endTime);
    }
    
    /**
     * 更新变压器数据状态
     */
    @PostMapping("/updateStatus")
    @ResponseBody
    public String updateTransformerDataStatus(
            @RequestParam String dataId,
            @RequestParam String status) {
        int result = transformerDataService.updateTransformerDataStatus(dataId, status);
        return result > 0 ? "success" : "failed";
    }
}

