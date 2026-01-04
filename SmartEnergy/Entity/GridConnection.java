package Demo.Entity;

import java.util.Date;

/**
 * 并网点信息表对应的实体类
 */
public class GridConnection {
    // 并网点编号（主键）
    private String gridConnectionId;
    // 并网点名称
    private String gridConnectionName;
    // 位置描述
    private String locationDesc;
    // 并网电压等级
    private String voltageLevel;
    // 并网容量（单位：kW）
    private Double gridCapacity;
    // 投运时间
    private Date commissioningTime;
    // 运行状态
    private String status;
    // 创建时间
    private Date createTime;
    // 更新时间
    private Date updateTime;

    // 无参构造函数
    public GridConnection() {
    }

    // 全参构造函数
    public GridConnection(String gridConnectionId, String gridConnectionName, String locationDesc,
                          String voltageLevel, Double gridCapacity, Date commissioningTime,
                          String status, Date createTime, Date updateTime) {
        this.gridConnectionId = gridConnectionId;
        this.gridConnectionName = gridConnectionName;
        this.locationDesc = locationDesc;
        this.voltageLevel = voltageLevel;
        this.gridCapacity = gridCapacity;
        this.commissioningTime = commissioningTime;
        this.status = status;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }

    // Getter & Setter
    public String getGridConnectionId() {
        return gridConnectionId;
    }

    public void setGridConnectionId(String gridConnectionId) {
        this.gridConnectionId = gridConnectionId;
    }

    public String getGridConnectionName() {
        return gridConnectionName;
    }

    public void setGridConnectionName(String gridConnectionName) {
        this.gridConnectionName = gridConnectionName;
    }

    public String getLocationDesc() {
        return locationDesc;
    }

    public void setLocationDesc(String locationDesc) {
        this.locationDesc = locationDesc;
    }

    public String getVoltageLevel() {
        return voltageLevel;
    }

    public void setVoltageLevel(String voltageLevel) {
        this.voltageLevel = voltageLevel;
    }

    public Double getGridCapacity() {
        return gridCapacity;
    }

    public void setGridCapacity(Double gridCapacity) {
        this.gridCapacity = gridCapacity;
    }

    public Date getCommissioningTime() {
        return commissioningTime;
    }

    public void setCommissioningTime(Date commissioningTime) {
        this.commissioningTime = commissioningTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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