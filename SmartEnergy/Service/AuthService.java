package Demo.Service;

import Demo.Dao.UserDao;
import Demo.Entity.User;
import Demo.Tool.SecurityTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * 认证服务
 * 实现：密码加密、登录失败限制、账号锁定
 */
@Service
public class AuthService {
    
    @Autowired
    private UserDao userDao;
    
    // 存储登录失败次数（实际应该用Redis或数据库）
    private Map<String, Integer> loginFailureCount = new HashMap<>();
    private Map<String, Date> accountLockTime = new HashMap<>();
    
    private static final int MAX_LOGIN_FAILURES = 5;
    private static final int LOCKOUT_MINUTES = 30;
    
    /**
     * 用户登录验证
     */
    public Map<String, Object> login(String userId, String password) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 检查账号是否被锁定
            if (isAccountLocked(userId)) {
                result.put("success", false);
                result.put("message", "账号已被锁定，请30分钟后再试");
                return result;
            }
            
            // 查询用户
            User user = userDao.getUserById(userId);
            if (user == null) {
                incrementFailureCount(userId);
                result.put("success", false);
                result.put("message", "用户名或密码错误");
                return result;
            }
            
            // 验证密码（使用SHA-256）
            String hashedPassword = SecurityTool.encryptPassword(password);
            if (!hashedPassword.equals(user.getPassword())) {
                incrementFailureCount(userId);
                result.put("success", false);
                result.put("message", "用户名或密码错误");
                return result;
            }
            
            // 登录成功，清除失败次数
            loginFailureCount.remove(userId);
            accountLockTime.remove(userId);
            
            // 更新最后登录时间
            userDao.updateLastLoginTime(userId);
            
            result.put("success", true);
            result.put("message", "登录成功");
            result.put("user", user);
            return result;
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "登录失败：" + e.getMessage());
            return result;
        }
    }
    
    /**
     * 检查账号是否被锁定
     */
    private boolean isAccountLocked(String userId) {
        Date lockTime = accountLockTime.get(userId);
        if (lockTime == null) {
            return false;
        }
        
        long currentTime = System.currentTimeMillis();
        long lockTimeMillis = lockTime.getTime();
        long lockoutDuration = LOCKOUT_MINUTES * 60 * 1000; // 30分钟
        
        if (currentTime - lockTimeMillis > lockoutDuration) {
            // 锁定时间已过，解除锁定
            accountLockTime.remove(userId);
            loginFailureCount.remove(userId);
            return false;
        }
        
        return true;
    }
    
    /**
     * 增加登录失败次数
     */
    private void incrementFailureCount(String userId) {
        int count = loginFailureCount.getOrDefault(userId, 0) + 1;
        loginFailureCount.put(userId, count);
        
        if (count >= MAX_LOGIN_FAILURES) {
            // 锁定账号
            accountLockTime.put(userId, new Date());
        }
    }
    
    /**
     * 获取剩余失败次数
     */
    public int getRemainingAttempts(String userId) {
        int count = loginFailureCount.getOrDefault(userId, 0);
        return Math.max(0, MAX_LOGIN_FAILURES - count);
    }
}

