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

        .config-card {
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 1.5rem;
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            box-shadow:
                0 8px 32px rgba(0, 0, 0, 0.3),
                inset 0 1px 0 rgba(255, 255, 255, 0.1);
            transition: all 0.3s ease;
        }

        .config-card:hover {
            transform: translateY(-4px);
            border-color: rgba(0, 122, 255, 0.3);
            box-shadow:
                0 20px 60px rgba(0, 0, 0, 0.4),
                0 0 40px rgba(0, 122, 255, 0.1),
                inset 0 1px 0 rgba(255, 255, 255, 0.15);
        }

        .config-card strong {
            color: #007AFF;
            font-weight: 600;
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

        .bg-info {
            background: linear-gradient(135deg, #007AFF, #34C759) !important;
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

        /* 响应式设计 */
        @media (max-width: 768px) {
            .container {
                padding: 1rem;
            }

            h2 {
                font-size: 2rem;
            }

            .config-card {
                padding: 1.5rem;
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

