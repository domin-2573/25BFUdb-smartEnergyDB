<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>实时监控大屏 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            color: #e2e8f0;
            font-family: 'Microsoft YaHei', 'Segoe UI', sans-serif;
            overflow-x: hidden;
        }
        
        .screen-header {
            background: rgba(15, 23, 42, 0.8);
            padding: 1rem 2rem;
            border-bottom: 2px solid #3b82f6;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 100;
            backdrop-filter: blur(10px);
        }
        
        .screen-title {
            font-size: 1.8rem;
            font-weight: bold;
            color: #60a5fa;
            text-shadow: 0 0 20px rgba(96, 165, 250, 0.5);
        }
        
        .screen-time {
            font-size: 1.2rem;
            color: #94a3b8;
        }
        
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            grid-template-rows: auto auto 1fr;
            gap: 1.5rem;
            padding: 2rem;
            min-height: calc(100vh - 80px);
        }
        
        .stat-card {
            background: rgba(30, 41, 59, 0.6);
            border: 1px solid rgba(59, 130, 246, 0.3);
            border-radius: 12px;
            padding: 1.5rem;
            backdrop-filter: blur(10px);
            transition: all 0.3s;
            position: relative;
            overflow: hidden;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: linear-gradient(90deg, #3b82f6, #8b5cf6, #ec4899);
            animation: shimmer 3s infinite;
        }
        
        @keyframes shimmer {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 1; }
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            border-color: #3b82f6;
            box-shadow: 0 10px 30px rgba(59, 130, 246, 0.3);
        }
        
        .stat-card.primary { border-left: 4px solid #3b82f6; }
        .stat-card.success { border-left: 4px solid #10b981; }
        .stat-card.warning { border-left: 4px solid #f59e0b; }
        .stat-card.danger { border-left: 4px solid #ef4444; }
        
        .stat-label {
            font-size: 0.9rem;
            color: #94a3b8;
            margin-bottom: 0.5rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .stat-value {
            font-size: 2.5rem;
            font-weight: bold;
            color: #e2e8f0;
            margin: 0.5rem 0;
        }
        
        .stat-unit {
            font-size: 1rem;
            color: #64748b;
            margin-left: 0.5rem;
        }
        
        .stat-icon {
            font-size: 2rem;
            opacity: 0.7;
            float: right;
        }
        
        .chart-container {
            background: rgba(30, 41, 59, 0.6);
            border: 1px solid rgba(59, 130, 246, 0.3);
            border-radius: 12px;
            padding: 1.5rem;
            backdrop-filter: blur(10px);
            grid-column: span 2;
        }
        
        .chart-title {
            font-size: 1.2rem;
            color: #60a5fa;
            margin-bottom: 1rem;
            text-align: center;
        }
        
        .alert-panel {
            background: rgba(30, 41, 59, 0.6);
            border: 1px solid rgba(239, 68, 68, 0.3);
            border-radius: 12px;
            padding: 1.5rem;
            backdrop-filter: blur(10px);
            grid-column: span 2;
            max-height: 400px;
            overflow-y: auto;
        }
        
        .alert-item {
            background: rgba(239, 68, 68, 0.1);
            border-left: 3px solid #ef4444;
            padding: 1rem;
            margin-bottom: 0.5rem;
            border-radius: 6px;
            animation: slideIn 0.5s;
        }
        
        .alert-item.alert-danger {
            background: rgba(239, 68, 68, 0.15);
            border-left-color: #ef4444;
        }
        
        .alert-item.alert-warning {
            background: rgba(245, 158, 11, 0.15);
            border-left-color: #f59e0b;
        }
        
        .alert-item.alert-info {
            background: rgba(59, 130, 246, 0.15);
            border-left-color: #3b82f6;
        }
        
        .alert-content {
            margin: 0.5rem 0;
            color: #e2e8f0;
        }
        
        .alert-device {
            font-size: 0.85rem;
            color: #94a3b8;
            margin-top: 0.25rem;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        
        .alert-time {
            font-size: 0.8rem;
            color: #94a3b8;
        }
        
        .refresh-indicator {
            position: fixed;
            bottom: 2rem;
            right: 2rem;
            background: rgba(59, 130, 246, 0.8);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            z-index: 1000;
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
        
        @media (max-width: 1400px) {
            .dashboard-grid {
                grid-template-columns: repeat(2, 1fr);
            }
            .chart-container, .alert-panel {
                grid-column: span 2;
            }
        }
        
        @media (max-width: 768px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
            .chart-container, .alert-panel {
                grid-column: span 1;
            }
        }
    </style>
</head>
<body>
    <!-- 大屏头部 -->
    <div class="screen-header">
        <div>
            <div class="screen-title">
                <i class="bi bi-lightning-charge-fill"></i> SmartEnergy 智慧能源实时监控大屏
            </div>
        </div>
        <div class="screen-time" id="currentTime"></div>
    </div>

    <!-- 大屏内容 -->
    <div class="dashboard-grid">
        <!-- 总用电量 -->
        <div class="stat-card primary">
            <div class="stat-label">总用电量</div>
            <div class="stat-value">
                <span id="totalElectricity">0</span>
                <span class="stat-unit">kWh</span>
            </div>
            <i class="bi bi-lightning-charge-fill stat-icon text-primary"></i>
        </div>

        <!-- 总用水量 -->
        <div class="stat-card success">
            <div class="stat-label">总用水量</div>
            <div class="stat-value">
                <span id="totalWater">0</span>
                <span class="stat-unit">m³</span>
            </div>
            <i class="bi bi-droplet-fill stat-icon text-success"></i>
        </div>

        <!-- 总天然气消耗量 -->
        <div class="stat-card warning">
            <div class="stat-label">总天然气消耗量</div>
            <div class="stat-value">
                <span id="totalGas">0</span>
                <span class="stat-unit">m³</span>
            </div>
            <i class="bi bi-fire stat-icon text-warning"></i>
        </div>

        <!-- 光伏总发电量 -->
        <div class="stat-card success">
            <div class="stat-label">光伏总发电量</div>
            <div class="stat-value">
                <span id="totalPvGeneration">0</span>
                <span class="stat-unit">kWh</span>
            </div>
            <i class="bi bi-sun-fill stat-icon text-warning"></i>
        </div>

        <!-- 总告警次数 -->
        <div class="stat-card danger">
            <div class="stat-label">总告警次数</div>
            <div class="stat-value">
                <span id="totalAlarms">0</span>
            </div>
            <i class="bi bi-exclamation-triangle-fill stat-icon text-danger"></i>
        </div>

        <!-- 高等级告警数 -->
        <div class="stat-card danger">
            <div class="stat-label">高等级告警</div>
            <div class="stat-value">
                <span id="highLevelAlarms">0</span>
            </div>
            <i class="bi bi-exclamation-circle-fill stat-icon text-danger"></i>
        </div>

        <!-- 中等级告警数 -->
        <div class="stat-card warning">
            <div class="stat-label">中等级告警</div>
            <div class="stat-value">
                <span id="mediumLevelAlarms">0</span>
            </div>
            <i class="bi bi-exclamation-triangle stat-icon text-warning"></i>
        </div>

        <!-- 低等级告警数 -->
        <div class="stat-card primary">
            <div class="stat-label">低等级告警</div>
            <div class="stat-value">
                <span id="lowLevelAlarms">0</span>
            </div>
            <i class="bi bi-info-circle stat-icon text-primary"></i>
        </div>

        <!-- 能耗趋势图表 -->
        <div class="chart-container">
            <div class="chart-title">能耗趋势（近24小时）</div>
            <canvas id="energyTrendChart"></canvas>
        </div>

        <!-- 告警统计图表 -->
        <div class="chart-container">
            <div class="chart-title">告警统计</div>
            <canvas id="alarmChart"></canvas>
        </div>

        <!-- 实时告警列表 -->
        <div class="alert-panel">
            <div class="chart-title text-danger">
                <i class="bi bi-bell-fill"></i> 实时告警信息
            </div>
            <div id="alertList">
                <div class="alert-item">
                    <div class="alert-time">加载中...</div>
                    <div>正在获取告警数据...</div>
                </div>
            </div>
        </div>
    </div>

    <!-- 刷新指示器 -->
    <div class="refresh-indicator">
        <i class="bi bi-arrow-clockwise pulse"></i> 自动刷新中...
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 更新时间
        function updateTime() {
            const now = new Date();
            const timeStr = now.toLocaleString('zh-CN', {
                year: 'numeric',
                month: '2-digit',
                day: '2-digit',
                hour: '2-digit',
                minute: '2-digit',
                second: '2-digit'
            });
            document.getElementById('currentTime').textContent = timeStr;
        }
        updateTime();
        setInterval(updateTime, 1000);

        // 格式化数字
        function formatNumber(num) {
            if (num >= 1000000) {
                return (num / 1000000).toFixed(2) + 'M';
            } else if (num >= 1000) {
                return (num / 1000).toFixed(2) + 'K';
            }
            return num.toFixed(2);
        }

        // 更新统计数据
        function updateStatistics(data) {
            if (!data) return;
            
            document.getElementById('totalElectricity').textContent = 
                formatNumber(data.totalElectricity || 0);
            document.getElementById('totalWater').textContent = 
                formatNumber(data.totalWater || 0);
            document.getElementById('totalGas').textContent = 
                formatNumber(data.totalGas || 0);
            document.getElementById('totalPvGeneration').textContent = 
                formatNumber(data.totalPvGeneration || 0);
            document.getElementById('totalAlarms').textContent = 
                data.totalAlarmCount || 0;
            document.getElementById('highLevelAlarms').textContent = 
                data.highLevelAlarmCount || 0;
            document.getElementById('mediumLevelAlarms').textContent = 
                data.mediumLevelAlarmCount || 0;
            document.getElementById('lowLevelAlarms').textContent = 
                data.lowLevelAlarmCount || 0;
        }

        // 初始化图表
        const energyCtx = document.getElementById('energyTrendChart').getContext('2d');
        const energyChart = new Chart(energyCtx, {
            type: 'line',
            data: {
                labels: [],
                datasets: [{
                    label: '用电量 (kWh)',
                    data: [],
                    borderColor: '#3b82f6',
                    backgroundColor: 'rgba(59, 130, 246, 0.1)',
                    tension: 0.4
                }, {
                    label: '光伏发电 (kWh)',
                    data: [],
                    borderColor: '#f59e0b',
                    backgroundColor: 'rgba(245, 158, 11, 0.1)',
                    tension: 0.4
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        labels: { color: '#e2e8f0' }
                    }
                },
                scales: {
                    x: { ticks: { color: '#94a3b8' }, grid: { color: 'rgba(148, 163, 184, 0.1)' } },
                    y: { ticks: { color: '#94a3b8' }, grid: { color: 'rgba(148, 163, 184, 0.1)' } }
                }
            }
        });

        const alarmCtx = document.getElementById('alarmChart').getContext('2d');
        const alarmChart = new Chart(alarmCtx, {
            type: 'doughnut',
            data: {
                labels: ['高等级', '中等级', '低等级'],
                datasets: [{
                    data: [0, 0, 0],
                    backgroundColor: ['#ef4444', '#f59e0b', '#3b82f6']
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { color: '#e2e8f0' }
                    }
                }
            }
        });

        // 加载实时数据
        async function loadRealtimeData() {
            try {
                const response = await fetch('/SmartEnergy/dashboard/realtime/latest');
                if (!response.ok) {
                    throw new Error('HTTP error! status: ' + response.status);
                }
                const data = await response.json();
                
                // 检查数据是否为空
                if (data && (data.summaryId !== 'DEFAULT' || data.totalAlarmCount !== null)) {
                    updateStatistics(data);
                    
                    // 更新告警图表
                    alarmChart.data.datasets[0].data = [
                        data.highLevelAlarmCount || 0,
                        data.mediumLevelAlarmCount || 0,
                        data.lowLevelAlarmCount || 0
                    ];
                    alarmChart.update();
                } else {
                    console.warn('实时数据为空，显示默认值');
                    // 显示默认值
                    updateStatistics({
                        totalElectricity: 0,
                        totalWater: 0,
                        totalGas: 0,
                        totalPvGeneration: 0,
                        totalAlarmCount: 0,
                        highLevelAlarmCount: 0,
                        mediumLevelAlarmCount: 0,
                        lowLevelAlarmCount: 0
                    });
                }
                
            } catch (error) {
                console.error('加载数据失败:', error);
                // 显示错误提示
                document.getElementById('totalElectricity').textContent = '加载失败';
            }
        }

        // 加载告警列表
        async function loadAlarms() {
            try {
                const response = await fetch('/SmartEnergy/alarm/list?limit=10');
                const alarms = await response.json();
                const alertList = document.getElementById('alertList');
                
                if (alarms && alarms.length > 0) {
                    alertList.innerHTML = alarms.map(alarm => {
                        const levelClass = alarm.alarmLevel === '高' ? 'danger' : 
                                          alarm.alarmLevel === '中' ? 'warning' : 'info';
                        const time = new Date(alarm.occurTime).toLocaleString('zh-CN');
                        return `
                            <div class="alert-item alert-${levelClass}">
                                <div class="alert-time">${time}</div>
                                <div class="alert-content">
                                    <span class="badge bg-${levelClass}">${alarm.alarmLevel}</span>
                                    ${alarm.alarmContent}
                                </div>
                                <div class="alert-device">设备: ${alarm.deviceId}</div>
                            </div>
                        `;
                    }).join('');
                } else {
                    alertList.innerHTML = '<div class="alert-item"><div>暂无告警信息</div></div>';
                }
            } catch (error) {
                console.error('加载告警失败:', error);
                const alertList = document.getElementById('alertList');
                alertList.innerHTML = '<div class="alert-item"><div>加载告警失败</div></div>';
            }
        }

        // 初始加载
        loadRealtimeData();
        loadAlarms();

        // 定时刷新（每分钟）
        setInterval(loadRealtimeData, 60000);
        setInterval(loadAlarms, 30000);

        // 全屏功能（可选）
        function toggleFullscreen() {
            if (!document.fullscreenElement) {
                document.documentElement.requestFullscreen();
            } else {
                document.exitFullscreen();
            }
        }
    </script>
</body>
</html>

