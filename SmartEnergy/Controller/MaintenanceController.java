package Demo.Controller;

import Demo.Entity.MaintenanceWorkOrder;
import Demo.Entity.EquipmentLedger;
import Demo.Service.IMaintenanceService;
import Demo.Service.IUserService;
import Demo.Entity.User;
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
    
    @Autowired
    private IUserService userService;
    
    // ========== 首页设备台账统计API ==========
    @GetMapping("/equipment/stats")
    @ResponseBody
    public Map<String, Object> getEquipmentStatistics() {
        return maintenanceService.getEquipmentStatistics();
    }
    
    // ========== 设备台账列表页面 ==========
    @GetMapping("/equipment/list")
    public String equipmentListPage(Model model) {
        List<EquipmentLedger> ledgerList = maintenanceService.getAllEquipmentLedgers();
        Map<String, Object> stats = maintenanceService.getEquipmentStatistics();
        
        model.addAttribute("ledgerList", ledgerList);
        model.addAttribute("stats", stats);
        return "maintenance/equipment_list";
    }
    
    // ========== 原有运维工单管理方法 ==========
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
    
    @GetMapping("/efficiency")
    @ResponseBody
    public List<Map<String, Object>> getSubstationMaintenanceEfficiency(
            @RequestParam String startTime,
            @RequestParam String endTime) {
        return maintenanceService.getSubstationMaintenanceEfficiency(startTime, endTime);
    }
    
    @PostMapping("/workorder/update")
    @ResponseBody
    public String updateMaintenanceWorkOrder(@RequestBody MaintenanceWorkOrder workOrder) {
        int result = maintenanceService.updateMaintenanceWorkOrder(workOrder);
        return result > 0 ? "success" : "failed";
    }
    
    // ========== 原有设备台账管理方法（如果需要保留） ==========
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
    
    @GetMapping("/ledger/expiringWarranty")
    @ResponseBody
    public List<EquipmentLedger> getEquipmentLedgersExpiringWarranty() {
        return maintenanceService.getEquipmentLedgersExpiringWarranty();
    }
    
    @PostMapping("/ledger/update")
    @ResponseBody
    public String updateEquipmentLedger(@RequestBody EquipmentLedger ledger) {
        int result = maintenanceService.updateEquipmentLedger(ledger);
        return result > 0 ? "success" : "failed";
    }
    
    // ========== 高等级告警派单相关方法 ==========
    @GetMapping("/highLevelDispatch")
    public String highLevelDispatchPage(Model model) {
        List<User> maintenanceUsers = userService.getUsersByRole("运维人员");
        List<MaintenanceWorkOrder> workOrderList = maintenanceService.getMaintenanceWorkOrdersByReviewStatus("未通过");
        model.addAttribute("maintenanceUsers", maintenanceUsers);
        model.addAttribute("workOrderList", workOrderList);
        return "alarm/high_level_alarms";
    }
    
    @PostMapping("/dispatch")
    @ResponseBody
    public Map<String, Object> manualDispatch(@RequestParam String alarmId, 
                                             @RequestParam String maintenancePersonId) {
        return maintenanceService.manualDispatchHighLevelAlarm(alarmId, maintenancePersonId);
    }
}