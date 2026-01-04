<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>能耗监测数据 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .quality-poor {
            background-color: #f8d7da;
            border-left: 4px solid #dc3545;
        }
        .quality-medium {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
        }
        .quality-good {
            background-color: #d1e7dd;
            border-left: 4px solid #198754;
        }
    </style>
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
            <i class="bi bi-graph-up"></i> 能耗监测数据
        </h2>

        <!-- 查询条件 -->
        <div class="card mb-4">
            <div class="card-body">
                <form method="get" class="row g-3">
                    <div class="col-md-3">
                        <label class="form-label">厂区编号</label>
                        <input type="text" class="form-control" name="factoryId" placeholder="输入厂区编号">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">开始时间</label>
                        <input type="datetime-local" class="form-control" name="startTime">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label">结束时间</label>
                        <input type="datetime-local" class="form-control" name="endTime">
                    </div>
                    <div class="col-md-3">
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

        <!-- 数据列表 -->
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="bi bi-table"></i> 监测数据列表</h5>
                <span class="badge bg-primary">共 ${dataList.size()} 条记录</span>
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-light">
                            <tr>
                                <th>数据编号</th>
                                <th>设备编号</th>
                                <th>采集时间</th>
                                <th>能耗值</th>
                                <th>单位</th>
                                <th>数据质量</th>
                                <th>核实状态</th>
                                <th>所属厂区</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="data" items="${dataList}">
                                <tr class="quality-${data.dataQuality == '优' ? 'good' : (data.dataQuality == '良' ? 'good' : (data.dataQuality == '中' ? 'medium' : 'poor'))}">
                                    <td>${data.dataId}</td>
                                    <td>${data.deviceId}</td>
                                    <td><fmt:formatDate value="${data.collectTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td><fmt:formatNumber value="${data.energyValue}" pattern="#,##0.00"/></td>
                                    <td>${data.unit}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${data.dataQuality == '优' || data.dataQuality == '良'}">
                                                <span class="badge bg-success">${data.dataQuality}</span>
                                            </c:when>
                                            <c:when test="${data.dataQuality == '中'}">
                                                <span class="badge bg-warning">${data.dataQuality}</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-danger">${data.dataQuality}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:if test="${data.dataQuality == '中' || data.dataQuality == '差'}">
                                            <span class="badge bg-warning">待核实</span>
                                        </c:if>
                                        <c:if test="${data.dataQuality == '优' || data.dataQuality == '良'}">
                                            <span class="badge bg-success">已核实</span>
                                        </c:if>
                                    </td>
                                    <td>${data.factoryAreaId}</td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty dataList}">
                                <tr>
                                    <td colspan="8" class="text-center text-muted">
                                        <i class="bi bi-inbox"></i> 暂无监测数据，请选择查询条件进行查询
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

