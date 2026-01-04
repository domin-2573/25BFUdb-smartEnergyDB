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
        body { background: #f5f7fa; }
        .filter-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .chart-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .trend-badge {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.85rem;
        }
        .trend-up { background: #fee2e2; color: #dc2626; }
        .trend-down { background: #dcfce7; color: #16a34a; }
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

