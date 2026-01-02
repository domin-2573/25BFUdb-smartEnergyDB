<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>回路监测 - SmartEnergy</title>
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
        <h2><i class="bi bi-lightning-charge"></i> 回路监测 - 异常数据</h2>
        <c:if test="${not empty abnormalData}">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th>数据编号</th>
                            <th>配电房编号</th>
                            <th>回路编号</th>
                            <th>采集时间</th>
                            <th>电压(kV)</th>
                            <th>电流(A)</th>
                            <th>功率因数</th>
                            <th>数据状态</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="data" items="${abnormalData}">
                            <tr>
                                <td>${data.dataId}</td>
                                <td>${data.substationId}</td>
                                <td>${data.circuitId}</td>
                                <td>${data.collectTime}</td>
                                <td>${data.voltage}</td>
                                <td>${data.current}</td>
                                <td>${data.powerFactor}</td>
                                <td><span class="badge bg-danger">${data.dataStatus}</span></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        <c:if test="${empty abnormalData}">
            <div class="alert alert-success">暂无异常数据</div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

