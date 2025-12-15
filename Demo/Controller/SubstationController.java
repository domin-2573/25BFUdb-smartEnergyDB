package Demo.Controller;

import Demo.Entity.Substation;
import Demo.Service.ISubstationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

/**
 * 配电房信息管理控制器
 */
@Controller
@RequestMapping("/substation")
public class SubstationController {
    
    @Autowired
    private ISubstationService substationService;
    
    /**
     * 配电房列表页面
     */
    @GetMapping("/list")
    public String substationList(Model model) {
        List<Substation> substations = substationService.getAllSubstations();
        model.addAttribute("substations", substations);
        return "substation/list";
    }
    
    /**
     * 配电房详情页面
     */
    @GetMapping("/detail/{substationId}")
    public String substationDetail(@PathVariable String substationId, Model model) {
        Substation substation = substationService.getSubstationById(substationId);
        model.addAttribute("substation", substation);
        return "substation/detail";
    }
    
    /**
     * 添加配电房页面
     */
    @GetMapping("/add")
    public String addSubstationPage() {
        return "substation/add";
    }
    
    /**
     * 添加配电房
     */
    @PostMapping("/add")
    @ResponseBody
    public String addSubstation(@RequestBody Substation substation) {
        int result = substationService.insertSubstation(substation);
        return result > 0 ? "success" : "failed";
    }
    
    /**
     * 更新配电房
     */
    @PostMapping("/update")
    @ResponseBody
    public String updateSubstation(@RequestBody Substation substation) {
        int result = substationService.updateSubstation(substation);
        return result > 0 ? "success" : "failed";
    }
    
    /**
     * 删除配电房
     */
    @PostMapping("/delete/{substationId}")
    @ResponseBody
    public String deleteSubstation(@PathVariable String substationId) {
        int result = substationService.deleteSubstation(substationId);
        return result > 0 ? "success" : "failed";
    }
    
    /**
     * 按电压等级查询配电房
     */
    @GetMapping("/byVoltageLevel")
    @ResponseBody
    public List<Substation> getSubstationsByVoltageLevel(@RequestParam String voltageLevel) {
        return substationService.getSubstationsByVoltageLevel(voltageLevel);
    }
}

