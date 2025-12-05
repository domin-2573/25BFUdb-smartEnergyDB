package Demo.Entity;

import java.util.Date;

/**
 * 设备台账数据表
 */
public class EquipmentLedger {
    /** 台账编号 - varchar(20) PRIMARY KEY（主键）, NOT NULL（非空） */
    private String ledgerId;
    
    /** 设备名称 - varchar(50) NOT NULL（非空） */
    private String equipmentName;
    
    /** 设备类型 - varchar(10) ENUM('变压器', '水表', '逆变器')，NOT NULL（非空） */
    private String equipmentType;
    
    /** 型号规格 - varchar(50) */
    private String modelSpecification;
    
    /** 安装时间 - datetime NOT NULL（非空） */
    private Date installTime;
    
    /** 质保期（年） - int */
    private Integer warrantyPeriod;
    
    /** 维修记录 - varchar(20)（关联工单编号） */
    private String maintenanceRecord;
    
    /** 校准记录 - varchar(20) */
    private String calibrationRecord;
    
    /** 报废状态 - varchar(10) ENUM('正常使用', '已报废') */
    private String scrapStatus;
    
    // getters and setters
    public String getLedgerId() { return ledgerId; }
    public void setLedgerId(String ledgerId) { this.ledgerId = ledgerId; }
    
    public String getEquipmentName() { return equipmentName; }
    public void setEquipmentName(String equipmentName) { this.equipmentName = equipmentName; }
    
    public String getEquipmentType() { return equipmentType; }
    public void setEquipmentType(String equipmentType) { this.equipmentType = equipmentType; }
    
    public String getModelSpecification() { return modelSpecification; }
    public void setModelSpecification(String modelSpecification) { this.modelSpecification = modelSpecification; }
    
    public Date getInstallTime() { return installTime; }
    public void setInstallTime(Date installTime) { this.installTime = installTime; }
    
    public Integer getWarrantyPeriod() { return warrantyPeriod; }
    public void setWarrantyPeriod(Integer warrantyPeriod) { this.warrantyPeriod = warrantyPeriod; }
    
    public String getMaintenanceRecord() { return maintenanceRecord; }
    public void setMaintenanceRecord(String maintenanceRecord) { this.maintenanceRecord = maintenanceRecord; }
    
    public String getCalibrationRecord() { return calibrationRecord; }
    public void setCalibrationRecord(String calibrationRecord) { this.calibrationRecord = calibrationRecord; }
    
    public String getScrapStatus() { return scrapStatus; }
    public void setScrapStatus(String scrapStatus) { this.scrapStatus = scrapStatus; }
}

