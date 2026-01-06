<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>历史趋势分析 - SmartEnergy</title>
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
            background: linear-gradient(135deg, #000000 0%, #1a1a2e 50%, #16213e 100%);
            color: #ffffff;
            font-family: 'SF Pro Display', 'Microsoft YaHei', 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            min-height: 100vh;
        }

        .navbar {
            background: rgba(0, 0, 0, 0.8) !important;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(0, 122, 255, 0.3);
        }

        .navbar-brand {
            color: #007AFF !important;
            font-weight: 600;
            font-size: 1.5rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #007AFF 0%, #5856D6 100%);
            border: none;
            border-radius: 25px;
            padding: 0.75rem 1.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 122, 255, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 122, 255, 0.4);
            background: linear-gradient(135deg, #5856D6 0%, #007AFF 100%);
        }

        .btn-outline-secondary {
            border: 1px solid rgba(255, 255, 255, 0.2);
            color: #ffffff;
            border-radius: 25px;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
        }

        .btn-outline-secondary:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: rgba(255, 255, 255, 0.4);
            color: #ffffff;
        }

        .container {
            padding: 2rem;
        }

        h2 {
            color: #007AFF;
            font-weight: 700;
            font-size: 2.5rem;
            margin-bottom: 2rem;
            text-align: center;
            text-shadow: 0 0 30px rgba(0, 122, 255, 0.3);
        }

        .filter-card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            box-shadow:
                0 8px 32px rgba(0, 0, 0, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
        }

        .form-label {
            color: #d1d5db;
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .form-select, .form-control {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: #ffffff;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-select:focus, .form-control:focus {
            background: rgba(255, 255, 255, 0.08);
            border-color: #007AFF;
            box-shadow: 0 0 20px rgba(0, 122, 255, 0.2);
            color: #ffffff;
        }

        .form-select option {
            background: #1a1a2e;
            color: #ffffff;
        }

        .chart-card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            box-shadow:
                0 8px 32px rgba(0, 0, 0, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
        }

        .chart-card h5 {
            color: #007AFF;
            font-weight: 600;
            font-size: 1.3rem;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .table {
            color: #ffffff;
            margin-bottom: 0;
        }

        .table thead th {
            background: rgba(0, 122, 255, 0.1);
            border-bottom: 1px solid rgba(0, 122, 255, 0.3);
            color: #007AFF;
            font-weight: 600;
            padding: 1rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.85rem;
        }

        .table tbody td {
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
            padding: 1rem;
            color: #d1d5db;
        }

        .table tbody tr:hover {
            background: rgba(255, 255, 255, 0.02);
        }

        .badge {
            border-radius: 20px;
            padding: 0.5rem 1rem;
            font-weight: 500;
            font-size: 0.8rem;
        }

        .bg-primary {
            background: linear-gradient(135deg, #007AFF, #5856D6) !important;
        }

        .trend-badge {
            padding: 0.4rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .trend-up {
            background: rgba(255, 59, 48, 0.1);
            color: #FF3B30;
            border-color: rgba(255, 59, 48, 0.3);
        }

        .trend-down {
            background: rgba(52, 199, 89, 0.1);
            color: #34C759;
            border-color: rgba(52, 199, 89, 0.3);
        }

        .alert {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 12px;
            color: #d1d5db;
            backdrop-filter: blur(10px);
        }

        .alert-info {
            border-color: rgba(0, 122, 255, 0.3);
        }

        .alert-info .bi {
            color: #007AFF;
        }

        /* 滚动条美化 */
        ::-webkit-scrollbar {
            width: 6px;
        }

        ::-webkit-scrollbar-track {
            background: rgba(255, 255, 255, 0.05);
        }

        ::-webkit-scrollbar-thumb {
            background: rgba(0, 122, 255, 0.5);
            border-radius: 3px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: rgba(0, 122, 255, 0.7);
        }

        /* 响应式设计 */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            h2 {
                font-size: 2rem;
            }

            .filter-card, .chart-card {
                padding: 1.5rem;
            }

            .table-responsive {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-light bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/admin/dashboard">SmartEnergy</a>
            <div>
                <a href="/SmartEnergy/dashboard/realtime" class="btn btn-primary me-2">
                    <i class="bi bi-tv"></i> 实时大屏
                </a>
                <a href="/SmartEnergy/admin/dashboard" class="btn btn-outline-secondary">返回</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4">
            <i class="bi bi-graph-up"></i> 历史趋势分析
        </h2>

        <!-- 筛选条件 -->
        <div class="filter-card">
            <form id="filterForm" class="row g-3">
                <div class="col-md-3">
                    <label class="form-label">能源类型</label>
                    <select class="form-select" name="energyType" id="energyType">
                        <option value="">全部</option>
                        <option value="电">电</option>
                        <option value="水">水</option>
                        <option value="蒸汽">蒸汽</option>
                        <option value="天然气">天然气</option>
                        <option value="光伏">光伏</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">统计周期</label>
                    <select class="form-select" name="period" id="period">
                        <option value="日">日</option>
                        <option value="周">周</option>
                        <option value="月">月</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <label class="form-label">开始日期</label>
                    <input type="date" class="form-control" name="startDate" id="startDate">
                </div>
                <div class="col-md-3">
                    <label class="form-label">结束日期</label>
                    <input type="date" class="form-control" name="endDate" id="endDate">
                </div>
                <div class="col-12">
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-search"></i> 查询
                    </button>
                    <button type="button" class="btn btn-secondary" onclick="resetFilter()">
                        <i class="bi bi-arrow-clockwise"></i> 重置
                    </button>
                </div>
            </form>
        </div>

        <!-- 趋势图表 -->
        <div class="chart-card">
            <h5 class="mb-3">能耗/发电量趋势</h5>
            <canvas id="trendChart" height="100"></canvas>
        </div>

        <!-- 趋势数据表格 -->
        <div class="chart-card">
            <h5 class="mb-3">趋势数据详情</h5>
            <c:if test="${not empty trendList}">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>趋势编号</th>
                                <th>能源类型</th>
                                <th>统计周期</th>
                                <th>统计时间</th>
                                <th>数值</th>
                                <th>同比增长率</th>
                                <th>环比增长率</th>
                                <th>趋势</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="trend" items="${trendList}">
                                <tr>
                                    <td>${trend.trendId}</td>
                                    <td><span class="badge bg-primary">${trend.energyType}</span></td>
                                    <td>${trend.statisticPeriod}</td>
                                    <td>${trend.statisticTime}</td>
                                    <td><strong>${trend.energyValue}</strong></td>
                                    <td>
                                        <c:if test="${not empty trend.yearOnYearGrowth}">
                                            ${trend.yearOnYearGrowth}%
                                        </c:if>
                                        <c:if test="${empty trend.yearOnYearGrowth}">-</c:if>
                                    </td>
                                    <td>
                                        <c:if test="${not empty trend.monthOnMonthGrowth}">
                                            ${trend.monthOnMonthGrowth}%
                                        </c:if>
                                        <c:if test="${empty trend.monthOnMonthGrowth}">-</c:if>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty trend.yearOnYearGrowth && trend.yearOnYearGrowth > 0}">
                                                <span class="trend-badge trend-up">能耗上升</span>
                                            </c:when>
                                            <c:when test="${not empty trend.yearOnYearGrowth && trend.yearOnYearGrowth < 0}">
                                                <span class="trend-badge trend-down">能耗下降</span>
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
            <c:if test="${empty trendList}">
                <div class="alert alert-info">
                    <i class="bi bi-info-circle"></i> 暂无趋势数据，请选择筛选条件查询
                </div>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 设置默认日期（最近30天）
        const today = new Date();
        const lastMonth = new Date(today);
        lastMonth.setMonth(lastMonth.getMonth() - 1);
        
        document.getElementById('startDate').value = lastMonth.toISOString().split('T')[0];
        document.getElementById('endDate').value = today.toISOString().split('T')[0];

        // 初始化图表
        const ctx = document.getElementById('trendChart').getContext('2d');
        const trendChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: [],
                datasets: []
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'top',
                    },
                    title: {
                        display: true,
                        text: '能耗/发电量趋势图'
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });

        // 更新图表
        function updateChart(trendList) {
            if (!trendList || trendList.length === 0) return;
            
            const labels = trendList.map(t => t.statisticTime);
            const data = trendList.map(t => t.energyValue);
            
            trendChart.data.labels = labels;
            trendChart.data.datasets = [{
                label: '能耗/发电量',
                data: data,
                borderColor: '#3b82f6',
                backgroundColor: 'rgba(59, 130, 246, 0.1)',
                tension: 0.4
            }];
            trendChart.update();
        }

        // 表单提交
        document.getElementById('filterForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            const formData = new FormData(e.target);
            const params = new URLSearchParams(formData);
            
            try {
                const response = await fetch(`/SmartEnergy/dashboard/trend/data?${params}`);
                const data = await response.json();
                updateChart(data);
                // 刷新页面显示数据
                window.location.href = `/SmartEnergy/dashboard/trend?${params}`;
            } catch (error) {
                console.error('查询失败:', error);
                alert('查询失败，请重试');
            }
        });

        // 重置筛选
        function resetFilter() {
            document.getElementById('energyType').value = '';
            document.getElementById('period').value = '日';
            const today = new Date();
            const lastMonth = new Date(today);
            lastMonth.setMonth(lastMonth.getMonth() - 1);
            document.getElementById('startDate').value = lastMonth.toISOString().split('T')[0];
            document.getElementById('endDate').value = today.toISOString().split('T')[0];
        }

        // 页面加载时更新图表
        <c:if test="${not empty trendList}">
        updateChart([
            <c:forEach var="trend" items="${trendList}" varStatus="status">
            {
                statisticTime: '${trend.statisticTime}',
                energyValue: ${trend.energyValue}
            }<c:if test="${!status.last}">,</c:if>
            </c:forEach>
        ]);
        </c:if>
    </script>
</body>
</html>

