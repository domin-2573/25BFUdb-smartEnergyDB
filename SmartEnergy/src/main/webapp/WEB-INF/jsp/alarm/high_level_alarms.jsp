<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>高等级告警 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-light bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/admin/dashboard">SmartEnergy</a>
            <a href="/SmartEnergy/alarm/manage" class="btn btn-outline-secondary">返回</a>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="text-danger"><i class="bi bi-exclamation-triangle"></i> 高等级告警</h2>
        <c:if test="${not empty highAlarms}">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-danger">
                        <tr>
                            <th>告警编号</th>
                            <th>告警类型</th>
                            <th>关联设备</th>
                            <th>发生时间</th>
                            <th>告警内容</th>
                            <th>处理状态</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="alarm" items="${highAlarms}">
                            <tr>
                                <td>${alarm.alarmId}</td>
                                <td>${alarm.alarmType}</td>
                                <td>${alarm.deviceId}</td>
                                <td>${alarm.occurTime}</td>
                                <td>${alarm.alarmContent}</td>
                                <td><span class="badge bg-warning">${alarm.handleStatus}</span></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <c:if test="${empty highAlarms}">
            <div class="alert alert-info">暂无高等级告警</div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

