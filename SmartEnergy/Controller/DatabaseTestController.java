package Demo.Controller;

import Demo.Dao.UserDao;
import Demo.Entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.util.HashMap;
import java.util.Map;

/**
 * 数据库连接测试控制器
 */
@RestController
@RequestMapping("/test")
public class DatabaseTestController {
    
    @Autowired
    private DataSource dataSource;
    
    @Autowired
    private UserDao userDao;
    
    /**
     * 测试数据库连接
     */
    @GetMapping("/db")
    @ResponseBody
    public Map<String, Object> testDatabase() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 测试数据源连接
            Connection conn = dataSource.getConnection();
            DatabaseMetaData metaData = conn.getMetaData();
            
            result.put("success", true);
            result.put("message", "数据库连接成功！");
            result.put("databaseUrl", metaData.getURL());
            result.put("databaseProductName", metaData.getDatabaseProductName());
            result.put("databaseProductVersion", metaData.getDatabaseProductVersion());
            result.put("driverName", metaData.getDriverName());
            result.put("driverVersion", metaData.getDriverVersion());
            result.put("username", metaData.getUserName());
            
            // 测试查询用户表
            try {
                User testUser = userDao.getUserById("001");
                if (testUser != null) {
                    result.put("userQuery", "成功");
                    Map<String, Object> userInfo = new HashMap<>();
                    userInfo.put("userId", testUser.getUserId() != null ? testUser.getUserId() : "null");
                    userInfo.put("name", testUser.getName() != null ? testUser.getName() : "null");
                    userInfo.put("role", testUser.getRole() != null ? testUser.getRole() : "null");
                    userInfo.put("hasPassword", testUser.getPassword() != null && !testUser.getPassword().isEmpty());
                    result.put("testUser", userInfo);
                } else {
                    result.put("userQuery", "用户001不存在");
                }
            } catch (Exception e) {
                result.put("userQuery", "查询失败: " + e.getMessage());
                result.put("userQueryError", e.getClass().getName());
            }
            
            conn.close();
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("message", "数据库连接失败！");
            result.put("error", e.getMessage());
            result.put("errorType", e.getClass().getName());
            e.printStackTrace();
        }
        
        return result;
    }
    
    /**
     * 测试查询所有用户
     */
    @GetMapping("/users")
    @ResponseBody
    public Map<String, Object> testUsers() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            java.util.List<User> users = userDao.getAllUsers();
            result.put("success", true);
            result.put("count", users.size());
            result.put("users", users.stream().map(u -> {
                Map<String, Object> userMap = new HashMap<>();
                userMap.put("userId", u.getUserId() != null ? u.getUserId() : "null");
                userMap.put("name", u.getName() != null ? u.getName() : "null");
                userMap.put("role", u.getRole() != null ? u.getRole() : "null");
                userMap.put("passwordLength", u.getPassword() != null ? u.getPassword().length() : 0);
                return userMap;
            }).collect(java.util.stream.Collectors.toList()));
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
            result.put("errorType", e.getClass().getName());
            e.printStackTrace();
        }
        
        return result;
    }
    
    /**
     * 测试密码加密
     */
    @GetMapping("/password")
    @ResponseBody
    public Map<String, Object> testPassword() {
        Map<String, Object> result = new HashMap<>();
        
        try {
            String testPassword = "123456";
            String hashed = Demo.Tool.SecurityTool.encryptPassword(testPassword);
            
            result.put("success", true);
            result.put("originalPassword", testPassword);
            result.put("hashedPassword", hashed);
            result.put("expectedHash", "8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92");
            result.put("matches", hashed.equals("8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92"));
            
            // 测试从数据库获取的用户密码
            User user = userDao.getUserById("001");
            if (user != null && user.getPassword() != null) {
                result.put("dbPassword", user.getPassword());
                result.put("dbPasswordMatches", hashed.equals(user.getPassword()));
            }
            
        } catch (Exception e) {
            result.put("success", false);
            result.put("error", e.getMessage());
            e.printStackTrace();
        }
        
        return result;
    }
}

