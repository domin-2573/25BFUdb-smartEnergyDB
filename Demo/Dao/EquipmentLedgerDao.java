package Demo.Dao;

import Demo.Entity.EquipmentLedger;
import org.apache.ibatis.annotations.*;
import java.util.List;

/**
 * 设备台账数据DAO
 */
@Mapper
public interface EquipmentLedgerDao {
    
    @Insert("INSERT INTO equipment_ledger (ledger_id, equipment_name, equipment_type, " +
            "model_specification, install_time, warranty_period, maintenance_record, " +
            "calibration_record, scrap_status) " +
            "VALUES (#{ledgerId}, #{equipmentName}, #{equipmentType}, " +
            "#{modelSpecification}, #{installTime}, #{warrantyPeriod}, #{maintenanceRecord}, " +
            "#{calibrationRecord}, #{scrapStatus})")
    int insertEquipmentLedger(EquipmentLedger ledger);
    
    @Select("SELECT * FROM equipment_ledger WHERE ledger_id = #{ledgerId}")
    EquipmentLedger getEquipmentLedgerById(@Param("ledgerId") String ledgerId);
    
    @Select("SELECT * FROM equipment_ledger WHERE equipment_type = #{equipmentType}")
    List<EquipmentLedger> getEquipmentLedgersByType(@Param("equipmentType") String equipmentType);
    
    @Select("SELECT * FROM equipment_ledger WHERE scrap_status = #{status}")
    List<EquipmentLedger> getEquipmentLedgersByScrapStatus(@Param("status") String status);
    
    @Select("SELECT * FROM equipment_ledger WHERE maintenance_record LIKE CONCAT('%', #{workOrderId}, '%')")
    List<EquipmentLedger> getEquipmentLedgersByMaintenanceRecord(@Param("workOrderId") String workOrderId);
    
    @Select("SELECT * FROM equipment_ledger WHERE scrap_status = '正常使用' " +
            "AND DATE_ADD(install_time, INTERVAL warranty_period YEAR) BETWEEN CURDATE() " +
            "AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)")
    List<EquipmentLedger> getEquipmentLedgersExpiringWarranty();
    
    @Select("SELECT * FROM equipment_ledger ORDER BY install_time DESC")
    List<EquipmentLedger> getAllEquipmentLedgers();
    
    @Update("UPDATE equipment_ledger SET equipment_name = #{equipmentName}, " +
            "equipment_type = #{equipmentType}, model_specification = #{modelSpecification}, " +
            "install_time = #{installTime}, warranty_period = #{warrantyPeriod}, " +
            "maintenance_record = #{maintenanceRecord}, calibration_record = #{calibrationRecord}, " +
            "scrap_status = #{scrapStatus} WHERE ledger_id = #{ledgerId}")
    int updateEquipmentLedger(EquipmentLedger ledger);
    
    @Delete("DELETE FROM equipment_ledger WHERE ledger_id = #{ledgerId}")
    int deleteEquipmentLedger(@Param("ledgerId") String ledgerId);
}

