<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>告警管理 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body { background: #f5f7fa; }
        .alert-card { 
            background: white; 
            border-radius: 10px; 
            padding: 1.5rem; 
            margin-bottom: 1rem; 
            box-shadow: 0 2px 10px rgba(0,0,0,0.1); 
        }
        .alert-high { border-left: 4px solid #ef4444; }
        .alert-medium { border-left: 4px solid #f59e0b; }
        .alert-low { border-left: 4px solid #10b981; }
        .accordion-button:not(.collapsed) {
            background-color: transparent;
            box-shadow: none;
        }
        .badge-high { background-color: #ef4444 !important; }
        .badge-medium { background-color: #f59e0b !important; }
        .badge-low { background-color: #10b981 !important; }
        .accordion-body {
            padding: 1rem 0 0 0;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/alarm/manage">
                <i class="bi bi-bell-fill text-danger"></i> SmartEnergy 告警中心
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link active" href="/SmartEnergy/alarm/manage">
                    <i class="bi bi-house-door"></i> 告警管理
                </a>
                <a class="nav-link" href="/SmartEnergy/alarm/statistics/page">
                    <i class="bi bi-bar-chart"></i> 告警统计
                </a>
                <a class="nav-link" href="/SmartEnergy/alarm/device/relation/page">
                    <i class="bi bi-diagram-3"></i> 设备关联
                </a>
                <a class="nav-link" href="/SmartEnergy/auth/logout">
                    <i class="bi bi-box-arrow-right"></i> 退出
                </a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4"><i class="bi bi-bell text-danger"></i> 告警管理</h2>
        
        <div class="accordion" id="alarmAccordion">
        
            <!-- 高等级告警 -->
            <div class="alert-card alert-high">
                <div class="accordion-item border-0">
                    <h2 class="accordion-header" id="headingHigh">
                        <button class="accordion-button collapsed p-0 bg-transparent" type="button" 
                                data-bs-toggle="collapse" data-bs-target="#collapseHigh" 
                                aria-expanded="false" aria-controls="collapseHigh">
                            <h5 class="text-danger mb-0">
                                <i class="bi bi-chevron-right accordion-arrow"></i>
                                高等级告警
                                <c:if test="${not empty highLevelAlarms}">
                                    <span class="badge bg-danger ms-2">${highLevelAlarms.size()}</span>
                                </c:if>
                            </h5>
                        </button>
                    </h2>
                    <div id="collapseHigh" class="accordion-collapse collapse" 
                         aria-labelledby="headingHigh" data-bs-parent="#alarmAccordion">
                        <div class="accordion-body">
                            <c:if test="${not empty highLevelAlarms}">
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>告警编号</th>
                                                <th>告警类型</th>
                                                <th>发生时间</th>
                                                <th>告警内容</th>
                                                <th>处理状态</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="alarm" items="${highLevelAlarms}">
                                                <tr>
                                                    <td>${alarm.alarmId}</td>
                                                    <td>${alarm.alarmType}</td>
                                                    <td>${alarm.occurTime}</td>
                                                    <td>${alarm.alarmContent}</td>
                                                    <td><span class="badge bg-warning">${alarm.handleStatus}</span></td>
                                                    <td>
                                                        <button class="btn btn-sm btn-primary" onclick="updateStatus('${alarm.alarmId}', '处理中')">
                                                            处理
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                            <c:if test="${empty highLevelAlarms}">
                                <p class="text-muted mb-0">暂无高等级告警</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 未处理告警 -->
            <div class="alert-card">
                <div class="accordion-item border-0">
                    <h2 class="accordion-header" id="headingUnhandled">
                        <button class="accordion-button collapsed p-0 bg-transparent" type="button" 
                                data-bs-toggle="collapse" data-bs-target="#collapseUnhandled" 
                                aria-expanded="false" aria-controls="collapseUnhandled">
                            <h5 class="mb-0">
                                <i class="bi bi-chevron-right accordion-arrow"></i>
                                未处理告警
                                <c:if test="${not empty unhandledAlarms}">
                                    <span class="badge bg-warning ms-2">${unhandledAlarms.size()}</span>
                                </c:if>
                            </h5>
                        </button>
                    </h2>
                    <div id="collapseUnhandled" class="accordion-collapse collapse" 
                         aria-labelledby="headingUnhandled" data-bs-parent="#alarmAccordion">
                        <div class="accordion-body">
                            <c:if test="${not empty unhandledAlarms}">
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>告警编号</th>
                                                <th>告警类型</th>
                                                <th>告警等级</th>
                                                <th>发生时间</th>
                                                <th>告警内容</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="alarm" items="${unhandledAlarms}">
                                                <tr>
                                                    <td>${alarm.alarmId}</td>
                                                    <td>${alarm.alarmType}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${alarm.alarmLevel == '高' || alarm.alarmLevel == 'HIGH' || alarm.alarmLevel == 'high'}">
                                                                <span class="badge badge-high">${alarm.alarmLevel}</span>
                                                            </c:when>
                                                            <c:when test="${alarm.alarmLevel == '中' || alarm.alarmLevel == 'MEDIUM' || alarm.alarmLevel == 'medium'}">
                                                                <span class="badge badge-medium">${alarm.alarmLevel}</span>
                                                            </c:when>
                                                            <c:when test="${alarm.alarmLevel == '低' || alarm.alarmLevel == 'LOW' || alarm.alarmLevel == 'low'}">
                                                                <span class="badge badge-low">${alarm.alarmLevel}</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">${alarm.alarmLevel}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${alarm.occurTime}</td>
                                                    <td>${alarm.alarmContent}</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-primary" onclick="updateStatus('${alarm.alarmId}', '处理中')">
                                                            处理
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                            <c:if test="${empty unhandledAlarms}">
                                <p class="text-muted mb-0">暂无未处理告警</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 处理中告警 -->
            <div class="alert-card">
                <div class="accordion-item border-0">
                    <h2 class="accordion-header" id="headingHandling">
                        <button class="accordion-button collapsed p-0 bg-transparent" type="button" 
                                data-bs-toggle="collapse" data-bs-target="#collapseHandling" 
                                aria-expanded="false" aria-controls="collapseHandling">
                            <h5 class="mb-0">
                                <i class="bi bi-chevron-right accordion-arrow"></i>
                                处理中告警
                                <c:if test="${not empty handlingAlarms}">
                                    <span class="badge bg-info ms-2">${handlingAlarms.size()}</span>
                                </c:if>
                            </h5>
                        </button>
                    </h2>
                    <div id="collapseHandling" class="accordion-collapse collapse" 
                         aria-labelledby="headingHandling" data-bs-parent="#alarmAccordion">
                        <div class="accordion-body">
                            <c:if test="${not empty handlingAlarms}">
                                <div class="table-responsive">
                                    <table class="table table-sm">
                                        <thead>
                                            <tr>
                                                <th>告警编号</th>
                                                <th>告警类型</th>
                                                <th>发生时间</th>
                                                <th>告警内容</th>
                                                <th>操作</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="alarm" items="${handlingAlarms}">
                                                <tr>
                                                    <td>${alarm.alarmId}</td>
                                                    <td>${alarm.alarmType}</td>
                                                    <td>${alarm.occurTime}</td>
                                                    <td>${alarm.alarmContent}</td>
                                                    <td>
                                                        <button class="btn btn-sm btn-success" onclick="updateStatus('${alarm.alarmId}', '已结案')">
                                                            结案
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                            <c:if test="${empty handlingAlarms}">
                                <p class="text-muted mb-0">暂无处理中告警</p>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function updateStatus(alarmId, status) {
            fetch('/SmartEnergy/alarm/updateStatus', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `alarmId=${alarmId}&status=${status}`
            })
            .then(response => response.text())
            .then(result => {
                if (result === 'success') {
                    alert('更新成功！');
                    location.reload();
                } else {
                    alert('更新失败');
                }
            });
        }
        
        // 添加折叠图标动画
        document.addEventListener('DOMContentLoaded', function() {
            const accordionButtons = document.querySelectorAll('.accordion-button');
            accordionButtons.forEach(button => {
                button.addEventListener('click', function() {
                    const icon = this.querySelector('.bi-chevron-right');
                    if (this.classList.contains('collapsed')) {
                        icon.classList.remove('bi-chevron-right');
                        icon.classList.add('bi-chevron-down');
                    } else {
                        icon.classList.remove('bi-chevron-down');
                        icon.classList.add('bi-chevron-right');
                    }
                });
            });
        });
    </script>
</body>
</html>