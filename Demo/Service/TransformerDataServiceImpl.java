package Demo.Service;

import Demo.Dao.TransformerDataDao;
import Demo.Entity.TransformerData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

/**
 * 变压器监测数据服务实现
 */
@Service
public class TransformerDataServiceImpl implements ITransformerDataService {
    
    @Autowired
    private TransformerDataDao transformerDataDao;
    
    @Override
    public int insertTransformerData(TransformerData transformerData) {
        return transformerDataDao.insertTransformerData(transformerData);
    }
    
    @Override
    public TransformerData getTransformerDataById(String dataId) {
        return transformerDataDao.getTransformerDataById(dataId);
    }
    
    @Override
    public List<TransformerData> getTransformerDataBySubstationAndTime(String substationId, String startTime, String endTime) {
        return transformerDataDao.getTransformerDataBySubstationAndTime(substationId, startTime, endTime);
    }
    
    @Override
    public List<TransformerData> getLatestTransformerData(String transformerId, int limit) {
        return transformerDataDao.getLatestTransformerData(transformerId, limit);
    }
    
    @Override
    public List<TransformerData> getAbnormalTransformerData(String startTime) {
        return transformerDataDao.getAbnormalTransformerData(startTime);
    }
    
    @Override
    public int updateTransformerDataStatus(String dataId, String status) {
        return transformerDataDao.updateTransformerDataStatus(dataId, status);
    }
    
    @Override
    public List<Map<String, Object>> getTransformerStatistics(String substationId, String startTime, String endTime) {
        return transformerDataDao.getTransformerStatistics(substationId, startTime, endTime);
    }
}

