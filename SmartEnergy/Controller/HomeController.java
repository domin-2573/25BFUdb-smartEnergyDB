package Demo.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HomeController {
    
    /**
     * 系统首页 - 重定向到仪表板
     */
    @GetMapping("/")
    public String home() {
        return "redirect:/admin/dashboard";
    }
    
    /**
     * 登录页面
     */
    @GetMapping("/login")
    public String login() {
        return "login";
    }
    
    /**
     * 系统欢迎页
     */
    @GetMapping("/welcome")
    public String welcome() {
        return "welcome";
    }
}