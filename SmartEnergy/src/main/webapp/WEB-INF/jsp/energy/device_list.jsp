<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>能耗计量设备管理 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-light bg-white shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/admin/dashboard">
                <i class="bi bi-lightning-charge"></i> SmartEnergy
            </a>
            <div>
                <a href="/SmartEnergy/admin/dashboard" class="btn btn-outline-primary">
                    <i class="bi bi-house"></i> 返回首页
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4">
            <i class="bi bi-speedometer2"></i> 能耗计量设备管理
        </h2>

        <!-- 筛选条件 -->
        <div class="card mb-4">
            <div class="card-body">
                <form method="get" class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label">能源类型</label>
                        <select class="form-select" name="energyType">
                            <option value="">全部</option>
                            <option value="电">电</option>
                            <option value="水">水</option>
                            <option value="蒸汽">蒸汽</option>
                            <option value="天然气">天然气</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">运行状态</label>
                        <select class="form-select" name="status">
                            <option value="">全部</option>
                            <option value="正常">正常</option>
                            <option value="故障">故障</option>
                            <option value="离线">离线</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label">&nbsp;</label>
                        <div>
                            <button type="submit" class="btn btn-primary w-100">
                                <i class="bi bi-search"></i> 查询
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <!-- 设备列表 -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="bi bi-list-ul"></i> 设备列表</h5>
                <span class="badge bg-primary">共 ${deviceList.size()} 台设备</span>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>设备编号</th>
                                <th>能源类型</th>
                                <th>安装位置</th>
                                <th>管径规格</th>
                                <th>通讯协议</th>
                                <th>运行状态</th>
                                <th>校准周期</th>
                                <th>生产厂家</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="device" items="${deviceList}">
                                <tr>
                                    <td>${device.deviceId}</td>
                                    <td>
                                        <span class="badge bg-info">${device.energyType}</span>
                                    </td>
                                    <td>${device.installationLocation}</td>
                                    <td>${device.pipeDiameterSpec}</td>
                                    <td>${device.communicationProtocol}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${device.operationStatus == '正常'}">
                                                <span class="badge bg-success">${device.operationStatus}</span>
                                            </c:when>
                                            <c:when test="${device.operationStatus == '故障'}">
                                                <span class="badge bg-danger">${device.operationStatus}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-warning">${device.operationStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${device.calibrationPeriod}</td>
                                    <td>${device.manufacturer}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty deviceList}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted">
                                        <i class="bi bi-inbox"></i> 暂无设备数据
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

