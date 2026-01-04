package Demo.Service;

import Demo.Dao.MaintenanceWorkOrderDao;
import Demo.Dao.EquipmentLedgerDao;
import Demo.Entity.MaintenanceWorkOrder;
import Demo.Entity.EquipmentLedger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

/**
 * 告警运维管理服务实现
 */
@Service
public class MaintenanceServiceImpl implements IMaintenanceService {
    
    @Autowired
    private MaintenanceWorkOrderDao maintenanceWorkOrderDao;
    
    @Autowired
    private EquipmentLedgerDao equipmentLedgerDao;
    
    // 运维工单管理
    @Override
    public int insertMaintenanceWorkOrder(MaintenanceWorkOrder workOrder) {
        return maintenanceWorkOrderDao.insertMaintenanceWorkOrder(workOrder);
    }
    
    @Override
    public MaintenanceWorkOrder getMaintenanceWorkOrderById(String workOrderId) {
        return maintenanceWorkOrderDao.getMaintenanceWorkOrderById(workOrderId);
    }
    
    @Override
    public List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByAlarmId(String alarmId) {
        return maintenanceWorkOrderDao.getMaintenanceWorkOrdersByAlarmId(alarmId);
    }
    
    @Override
    public List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByPersonId(String personId) {
        return maintenanceWorkOrderDao.getMaintenanceWorkOrdersByPersonId(personId);
    }
    
    @Override
    public List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByReviewStatus(String status) {
        return maintenanceWorkOrderDao.getMaintenanceWorkOrdersByReviewStatus(status);
    }
    
    @Override
    public List<Map<String, Object>> getSubstationMaintenanceEfficiency(String startTime, String endTime) {
        return maintenanceWorkOrderDao.getSubstationMaintenanceEfficiency(startTime, endTime);
    }
    
    @Override
    public int updateMaintenanceWorkOrder(MaintenanceWorkOrder workOrder) {
        return maintenanceWorkOrderDao.updateMaintenanceWorkOrder(workOrder);
    }
    
    // 设备台账管理
    @Override
    public int insertEquipmentLedger(EquipmentLedger ledger) {
        return equipmentLedgerDao.insertEquipmentLedger(ledger);
    }
    
    @Override
    public EquipmentLedger getEquipmentLedgerById(String ledgerId) {
        return equipmentLedgerDao.getEquipmentLedgerById(ledgerId);
    }
    
    @Override
    public List<EquipmentLedger> getEquipmentLedgersByType(String equipmentType) {
        return equipmentLedgerDao.getEquipmentLedgersByType(equipmentType);
    }
    
    @Override
    public List<EquipmentLedger> getEquipmentLedgersByScrapStatus(String status) {
        return equipmentLedgerDao.getEquipmentLedgersByScrapStatus(status);
    }
    
    @Override
    public List<EquipmentLedger> getEquipmentLedgersByMaintenanceRecord(String workOrderId) {
        return equipmentLedgerDao.getEquipmentLedgersByMaintenanceRecord(workOrderId);
    }
    
    @Override
    public List<EquipmentLedger> getEquipmentLedgersExpiringWarranty() {
        return equipmentLedgerDao.getEquipmentLedgersExpiringWarranty();
    }
    
    @Override
    public int updateEquipmentLedger(EquipmentLedger ledger) {
        return equipmentLedgerDao.updateEquipmentLedger(ledger);
    }
    
    @Override
    public int deleteEquipmentLedger(String ledgerId) {
        return equipmentLedgerDao.deleteEquipmentLedger(ledgerId);
    }
}

