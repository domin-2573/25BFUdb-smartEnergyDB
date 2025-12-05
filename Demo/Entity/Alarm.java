package Demo.Entity;

import java.util.Date;

/**
 * 告警信息表
 */
public class Alarm {
    /** 告警编号 - varchar(20) PRIMARY KEY（主键）, NOT NULL（非空） */
    private String alarmId;
    
    /** 告警类型 - varchar(20) ENUM('越限告警', '通讯故障', '设备故障')，NOT NULL（非空） */
    private String alarmType;
    
    /** 关联设备编号 - varchar(20) NOT NULL（非空） */
    private String deviceId;
    
    /** 发生时间 - datetime NOT NULL（非空） */
    private Date occurTime;
    
    /** 告警等级 - varchar(20) ENUM('高', '中','低')，NOT NULL（非空） */
    private String alarmLevel;
    
    /** 告警内容 - varchar(500) NOT NULL（非空） */
    private String alarmContent;
    
    /** 处理状态 - varchar(20) ENUM('未处理', '处理中', '已结案')，NOT NULL（非空）， DEFAULT '未处理' */
    private String handleStatus;
    
    /** 告警触发阈值 - varchar(100) */
    private String triggerThreshold;
    
    // getters and setters
    public String getAlarmId() { return alarmId; }
    public void setAlarmId(String alarmId) { this.alarmId = alarmId; }
    
    public String getAlarmType() { return alarmType; }
    public void setAlarmType(String alarmType) { this.alarmType = alarmType; }
    
    public String getDeviceId() { return deviceId; }
    public void setDeviceId(String deviceId) { this.deviceId = deviceId; }
    
    public Date getOccurTime() { return occurTime; }
    public void setOccurTime(Date occurTime) { this.occurTime = occurTime; }
    
    public String getAlarmLevel() { return alarmLevel; }
    public void setAlarmLevel(String alarmLevel) { this.alarmLevel = alarmLevel; }
    
    public String getAlarmContent() { return alarmContent; }
    public void setAlarmContent(String alarmContent) { this.alarmContent = alarmContent; }
    
    public String getHandleStatus() { return handleStatus; }
    public void setHandleStatus(String handleStatus) { this.handleStatus = handleStatus; }
    
    public String getTriggerThreshold() { return triggerThreshold; }
    public void setTriggerThreshold(String triggerThreshold) { this.triggerThreshold = triggerThreshold; }
}