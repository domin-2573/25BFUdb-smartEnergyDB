package Demo.Service;

import Demo.Dao.PvForecastDataDao;
import Demo.Entity.PvForecastData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;

/**
 * 光伏预测数据服务实现
 */
@Service
public class PvForecastServiceImpl implements IPvForecastService {
    
    @Autowired
    private PvForecastDataDao pvForecastDataDao;
    
    @Override
    public int insertPvForecastData(PvForecastData pvForecastData) {
        return pvForecastDataDao.insertPvForecastData(pvForecastData);
    }
    
    @Override
    public PvForecastData getPvForecastDataById(String forecastId) {
        return pvForecastDataDao.getPvForecastDataById(forecastId);
    }
    
    @Override
    public List<PvForecastData> getPvForecastDataByGridPointAndDate(String gridPointId, String forecastDate) {
        return pvForecastDataDao.getPvForecastDataByGridPointAndDate(gridPointId, forecastDate);
    }
    
    @Override
    public List<PvForecastData> getHighDeviationForecastData(String startDate) {
        return pvForecastDataDao.getHighDeviationForecastData(startDate);
    }
    
    @Override
    public List<Map<String, Object>> getForecastDeviationStatistics(String gridPointId, String startDate, String endDate) {
        return pvForecastDataDao.getForecastDeviationStatistics(gridPointId, startDate, endDate);
    }
    
    @Override
    public int updatePvForecastData(PvForecastData pvForecastData) {
        return pvForecastDataDao.updatePvForecastData(pvForecastData);
    }
}

