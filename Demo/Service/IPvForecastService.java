package Demo.Service;

import Demo.Entity.PvForecastData;
import java.util.List;
import java.util.Map;

/**
 * 光伏预测数据服务接口
 */
public interface IPvForecastService {
    
    int insertPvForecastData(PvForecastData pvForecastData);
    PvForecastData getPvForecastDataById(String forecastId);
    List<PvForecastData> getPvForecastDataByGridPointAndDate(String gridPointId, String forecastDate);
    List<PvForecastData> getHighDeviationForecastData(String startDate);
    List<Map<String, Object>> getForecastDeviationStatistics(String gridPointId, String startDate, String endDate);
    int updatePvForecastData(PvForecastData pvForecastData);
}

