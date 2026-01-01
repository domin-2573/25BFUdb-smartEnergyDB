<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>智慧能源管理系统 - 仪表板</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
        }
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
        .card {
            background: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            border-left: 4px solid #4CAF50;
        }
        .card h3 {
            margin-top: 0;
            color: #666;
        }
        .card .value {
            font-size: 24px;
            font-weight: bold;
            color: #333;
        }
        .api-link {
            margin-top: 20px;
            padding: 10px;
            background: #e3f2fd;
            border-radius: 5px;
        }
        .api-link a {
            color: #1976d2;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>智慧能源管理系统 - 仪表板</h1>
        
        <div class="dashboard-grid">
            <c:if test="${not empty dashboard}">
                <c:forEach var="entry" items="${dashboard}">
                    <div class="card">
                        <h3>${entry.key}</h3>
                        <div class="value">${entry.value}</div>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty dashboard}">
                <div class="card">
                    <h3>提示</h3>
                    <p>暂无数据，请检查数据库连接和服务配置。</p>
                </div>
            </c:if>
        </div>
        
        <div class="api-link">
            <p><strong>API接口：</strong></p>
            <p>获取JSON数据：<a href="/energy/admin/dashboard/data" target="_blank">/energy/admin/dashboard/data</a></p>
        </div>
    </div>
</body>
</html>

