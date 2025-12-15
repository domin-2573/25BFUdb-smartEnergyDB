package Demo.Controller;

import Demo.Entity.MaintenanceWorkOrder;
import Demo.Entity.EquipmentLedger;
import Demo.Service.IMaintenanceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

/**
 * 告警运维管理控制器
 */
@Controller
@RequestMapping("/maintenance")
public class MaintenanceController {
    
    @Autowired
    private IMaintenanceService maintenanceService;
    
    // ========== 运维工单管理 ==========
    
    /**
     * 运维工单列表页面
     */
    @GetMapping("/workorder/list")
    public String workOrderList(
            @RequestParam(required = false) String personId,
            @RequestParam(required = false) String status,
            Model model) {
        List<MaintenanceWorkOrder> workOrderList;
        if (personId != null) {
            workOrderList = maintenanceService.getMaintenanceWorkOrdersByPersonId(personId);
        } else if (status != null) {
            workOrderList = maintenanceService.getMaintenanceWorkOrdersByReviewStatus(status);
        } else {
            workOrderList = maintenanceService.getMaintenanceWorkOrdersByReviewStatus("未通过");
        }
        model.addAttribute("workOrderList", workOrderList);
        return "maintenance/workorder_list";
    }
    
    /**
     * 获取配电房运维效率统计
     */
    @GetMapping("/efficiency")
    @ResponseBody
    public List<Map<String, Object>> getSubstationMaintenanceEfficiency(
            @RequestParam String startTime,
            @RequestParam String endTime) {
        return maintenanceService.getSubstationMaintenanceEfficiency(startTime, endTime);
    }
    
    /**
     * 更新运维工单
     */
    @PostMapping("/workorder/update")
    @ResponseBody
    public String updateMaintenanceWorkOrder(@RequestBody MaintenanceWorkOrder workOrder) {
        int result = maintenanceService.updateMaintenanceWorkOrder(workOrder);
        return result > 0 ? "success" : "failed";
    }
    
    // ========== 设备台账管理 ==========
    
    /**
     * 设备台账列表页面
     */
    @GetMapping("/ledger/list")
    public String equipmentLedgerList(
            @RequestParam(required = false) String equipmentType,
            Model model) {
        List<EquipmentLedger> ledgerList;
        if (equipmentType != null) {
            ledgerList = maintenanceService.getEquipmentLedgersByType(equipmentType);
        } else {
            ledgerList = maintenanceService.getEquipmentLedgersExpiringWarranty();
        }
        model.addAttribute("ledgerList", ledgerList);
        return "maintenance/ledger_list";
    }
    
    /**
     * 获取质保即将到期的设备
     */
    @GetMapping("/ledger/expiringWarranty")
    @ResponseBody
    public List<EquipmentLedger> getEquipmentLedgersExpiringWarranty() {
        return maintenanceService.getEquipmentLedgersExpiringWarranty();
    }
    
    /**
     * 更新设备台账
     */
    @PostMapping("/ledger/update")
    @ResponseBody
    public String updateEquipmentLedger(@RequestBody EquipmentLedger ledger) {
        int result = maintenanceService.updateEquipmentLedger(ledger);
        return result > 0 ? "success" : "failed";
    }
}

