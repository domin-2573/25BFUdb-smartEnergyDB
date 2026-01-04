<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>光伏发电数据详细展示 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <style>
        .stat-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .stat-value {
            font-size: 2rem;
            font-weight: bold;
        }
        .efficiency-warning {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
        }
        .efficiency-danger {
            background-color: #f8d7da;
            border-left: 4px solid #dc3545;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-light bg-white shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/admin/dashboard">
                <i class="bi bi-sun"></i> SmartEnergy
            </a>
            <div>
                <a href="/SmartEnergy/energy/pv" class="btn btn-outline-secondary me-2">
                    <i class="bi bi-arrow-left"></i> 返回光伏管理
                </a>
                <a href="/SmartEnergy/admin/dashboard" class="btn btn-outline-primary">
                    <i class="bi bi-house"></i> 返回首页
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4">
            <i class="bi bi-lightning-charge-fill text-warning"></i> 光伏发电数据详细展示
        </h2>

        <!-- 查询条件 -->
        <div class="card mb-4">
            <div class="card-body">
                <form id="queryForm" class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">设备编号</label>
                        <input type="text" class="form-control" id="deviceId" name="deviceId" placeholder="输入设备编号">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">开始时间</label>
                        <input type="datetime-local" class="form-control" id="startTime" name="startTime">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">结束时间</label>
                        <input type="datetime-local" class="form-control" id="endTime" name="endTime">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">&nbsp;</label>
                        <div>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-search"></i> 查询
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- 统计卡片 -->
        <div class="row mb-4" id="summaryCards" style="display: none;">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="small">总发电量</div>
                            <div class="stat-value" id="totalGeneration">0</div>
                            <div class="small">kWh</div>
                        </div>
                        <i class="bi bi-lightning-charge-fill" style="font-size: 3rem; opacity: 0.3;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="small">上网电量</div>
                            <div class="stat-value" id="totalGridPower">0</div>
                            <div class="small">kWh</div>
                        </div>
                        <i class="bi bi-grid-3x3-gap-fill" style="font-size: 3rem; opacity: 0.3;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="small">自用电量</div>
                            <div class="stat-value" id="totalSelfConsumption">0</div>
                            <div class="small">kWh</div>
                        </div>
                        <i class="bi bi-house-fill" style="font-size: 3rem; opacity: 0.3;"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <div class="small">平均效率</div>
                            <div class="stat-value" id="avgEfficiency">0</div>
                            <div class="small">%</div>
                        </div>
                        <i class="bi bi-speedometer2" style="font-size: 3rem; opacity: 0.3;"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- 图表区域 -->
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="bi bi-graph-up"></i> 发电量趋势图</h5>
                    </div>
                    <div class="card-body">
                        <canvas id="generationChart" height="100"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- 数据表格 -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="bi bi-table"></i> 详细数据列表</h5>
                <span class="badge bg-primary" id="dataCount">共 0 条记录</span>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>数据编号</th>
                                <th>设备编号</th>
                                <th>并网点编号</th>
                                <th>采集时间</th>
                                <th>发电量 (kWh)</th>
                                <th>上网电量 (kWh)</th>
                                <th>自用电量 (kWh)</th>
                                <th>组串电压 (V)</th>
                                <th>组串电流 (A)</th>
                                <th>逆变器效率 (%)</th>
                                <th>状态</th>
                            </tr>
                        </thead>
                        <tbody id="dataTableBody">
                            <c:forEach var="data" items="${dataList}">
                                <tr class="${data.inverterEfficiency.doubleValue() < 85 ? 'efficiency-danger' : (data.inverterEfficiency.doubleValue() < 90 ? 'efficiency-warning' : '')}">
                                    <td>${data.dataId}</td>
                                    <td>${data.deviceId}</td>
                                    <td>${data.gridPointId}</td>
                                    <td><fmt:formatDate value="${data.collectTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td><fmt:formatNumber value="${data.generation}" pattern="#,##0.00"/></td>
                                    <td><fmt:formatNumber value="${data.gridPower}" pattern="#,##0.00"/></td>
                                    <td><fmt:formatNumber value="${data.selfConsumption}" pattern="#,##0.00"/></td>
                                    <td><fmt:formatNumber value="${data.stringVoltage}" pattern="#,##0.00"/></td>
                                    <td><fmt:formatNumber value="${data.stringCurrent}" pattern="#,##0.00"/></td>
                                    <td>
                                        <span class="badge ${data.inverterEfficiency.doubleValue() < 85 ? 'bg-danger' : (data.inverterEfficiency.doubleValue() < 90 ? 'bg-warning' : 'bg-success')}">
                                            <fmt:formatNumber value="${data.inverterEfficiency}" pattern="#,##0.00"/>%
                                        </span>
                                    </td>
                                    <td>
                                        <c:if test="${data.inverterEfficiency.doubleValue() < 85}">
                                            <span class="badge bg-danger">设备异常</span>
                                        </c:if>
                                        <c:if test="${data.inverterEfficiency.doubleValue() >= 85}">
                                            <span class="badge bg-success">正常</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty dataList}">
                                <tr>
                                    <td colspan="11" class="text-center text-muted">
                                        <i class="bi bi-inbox"></i> 暂无数据，请选择查询条件进行查询
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        let generationChart = null;

        // 初始化图表
        function initChart() {
            const ctx = document.getElementById('generationChart');
            if (generationChart) {
                generationChart.destroy();
            }
            generationChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: [],
                    datasets: [{
                        label: '发电量 (kWh)',
                        data: [],
                        borderColor: '#667eea',
                        backgroundColor: 'rgba(102, 126, 234, 0.1)',
                        tension: 0.4,
                        fill: true
                    }, {
                        label: '上网电量 (kWh)',
                        data: [],
                        borderColor: '#f5576c',
                        backgroundColor: 'rgba(245, 87, 108, 0.1)',
                        tension: 0.4,
                        fill: true
                    }, {
                        label: '自用电量 (kWh)',
                        data: [],
                        borderColor: '#4facfe',
                        backgroundColor: 'rgba(79, 172, 254, 0.1)',
                        tension: 0.4,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'top',
                        },
                        tooltip: {
                            mode: 'index',
                            intersect: false,
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        // 查询表单提交
        document.getElementById('queryForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const deviceId = document.getElementById('deviceId').value;
            const startTime = document.getElementById('startTime').value;
            const endTime = document.getElementById('endTime').value;

            if (!deviceId || !startTime || !endTime) {
                alert('请填写完整的查询条件');
                return;
            }

            try {
                const response = await fetch(`/SmartEnergy/pv/generation/data?deviceId=${deviceId}&startTime=${startTime}&endTime=${endTime}`);
                const data = await response.json();
                
                updateTable(data);
                updateChart(data);
                updateSummary(data);
            } catch (error) {
                console.error('查询失败:', error);
                alert('查询失败，请稍后重试');
            }
        });

        // 更新表格
        function updateTable(data) {
            const tbody = document.getElementById('dataTableBody');
            const countBadge = document.getElementById('dataCount');
            
            if (data.length === 0) {
                tbody.innerHTML = '<tr><td colspan="11" class="text-center text-muted"><i class="bi bi-inbox"></i> 暂无数据</td></tr>';
                countBadge.textContent = '共 0 条记录';
                return;
            }

            countBadge.textContent = `共 ${data.length} 条记录`;
            
            tbody.innerHTML = data.map(item => {
                const efficiency = parseFloat(item.inverterEfficiency);
                const efficiencyClass = efficiency < 85 ? 'efficiency-danger' : (efficiency < 90 ? 'efficiency-warning' : '');
                const efficiencyBadge = efficiency < 85 ? 'bg-danger' : (efficiency < 90 ? 'bg-warning' : 'bg-success');
                const statusBadge = efficiency < 85 ? '<span class="badge bg-danger">设备异常</span>' : '<span class="badge bg-success">正常</span>';
                
                const collectTime = new Date(item.collectTime).toLocaleString('zh-CN');
                
                return `
                    <tr class="${efficiencyClass}">
                        <td>${item.dataId}</td>
                        <td>${item.deviceId}</td>
                        <td>${item.gridPointId}</td>
                        <td>${collectTime}</td>
                        <td>${parseFloat(item.generation).toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2})}</td>
                        <td>${parseFloat(item.gridPower).toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2})}</td>
                        <td>${parseFloat(item.selfConsumption).toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2})}</td>
                        <td>${parseFloat(item.stringVoltage).toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2})}</td>
                        <td>${parseFloat(item.stringCurrent).toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2})}</td>
                        <td><span class="badge ${efficiencyBadge}">${efficiency.toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2})}%</span></td>
                        <td>${statusBadge}</td>
                    </tr>
                `;
            }).join('');
        }

        // 更新图表
        function updateChart(data) {
            if (data.length === 0) return;

            const labels = data.map(item => new Date(item.collectTime).toLocaleString('zh-CN', {month: 'short', day: 'numeric', hour: '2-digit', minute: '2-digit'}));
            const generationData = data.map(item => parseFloat(item.generation));
            const gridPowerData = data.map(item => parseFloat(item.gridPower));
            const selfConsumptionData = data.map(item => parseFloat(item.selfConsumption));

            generationChart.data.labels = labels;
            generationChart.data.datasets[0].data = generationData;
            generationChart.data.datasets[1].data = gridPowerData;
            generationChart.data.datasets[2].data = selfConsumptionData;
            generationChart.update();
        }

        // 更新统计
        function updateSummary(data) {
            if (data.length === 0) {
                document.getElementById('summaryCards').style.display = 'none';
                return;
            }

            document.getElementById('summaryCards').style.display = 'flex';
            
            const totalGeneration = data.reduce((sum, item) => sum + parseFloat(item.generation), 0);
            const totalGridPower = data.reduce((sum, item) => sum + parseFloat(item.gridPower), 0);
            const totalSelfConsumption = data.reduce((sum, item) => sum + parseFloat(item.selfConsumption), 0);
            const avgEfficiency = data.reduce((sum, item) => sum + parseFloat(item.inverterEfficiency), 0) / data.length;

            document.getElementById('totalGeneration').textContent = totalGeneration.toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
            document.getElementById('totalGridPower').textContent = totalGridPower.toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
            document.getElementById('totalSelfConsumption').textContent = totalSelfConsumption.toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
            document.getElementById('avgEfficiency').textContent = avgEfficiency.toLocaleString('zh-CN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
        }

        // 初始化
        initChart();
        <c:if test="${not empty dataList}">
            updateSummary([
                <c:forEach var="data" items="${dataList}" varStatus="status">
                    {
                        generation: ${data.generation},
                        gridPower: ${data.gridPower},
                        selfConsumption: ${data.selfConsumption},
                        inverterEfficiency: ${data.inverterEfficiency},
                        collectTime: '${data.collectTime}'
                    }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ]);
        </c:if>
    </script>
</body>
</html>

