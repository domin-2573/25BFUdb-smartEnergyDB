<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>配电房详情 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
        }
        .detail-card {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .info-row {
            padding: 1rem 0;
            border-bottom: 1px solid #e5e7eb;
        }
        .info-label {
            font-weight: 600;
            color: #6b7280;
        }
        .info-value {
            color: #1f2937;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/admin/dashboard">
                <i class="bi bi-lightning-charge-fill text-primary"></i> SmartEnergy
            </a>
            <a href="/SmartEnergy/substation/list" class="btn btn-outline-secondary">
                <i class="bi bi-arrow-left"></i> 返回列表
            </a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="detail-card">
            <h3 class="mb-4">
                <i class="bi bi-building text-primary"></i> 配电房详情
            </h3>
            
            <c:if test="${not empty substation}">
                <div class="info-row">
                    <div class="row">
                        <div class="col-md-3 info-label">配电房编号</div>
                        <div class="col-md-9 info-value"><strong>${substation.substationId}</strong></div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="row">
                        <div class="col-md-3 info-label">名称</div>
                        <div class="col-md-9 info-value">${substation.name}</div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="row">
                        <div class="col-md-3 info-label">位置描述</div>
                        <div class="col-md-9 info-value">${substation.location}</div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="row">
                        <div class="col-md-3 info-label">电压等级</div>
                        <div class="col-md-9 info-value">
                            <span class="badge bg-info">${substation.voltageLevel}</span>
                        </div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="row">
                        <div class="col-md-3 info-label">变压器数量</div>
                        <div class="col-md-9 info-value">${substation.transformerCount} 台</div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="row">
                        <div class="col-md-3 info-label">投运时间</div>
                        <div class="col-md-9 info-value">${substation.operationTime}</div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="row">
                        <div class="col-md-3 info-label">负责人ID</div>
                        <div class="col-md-9 info-value">${substation.managerId}</div>
                    </div>
                </div>
                <div class="info-row">
                    <div class="row">
                        <div class="col-md-3 info-label">联系方式</div>
                        <div class="col-md-9 info-value">${substation.contact}</div>
                    </div>
                </div>
            </c:if>
            <c:if test="${empty substation}">
                <div class="alert alert-warning">
                    <i class="bi bi-exclamation-triangle"></i> 未找到配电房信息
                </div>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

