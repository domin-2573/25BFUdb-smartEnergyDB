<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>光伏设备管理 - SmartEnergy</title>
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
        <h2><i class="bi bi-sun"></i> 光伏设备管理</h2>
        
        <c:if test="${not empty pvSummary}">
            <div class="row mb-4">
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5>总设备数</h5>
                            <h3>${pvSummary.totalDevices}</h3>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h5>总装机容量</h5>
                            <h3>${pvSummary.totalCapacity} kW</h3>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <div class="row">
            <div class="col-md-6">
                <h4>正常设备</h4>
                <c:if test="${not empty normalDevices}">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>设备编号</th>
                                <th>设备类型</th>
                                <th>运行状态</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="device" items="${normalDevices}">
                                <tr>
                                    <td>${device.deviceId}</td>
                                    <td>${device.deviceType}</td>
                                    <td><span class="badge bg-success">${device.operationStatus}</span></td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
            <div class="col-md-6">
                <h4>故障设备</h4>
                <c:if test="${not empty faultDevices}">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>设备编号</th>
                                <th>设备类型</th>
                                <th>运行状态</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="device" items="${faultDevices}">
                                <tr>
                                    <td>${device.deviceId}</td>
                                    <td>${device.deviceType}</td>
                                    <td><span class="badge bg-danger">${device.operationStatus}</span></td>
                                    <td>
                                        <button class="btn btn-sm btn-primary" onclick="updateStatus('${device.deviceId}', '正常')">
                                            修复
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateStatus(deviceId, status) {
            fetch('/SmartEnergy/energy/pv/updateStatus', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `deviceId=${deviceId}&status=${status}`
            })
            .then(response => response.text())
            .then(result => {
                if (result === 'success') {
                    alert('更新成功！');
                    location.reload();
                }
            });
        }
    </script>
</body>
</html>

