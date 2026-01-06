<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>运维工单 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-light bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/admin/dashboard">SmartEnergy</a>
            <a href="/SmartEnergy/admin/dashboard" class="btn btn-outline-secondary">返回</a>
        </div>
    </nav>

    <div class="container mt-4">
        <h2><i class="bi bi-tools"></i> 运维工单</h2>
        <c:if test="${not empty workOrderList}">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>工单编号</th>
                        <th>告警编号</th>
                        <th>运维人员ID</th>
                        <th>派单时间</th>
                        <th>处理状态</th>
                        <th>复查状态</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${workOrderList}">
                        <tr>
                            <td>${order.workOrderId}</td>
                            <td>${order.alarmId}</td>
                            <td>${order.maintenancePersonId}</td>
                            <td>${order.dispatchTime}</td>
                            <td><span class="badge bg-info">${order.reviewStatus}</span></td>
                            <td>${order.reviewStatus}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty workOrderList}">
            <div class="alert alert-info">暂无运维工单</div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

