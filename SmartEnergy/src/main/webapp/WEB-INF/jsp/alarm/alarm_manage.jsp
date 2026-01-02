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
        .alert-card { background: white; border-radius: 10px; padding: 1.5rem; margin-bottom: 1rem; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .alert-high { border-left: 4px solid #ef4444; }
        .alert-medium { border-left: 4px solid #f59e0b; }
        .alert-low { border-left: 4px solid #10b981; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/admin/dashboard">
                <i class="bi bi-lightning-charge-fill text-primary"></i> SmartEnergy
            </a>
            <div class="navbar-nav ms-auto">
                <a class="nav-link" href="/SmartEnergy/admin/dashboard">仪表板</a>
                <a class="nav-link active" href="/SmartEnergy/alarm/manage">告警管理</a>
                <a class="nav-link" href="/SmartEnergy/auth/logout">退出</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4"><i class="bi bi-bell text-danger"></i> 告警管理</h2>
        
        <!-- 高等级告警 -->
        <div class="alert-card alert-high">
            <h5 class="text-danger">高等级告警</h5>
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
                <p class="text-muted">暂无高等级告警</p>
            </c:if>
        </div>

        <!-- 未处理告警 -->
        <div class="alert-card">
            <h5>未处理告警</h5>
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
                                    <td><span class="badge bg-danger">${alarm.alarmLevel}</span></td>
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
                <p class="text-muted">暂无未处理告警</p>
            </c:if>
        </div>

        <!-- 处理中告警 -->
        <div class="alert-card">
            <h5>处理中告警</h5>
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
                <p class="text-muted">暂无处理中告警</p>
            </c:if>
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
    </script>
</body>
</html>

