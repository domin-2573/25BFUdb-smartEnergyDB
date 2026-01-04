package Demo.Service;

import Demo.Entity.PvGenerationData;
import java.util.List;
import java.util.Map;

/**
 * 光伏发电数据服务接口
 */
public interface IPvGenerationService {
    
    int insertPvGenerationData(PvGenerationData pvGenerationData);
    PvGenerationData getPvGenerationDataById(String dataId);
    List<PvGenerationData> getPvGenerationDataByDeviceAndTime(String deviceId, String startTime, String endTime);
    List<PvGenerationData> getPvGenerationDataByGridPointAndDate(String gridPointId, String date);
    List<Map<String, Object>> getDailyPvGenerationSummary(String startTime, String endTime);
    List<PvGenerationData> getLowEfficiencyPvData(String startTime);
}

