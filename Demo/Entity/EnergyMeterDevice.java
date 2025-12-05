package Demo.Entity;

/**
 * 能耗计量设备信息表
 */
public class EnergyMeterDevice {
    /** 设备编号 - VARCHAR(20) 主键（PK）、唯一，唯一标识计量设备 */
    private String deviceId;
    
    /** 能源类型 - VARCHAR(10) 非空、枚举（水 / 蒸汽 / 天然气），区分计量的能源种类 */
    private String energyType;
    
    /** 安装位置 - VARCHAR(50) 非空，精确到具体区域（如 VOCS 下面 / 糕饼一厂东北角） */
    private String installLocation;
    
    /** 管径规格 - VARCHAR(10) 允许空（非管道类设备无），如 DN25/DN50/DN100/DN110 */
    private String pipeDiameter;
    
    /** 通讯协议 - VARCHAR(10) 非空、枚举（RS485/Lora），设备数据传输协议 */
    private String communicationProtocol;
    
    /** 运行状态 - VARCHAR(10) 非空、枚举（正常 / 故障），设备当前运行情况 */
    private String operationStatus;
    
    /** 校准周期 - INT 非空、（≥3、≤24），单位：月 */
    private Integer calibrationCycle;
    
    /** 生产厂家 - VARCHAR(30) 允许空，设备生产企业名称 */
    private String manufacturer;
    
    // getters and setters
    public String getDeviceId() { return deviceId; }
    public void setDeviceId(String deviceId) { this.deviceId = deviceId; }
    
    public String getEnergyType() { return energyType; }
    public void setEnergyType(String energyType) { this.energyType = energyType; }
    
    public String getInstallLocation() { return installLocation; }
    public void setInstallLocation(String installLocation) { this.installLocation = installLocation; }
    
    public String getPipeDiameter() { return pipeDiameter; }
    public void setPipeDiameter(String pipeDiameter) { this.pipeDiameter = pipeDiameter; }
    
    public String getCommunicationProtocol() { return communicationProtocol; }
    public void setCommunicationProtocol(String communicationProtocol) { this.communicationProtocol = communicationProtocol; }
    
    public String getOperationStatus() { return operationStatus; }
    public void setOperationStatus(String operationStatus) { this.operationStatus = operationStatus; }
    
    public Integer getCalibrationCycle() { return calibrationCycle; }
    public void setCalibrationCycle(Integer calibrationCycle) { this.calibrationCycle = calibrationCycle; }
    
    public String getManufacturer() { return manufacturer; }
    public void setManufacturer(String manufacturer) { this.manufacturer = manufacturer; }
}

