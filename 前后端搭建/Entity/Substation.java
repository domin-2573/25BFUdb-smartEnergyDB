package Demo.Entity;

import java.util.Date;

/**
 * 配电房信息表
 * 参考国标：《DL/T 1406-2015 配电自动化技术导则》
 */
public class Substation {
    /** 配电房编号 - VARCHAR(15) 主键、唯一，按《DL/T 1406-2015 配电自动化技术导则》编码，如 "PD-35kV-001" */
    private String substationId;
    
    /** 名称 - VARCHAR(20) 非空，示例："总配电房""分配电房 1" */
    private String name;
    
    /** 位置描述 - VARCHAR(50) 非空，具体地址 + 区域，如 "XX 园区 A 栋地下 1 层" */
    private String location;
    
    /** 电压等级 - VARCHAR(10) 非空，符合《GB/T 156-2017 标准电压》："35kV/0.4kV""10kV/0.4kV" */
    private String voltageLevel;
    
    /** 变压器数量 - TINYINT 非空、≥1，一般 1-5 台（配电房常见配置） */
    private Integer transformerCount;
    
    /** 投运时间 - DATE 非空，格式：YYYY-MM-DD */
    private Date operationTime;
    
    /** 负责人 ID - VARCHAR(20) 非空，关联人员管理系统 ID */
    private String managerId;
    
    /** 联系方式 - VARCHAR(20) 非空，手机号（11 位）或固定电话 */
    private String contact;
    
    // getters and setters
    public String getSubstationId() { return substationId; }
    public void setSubstationId(String substationId) { this.substationId = substationId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    
    public String getVoltageLevel() { return voltageLevel; }
    public void setVoltageLevel(String voltageLevel) { this.voltageLevel = voltageLevel; }
    
    public Integer getTransformerCount() { return transformerCount; }
    public void setTransformerCount(Integer transformerCount) { this.transformerCount = transformerCount; }
    
    public Date getOperationTime() { return operationTime; }
    public void setOperationTime(Date operationTime) { this.operationTime = operationTime; }
    
    public String getManagerId() { return managerId; }
    public void setManagerId(String managerId) { this.managerId = managerId; }
    
    public String getContact() { return contact; }
    public void setContact(String contact) { this.contact = contact; }
}