package Demo.Entity;

import java.util.Date;

/**
 * 光伏设备信息表对应的实体类
 */
public class PvDevice {
    // 设备编号（主键）
    private String deviceId;
    // 设备类型（逆变器、汇流箱）
    private String deviceType;
    // 安装位置
    private String installLocation;
    // 装机容量（单位：kWp）
    private Double installedCapacity;
    // 投运时间
    private Date commissioningTime;
    // 校准周期（单位：月）
    private Integer calibrationCycle;
    // 运行状态（正常、故障、离线）
    private String status;
    // 通信协议
    private String communicationProtocol;
    // 创建时间
    private Date createTime;
    // 更新时间
    private Date updateTime;

    // 无参构造函数
    public PvDevice() {
    }

    // 全参构造函数
    public PvDevice(String deviceId, String deviceType, String installLocation, Double installedCapacity,
                    Date commissioningTime, Integer calibrationCycle, String status,
                    String communicationProtocol, Date createTime, Date updateTime) {
        this.deviceId = deviceId;
        this.deviceType = deviceType;
        this.installLocation = installLocation;
        this.installedCapacity = installedCapacity;
        this.commissioningTime = commissioningTime;
        this.calibrationCycle = calibrationCycle;
        this.status = status;
        this.communicationProtocol = communicationProtocol;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    // Getter & Setter
    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceType() {
        return deviceType;
    }

    public void setDeviceType(String deviceType) {
        this.deviceType = deviceType;
    }

    public String getInstallLocation() {
        return installLocation;
    }

    public void setInstallLocation(String installLocation) {
        this.installLocation = installLocation;
    }

    public Double getInstalledCapacity() {
        return installedCapacity;
    }

    public void setInstalledCapacity(Double installedCapacity) {
        this.installedCapacity = installedCapacity;
    }

    public Date getCommissioningTime() {
        return commissioningTime;
    }

    public void setCommissioningTime(Date commissioningTime) {
        this.commissioningTime = commissioningTime;
    }

    public Integer getCalibrationCycle() {
        return calibrationCycle;
    }

    public void setCalibrationCycle(Integer calibrationCycle) {
        this.calibrationCycle = calibrationCycle;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getCommunicationProtocol() {
        return communicationProtocol;
    }

    public void setCommunicationProtocol(String communicationProtocol) {
        this.communicationProtocol = communicationProtocol;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}