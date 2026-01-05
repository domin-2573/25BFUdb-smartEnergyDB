//package Demo.Service;
//
//import Demo.Dao.AlarmDao;
//import Demo.Entity.Alarm;
//import org.junit.jupiter.api.BeforeEach;
//import org.junit.jupiter.api.Test;
//import org.junit.jupiter.api.extension.ExtendWith;
//import org.mockito.InjectMocks;
//import org.mockito.Mock;
//import org.mockito.junit.jupiter.MockitoExtension;
//import java.util.*;
//
//import static org.junit.jupiter.api.Assertions.*;
//import static org.mockito.ArgumentMatchers.*;
//import static org.mockito.Mockito.*;
//
///**
// * 告警服务测试类
// * 测试告警业务线的核心功能
// */
//@ExtendWith(MockitoExtension.class)
//public class AlarmServiceTest {
//
//    @Mock
//    private AlarmDao alarmDao;
//
//    @Mock
//    private IEnergyService energyService;
//
//    @InjectMocks
//    private EnergyServiceImpl energyServiceImpl;
//
//    private Alarm testAlarm;
//    private List<Alarm> alarmList;
//
//    @BeforeEach
//    void setUp() {
//        // 初始化测试数据
//        testAlarm = new Alarm();
//        testAlarm.setAlarmId("TEST-001");
//        testAlarm.setAlarmType("设备故障");
//        testAlarm.setDeviceId("BYQ-001");
//        testAlarm.setOccurTime(new Date());
//        testAlarm.setAlarmLevel("高");
//        testAlarm.setAlarmContent("变压器温度超限");
//        testAlarm.setHandleStatus("未处理");
//        testAlarm.setTriggerThreshold("95℃");
//
//        alarmList = new ArrayList<>();
//        for (int i = 1; i <= 5; i++) {
//            Alarm alarm = new Alarm();
//            alarm.setAlarmId("TEST-" + i);
//            alarm.setAlarmType(i % 2 == 0 ? "越限告警" : "设备故障");
//            alarm.setAlarmLevel(i == 1 ? "高" : i == 2 ? "中" : "低");
//            alarm.setHandleStatus(i % 3 == 0 ? "未处理" : i % 3 == 1 ? "处理中" : "已结案");
//            alarmList.add(alarm);
//        }
//    }
//
//    @Test
//    void testGetAlarmsByStatus() {
//        // 准备测试数据
//        List<Alarm> expectedAlarms = alarmList.stream()
//                .filter(a -> "未处理".equals(a.getHandleStatus()))
//                .toList();
//
//        // 模拟DAO层行为
//        when(alarmDao.getAlarmsByStatus("未处理")).thenReturn(expectedAlarms);
//
//        // 执行测试
//        List<Alarm> actualAlarms = energyService.getAlarmsByStatus("未处理");
//
//        // 验证结果
//        assertNotNull(actualAlarms);
//        assertEquals(expectedAlarms.size(), actualAlarms.size());
//        assertTrue(actualAlarms.stream().allMatch(a -> "未处理".equals(a.getHandleStatus())));
//
//        // 验证DAO方法被调用
//        verify(alarmDao, times(1)).getAlarmsByStatus("未处理");
//    }
//
//    @Test
//    void testGetHighLevelUnhandledAlarms() {
//        // 准备测试数据
//        List<Alarm> expectedAlarms = alarmList.stream()
//                .filter(a -> "高".equals(a.getAlarmLevel()) && "未处理".equals(a.getHandleStatus()))
//                .toList();
//
//        // 模拟DAO层行为
//        when(alarmDao.getHighLevelUnhandledAlarms()).thenReturn(expectedAlarms);
//
//        // 执行测试
//        List<Alarm> actualAlarms = energyService.getHighLevelUnhandledAlarms();
//
//        // 验证结果
//        assertNotNull(actualAlarms);
//        assertEquals(expectedAlarms.size(), actualAlarms.size());
//        assertTrue(actualAlarms.stream().allMatch(a -> 
//            "高".equals(a.getAlarmLevel()) && "未处理".equals(a.getHandleStatus())));
//
//        // 验证DAO方法被调用
//        verify(alarmDao, times(1)).getHighLevelUnhandledAlarms();
//    }
//
//    @Test
//    void testUpdateAlarmStatus() {
//        // 模拟DAO层行为
//        when(alarmDao.updateAlarmStatus("TEST-001", "处理中")).thenReturn(1);
//
//        // 执行测试
//        int result = alarmDao.updateAlarmStatus("TEST-001", "处理中");
//
//        // 验证结果
//        assertEquals(1, result);
//
//        // 验证DAO方法被调用
//        verify(alarmDao, times(1)).updateAlarmStatus("TEST-001", "处理中");
//    }
//
//    @Test
//    void testGetAlarmStatistics() {
//        // 准备测试数据
//        List<Map<String, Object>> expectedStats = new ArrayList<>();
//        Map<String, Object> highStat = new HashMap<>();
//        highStat.put("告警等级", "高");
//        highStat.put("alarm_count", 5);
//        expectedStats.add(highStat);
//
//        Map<String, Object> mediumStat = new HashMap<>();
//        mediumStat.put("告警等级", "中");
//        mediumStat.put("alarm_count", 3);
//        expectedStats.add(mediumStat);
//
//        // 模拟DAO层行为
//        when(alarmDao.getAlarmStatistics("2025-01-01", "2025-01-31")).thenReturn(expectedStats);
//
//        // 执行测试
//        List<Map<String, Object>> actualStats = alarmDao.getAlarmStatistics("2025-01-01", "2025-01-31");
//
//        // 验证结果
//        assertNotNull(actualStats);
//        assertEquals(2, actualStats.size());
//        assertEquals(5, ((Number) actualStats.get(0).get("alarm_count")).intValue());
//        assertEquals("高", actualStats.get(0).get("告警等级"));
//
//        // 验证DAO方法被调用
//        verify(alarmDao, times(1)).getAlarmStatistics("2025-01-01", "2025-01-31");
//    }
//
//    @Test
//    void testGetAlarmTypeDistribution() {
//        // 准备测试数据
//        List<Map<String, Object>> expectedDistribution = new ArrayList<>();
//        
//        Map<String, Object> type1 = new HashMap<>();
//        type1.put("告警类型", "设备故障");
//        type1.put("count", 10);
//        expectedDistribution.add(type1);
//        
//        Map<String, Object> type2 = new HashMap<>();
//        type2.put("告警类型", "越限告警");
//        type2.put("count", 8);
//        expectedDistribution.add(type2);
//
//        // 模拟DAO层行为
//        when(alarmDao.getAlarmTypeDistribution("2025-01-01", "2025-01-31")).thenReturn(expectedDistribution);
//
//        // 执行测试
//        List<Map<String, Object>> actualDistribution = energyServiceImpl.getAlarmTypeDistribution("2025-01-01", "2025-01-31");
//
//        // 验证结果
//        assertNotNull(actualDistribution);
//        assertEquals(2, actualDistribution.size());
//        assertEquals("设备故障", actualDistribution.get(0).get("告警类型"));
//        assertEquals(10, ((Number) actualDistribution.get(0).get("count")).intValue());
//
//        // 验证DAO方法被调用
//        verify(alarmDao, times(1)).getAlarmTypeDistribution("2025-01-01", "2025-01-31");
//    }
//
//    @Test
//    void testGetAlarmLevelDistribution() {
//        // 准备测试数据
//        List<Map<String, Object>> expectedDistribution = new ArrayList<>();
//        
//        Map<String, Object> highLevel = new HashMap<>();
//        highLevel.put("告警等级", "高");
//        highLevel.put("count", 5);
//        expectedDistribution.add(highLevel);
//        
//        Map<String, Object> mediumLevel = new HashMap<>();
//        mediumLevel.put("告警等级", "中");
//        mediumLevel.put("count", 3);
//        expectedDistribution.add(mediumLevel);
//        
//        Map<String, Object> lowLevel = new HashMap<>();
//        lowLevel.put("告警等级", "低");
//        lowLevel.put("count", 2);
//        expectedDistribution.add(lowLevel);
//
//        // 模拟DAO层行为
//        when(alarmDao.getAlarmLevelDistribution("2025-01-01", "2025-01-31")).thenReturn(expectedDistribution);
//
//        // 执行测试
//        List<Map<String, Object>> actualDistribution = energyServiceImpl.getAlarmLevelDistribution("2025-01-01", "2025-01-31");
//
//        // 验证结果
//        assertNotNull(actualDistribution);
//        assertEquals(3, actualDistribution.size());
//        assertEquals("高", actualDistribution.get(0).get("告警等级"));
//        assertEquals(5, ((Number) actualDistribution.get(0).get("count")).intValue());
//
//        // 验证DAO方法被调用
//        verify(alarmDao, times(1)).getAlarmLevelDistribution("2025-01-01", "2025-01-31");
//    }
//
//    @Test
//    void testGetAlarmHandleEfficiency() {
//        // 准备测试数据
//        List<Map<String, Object>> alarmStats = new ArrayList<>();
//        Map<String, Object> stat = new HashMap<>();
//        stat.put("告警等级", "高");
//        stat.put("alarm_count", 10);
//        alarmStats.add(stat);
//
//        // 模拟DAO层行为
//        when(alarmDao.getAlarmStatistics("2025-01-01", "2025-01-31")).thenReturn(alarmStats);
//        when(alarmDao.getHandledAlarmsCount("2025-01-01", "2025-01-31")).thenReturn(8);
//        when(alarmDao.getAvgResponseTime("2025-01-01", "2025-01-31")).thenReturn(25.5);
//
//        // 执行测试
//        Map<String, Object> efficiency = energyServiceImpl.getAlarmHandleEfficiency("2025-01-01", "2025-01-31");
//
//        // 验证结果
//        assertNotNull(efficiency);
//        assertEquals(10, efficiency.get("totalAlarms"));
//        assertEquals(8, efficiency.get("handledAlarms"));
//        assertEquals("80.00%", efficiency.get("handleRate"));
//        assertEquals("25.50分钟", efficiency.get("avgResponseTime"));
//        assertEquals(2, efficiency.get("unhandledAlarms"));
//
//        // 验证DAO方法被调用
//        verify(alarmDao, times(1)).getAlarmStatistics("2025-01-01", "2025-01-31");
//        verify(alarmDao, times(1)).getHandledAlarmsCount("2025-01-01", "2025-01-31");
//        verify(alarmDao, times(1)).getAvgResponseTime("2025-01-01", "2025-01-31");
//    }
//
//    @Test
//    void testGetAlarmTrendByDay() {
//        // 准备测试数据
//        List<Map<String, Object>> expectedTrend = new ArrayList<>();
//        
//        Map<String, Object> day1 = new HashMap<>();
//        day1.put("date", "2025-01-01");
//        day1.put("alarm_count", 5);
//        day1.put("high_count", 2);
//        day1.put("medium_count", 2);
//        day1.put("low_count", 1);
//        expectedTrend.add(day1);
//        
//        Map<String, Object> day2 = new HashMap<>();
//        day2.put("date", "2025-01-02");
//        day2.put("alarm_count", 3);
//        day2.put("high_count", 1);
//        day2.put("medium_count", 1);
//        day2.put("low_count", 1);
//        expectedTrend.add(day2);
//
//        // 模拟DAO层行为
//        when(alarmDao.getAlarmTrendByDay("2025-01-01", "2025-01-02")).thenReturn(expectedTrend);
//
//        // 执行测试