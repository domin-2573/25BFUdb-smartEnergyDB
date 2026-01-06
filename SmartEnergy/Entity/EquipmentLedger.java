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
    
    /** 设备类型 - varchar(20) NOT NULL（非空） */
    private String equipmentType;
    
    /** 型号规格 - varchar(50) */
    private String modelSpecification;
    
    /** 安装时间 - datetime NOT NULL（非空） */
    private Date installTime;
    
    /** 质保期_年 - int */
    private Integer warrantyPeriodYears;
    
    /** 维修记录 - varchar(20) */
    private String maintenanceRecord;
    
    /** 校准记录 - varchar(50) */
    private String calibrationRecord;
    
    /** 报废状态 - varchar(10) */
    private String scrapStatus;
    
    /** 创建时间 - datetime */
    private Date createTime;
    
    /** 更新时间 - datetime */
    private Date updateTime;
    
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
    
    public Integer getWarrantyPeriodYears() { return warrantyPeriodYears; }
    public void setWarrantyPeriodYears(Integer warrantyPeriodYears) { this.warrantyPeriodYears = warrantyPeriodYears; }
    
    public String getMaintenanceRecord() { return maintenanceRecord; }
    public void setMaintenanceRecord(String maintenanceRecord) { this.maintenanceRecord = maintenanceRecord; }
    
    public String getCalibrationRecord() { return calibrationRecord; }
    public void setCalibrationRecord(String calibrationRecord) { this.calibrationRecord = calibrationRecord; }
    
    public String getScrapStatus() { return scrapStatus; }
    public void setScrapStatus(String scrapStatus) { this.scrapStatus = scrapStatus; }
    
    public Date getCreateTime() { return createTime; }
    public void setCreateTime(Date createTime) { this.createTime = createTime; }
    
    public Date getUpdateTime() { return updateTime; }
    public void setUpdateTime(Date updateTime) { this.updateTime = updateTime; }
}