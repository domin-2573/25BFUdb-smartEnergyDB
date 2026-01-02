<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>系统配置 - SmartEnergy</title>
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
        <h2><i class="bi bi-gear"></i> 系统配置</h2>
        <div class="card">
            <div class="card-body">
                <h5>告警规则配置</h5>
                <p class="text-muted">配置告警阈值和规则</p>
            </div>
        </div>
        <div class="card mt-3">
            <div class="card-body">
                <h5>峰谷时段划分</h5>
                <p class="text-muted">配置峰谷时段参数</p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

