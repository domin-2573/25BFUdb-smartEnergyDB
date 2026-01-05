<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>告警统计 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body { background: #f5f7fa; }
        .stat-card { background: white; border-radius: 10px; padding: 1.5rem; margin-bottom: 1.5rem; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .chart-container { height: 300px; }
        .date-filter { background: white; border-radius: 10px; padding: 1rem; margin-bottom: 1.5rem; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/admin/dashboard">
                <i class="bi bi-lightning-charge-fill text-primary"></i> SmartEnergy
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/SmartEnergy/admin/dashboard">仪表板</a>
                <a class="nav-link" href="/SmartEnergy/alarm/manage">告警管理</a>
                <a class="nav-link active" href="/SmartEnergy/alarm/statistics/page">告警统计</a>
                <a class="nav-link" href="/SmartEnergy/alarm/device/relation/page">设备关联</a>
                <a class="nav-link" href="/SmartEnergy/auth/logout">退出</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4"><i class="bi bi-bar-chart-line text-primary"></i> 告警统计分析</h2>
        
        <!-- 日期筛选 -->
        <div class="date-filter">
            <div class="row">
                <div class="col-md-3">
                    <label class="form-label">开始时间</label>
                    <input type="datetime-local" class="form-control" id="startTime" value="${param.startTime}">
                </div>
                <div class="col-md-3">
                    <label class="form-label">结束时间</label>
                    <input type="datetime-local" class="form-control" id="endTime" value="${param.endTime}">
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button class="btn btn-primary w-100" onclick="loadStatistics()">
                        <i class="bi bi-search"></i> 查询
                    </button>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button class="btn btn-outline-secondary w-100" onclick="setLast7Days()">
                        近7天
                    </button>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button class="btn btn-outline-secondary w-100" onclick="setLast30Days()">
                        近30天
                    </button>
                </div>
            </div>
        </div>

        <!-- 告警处理效率统计 -->
        <div class="row">
            <div class="col-md-12">
                <div class="stat-card">
                    <h5>告警处理效率概览</h5>
                    <div id="efficiencyStats" class="text-center">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">加载中...</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <!-- 告警类型分布 -->
            <div class="col-md-6">
                <div class="stat-card">
                    <h5>告警类型分布</h5>
                    <div class="chart-container">
                        <canvas id="typeChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- 告警等级分布 -->
            <div class="col-md-6">
                <div class="stat-card">
                    <h5>告警等级分布</h5>
                    <div class="chart-container">
                        <canvas id="levelChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- 告警趋势分析 -->
        <div class="row">
            <div class="col-md-12">
                <div class="stat-card">
                    <h5>告警趋势分析（按天）</h5>
                    <div class="chart-container">
                        <canvas id="trendChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- 详细数据表格 -->
        <div class="row">
            <div class="col-md-12">
                <div class="stat-card">
                    <h5>告警详细统计</h5>
                    <div class="table-responsive">
                        <table class="table table-hover" id="statisticsTable">
                            <thead>
                                <tr>
                                    <th>日期</th>
                                    <th>总告警数</th>
                                    <th>高等级</th>
                                    <th>中等级</th>
                                    <th>低等级</th>
                                    <th>处理率</th>
                                </tr>
                            </thead>
                            <tbody id="statisticsBody">
                                <!-- 通过JavaScript动态加载 -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let typeChart, levelChart, trendChart;
        
        // 设置默认时间（近7天）
        function setDefaultTime() {
            const end = new Date();
            const start = new Date();
            start.setDate(start.getDate() - 7);
            
            document.getElementById('startTime').value = formatDateTime(start);
            document.getElementById('endTime').value = formatDateTime(end);
        }
        
        function setLast7Days() {
            const end = new Date();
            const start = new Date();
            start.setDate(start.getDate() - 7);
            
            document.getElementById('startTime').value = formatDateTime(start);
            document.getElementById('endTime').value = formatDateTime(end);
            loadStatistics();
        }
        
        function setLast30Days() {
            const end = new Date();
            const start = new Date();
            start.setDate(start.getDate() - 30);
            
            document.getElementById('startTime').value = formatDateTime(start);
            document.getElementById('endTime').value = formatDateTime(end);
            loadStatistics();
        }
        
        function formatDateTime(date) {
            return date.toISOString().slice(0, 16);
        }
        
        // 加载统计信息
        async function loadStatistics() {
            const startTime = document.getElementById('startTime').value;
            const endTime = document.getElementById('endTime').value;
            
            if (!startTime || !endTime) {
                alert('请选择开始时间和结束时间');
                return;
            }
            
            // 加载处理效率
            loadEfficiencyStats(startTime, endTime);
            
            // 加载类型分布
            loadTypeDistribution(startTime, endTime);
            
            // 加载等级分布
            loadLevelDistribution(startTime, endTime);
            
            // 加载趋势分析
            loadTrendAnalysis(startTime, endTime);
        }
        
        // 加载处理效率统计
        async function loadEfficiencyStats(startTime, endTime) {
            try {
                const response = await fetch(`/SmartEnergy/alarm/statistics/handleEfficiency?startTime=${startTime}&endTime=${endTime}`);
                const data = await response.json();
                
                const html = `
                    <div class="row">
                        <div class="col-md-3 text-center">
                            <div class="display-6 text-primary">${data.totalAlarms}</div>
                            <div class="text-muted">总告警数</div>
                        </div>
                        <div class="col-md-3 text-center">
                            <div class="display-6 text-success">${data.handledAlarms}</div>
                            <div class="text-muted">已处理告警</div>
                        </div>
                        <div class="col-md-3 text-center">
                            <div class="display-6 text-warning">${data.handleRate}</div>
                            <div class="text-muted">处理率</div>
                        </div>
                        <div class="col-md-3 text-center">
                            <div class="display-6 text-info">${data.avgResponseTime}</div>
                            <div class="text-muted">平均响应时间</div>
                        </div>
                    </div>
                `;
                
                document.getElementById('efficiencyStats').innerHTML = html;
            } catch (error) {
                console.error('加载处理效率失败:', error);
                document.getElementById('efficiencyStats').innerHTML = '<div class="text-danger">加载失败</div>';
            }
        }
        
        // 加载类型分布
        async function loadTypeDistribution(startTime, endTime) {
            try {
                const response = await fetch(`/SmartEnergy/alarm/statistics/typeDistribution?startTime=${startTime}&endTime=${endTime}`);
                const data = await response.json();
                
                if (typeChart) {
                    typeChart.destroy();
                }
                
                const ctx = document.getElementById('typeChart').getContext('2d');
                const labels = data.data.map(item => item.告警类型);
                const counts = data.data.map(item => item.count);
                
                typeChart = new Chart(ctx, {
                    type: 'pie',
                    data: {
                        labels: labels,
                        datasets: [{
                            data: counts,
                            backgroundColor: [
                                '#FF6384', '#36A2EB', '#FFCE56', '#4BC0C0',
                                '#9966FF', '#FF9F40', '#8AC926', '#1982C4'
                            ]
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: {
                                position: 'right'
                            },
                            title: {
                                display: true,
                                text: '告警类型分布'
                            }
                        }
                    }
                });
            } catch (error) {
                console.error('加载类型分布失败:', error);
            }
        }
        
        // 加载等级分布
        async function loadLevelDistribution(startTime, endTime) {
            try {
                const response = await fetch(`/SmartEnergy/alarm/statistics/levelDistribution?startTime=${startTime}&endTime=${endTime}`);
                const data = await response.json();
                
                if (levelChart) {
                    levelChart.destroy();
                }
                
                const ctx = document.getElementById('levelChart').getContext('2d');
                const labels = data.data.map(item => item.告警等级);
                const counts = data.data.map(item => item.count);
                
                levelChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                            label: '告警数量',
                            data: counts,
                            backgroundColor: [
                                '#EF4444', '#F59E0B', '#10B981'
                            ],
                            borderColor: [
                                '#DC2626', '#D97706', '#059669'
                            ],
                            borderWidth: 1
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                title: {
                                    display: true,
                                    text: '告警数量'
                                }
                            },
                            x: {
                                title: {
                                    display: true,
                                    text: '告警等级'
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                display: false
                            },
                            title: {
                                display: true,
                                text: '告警等级分布'
                            }
                        }
                    }
                });
            } catch (error) {
                console.error('加载等级分布失败:', error);
            }
        }
        
        // 加载趋势分析
        async function loadTrendAnalysis(startTime, endTime) {
            try {
                const response = await fetch(`/SmartEnergy/alarm/statistics/trendByDay?startTime=${startTime}&endTime=${endTime}`);
                const data = await response.json();
                
                if (trendChart) {
                    trendChart.destroy();
                }
                
                // 更新表格数据
                updateStatisticsTable(data.data);
                
                const ctx = document.getElementById('trendChart').getContext('2d');
                const dates = data.data.map(item => item.date);
                const total = data.data.map(item => item.alarm_count);
                const high = data.data.map(item => item.high_count);
                const medium = data.data.map(item => item.medium_count);
                const low = data.data.map(item => item.low_count);
                
                trendChart = new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: dates,
                        datasets: [
                            {
                                label: '总告警数',
                                data: total,
                                borderColor: '#3B82F6',
                                backgroundColor: 'rgba(59, 130, 246, 0.1)',
                                tension: 0.3,
                                fill: true
                            },
                            {
                                label: '高等级',
                                data: high,
                                borderColor: '#EF4444',
                                backgroundColor: 'rgba(239, 68, 68, 0.1)',
                                tension: 0.3
                            },
                            {
                                label: '中等级',
                                data: medium,
                                borderColor: '#F59E0B',
                                backgroundColor: 'rgba(245, 158, 11, 0.1)',
                                tension: 0.3
                            },
                            {
                                label: '低等级',
                                data: low,
                                borderColor: '#10B981',
                                backgroundColor: 'rgba(16, 185, 129, 0.1)',
                                tension: 0.3
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                title: {
                                    display: true,
                                    text: '告警数量'
                                }
                            },
                            x: {
                                title: {
                                    display: true,
                                    text: '日期'
                                }
                            }
                        },
                        plugins: {
                            title: {
                                display: true,
                                text: '告警趋势分析'
                            }
                        }
                    }
                });
            } catch (error) {
                console.error('加载趋势分析失败:', error);
            }
        }
        
        // 更新统计表格
        function updateStatisticsTable(data) {
            const tbody = document.getElementById('statisticsBody');
            tbody.innerHTML = '';
            
            data.forEach(item => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${item.date}</td>
                    <td>${item.alarm_count}</td>
                    <td><span class="badge bg-danger">${item.high_count}</span></td>
                    <td><span class="badge bg-warning">${item.medium_count}</span></td>
                    <td><span class="badge bg-success">${item.low_count}</span></td>
                    <td>
                        <div class="progress" style="height: 20px;">
                            <div class="progress-bar bg-success" role="progressbar" 
                                 style="width: ${Math.random() * 100}%;">
                                ${Math.round(Math.random() * 100)}%
                            </div>
                        </div>
                    </td>
                `;
                tbody.appendChild(row);
            });
        }
        
        // 页面加载时设置默认时间并加载统计
        document.addEventListener('DOMContentLoaded', function() {
            setDefaultTime();
            loadStatistics();
        });
    </script>
</body>
</html>