package Demo.Controller;

import Demo.Entity.EnergyMeterDevice;
import Demo.Entity.EnergyMonitorData;
import Demo.Entity.PeakValleyEnergyData;
import Demo.Service.IEnergyMonitorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * 综合能耗管理控制器
 */
@Controller
@RequestMapping("/energy/monitor")
public class EnergyMonitorController {
    
    @Autowired
    private IEnergyMonitorService energyMonitorService;
    
    // ========== 能耗计量设备管理 ==========
    
    /**
     * 能耗计量设备列表页面
     */
    @GetMapping("/device/list")
    public String energyMeterDeviceList(
            @RequestParam(required = false) String energyType,
            Model model) {
        List<EnergyMeterDevice> deviceList;
        if (energyType != null) {
            deviceList = energyMonitorService.getEnergyMeterDevicesByEnergyType(energyType);
        } else {
            deviceList = energyMonitorService.getEnergyMeterDevicesByStatus("正常");
        }
        model.addAttribute("deviceList", deviceList);
        return "energy/device_list";
    }
    
    /**
     * 添加能耗计量设备
     */
    @PostMapping("/device/add")
    @ResponseBody
    public String addEnergyMeterDevice(@RequestBody EnergyMeterDevice device) {
        int result = energyMonitorService.insertEnergyMeterDevice(device);
        return result > 0 ? "success" : "failed";
    }
    
    // ========== 能耗监测数据管理 ==========
    
    /**
     * 能耗监测数据列表页面
     */
    @GetMapping("/data/list")
    public String energyMonitorDataList(
            @RequestParam(required = false) String factoryId,
            @RequestParam(required = false) String startTime,
            @RequestParam(required = false) String endTime,
            Model model) {
        List<EnergyMonitorData> dataList;
        if (factoryId != null && startTime != null && endTime != null) {
            dataList = energyMonitorService.getEnergyMonitorDataByFactoryAndTime(
                    factoryId, startTime, endTime);
        } else {
            dataList = energyMonitorService.getPoorQualityData(
                    java.time.LocalDateTime.now().minusDays(1).toString());
        }
        model.addAttribute("dataList", dataList);
        return "energy/data_list";
    }
    
    /**
     * 获取厂区能耗汇总
     */
    @GetMapping("/factory/summary")
    @ResponseBody
    public List<Map<String, Object>> getFactoryEnergySummary(
            @RequestParam String startTime,
            @RequestParam String endTime) {
        return energyMonitorService.getFactoryEnergySummary(startTime, endTime);
    }
    
    // ========== 峰谷能耗数据管理 ==========
    
    /**
     * 峰谷能耗数据列表页面
     */
    @GetMapping("/peakvalley/list")
    public String peakValleyEnergyDataList(
            @RequestParam(required = false) String factoryId,
            @RequestParam(required = false) String startDate,
            @RequestParam(required = false) String endDate,
            Model model) {
        List<PeakValleyEnergyData> dataList;
        if (factoryId != null && startDate != null && endDate != null) {
            dataList = energyMonitorService.getPeakValleyEnergyDataByFactoryAndDate(
                    factoryId, startDate, endDate);
        } else {
            dataList = energyMonitorService.getPeakValleyEnergyDataByFactoryAndDate(
                    "A3", 
                    java.time.LocalDate.now().minusDays(7).toString(),
                    java.time.LocalDate.now().toString());
        }
        model.addAttribute("dataList", dataList);
        return "energy/peakvalley_list";
    }
    
    /**
     * 获取日能耗成本报表
     */
    @GetMapping("/cost/report")
    @ResponseBody
    public List<Map<String, Object>> getDailyEnergyCostReport(
            @RequestParam String startDate,
            @RequestParam String endDate) {
        return energyMonitorService.getDailyEnergyCostReport(startDate, endDate);
    }
    
    /**
     * 获取谷段用电占比低于30%的厂区
     */
    @GetMapping("/lowValleyRatio")
    @ResponseBody
    public List<Map<String, Object>> getFactoriesWithLowValleyRatio(
            @RequestParam String startDate,
            @RequestParam String endDate) {
        return energyMonitorService.getFactoriesWithLowValleyRatio(startDate, endDate);
    }
}

