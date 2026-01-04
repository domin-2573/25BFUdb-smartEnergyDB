package Demo.Entity;

import java.util.Date;

/**
 * 光伏发电数据表对应的实体类
 */
public class PvGenerationData {
    // 数据编号（主键）
    private String dataId;
    // 设备编号（关联光伏设备表）
    private String deviceId;
    // 并网点编号（关联并网点表）
    private String gridConnectionId;
    // 采集时间
    private Date collectionTime;
    // 发电量（单位：kWh）
    private Double powerGeneration;
    // 上网电量（单位：kWh）
    private Double gridPower;
    // 自用电量（单位：kWh）
    private Double selfUsePower;
    // 逆变器效率（%）
    private Double inverterEfficiency;
    // 汇流箱组串电压（单位：V）
    private Double stringVoltage;
    // 组串电流（单位：A）
    private Double stringCurrent;

    // 无参构造函数
    public PvGenerationData() {
    }

    // 全参构造函数
    public PvGenerationData(String dataId, String deviceId, String gridConnectionId, Date collectionTime,
                            Double powerGeneration, Double gridPower, Double selfUsePower,
                            Double inverterEfficiency, Double stringVoltage, Double stringCurrent) {
        this.dataId = dataId;
        this.deviceId = deviceId;
        this.gridConnectionId = gridConnectionId;
        this.collectionTime = collectionTime;
        this.powerGeneration = powerGeneration;
        this.gridPower = gridPower;
        this.selfUsePower = selfUsePower;
        this.inverterEfficiency = inverterEfficiency;
        this.stringVoltage = stringVoltage;
        this.stringCurrent = stringCurrent;
    }

    // Getter & Setter
    public String getDataId() {
        return dataId;
    }

    public void setDataId(String dataId) {
        this.dataId = dataId;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getGridConnectionId() {
        return gridConnectionId;
    }

    public void setGridConnectionId(String gridConnectionId) {
        this.gridConnectionId = gridConnectionId;
    }

    public Date getCollectionTime() {
        return collectionTime;
    }

    public void setCollectionTime(Date collectionTime) {
        this.collectionTime = collectionTime;
    }

    public Double getPowerGeneration() {
        return powerGeneration;
    }

    public void setPowerGeneration(Double powerGeneration) {
        this.powerGeneration = powerGeneration;
    }

    public Double getGridPower() {
        return gridPower;
    }

    public void setGridPower(Double gridPower) {
        this.gridPower = gridPower;
    }

    public Double getSelfUsePower() {
        return selfUsePower;
    }

    public void setSelfUsePower(Double selfUsePower) {
        this.selfUsePower = selfUsePower;
    }

    public Double getInverterEfficiency() {
        return inverterEfficiency;
    }

    public void setInverterEfficiency(Double inverterEfficiency) {
        this.inverterEfficiency = inverterEfficiency;
    }

    public Double getStringVoltage() {
        return stringVoltage;
    }

    public void setStringVoltage(Double stringVoltage) {
        this.stringVoltage = stringVoltage;
    }

    public Double getStringCurrent() {
        return stringCurrent;
    }

    public void setStringCurrent(Double stringCurrent) {
        this.stringCurrent = stringCurrent;
    }
}