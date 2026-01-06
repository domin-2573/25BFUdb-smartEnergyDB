<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>设备台账 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .badge-normal {
            background-color: #28a745;
        }
        .badge-scrapped {
            background-color: #dc3545;
        }
        .badge-type {
            background-color: #6c757d;
        }
    </style>
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
        
        <!-- 添加简单的统计信息 -->
        <div class="row mb-3">
            <div class="col-md-12">
                <div class="alert alert-light">
                    <strong>统计信息：</strong>
                    共 <span class="badge bg-primary">${ledgerList.size()}</span> 台设备
                </div>
            </div>
        </div>
        
        <c:if test="${not empty ledgerList}">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>台账编号</th>
                        <th>设备名称</th>
                        <th>设备类型</th>
                        <th>型号规格</th>
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
                            <td>
                                <span class="badge badge-type">${ledger.equipmentType}</span>
                            </td>
                            <td>${ledger.modelSpecification}</td>
                            <td>
                                <fmt:formatDate value="${ledger.installTime}" pattern="yyyy-MM-dd" />
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${ledger.warrantyPeriodYears != null}">
                                        ${ledger.warrantyPeriodYears} 年
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-muted">无</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${ledger.scrapStatus == '正常使用'}">
                                        <span class="badge badge-normal">${ledger.scrapStatus}</span>
                                    </c:when>
                                    <c:when test="${ledger.scrapStatus == '已报废'}">
                                        <span class="badge badge-scrapped">${ledger.scrapStatus}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-secondary">${ledger.scrapStatus}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <c:if test="${empty ledgerList}">
            <div class="alert alert-info">
                <h5><i class="bi bi-info-circle"></i> 暂无设备台账数据</h5>
                <p>请检查数据库连接或添加设备台账信息。</p>
            </div>
        </c:if>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 简单的调试代码
        console.log("设备台账页面加载完成");
        console.log("设备数量：", ${ledgerList.size()});
    </script>
</body>
</html>