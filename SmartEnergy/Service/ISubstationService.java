package Demo.Service;

import Demo.Entity.Substation;
import java.util.List;

/**
 * 配电网监测业务服务接口
 */
public interface ISubstationService {
    
    // 配电房信息管理
    int insertSubstation(Substation substation);
    Substation getSubstationById(String substationId);
    List<Substation> getAllSubstations();
    List<Substation> getSubstationsByVoltageLevel(String voltageLevel);
    int updateSubstation(Substation substation);
    int deleteSubstation(String substationId);
}

