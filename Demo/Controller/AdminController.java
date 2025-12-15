package Demo.Controller;

import Demo.Service.IEnergyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {
    
    @Autowired
    private IEnergyService energyService;
    
    // ϵͳ�Ǳ���
    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        Map<String, Object> dashboardData = energyService.getDashboardSummary();
        model.addAttribute("dashboard", dashboardData);
        return "admin/dashboard";
    }
    
    // ��ȡ�Ǳ�������API
    @GetMapping("/dashboard/data")
    @ResponseBody
    public Map<String, Object> getDashboardData() {
        return energyService.getDashboardSummary();
    }
    
    // �û�����ҳ��
    @GetMapping("/users")
    public String userManagement() {
        return "admin/user_manage";
    }
    
    // ϵͳ����ҳ��
    @GetMapping("/config")
    public String systemConfig() {
        return "admin/system_config";
    }
}