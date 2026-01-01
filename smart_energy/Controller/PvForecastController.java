package Demo.Controller;

import Demo.Entity.PvForecastData;
import Demo.Service.IPvForecastService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * 光伏预测数据控制器
 */
@Controller
@RequestMapping("/pv/forecast")
public class PvForecastController {
    
    @Autowired
    private IPvForecastService pvForecastService;
    
    /**
     * 光伏预测数据列表页面
     */
    @GetMapping("/list")
    public String pvForecastList(
            @RequestParam(required = false) String gridPointId,
            @RequestParam(required = false) String forecastDate,
            Model model) {
        List<PvForecastData> dataList;
        if (gridPointId != null && forecastDate != null) {
            dataList = pvForecastService.getPvForecastDataByGridPointAndDate(
                    gridPointId, forecastDate);
        } else {
            dataList = pvForecastService.getHighDeviationForecastData(
                    java.time.LocalDate.now().minusDays(7).toString());
        }
        model.addAttribute("dataList", dataList);
        return "pv/forecast_list";
    }
    
    /**
     * 获取光伏预测数据API
     */
    @GetMapping("/data")
    @ResponseBody
    public List<PvForecastData> getPvForecastData(
            @RequestParam String gridPointId,
            @RequestParam String forecastDate) {
        return pvForecastService.getPvForecastDataByGridPointAndDate(gridPointId, forecastDate);
    }
    
    /**
     * 获取高偏差预测数据
     */
    @GetMapping("/highDeviation")
    @ResponseBody
    public List<PvForecastData> getHighDeviationForecastData(@RequestParam String startDate) {
        return pvForecastService.getHighDeviationForecastData(startDate);
    }
    
    /**
     * 获取预测偏差统计
     */
    @GetMapping("/deviationStatistics")
    @ResponseBody
    public List<Map<String, Object>> getForecastDeviationStatistics(
            @RequestParam String gridPointId,
            @RequestParam String startDate,
            @RequestParam String endDate) {
        return pvForecastService.getForecastDeviationStatistics(
                gridPointId, startDate, endDate);
    }
    
    /**
     * 更新预测数据
     */
    @PostMapping("/update")
    @ResponseBody
    public String updatePvForecastData(@RequestBody PvForecastData data) {
        int result = pvForecastService.updatePvForecastData(data);
        return result > 0 ? "success" : "failed";
    }
}

