<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>配电房管理 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            background: white !important;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .page-header {
            background: white;
            padding: 2rem;
            margin-bottom: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .table-container {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .table thead {
            background: #2563eb;
            color: white;
        }
        .badge {
            padding: 0.5rem 0.75rem;
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
                        <a class="nav-link" href="/SmartEnergy/admin/dashboard">
                            <i class="bi bi-speedometer2"></i> 仪表板
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="/SmartEnergy/substation/list">
                            <i class="bi bi-building"></i> 配电房
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/SmartEnergy/alarm/manage">
                            <i class="bi bi-bell"></i> 告警
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

    <div class="container-fluid mt-4">
        <!-- 页面标题 -->
        <div class="page-header">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h2 class="mb-0">
                        <i class="bi bi-building text-primary"></i> 配电房管理
                    </h2>
                    <p class="text-muted mb-0 mt-2">管理所有配电房信息</p>
                </div>
                <a href="/SmartEnergy/substation/add" class="btn btn-primary">
                    <i class="bi bi-plus-circle"></i> 添加配电房
                </a>
            </div>
        </div>

        <!-- 数据表格 -->
        <div class="table-container">
            <c:if test="${not empty substations}">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>配电房编号</th>
                            <th>名称</th>
                            <th>位置描述</th>
                            <th>电压等级</th>
                            <th>变压器数量</th>
                            <th>投运时间</th>
                            <th>负责人ID</th>
                            <th>联系方式</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="substation" items="${substations}">
                            <tr>
                                <td><strong>${substation.substationId}</strong></td>
                                <td>${substation.name}</td>
                                <td>${substation.location}</td>
                                <td><span class="badge bg-info">${substation.voltageLevel}</span></td>
                                <td>${substation.transformerCount}</td>
                                <td>${substation.operationTime}</td>
                                <td>${substation.managerId}</td>
                                <td>${substation.contact}</td>
                                <td>
                                    <a href="/SmartEnergy/substation/detail/${substation.substationId}" 
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="bi bi-eye"></i> 详情
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>
            <c:if test="${empty substations}">
                <div class="text-center py-5">
                    <i class="bi bi-inbox text-muted" style="font-size: 3rem;"></i>
                    <p class="text-muted mt-3">暂无配电房数据</p>
                    <a href="/SmartEnergy/substation/add" class="btn btn-primary mt-2">
                        <i class="bi bi-plus-circle"></i> 添加第一个配电房
                    </a>
                </div>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

