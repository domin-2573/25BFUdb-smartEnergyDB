package Demo.Service;

import Demo.Entity.MaintenanceWorkOrder;
import Demo.Entity.EquipmentLedger;
import java.util.List;
import java.util.Map;

/**
 * 告警运维管理服务接口
 */
public interface IMaintenanceService {
    
    // 运维工单管理
    int insertMaintenanceWorkOrder(MaintenanceWorkOrder workOrder);
    MaintenanceWorkOrder getMaintenanceWorkOrderById(String workOrderId);
    List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByAlarmId(String alarmId);
    List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByPersonId(String personId);
    List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByReviewStatus(String status);
    List<Map<String, Object>> getSubstationMaintenanceEfficiency(String startTime, String endTime);
    int updateMaintenanceWorkOrder(MaintenanceWorkOrder workOrder);
    
    // 设备台账管理
    int insertEquipmentLedger(EquipmentLedger ledger);
    EquipmentLedger getEquipmentLedgerById(String ledgerId);
    List<EquipmentLedger> getEquipmentLedgersByType(String equipmentType);
    List<EquipmentLedger> getEquipmentLedgersByScrapStatus(String status);
    List<EquipmentLedger> getEquipmentLedgersByMaintenanceRecord(String workOrderId);
    List<EquipmentLedger> getEquipmentLedgersExpiringWarranty();
    int updateEquipmentLedger(EquipmentLedger ledger);
    int deleteEquipmentLedger(String ledgerId);
}

