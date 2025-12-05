package Demo.Controller;

import Demo.Entity.*;
import Demo.Service.IEnergyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/energy")
public class EnergyController {
    
    @Autowired
    private IEnergyService energyService;
    
    // ��������ҳ��
    @GetMapping("/circuit")
    public String circuitMonitor(Model model) {
        List<CircuitData> abnormalData = energyService.getAbnormalCircuitData(
            java.time.LocalDateTime.now().minusDays(1).toString()
        );
        model.addAttribute("abnormalData", abnormalData);
        return "energy/circuit_monitor";
    }
    
    // ��ȡ��·����API
    @GetMapping("/circuit/data")
    @ResponseBody
    public List<CircuitData> getCircuitData(
            @RequestParam String substationId,
            @RequestParam String startTime,
            @RequestParam String endTime) {
        return energyService.getCircuitDataByTimeRange(substationId, startTime, endTime);
    }
    
    // ����豸����ҳ��
    @GetMapping("/pv")
    public String pvManagement(Model model) {
        Map<String, Object> pvSummary = energyService.getPvDeviceSummary();
        List<PvDevice> normalDevices = energyService.getPvDevicesByStatus("����");
        List<PvDevice> faultDevices = energyService.getPvDevicesByStatus("����");
        
        model.addAttribute("pvSummary", pvSummary);
        model.addAttribute("normalDevices", normalDevices);
        model.addAttribute("faultDevices", faultDevices);
        
        return "energy/pv_management";
    }
    
    // �����豸״̬
    @PostMapping("/pv/updateStatus")
    @ResponseBody
    public String updatePvDeviceStatus(@RequestParam String deviceId, @RequestParam String status) {
        energyService.updatePvDeviceStatus(deviceId, status);
        return "success";
    }
    
    // �ܺ���������API
    @GetMapping("/trend")
    @ResponseBody
    public Map<String, Object> getEnergyTrend(
            @RequestParam String energyType,
            @RequestParam String period) {
        return energyService.getEnergyTrend(energyType, period);
    }
}