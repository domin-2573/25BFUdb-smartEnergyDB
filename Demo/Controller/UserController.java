package Demo.Controller;

import Demo.Entity.User;
import Demo.Service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 用户管理控制器
 */
@Controller
@RequestMapping("/user")
public class UserController {
    
    @Autowired
    private IUserService userService;
    
    /**
     * 用户列表页面
     */
    @GetMapping("/list")
    public String userList(
            @RequestParam(required = false) String role,
            Model model) {
        List<User> userList;
        if (role != null) {
            userList = userService.getUsersByRole(role);
        } else {
            userList = userService.getAllUsers();
        }
        model.addAttribute("userList", userList);
        return "user/list";
    }
    
    /**
     * 用户详情页面
     */
    @GetMapping("/detail/{userId}")
    public String userDetail(@PathVariable String userId, Model model) {
        User user = userService.getUserById(userId);
        model.addAttribute("user", user);
        return "user/detail";
    }
    
    /**
     * 添加用户页面
     */
    @GetMapping("/add")
    public String addUserPage() {
        return "user/add";
    }
    
    /**
     * 添加用户
     */
    @PostMapping("/add")
    @ResponseBody
    public String addUser(@RequestBody User user) {
        int result = userService.insertUser(user);
        return result > 0 ? "success" : "failed";
    }
    
    /**
     * 更新用户
     */
    @PostMapping("/update")
    @ResponseBody
    public String updateUser(@RequestBody User user) {
        int result = userService.updateUser(user);
        return result > 0 ? "success" : "failed";
    }
    
    /**
     * 删除用户
     */
    @PostMapping("/delete/{userId}")
    @ResponseBody
    public String deleteUser(@PathVariable String userId) {
        int result = userService.deleteUser(userId);
        return result > 0 ? "success" : "failed";
    }
    
    /**
     * 用户登录验证
     */
    @PostMapping("/login")
    @ResponseBody
    public String login(@RequestParam String userId, @RequestParam String password) {
        boolean isValid = userService.validateUser(userId, password);
        return isValid ? "success" : "failed";
    }
}

