package Demo.Service;

import Demo.Dao.AlarmDao;
import Demo.Dao.MaintenanceWorkOrderDao;
import Demo.Dao.UserDao;
import Demo.Entity.Alarm;
import Demo.Entity.MaintenanceWorkOrder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.Map;   

/**
 * 高等级告警自动派单定时任务
 */
@Service
public class AlarmAutoDispatchService {
    @Autowired
    private AlarmDao alarmDao;
    @Autowired
    private MaintenanceWorkOrderDao maintenanceWorkOrderDao;
    @Autowired
    private UserDao userDao;

    // 每1分钟执行一次，扫描15分钟内未处理的高等级告警
    @Scheduled(cron = "0 */1 * * * ?")
    public void autoDispatchHighLevelAlarms() {
        List<Alarm> highLevelAlarms = alarmDao.getHighLevelUnhandledAlarms();
        Date now = new Date();
        long fifteenMinutes = 15 * 60 * 1000; // 15分钟毫秒数

        for (Alarm alarm : highLevelAlarms) {
            long timeDiff = now.getTime() - alarm.getOccurTime().getTime();
            // 告警超过15分钟未处理，自动派单
            if (timeDiff >= fifteenMinutes) {
                // 校验设备是否存在（双重保障）
                Map<String, Object> deviceInfo = alarmDao.getDeviceInfo(alarm.getDeviceId());
                if (deviceInfo == null || deviceInfo.isEmpty()) {
                    continue; // 设备不存在，跳过派单
                }
                // 获取任意运维人员（实际可扩展为按区域/负载分配）
                String maintenancePersonId = getAnyMaintenancePersonId();
                if (maintenancePersonId == null) {
                    continue; // 无运维人员，跳过派单
                }
                // 创建运维工单
                MaintenanceWorkOrder workOrder = new MaintenanceWorkOrder();
                workOrder.setWorkOrderId("WO-AUTO-" + UUID.randomUUID().toString().substring(0, 8));
                workOrder.setAlarmId(alarm.getAlarmId());
                workOrder.setMaintenancePersonId(maintenancePersonId);
                workOrder.setDispatchTime(now);
                workOrder.setReviewStatus("待复查");
                // 保存工单并更新告警状态
                maintenanceWorkOrderDao.insertMaintenanceWorkOrder(workOrder);
                alarmDao.updateAlarmStatus(alarm.getAlarmId(), "处理中");
            }
        }
    }

    // 辅助方法：获取任意运维人员ID（依赖UserDao实现）
    private String getAnyMaintenancePersonId() {
        try {
            // 假设UserDao存在查询运维人员的方法
            List<String> maintenancePersonIds = userDao.getMaintenancePersonIds();
            return maintenancePersonIds.isEmpty() ? null : maintenancePersonIds.get(0);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}