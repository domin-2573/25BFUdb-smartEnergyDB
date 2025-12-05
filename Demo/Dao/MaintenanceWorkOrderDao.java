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
    
    @Insert("INSERT INTO maintenance_work_order (work_order_id, alarm_id, maintenance_person_id, " +
            "dispatch_time, response_time, completion_time, process_result, review_status, attachment_path) " +
            "VALUES (#{workOrderId}, #{alarmId}, #{maintenancePersonId}, " +
            "#{dispatchTime}, #{responseTime}, #{completionTime}, #{processResult}, #{reviewStatus}, #{attachmentPath})")
    int insertMaintenanceWorkOrder(MaintenanceWorkOrder workOrder);
    
    @Select("SELECT * FROM maintenance_work_order WHERE work_order_id = #{workOrderId}")
    MaintenanceWorkOrder getMaintenanceWorkOrderById(@Param("workOrderId") String workOrderId);
    
    @Select("SELECT * FROM maintenance_work_order WHERE alarm_id = #{alarmId}")
    List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByAlarmId(@Param("alarmId") String alarmId);
    
    @Select("SELECT * FROM maintenance_work_order WHERE maintenance_person_id = #{personId} " +
            "AND review_status != '通过' ORDER BY dispatch_time DESC")
    List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByPersonId(@Param("personId") String personId);
    
    @Select("SELECT * FROM maintenance_work_order WHERE review_status = #{status} " +
            "ORDER BY dispatch_time DESC")
    List<MaintenanceWorkOrder> getMaintenanceWorkOrdersByReviewStatus(@Param("status") String status);
    
    @Select("SELECT s.substation_id, s.name as substation_name, " +
            "AVG(TIMESTAMPDIFF(MINUTE, wo.dispatch_time, wo.completion_time)) as avg_process_time, " +
            "COUNT(*) as work_order_count " +
            "FROM maintenance_work_order wo " +
            "JOIN alarm a ON wo.alarm_id = a.alarm_id " +
            "JOIN circuit_data cd ON a.device_id = cd.data_id " +
            "JOIN substation s ON cd.substation_id = s.substation_id " +
            "WHERE wo.completion_time IS NOT NULL " +
            "AND wo.dispatch_time BETWEEN #{startTime} AND #{endTime} " +
            "GROUP BY s.substation_id, s.name")
    List<Map<String, Object>> getSubstationMaintenanceEfficiency(
            @Param("startTime") String startTime,
            @Param("endTime") String endTime);
    
    @Update("UPDATE maintenance_work_order SET response_time = #{responseTime}, " +
            "completion_time = #{completionTime}, process_result = #{processResult}, " +
            "review_status = #{reviewStatus}, attachment_path = #{attachmentPath} " +
            "WHERE work_order_id = #{workOrderId}")
    int updateMaintenanceWorkOrder(MaintenanceWorkOrder workOrder);
}

