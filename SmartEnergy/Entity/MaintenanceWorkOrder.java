package Demo.Entity;

import java.util.Date;

/**
 * 运维工单数据表
 */
public class MaintenanceWorkOrder {
    /** 工单编号 - varchar(20) PRIMARY KEY（主键）, NOT NULL（非空） */
    private String workOrderId;
    
    /** 告警编号 - varchar(20) NOT NULL, FOREIGN KEY */
    private String alarmId;
    
    /** 运维人员ID - varchar(20) NOT NULL（非空） */
    private String maintenancePersonId;
    
    /** 派单时间 - datetime NOT NULL（非空） */
    private Date dispatchTime;
    
    /** 响应时间 - datetime */
    private Date responseTime;
    
    /** 处理完成时间 - datetime */
    private Date completionTime;
    
    /** 处理结果 - varchar(500) */
    private String processResult;
    
    /** 复查状态 - varchar(10)，通过/未通过 */
    private String reviewStatus;
    
    /** 附件路径 - varchar(200) */
    private String attachmentPath;
    
    // getters and setters
    public String getWorkOrderId() { return workOrderId; }
    public void setWorkOrderId(String workOrderId) { this.workOrderId = workOrderId; }
    
    public String getAlarmId() { return alarmId; }
    public void setAlarmId(String alarmId) { this.alarmId = alarmId; }
    
    public String getMaintenancePersonId() { return maintenancePersonId; }
    public void setMaintenancePersonId(String maintenancePersonId) { this.maintenancePersonId = maintenancePersonId; }
    
    public Date getDispatchTime() { return dispatchTime; }
    public void setDispatchTime(Date dispatchTime) { this.dispatchTime = dispatchTime; }
    
    public Date getResponseTime() { return responseTime; }
    public void setResponseTime(Date responseTime) { this.responseTime = responseTime; }
    
    public Date getCompletionTime() { return completionTime; }
    public void setCompletionTime(Date completionTime) { this.completionTime = completionTime; }
    
    public String getProcessResult() { return processResult; }
    public void setProcessResult(String processResult) { this.processResult = processResult; }
    
    public String getReviewStatus() { return reviewStatus; }
    public void setReviewStatus(String reviewStatus) { this.reviewStatus = reviewStatus; }
    
    public String getAttachmentPath() { return attachmentPath; }
    public void setAttachmentPath(String attachmentPath) { this.attachmentPath = attachmentPath; }
}

