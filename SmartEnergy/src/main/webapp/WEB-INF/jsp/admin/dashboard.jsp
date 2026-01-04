<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartEnergy - 智慧能源管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #10b981;
            --danger-color: #ef4444;
            --warning-color: #f59e0b;
            --dark-bg: #1e293b;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
        }
        
        .dashboard-container {
            padding: 2rem 0;
        }
        
        .stat-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            transition: transform 0.3s, box-shadow 0.3s;
            border-left: 4px solid var(--primary-color);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.2);
        }
        
        .stat-card.success {
            border-left-color: var(--secondary-color);
        }
        
        .stat-card.warning {
            border-left-color: var(--warning-color);
        }
        
        .stat-card.danger {
            border-left-color: var(--danger-color);
        }
        
        .stat-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }
        
        .stat-value {
            font-size: 2rem;
            font-weight: bold;
            color: #1e293b;
            margin: 0.5rem 0;
        }
        
        .stat-label {
            color: #64748b;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .chart-container {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .page-header {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .page-title {
            font-size: 2rem;
            font-weight: bold;
            color: #1e293b;
            margin: 0;
        }
        
        .page-subtitle {
            color: #64748b;
            margin-top: 0.5rem;
        }
    </style>
</head>
<body>
    <!-- 导航栏 -->
    <nav class="navbar navbar-expand-lg navbar-light">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold" href="/SmartEnergy/admin/dashboard">
                <i class="bi bi-lightning-charge-fill text-primary"></i> SmartEnergy
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="/SmartEnergy/admin/dashboard">
                            <i class="bi bi-speedometer2"></i> 仪表板
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SmartEnergy/substation/list">
                            <i class="bi bi-building"></i> 配电房
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SmartEnergy/alarm/manage">
                            <i class="bi bi-bell"></i> 告警
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SmartEnergy/energy/pv">
                            <i class="bi bi-sun"></i> 光伏
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SmartEnergy/energy/circuit">
                            <i class="bi bi-lightning-charge"></i> 回路监测
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SmartEnergy/admin/users">
                            <i class="bi bi-people"></i> 用户管理
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SmartEnergy/dashboard/realtime">
                            <i class="bi bi-tv"></i> 实时大屏
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SmartEnergy/auth/logout">
                            <i class="bi bi-box-arrow-right"></i> 退出
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container-fluid dashboard-container">
        <!-- 页面标题 -->
        <div class="page-header">
            <h1 class="page-title">
                <i class="bi bi-speedometer2 text-primary"></i> 智慧能源管理系统
            </h1>
            <p class="page-subtitle">实时监控 · 智能分析 · 高效管理</p>
        </div>

        <!-- 统计卡片 -->
        <div class="row">
            <c:if test="${not empty dashboard}">
                <c:forEach var="entry" items="${dashboard}">
                    <div class="col-md-3 col-sm-6">
                        <div class="stat-card 
                            <c:choose>
                                <c:when test="${entry.key.contains('告警') || entry.key.contains('Alarm')}">danger</c:when>
                                <c:when test="${entry.key.contains('设备') || entry.key.contains('Device')}">warning</c:when>
                                <c:otherwise>success</c:otherwise>
                            </c:choose>">
                            <div class="stat-icon">
                                <c:choose>
                                    <c:when test="${entry.key.contains('告警') || entry.key.contains('Alarm')}">
                                        <i class="bi bi-exclamation-triangle-fill"></i>
                                    </c:when>
                                    <c:when test="${entry.key.contains('设备') || entry.key.contains('Device')}">
                                        <i class="bi bi-cpu-fill"></i>
                                    </c:when>
                                    <c:when test="${entry.key.contains('容量') || entry.key.contains('Capacity')}">
                                        <i class="bi bi-battery-full"></i>
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-graph-up-arrow"></i>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="stat-value">${entry.value}</div>
                            <div class="stat-label">${entry.key}</div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty dashboard}">
                <div class="col-12">
                    <div class="stat-card">
                        <div class="text-center py-5">
                            <i class="bi bi-info-circle text-warning" style="font-size: 3rem;"></i>
                            <h4 class="mt-3">暂无数据</h4>
                            <p class="text-muted">请检查数据库连接和服务配置</p>
                            <a href="/SmartEnergy/admin/dashboard/data" class="btn btn-primary mt-3" target="_blank">
                                <i class="bi bi-arrow-right-circle"></i> 查看API数据
                            </a>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- API接口信息 -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="chart-container">
                    <h5 class="mb-3"><i class="bi bi-code-slash"></i> API接口</h5>
                    <div class="d-flex flex-wrap gap-2">
                        <a href="/SmartEnergy/admin/dashboard/data" class="btn btn-outline-primary" target="_blank">
                            <i class="bi bi-link-45deg"></i> /SmartEnergy/admin/dashboard/data
                        </a>
                        <a href="/SmartEnergy/substation/list" class="btn btn-outline-success" target="_blank">
                            <i class="bi bi-building"></i> 配电房列表
                        </a>
                        <a href="/SmartEnergy/alarm/manage" class="btn btn-outline-danger">
                            <i class="bi bi-bell"></i> 告警管理
                        </a>
                        <a href="/SmartEnergy/energy/pv" class="btn btn-outline-warning">
                            <i class="bi bi-sun"></i> 光伏管理
                        </a>
                        <a href="/SmartEnergy/maintenance/workorder/list" class="btn btn-outline-info">
                            <i class="bi bi-tools"></i> 运维工单
                        </a>
                        <a href="/SmartEnergy/dashboard/realtime" class="btn btn-outline-warning">
                            <i class="bi bi-tv"></i> 实时监控大屏
                        </a>
                        <a href="/SmartEnergy/dashboard/trend" class="btn btn-outline-success">
                            <i class="bi bi-graph-up"></i> 历史趋势分析
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 自动刷新数据（每30秒）
        setInterval(function() {
            fetch('/SmartEnergy/admin/dashboard/data')
                .then(response => response.json())
                .then(data => {
                    console.log('数据已更新', data);
                    // 可以在这里更新页面数据
                })
                .catch(error => console.error('数据更新失败', error));
        }, 30000);
    </script>
</body>
</html>
