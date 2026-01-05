package Demo.Service;

import Demo.Dao.AlarmDao;
import Demo.Dao.CircuitDataDao;
import Demo.Dao.PvDeviceDao;
import Demo.Entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class EnergyServiceImpl implements IEnergyService {
    
    @Autowired
    private AlarmDao alarmDao;
    
    @Autowired
    private CircuitDataDao circuitDataDao;
    
    @Autowired
    private PvDeviceDao pvDeviceDao;
    
    // ==================== Circuit monitoring business ====================
    
    @Override
    public List<CircuitData> getCircuitDataByTimeRange(String substationId, String startTime, String endTime) {
        try {
            return circuitDataDao.getCircuitDataBySubstationAndTime(substationId, startTime, endTime);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public List<CircuitData> getAbnormalCircuitData(String startTime) {
        try {
            return circuitDataDao.getAbnormalCircuitData(startTime);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public void updateCircuitDataStatus(Long dataId, String status) {
        try {
            circuitDataDao.updateDataStatus(dataId.toString(), status);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // ==================== PV device business ====================
    
    @Override
    public List<PvDevice> getPvDevicesByStatus(String status) {
        try {
            return pvDeviceDao.getPvDevicesByStatus(status);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public Map<String, Object> getPvDeviceSummary() {
        Map<String, Object> summary = new HashMap<>();
        
        try {
            List<PvDevice> allDevices = pvDeviceDao.getAllPvDevices();
            
            // 设备总数
            summary.put("totalDevices", allDevices.size());
            
            // 按状态统计 - 使用operationStatus字段
            long normalCount = 0;
            long abnormalCount = 0;
            long offlineCount = 0;
            
            for (PvDevice device : allDevices) {
                String status = device.getOperationStatus();
                if ("正常运行".equals(status)) {
                    normalCount++;
                } else if ("异常".equals(status)) {
                    abnormalCount++;
                } else if ("离线".equals(status)) {
                    offlineCount++;
                }
            }
            
            summary.put("normalCount", normalCount);
            summary.put("abnormalCount", abnormalCount);
            summary.put("offlineCount", offlineCount);
            
            // 按类型统计
            Map<String, Long> typeCount = new HashMap<>();
            for (PvDevice device : allDevices) {
                String type = device.getDeviceType();
                typeCount.put(type, typeCount.getOrDefault(type, 0L) + 1);
            }
            summary.put("typeDistribution", typeCount);
            
            // 总装机容量 - 使用capacity字段
            double totalCapacity = 0;
            for (PvDevice device : allDevices) {
                try {
                    if (device.getCapacity() != null) {
                        totalCapacity += Double.parseDouble(device.getCapacity());
                    }
                } catch (NumberFormatException e) {
                    // 忽略格式错误
                }
            }
            summary.put("totalCapacity", totalCapacity);
            
            // 正常率
            double normalRate = allDevices.size() > 0 ? (normalCount * 100.0 / allDevices.size()) : 0;
            summary.put("normalRate", Math.round(normalRate * 100.0) / 100.0);
            
        } catch (Exception e) {
            e.printStackTrace();
            // 设置默认值
            summary.put("totalDevices", 0);
            summary.put("normalCount", 0);
            summary.put("abnormalCount", 0);
            summary.put("offlineCount", 0);
            summary.put("typeDistribution", new HashMap<>());
            summary.put("totalCapacity", 0.0);
            summary.put("normalRate", 0.0);
        }
        
        return summary;
    }
    
    @Override
    public void updatePvDeviceStatus(String deviceId, String status) {
        try {
            pvDeviceDao.updateDeviceStatus(deviceId, status);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // ==================== Alarm management business ====================
    
    @Override
    public List<Alarm> getAlarmsByStatus(String status) {
        try {
            return alarmDao.getAlarmsByStatus(status);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public List<Alarm> getHighLevelUnhandledAlarms() {
        try {
            return alarmDao.getHighLevelUnhandledAlarms();
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public void updateAlarmStatus(Long alarmId, String status) {
        try {
            alarmDao.updateAlarmStatus(alarmId.toString(), status);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public Map<String, Object> getAlarmStatistics(String startTime, String endTime) {
        Map<String, Object> result = new HashMap<>();
        
        try {
            // 获取原始统计数据
            List<Map<String, Object>> rawStats = alarmDao.getAlarmStatistics(startTime, endTime);
            
            // 计算总数
            int totalAlarms = 0;
            Map<String, Integer> levelCount = new HashMap<>();
            
            for (Map<String, Object> stat : rawStats) {
                Object levelObj = stat.get("告警等级");
                Object countObj = stat.get("alarm_count");
                
                String level = levelObj != null ? levelObj.toString() : "未知";
                int count = 0;
                
                if (countObj != null) {
                    if (countObj instanceof Number) {
                        count = ((Number) countObj).intValue();
                    } else if (countObj instanceof String) {
                        try {
                            count = Integer.parseInt((String) countObj);
                        } catch (NumberFormatException e) {
                            count = 0;
                        }
                    }
                }
                
                totalAlarms += count;
                levelCount.put(level, count);
            }
            
            // 构建响应
            result.put("data", rawStats);
            result.put("totalAlarms", totalAlarms);
            result.put("levelDistribution", levelCount);
            
            // 计算各等级比例
            Map<String, Double> levelRatio = new HashMap<>();
            for (Map.Entry<String, Integer> entry : levelCount.entrySet()) {
                double ratio = totalAlarms > 0 ? (entry.getValue() * 100.0 / totalAlarms) : 0;
                levelRatio.put(entry.getKey(), Math.round(ratio * 100.0) / 100.0);
            }
            result.put("levelRatio", levelRatio);
            
        } catch (Exception e) {
            e.printStackTrace();
            // 返回空结果
            result.put("data", new ArrayList<>());
            result.put("totalAlarms", 0);
            result.put("levelDistribution", new HashMap<>());
            result.put("levelRatio", new HashMap<>());
        }
        
        return result;
    }
    
    @Override
    public List<Map<String, Object>> getAlarmTypeDistribution(String startTime, String endTime) {
        try {
            return alarmDao.getAlarmTypeDistribution(startTime, endTime);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public List<Map<String, Object>> getAlarmLevelDistribution(String startTime, String endTime) {
        try {
            return alarmDao.getAlarmLevelDistribution(startTime, endTime);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public Map<String, Object> getAlarmHandleEfficiency(String startTime, String endTime) {
        Map<String, Object> efficiency = new HashMap<>();
        
        try {
            // 获取已处理告警数量
            int handledCount = alarmDao.getHandledAlarmsCount(startTime, endTime);
            efficiency.put("handled_count", handledCount);
            
            // 获取平均响应时间（分钟）
            Double avgResponseTime = alarmDao.getAvgResponseTime(startTime, endTime);
            efficiency.put("avg_response_time_minutes", avgResponseTime != null ? avgResponseTime : 0);
            
            // 转换为小时（保留2位小数）
            double avgResponseHours = avgResponseTime != null ? Math.round((avgResponseTime / 60) * 100.0) / 100.0 : 0;
            efficiency.put("avg_response_time_hours", avgResponseHours);
            
            // 获取总告警数
            List<Map<String, Object>> allAlarms = alarmDao.getAlarmStatistics(startTime, endTime);
            int totalAlarms = 0;
            for (Map<String, Object> stat : allAlarms) {
                Object countObj = stat.get("alarm_count");
                if (countObj instanceof Number) {
                    totalAlarms += ((Number) countObj).intValue();
                }
            }
            
            // 计算处理率
            double handleRate = totalAlarms > 0 ? (handledCount * 100.0 / totalAlarms) : 0;
            efficiency.put("handle_rate", Math.round(handleRate * 100.0) / 100.0);
            efficiency.put("total_alarms", totalAlarms);
            
            // 未处理告警数
            int unhandledCount = totalAlarms - handledCount;
            efficiency.put("unhandled_count", unhandledCount);
            
            // 响应效率评级
            String efficiencyLevel;
            if (avgResponseTime == null || avgResponseTime == 0) {
                efficiencyLevel = "暂无数据";
            } else if (avgResponseTime <= 30) {
                efficiencyLevel = "优秀";
            } else if (avgResponseTime <= 60) {
                efficiencyLevel = "良好";
            } else if (avgResponseTime <= 120) {
                efficiencyLevel = "一般";
            } else {
                efficiencyLevel = "需改进";
            }
            efficiency.put("efficiency_level", efficiencyLevel);
            
        } catch (Exception e) {
            e.printStackTrace();
            // 设置默认值
            efficiency.put("handled_count", 0);
            efficiency.put("avg_response_time_minutes", 0);
            efficiency.put("avg_response_time_hours", 0);
            efficiency.put("handle_rate", 0);
            efficiency.put("total_alarms", 0);
            efficiency.put("unhandled_count", 0);
            efficiency.put("efficiency_level", "暂无数据");
        }
        
        return efficiency;
    }
    
    @Override
    public List<Map<String, Object>> getAlarmTrendByDay(String startTime, String endTime) {
        try {
            return alarmDao.getAlarmTrendByDay(startTime, endTime);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public List<Map<String, Object>> getFrequentAlarmDevices(String startTime, String endTime, int limit) {
        try {
            return alarmDao.getFrequentAlarmDevices(startTime, endTime, limit);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public List<Map<String, Object>> getAlarmDeviceTypeDistribution(String startTime, String endTime) {
        try {
            return alarmDao.getAlarmDeviceTypeDistribution(startTime, endTime);
        } catch (Exception e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
    
    @Override
    public Map<String, Object> getDeviceAlarmDetails(String deviceId, String startTime, String endTime) {
        Map<String, Object> details = new HashMap<>();
        
        try {
            // 获取设备基本信息
            Map<String, Object> deviceInfo = alarmDao.getDeviceInfo(deviceId);
            details.put("device_info", deviceInfo != null ? deviceInfo : new HashMap<>());
            
            // 获取设备告警列表
            List<Map<String, Object>> alarmList = alarmDao.getDeviceAlarms(deviceId, startTime, endTime);
            details.put("alarm_list", alarmList);
            
            // 获取设备告警统计
            Map<String, Object> alarmStats = alarmDao.getDeviceAlarmStats(deviceId, startTime, endTime);
            details.put("alarm_stats", alarmStats != null ? alarmStats : new HashMap<>());
            
            // 计算告警频率（次/天）
            long alarmCount = alarmList.size();
            try {
                // 计算时间范围内的天数
                java.time.LocalDate startDate = java.time.LocalDate.parse(startTime);
                java.time.LocalDate endDate = java.time.LocalDate.parse(endTime);
                long days = java.time.temporal.ChronoUnit.DAYS.between(startDate, endDate) + 1;
                
                double frequency = days > 0 ? (double) alarmCount / days : alarmCount;
                details.put("alarm_frequency_per_day", Math.round(frequency * 100.0) / 100.0);
                details.put("time_period_days", days);
            } catch (Exception e) {
                details.put("alarm_frequency_per_day", alarmCount);
                details.put("time_period_days", "未知");
            }
            
            // 最近一次告警时间
            if (!alarmList.isEmpty() && alarmList.get(0).containsKey("发生时间")) {
                details.put("last_alarm_time", alarmList.get(0).get("发生时间"));
            } else {
                details.put("last_alarm_time", "无告警记录");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // 返回空结果
            details.put("device_info", new HashMap<>());
            details.put("alarm_list", new ArrayList<>());
            details.put("alarm_stats", new HashMap<>());
            details.put("alarm_frequency_per_day", 0);
            details.put("time_period_days", 0);
            details.put("last_alarm_time", "无数据");
        }
        
        return details;
    }
    
    // ==================== Dashboard display ====================
    
    @Override
    public Map<String, Object> getDashboardSummary() {
        Map<String, Object> summary = new HashMap<>();
        
        try {
            // 告警统计
            List<Alarm> unhandledAlarms = getAlarmsByStatus("未处理");
            List<Alarm> highAlarms = getHighLevelUnhandledAlarms();
            
            summary.put("unhandledAlarmCount", unhandledAlarms.size());
            summary.put("highLevelAlarmCount", highAlarms.size());
            
            // 设备状态统计
            Map<String, Object> pvSummary = getPvDeviceSummary();
            summary.put("pvDeviceSummary", pvSummary);
            
            // 能耗概况（示例数据）
            summary.put("totalEnergyConsumption", 12540.5); // 总能耗（kWh）
            summary.put("energyCost", 8768.35); // 能源成本（元）
            summary.put("energySaving", 12.5); // 节能率（%）
            
            // 系统状态
            summary.put("systemStatus", "运行正常");
            summary.put("lastUpdateTime", new java.util.Date());
            
        } catch (Exception e) {
            e.printStackTrace();
            // 设置默认值
            summary.put("unhandledAlarmCount", 0);
            summary.put("highLevelAlarmCount", 0);
            summary.put("pvDeviceSummary", new HashMap<>());
            summary.put("totalEnergyConsumption", 0);
            summary.put("energyCost", 0);
            summary.put("energySaving", 0);
            summary.put("systemStatus", "数据异常");
            summary.put("lastUpdateTime", new java.util.Date());
        }
        
        return summary;
    }
    
    @Override
    public Map<String, Object> getEnergyTrend(String energyType, String period) {
        Map<String, Object> trend = new HashMap<>();
        
        try {
            // 使用传统方式创建List，兼容Java 8
            List<String> labels = new ArrayList<>();
            labels.add("1月");
            labels.add("2月");
            labels.add("3月");
            labels.add("4月");
            labels.add("5月");
            labels.add("6月");
            
            List<Double> values = new ArrayList<>();
            values.add(1200.5);
            values.add(1150.2);
            values.add(1300.8);
            values.add(1250.3);
            values.add(1400.6);
            values.add(1350.9);
            
            trend.put("energyType", energyType);
            trend.put("period", period);
            trend.put("labels", labels);
            trend.put("values", values);
            
            // 计算统计信息
            double total = 0;
            double max = Double.MIN_VALUE;
            double min = Double.MAX_VALUE;
            
            for (Double value : values) {
                if (value != null) {
                    total += value;
                    if (value > max) max = value;
                    if (value < min) min = value;
                }
            }
            
            double average = !values.isEmpty() ? total / values.size() : 0;
            
            trend.put("totalConsumption", Math.round(total * 100.0) / 100.0);
            trend.put("averageConsumption", Math.round(average * 100.0) / 100.0);
            trend.put("maxConsumption", Math.round(max * 100.0) / 100.0);
            trend.put("minConsumption", Math.round(min * 100.0) / 100.0);
            
            // 趋势分析
            if (values.size() >= 2) {
                Double first = values.get(0);
                Double last = values.get(values.size() - 1);
                if (first != null && last != null && first > 0) {
                    double growthRate = ((last - first) / first * 100);
                    trend.put("growthRate", Math.round(growthRate * 100.0) / 100.0);
                    trend.put("trendDirection", growthRate > 0 ? "上升" : growthRate < 0 ? "下降" : "平稳");
                } else {
                    trend.put("growthRate", 0);
                    trend.put("trendDirection", "平稳");
                }
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // 返回空结果
            trend.put("energyType", energyType);
            trend.put("period", period);
            trend.put("labels", new ArrayList<>());
            trend.put("values", new ArrayList<>());
            trend.put("totalConsumption", 0);
            trend.put("averageConsumption", 0);
            trend.put("maxConsumption", 0);
            trend.put("minConsumption", 0);
            trend.put("growthRate", 0);
            trend.put("trendDirection", "数据异常");
        }
        
        return trend;
    }
    
 // 新增：告警新增时校验设备关联（确保告警必关联具体设备）
    public int insertAlarm(Alarm alarm) {
        // 校验关联设备是否存在
        String deviceExists = alarmDao.verifyDeviceExists(alarm.getDeviceId());
        if (deviceExists == null) {
            throw new IllegalArgumentException("告警关联的设备不存在：" + alarm.getDeviceId());
        }
        // 高等级告警默认处理状态为「未处理」
        if ("高".equals(alarm.getAlarmLevel()) && alarm.getHandleStatus() == null) {
            alarm.setHandleStatus("未处理");
        }
        return alarmDao.insertAlarm(alarm);
    }
}