package Demo.Entity;

import java.util.Date;

/**
 * 光伏设备信息表
 */
public class PvDevice {
    /** 设备编号 - VARCHAR(20) 主键（如 SD-PV-001），非空 */
    private String deviceId;
    
    /** 设备类型 - VARCHAR(50) 非空 */
    private String deviceType;
    
    /** 安装位置 - VARCHAR(50) 非空（如屋顶区域编号 / 园区片区） */
    private String installLocation;
    
    /** 装机容量 - VARCHAR(50) 非空 */
    private String capacity;
    
    /** 投运时间 - DATE 非空 */
    private Date operationTime;
    
    /** 校准周期 - INT 非空 */
    private Integer calibrationCycle;
    
    /** 运行状态 - VARCHAR(10) 非空（正常 / 故障 / 离线） */
    private String operationStatus;
    
    /** 通信协议 - VARCHAR(20) 非空（RS485/Lora/ 以太网） */
    private String communicationProtocol;
    
    // getters and setters
    public String getDeviceId() { return deviceId; }
    public void setDeviceId(String deviceId) { this.deviceId = deviceId; }
    
    public String getDeviceType() { return deviceType; }
    public void setDeviceType(String deviceType) { this.deviceType = deviceType; }
    
    public String getInstallLocation() { return installLocation; }
    public void setInstallLocation(String installLocation) { this.installLocation = installLocation; }
    
    public String getCapacity() { return capacity; }
    public void setCapacity(String capacity) { this.capacity = capacity; }
    
    public Date getOperationTime() { return operationTime; }
    public void setOperationTime(Date operationTime) { this.operationTime = operationTime; }
    
    public Integer getCalibrationCycle() { return calibrationCycle; }
    public void setCalibrationCycle(Integer calibrationCycle) { this.calibrationCycle = calibrationCycle; }
    
    public String getOperationStatus() { return operationStatus; }
    public void setOperationStatus(String operationStatus) { this.operationStatus = operationStatus; }
    
    public String getCommunicationProtocol() { return communicationProtocol; }
    public void setCommunicationProtocol(String communicationProtocol) { this.communicationProtocol = communicationProtocol; }
}