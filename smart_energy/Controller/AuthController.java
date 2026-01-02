package Demo.Controller;

import Demo.Entity.User;
import Demo.Service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * 认证控制器
 * 处理登录、登出等认证相关操作
 */
@Controller
@RequestMapping("/auth")
public class AuthController {
    
    @Autowired
    private AuthService authService;
    
    /**
     * 用户登录
     */
    @PostMapping(value = "/login", produces = "application/json;charset=UTF-8")
    @ResponseBody
    public Map<String, Object> login(
            @RequestParam String userId,
            @RequestParam String password,
            HttpSession session) {
        
        Map<String, Object> result = new java.util.HashMap<>();
        
        try {
            Map<String, Object> loginResult = authService.login(userId, password);
            
            if ((Boolean) loginResult.get("success")) {
                // 登录成功，保存用户信息到session
                User user = (User) loginResult.get("user");
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userName", user.getName());
                session.setAttribute("role", user.getRole());
                session.setAttribute("lastAccessTime", System.currentTimeMillis());
                result.put("success", true);
                result.put("message", "登录成功");
                result.put("redirect", "/SmartEnergy/admin/dashboard");
            } else {
                // 登录失败，返回剩余尝试次数
                int remaining = authService.getRemainingAttempts(userId);
                result.put("success", false);
                result.put("message", loginResult.get("message"));
                result.put("remainingAttempts", remaining);
            }
        } catch (Exception e) {
            // 捕获所有异常，返回友好的错误信息
            result.put("success", false);
            result.put("message", "登录失败：" + e.getMessage());
            e.printStackTrace(); // 打印到服务器日志
        }
        
        return result;
    }
    
    /**
     * 用户登出
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/SmartEnergy/login";
    }
    
    /**
     * 检查登录状态
     */
    @GetMapping("/check")
    @ResponseBody
    public Map<String, Object> checkLogin(HttpSession session) {
        User user = (User) session.getAttribute("user");
        Map<String, Object> result = new java.util.HashMap<>();
        result.put("loggedIn", user != null);
        if (user != null) {
            result.put("user", user);
        }
        return result;
    }
}

