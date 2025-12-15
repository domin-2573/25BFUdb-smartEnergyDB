package Demo.Service;

import Demo.Dao.PvGenerationDataDao;
import Demo.Entity.PvGenerationData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

/**
 * 光伏发电数据服务实现
 */
@Service
public class PvGenerationServiceImpl implements IPvGenerationService {
    
    @Autowired
    private PvGenerationDataDao pvGenerationDataDao;
    
    @Override
    public int insertPvGenerationData(PvGenerationData pvGenerationData) {
        return pvGenerationDataDao.insertPvGenerationData(pvGenerationData);
    }
    
    @Override
    public PvGenerationData getPvGenerationDataById(String dataId) {
        return pvGenerationDataDao.getPvGenerationDataById(dataId);
    }
    
    @Override
    public List<PvGenerationData> getPvGenerationDataByDeviceAndTime(String deviceId, String startTime, String endTime) {
        return pvGenerationDataDao.getPvGenerationDataByDeviceAndTime(deviceId, startTime, endTime);
    }
    
    @Override
    public List<PvGenerationData> getPvGenerationDataByGridPointAndDate(String gridPointId, String date) {
        return pvGenerationDataDao.getPvGenerationDataByGridPointAndDate(gridPointId, date);
    }
    
    @Override
    public List<Map<String, Object>> getDailyPvGenerationSummary(String startTime, String endTime) {
        return pvGenerationDataDao.getDailyPvGenerationSummary(startTime, endTime);
    }
    
    @Override
    public List<PvGenerationData> getLowEfficiencyPvData(String startTime) {
        return pvGenerationDataDao.getLowEfficiencyPvData(startTime);
    }
}

