package Demo.Entity;

import java.util.Date;

/**
 * 用户表
 */
public class User {
    /** 用户ID - CHAR(3) PRIMARY KEY，NOT NULL，唯一标识用户，001、002…… */
    private String userId;
    
    /** 姓名 - VARCHAR(50) NOT NULL，用户真实姓名 */
    private String name;
    
    /** 密码 - VARCHAR(100) NOT NULL，哈希后的密码字符串 */
    private String password;
    
    /** 角色 - VARCHAR(50) NOT NULL，系统管理员 / 能源管理员 / 运维人员 / 数据分析师 / 企业管理层 / 运维工单管理员 */
    private String role;
    
    /** 最后登录时间 */
    private Date lastLoginTime;
    
    // getters and setters
    public String getUserId() { return userId; }
    public void setUserId(String userId) { this.userId = userId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
    
    public Date getLastLoginTime() { return lastLoginTime; }
    public void setLastLoginTime(Date lastLoginTime) { this.lastLoginTime = lastLoginTime; }
}

