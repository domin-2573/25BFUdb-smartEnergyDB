<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>大屏配置管理 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f5f7fa; }
        .config-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-light bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/admin/dashboard">SmartEnergy</a>
            <div>
                <a href="/SmartEnergy/dashboard/realtime" class="btn btn-primary me-2">
                    <i class="bi bi-tv"></i> 查看大屏
                </a>
                <a href="/SmartEnergy/admin/dashboard" class="btn btn-outline-secondary">返回</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4">
            <i class="bi bi-gear"></i> 大屏展示配置管理
        </h2>
        
        <c:if test="${not empty configList}">
            <c:forEach var="config" items="${configList}">
                <div class="config-card">
                    <div class="row">
                        <div class="col-md-3">
                            <strong>配置编号:</strong> ${config.configId}
                        </div>
                        <div class="col-md-3">
                            <strong>展示模块:</strong> 
                            <span class="badge bg-primary">${config.displayModule}</span>
                        </div>
                        <div class="col-md-3">
                            <strong>刷新频率:</strong> ${config.refreshFrequency}
                        </div>
                        <div class="col-md-3">
                            <strong>权限等级:</strong> 
                            <span class="badge bg-info">${config.permissionLevel}</span>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-6">
                            <strong>展示字段:</strong> ${config.displayFields}
                        </div>
                        <div class="col-md-6">
                            <strong>排序规则:</strong> ${config.sortRule}
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:if>
        <c:if test="${empty configList}">
            <div class="alert alert-info">
                <i class="bi bi-info-circle"></i> 暂无配置数据
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

