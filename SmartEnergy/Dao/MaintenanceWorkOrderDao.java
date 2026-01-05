package Demo.Dao;

import Demo.Entity.MaintenanceWorkOrder;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

/**
 * 运维工单数据DAO
 */
@Mapper
public interface MaintenanceWorkOrderDao {
    
    @Insert("INSERT INTO `运维工单数据表` (`工单编号`, `告警编号`, `运维人员ID`, " +
            "`派单时间`, `响应时间`, `处理完成时间`, `处理结果`, `复查状态`, `附件路径`) " +
            "VALUES (#{workOrderId}, #{alarmId}, #{maintenancePersonId}, " +
            "#{dispatchTime}, #{responseTime}, #{completionTime}, #{processResult}, #{reviewStatus}, #{attachmentPath})")
    int insertMaintenanceWorkOrder(MaintenanceWorkOrder workOrder);
    
    @Select("SELECT `工单编号` AS workOrderId, `告警编号` AS alarmId, `运维人员ID` AS maintenancePersonId, " +
            "`派单时间` AS dispatchTime, `响应时间` AS responseTime, `处理完成时间` AS completionTime, " +
            "`处理结果` AS processResult, `复查状态` AS reviewStatus, `附件路径` AS attachmentPath " +
            "FROM `运维工单数据表` WHERE `工单编号` = #{workOrderId}")
    MaintenanceWorkOrder getMaintenanceWorkOrderById(@Param("workOrderId") String workOrderId);
    
    @Select("SELECT `工单编号` AS workOrderId, `告警编号` AS alarmId, `运维人员ID` AS maintenancePersonId, " +
            "`派单时间` AS dispatchTime, `响应时间` AS responseTime, `处理完成时间` AS completionTime, " +
            "`处理结果` AS processResult, `复查状态` AS reviewStatus, `附件路径` AS attachmentPath " +
            "FROM `运维工单数据表` WHERE `告警编号` = #{alarmId}")
    List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByAlarmId(@Param("alarmId") String alarmId);
    
    @Select("SELECT `工单编号` AS workOrderId, `告警编号` AS alarmId, `运维人员ID` AS maintenancePersonId, " +
            "`派单时间` AS dispatchTime, `响应时间` AS responseTime, `处理完成时间` AS completionTime, " +
            "`处理结果` AS processResult, `复查状态` AS reviewStatus, `附件路径` AS attachmentPath " +
            "FROM `运维工单数据表` WHERE `运维人员ID` = #{personId} " +
            "AND `复查状态` != '通过' ORDER BY `派单时间` DESC")
    List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByPersonId(@Param("personId") String personId);
    
    @Select("SELECT `工单编号` AS workOrderId, `告警编号` AS alarmId, `运维人员ID` AS maintenancePersonId, " +
            "`派单时间` AS dispatchTime, `响应时间` AS responseTime, `处理完成时间` AS completionTime, " +
            "`处理结果` AS processResult, `复查状态` AS reviewStatus, `附件路径` AS attachmentPath " +
            "FROM `运维工单数据表` WHERE `复查状态` = #{status} " +
            "ORDER BY `派单时间` DESC")
    List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByReviewStatus(@Param("status") String status);
    
    @Select("SELECT s.`配电房编号`, s.`名称` as substation_name, " +
            "AVG(TIMESTAMPDIFF(MINUTE, wo.`派单时间`, wo.`处理完成时间`)) as avg_process_time, " +
            "COUNT(*) as work_order_count " +
            "FROM `运维工单数据表` wo " +
            "JOIN `告警信息表` a ON wo.`告警编号` = a.`告警编号` " +
            "JOIN `回路监测数据表` cd ON a.`关联设备编号` = cd.`数据编号` " +
            "JOIN `配电房信息表` s ON cd.`配电房编号` = s.`配电房编号` " +
            "WHERE wo.`处理完成时间` IS NOT NULL " +
            "AND wo.`派单时间` BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY s.`配电房编号`, s.`名称`")
    List<Map<String, Object>> getSubstationMaintenanceEfficiency(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Update("UPDATE `运维工单数据表` SET `响应时间` = #{responseTime}, " +
            "`处理完成时间` = #{completionTime}, `处理结果` = #{processResult}, " +
            "`复查状态` = #{reviewStatus}, `附件路径` = #{attachmentPath} " +
            "WHERE `工单编号` = #{workOrderId}")
    int updateMaintenanceWorkOrder(MaintenanceWorkOrder workOrder);
    
 // 新增：根据告警编号查询工单数量（注解方式，无需XML）
    @Select("SELECT COUNT(1) FROM `运维工单数据表` WHERE `告警编号` = #{alarmId}")
    int countByAlarmId(@Param("alarmId") String alarmId);

}

