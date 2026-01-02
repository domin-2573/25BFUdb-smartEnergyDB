<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>设备台账 - SmartEnergy</title>
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
        <h2><i class="bi bi-clipboard-data"></i> 设备台账</h2>
        <c:if test="${not empty ledgerList}">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>台账编号</th>
                        <th>设备名称</th>
                        <th>设备类型</th>
                        <th>安装时间</th>
                        <th>质保期</th>
                        <th>报废状态</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="ledger" items="${ledgerList}">
                        <tr>
                            <td>${ledger.ledgerId}</td>
                            <td>${ledger.equipmentName}</td>
                            <td>${ledger.equipmentType}</td>
                            <td>${ledger.installTime}</td>
                            <td>${ledger.warrantyPeriod} 年</td>
                            <td><span class="badge bg-secondary">${ledger.scrapStatus}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${empty ledgerList}">
            <div class="alert alert-info">暂无设备台账数据</div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

