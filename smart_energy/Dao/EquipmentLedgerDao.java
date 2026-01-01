package Demo.Dao;

import Demo.Entity.EquipmentLedger;
import org.apache.ibatis.annotations.*;
import java.util.List;

/**
 * 设备台账数据DAO
 */
@Mapper
public interface EquipmentLedgerDao {
    
    @Insert("INSERT INTO `设备台账数据` (`台账编号`, `设备名称`, `设备类型`, " +
            "`型号规格`, `安装时间`, `质保期年`, `维修记录`, " +
            "`校准记录`, `报废状态`) " +
            "VALUES (#{ledgerId}, #{equipmentName}, #{equipmentType}, " +
            "#{modelSpecification}, #{installTime}, #{warrantyPeriod}, #{maintenanceRecord}, " +
            "#{calibrationRecord}, #{scrapStatus})")
    int insertEquipmentLedger(EquipmentLedger ledger);
    
    @Select("SELECT `台账编号` AS ledgerId, `设备名称` AS equipmentName, `设备类型` AS equipmentType, " +
            "`型号规格` AS modelSpecification, `安装时间` AS installTime, `质保期年` AS warrantyPeriod, " +
            "`维修记录` AS maintenanceRecord, `校准记录` AS calibrationRecord, `报废状态` AS scrapStatus " +
            "FROM `设备台账数据` WHERE `台账编号` = #{ledgerId}")
    EquipmentLedger getEquipmentLedgerById(@Param("ledgerId") String ledgerId);
    
    @Select("SELECT `台账编号` AS ledgerId, `设备名称` AS equipmentName, `设备类型` AS equipmentType, " +
            "`型号规格` AS modelSpecification, `安装时间` AS installTime, `质保期年` AS warrantyPeriod, " +
            "`维修记录` AS maintenanceRecord, `校准记录` AS calibrationRecord, `报废状态` AS scrapStatus " +
            "FROM `设备台账数据` WHERE `设备类型` = #{equipmentType}")
    List<EquipmentLedger> getEquipmentLedgersByType(@Param("equipmentType") String equipmentType);
    
    @Select("SELECT `台账编号` AS ledgerId, `设备名称` AS equipmentName, `设备类型` AS equipmentType, " +
            "`型号规格` AS modelSpecification, `安装时间` AS installTime, `质保期年` AS warrantyPeriod, " +
            "`维修记录` AS maintenanceRecord, `校准记录` AS calibrationRecord, `报废状态` AS scrapStatus " +
            "FROM `设备台账数据` WHERE `报废状态` = #{status}")
    List<EquipmentLedger> getEquipmentLedgersByScrapStatus(@Param("status") String status);
    
    @Select("SELECT `台账编号` AS ledgerId, `设备名称` AS equipmentName, `设备类型` AS equipmentType, " +
            "`型号规格` AS modelSpecification, `安装时间` AS installTime, `质保期年` AS warrantyPeriod, " +
            "`维修记录` AS maintenanceRecord, `校准记录` AS calibrationRecord, `报废状态` AS scrapStatus " +
            "FROM `设备台账数据` WHERE `维修记录` LIKE CONCAT('%', #{workOrderId}, '%')")
    List<EquipmentLedger> getEquipmentLedgersByMaintenanceRecord(@Param("workOrderId") String workOrderId);
    
    @Select("SELECT `台账编号` AS ledgerId, `设备名称` AS equipmentName, `设备类型` AS equipmentType, " +
            "`型号规格` AS modelSpecification, `安装时间` AS installTime, `质保期年` AS warrantyPeriod, " +
            "`维修记录` AS maintenanceRecord, `校准记录` AS calibrationRecord, `报废状态` AS scrapStatus " +
            "FROM `设备台账数据` WHERE `报废状态` = '正常使用' " +
            "AND DATE_ADD(`安装时间`, INTERVAL `质保期年` YEAR) BETWEEN CURDATE() " +
            "AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)")
    List<EquipmentLedger> getEquipmentLedgersExpiringWarranty();
    
    @Select("SELECT `台账编号` AS ledgerId, `设备名称` AS equipmentName, `设备类型` AS equipmentType, " +
            "`型号规格` AS modelSpecification, `安装时间` AS installTime, `质保期年` AS warrantyPeriod, " +
            "`维修记录` AS maintenanceRecord, `校准记录` AS calibrationRecord, `报废状态` AS scrapStatus " +
            "FROM `设备台账数据` ORDER BY `安装时间` DESC")
    List<EquipmentLedger> getAllEquipmentLedgers();
    
    @Update("UPDATE `设备台账数据` SET `设备名称` = #{equipmentName}, " +
            "`设备类型` = #{equipmentType}, `型号规格` = #{modelSpecification}, " +
            "`安装时间` = #{installTime}, `质保期年` = #{warrantyPeriod}, " +
            "`维修记录` = #{maintenanceRecord}, `校准记录` = #{calibrationRecord}, " +
            "`报废状态` = #{scrapStatus} WHERE `台账编号` = #{ledgerId}")
    int updateEquipmentLedger(EquipmentLedger ledger);
    
    @Delete("DELETE FROM `设备台账数据` WHERE `台账编号` = #{ledgerId}")
    int deleteEquipmentLedger(@Param("ledgerId") String ledgerId);
}

