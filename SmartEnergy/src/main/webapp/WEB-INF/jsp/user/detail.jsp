<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户详情 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-light bg-white">
        <div class="container-fluid">
            <a class="navbar-brand" href="/SmartEnergy/admin/dashboard">SmartEnergy</a>
            <a href="/SmartEnergy/user/list" class="btn btn-outline-secondary">返回</a>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="card">
            <div class="card-body">
                <h3>用户详情</h3>
                <c:if test="${not empty user}">
                    <table class="table">
                        <tr>
                            <th>用户ID</th>
                            <td>${user.userId}</td>
                        </tr>
                        <tr>
                            <th>姓名</th>
                            <td>${user.name}</td>
                        </tr>
                        <tr>
                            <th>角色</th>
                            <td><span class="badge bg-primary">${user.role}</span></td>
                        </tr>
                    </table>
                </c:if>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

