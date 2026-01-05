package Demo.Service;

import Demo.Dao.AlarmDao;
import Demo.Dao.MaintenanceWorkOrderDao;
import Demo.Dao.UserDao;
import Demo.Entity.Alarm;
import Demo.Entity.MaintenanceWorkOrder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;

@Service
public class AlarmScheduledService {
    // 1. 注入日志对象（解决log找不到符号）
    private static final Logger log = LoggerFactory.getLogger(AlarmScheduledService.class);

    @Autowired
    private MaintenanceWorkOrderDao workOrderDao;

    @Autowired
    private AlarmDao alarmDao;

    @Autowired
    private UserDao userDao;

    // 定时任务：每1分钟执行一次（可根据业务调整）
    @Scheduled(fixedRate = 60000)
    public void autoDispatchHighLevelAlarms() {
        try {
            // 查询高等级未处理告警
            List<Alarm> highLevelAlarms = alarmDao.getHighLevelUnhandledAlarms();
            if (highLevelAlarms.isEmpty()) {
                log.info("暂无高等级未处理告警，无需派单");
                return;
            }

            for (Alarm alarm : highLevelAlarms) {
                String alarmId = alarm.getAlarmId();
                
                // 校验该告警是否已生成工单（解决countByAlarmId找不到符号）
                int count = workOrderDao.countByAlarmId(alarmId);
                if (count > 0) {
                    log.warn("告警{}已生成运维工单，跳过重复创建", alarmId);
                    continue;
                }

                // 构建运维工单
                MaintenanceWorkOrder workOrder = new MaintenanceWorkOrder();
                // 生成唯一工单编号
                workOrder.setWorkOrderId("WO-" + UUID.randomUUID().toString().substring(0, 8));
                workOrder.setAlarmId(alarmId);
                // 获取随机运维人员ID
                workOrder.setMaintenancePersonId(userDao.getRandomMaintenancePersonId());
                // 派单时间（解决Timestamp找不到符号）
                workOrder.setDispatchTime(new Timestamp(System.currentTimeMillis()));
                workOrder.setReviewStatus("待复查");

                // 插入工单
                int insertResult = workOrderDao.insertMaintenanceWorkOrder(workOrder);
                if (insertResult > 0) {
                    log.info("为告警{}成功生成运维工单{}", alarmId, workOrder.getWorkOrderId());
                    // 可选：更新告警状态为"已派单"，避免重复查询
                    // alarmDao.updateAlarmHandleStatus(alarmId, "已派单");
                } else {
                    log.error("为告警{}生成工单失败", alarmId);
                }
            }
        } catch (Exception e) {
            log.error("高等级告警自动派单任务执行失败", e);
        }
    }
}