package Demo.Service;

import Demo.Entity.TransformerData;
import java.util.List;
import java.util.Map;

/**
 * 变压器监测数据服务接口
 */
public interface ITransformerDataService {
    
    int insertTransformerData(TransformerData transformerData);
    TransformerData getTransformerDataById(String dataId);
    List<TransformerData> getTransformerDataBySubstationAndTime(String substationId, String startTime, String endTime);
    List<TransformerData> getLatestTransformerData(String transformerId, int limit);
    List<TransformerData> getAbnormalTransformerData(String startTime);
    int updateTransformerDataStatus(String dataId, String status);
    List<Map<String, Object>> getTransformerStatistics(String substationId, String startTime, String endTime);
}

