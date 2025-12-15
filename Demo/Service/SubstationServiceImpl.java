package Demo.Service;

import Demo.Dao.SubstationDao;
import Demo.Entity.Substation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 配电网监测业务服务实现
 */
@Service
public class SubstationServiceImpl implements ISubstationService {
    
    @Autowired
    private SubstationDao substationDao;
    
    @Override
    public int insertSubstation(Substation substation) {
        return substationDao.insertSubstation(substation);
    }
    
    @Override
    public Substation getSubstationById(String substationId) {
        return substationDao.getSubstationById(substationId);
    }
    
    @Override
    public List<Substation> getAllSubstations() {
        return substationDao.getAllSubstations();
    }
    
    @Override
    public List<Substation> getSubstationsByVoltageLevel(String voltageLevel) {
        return substationDao.getSubstationsByVoltageLevel(voltageLevel);
    }
    
    @Override
    public int updateSubstation(Substation substation) {
        return substationDao.updateSubstation(substation);
    }
    
    @Override
    public int deleteSubstation(String substationId) {
        return substationDao.deleteSubstation(substationId);
    }
}

