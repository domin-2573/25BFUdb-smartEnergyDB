package Demo.Service;

import Demo.Dao.MaintenanceWorkOrderDao;
import Demo.Dao.EquipmentLedgerDao;
import Demo.Entity.MaintenanceWorkOrder;
import Demo.Entity.EquipmentLedger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;
import Demo.Dao.AlarmDao;  // 添加这行
import Demo.Entity.Alarm;   // 添加这行
import java.util.*;        // 添加这行，导入Map、HashMap、Date等
import java.util.UUID;     // 或者单独导入UUID

/**
 * 告警运维管理服务实现
 */
@Service
public class MaintenanceServiceImpl implements IMaintenanceService {
    
    @Autowired
    private MaintenanceWorkOrderDao maintenanceWorkOrderDao;
    
    @Autowired
    private EquipmentLedgerDao equipmentLedgerDao;
    
 // 新增：注入告警DAO和设备台账DAO（用于校验和状态更新）
    @Autowired
    private AlarmDao alarmDao;
    
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
    
 // ========== 新增：实现高等级告警手动派单方法 ==========
    @Override
    public Map<String, Object> manualDispatchHighLevelAlarm(String alarmId, String maintenancePersonId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 1. 校验告警是否为高等级且未处理
            Alarm alarm = getAlarmById(alarmId);
            if (alarm == null) {
                result.put("success", false);
                result.put("message", "告警不存在：" + alarmId);
                return result;
            }
            if (!"高".equals(alarm.getAlarmLevel())) {
                result.put("success", false);
                result.put("message", "仅支持高等级告警派单");
                return result;
            }
            if (!"未处理".equals(alarm.getHandleStatus())) {
                result.put("success", false);
                result.put("message", "该告警已处理或处理中，无需重复派单");
                return result;
            }
            
            // 2. 校验关联设备是否存在（确保告警关联具体设备）
            Map<String, Object> deviceInfo = alarmDao.getDeviceInfo(alarm.getDeviceId());
            if (deviceInfo == null || deviceInfo.isEmpty()) {
                result.put("success", false);
                result.put("message", "告警关联的设备不存在：" + alarm.getDeviceId());
                return result;
            }
            
            // 3. 创建运维工单
            MaintenanceWorkOrder workOrder = new MaintenanceWorkOrder();
            workOrder.setWorkOrderId("WO-" + UUID.randomUUID().toString().substring(0, 10));
            workOrder.setAlarmId(alarmId);
            workOrder.setMaintenancePersonId(maintenancePersonId);
            workOrder.setDispatchTime(new Date());
            workOrder.setReviewStatus("待复查");
            maintenanceWorkOrderDao.insertMaintenanceWorkOrder(workOrder);
            
            // 4. 更新告警状态为「处理中」
            alarmDao.updateAlarmStatus(alarmId, "处理中");
            
            result.put("success", true);
            result.put("workOrderId", workOrder.getWorkOrderId());
            result.put("message", "派单成功");
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "派单失败：" + e.getMessage());
        }
        return result;
    }
    
    // 新增：辅助方法 - 根据告警ID查询告警详情
    private Alarm getAlarmById(String alarmId) {
        try {
            // 复用AlarmDao现有查询逻辑，拼接查询条件
            List<Alarm> alarms = alarmDao.getAlarmsByStatus("未处理");
            for (Alarm alarm : alarms) {
                if (alarmId.equals(alarm.getAlarmId())) {
                    return alarm;
                }
            }
            // 检查处理中状态的告警
            List<Alarm> handlingAlarms = alarmDao.getAlarmsByStatus("处理中");
            for (Alarm alarm : handlingAlarms) {
                if (alarmId.equals(alarm.getAlarmId())) {
                    return alarm;
                }
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
 // 新增：获取所有设备台账
    @Override
    public List<EquipmentLedger> getAllEquipmentLedgers() {
        return equipmentLedgerDao.getAllEquipmentLedgers();
    }
    
    // 新增：设备台账统计
    @Override
    public Map<String, Object> getEquipmentStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalCount", equipmentLedgerDao.getEquipmentCount());
        stats.put("scrappedCount", equipmentLedgerDao.getScrappedEquipmentCount());
        stats.put("expiringWarrantyCount", equipmentLedgerDao.getExpiringWarrantyCount());
        stats.put("normalCount", equipmentLedgerDao.getEquipmentCount() - equipmentLedgerDao.getScrappedEquipmentCount());
        return stats;
    }
}

