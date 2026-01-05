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
    
    // 新增：注入用户服务（用于查询运维人员）
    @Autowired
    private IUserService userService;
    
    // ========== 原有运维工单管理方法（保持不变） ==========
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
    
    // ========== 原有设备台账管理方法（保持不变） ==========
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
    
    // ========== 新增：高等级告警派单相关方法 ==========
    /**
     * 高等级告警页面（携带运维人员列表）
     */
    @GetMapping("/highLevelDispatch")
    public String highLevelDispatchPage(Model model) {
        List<User> maintenanceUsers = userService.getUsersByRole("运维人员"); // 查询所有运维人员
        List<MaintenanceWorkOrder> workOrderList = maintenanceService.getMaintenanceWorkOrdersByReviewStatus("未通过");
        model.addAttribute("maintenanceUsers", maintenanceUsers);
        model.addAttribute("workOrderList", workOrderList); // 保留原有工单列表数据
        return "alarm/high_level_alarms";
    }
    
    /**
     * 手动派单接口
     */
    @PostMapping("/dispatch")
    @ResponseBody
    public Map<String, Object> manualDispatch(@RequestParam String alarmId, 
                                             @RequestParam String maintenancePersonId) {
        return maintenanceService.manualDispatchHighLevelAlarm(alarmId, maintenancePersonId);
    }
}