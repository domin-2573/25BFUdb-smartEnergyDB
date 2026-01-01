package Demo.Entity;

/**
 * 大屏展示配置表
 */
public class DashboardConfig {
    /** 配置编号 - varchar(15) 主键（DP001、DP002...）唯一，非空 */
    private String configId;
    
    /** 展示模块 - varchar(50) 非空（能源总览 / 光伏总览 / 配电网运行状态 / 告警统计） */
    private String displayModule;
    
    /** 数据刷新频率 - INT 非空（分钟） */
    private Integer refreshFrequency;
    
    /** 展示字段1 - 非空（总能耗 / 光伏发电量 / 高等级告警数） */
    private String displayField1;
    
    /** 排序规则 - varchar(50) 可空（按时间降序 / 按能耗降序...） */
    private String sortRule;
    
    /** 权限等级 - varchar(50) 非空（管理员 / 能源管理员 / 运维人员） */
    private String permissionLevel;
    
    // getters and setters
    public String getConfigId() { return configId; }
    public void setConfigId(String configId) { this.configId = configId; }
    
    public String getDisplayModule() { return displayModule; }
    public void setDisplayModule(String displayModule) { this.displayModule = displayModule; }
    
    public Integer getRefreshFrequency() { return refreshFrequency; }
    public void setRefreshFrequency(Integer refreshFrequency) { this.refreshFrequency = refreshFrequency; }
    
    public String getDisplayField1() { return displayField1; }
    public void setDisplayField1(String displayField1) { this.displayField1 = displayField1; }
    
    public String getSortRule() { return sortRule; }
    public void setSortRule(String sortRule) { this.sortRule = sortRule; }
    
    public String getPermissionLevel() { return permissionLevel; }
    public void setPermissionLevel(String permissionLevel) { this.permissionLevel = permissionLevel; }
}

