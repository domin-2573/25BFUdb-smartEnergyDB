<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加配电房 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: #f5f7fa;
        }
        .form-card {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
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
        <div class="form-card">
            <h3 class="mb-4">
                <i class="bi bi-plus-circle text-primary"></i> 添加配电房
            </h3>
            
            <form id="addSubstationForm">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">配电房编号 <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="substationId" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">名称 <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">位置描述 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="location" required>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">电压等级 <span class="text-danger">*</span></label>
                        <select class="form-select" name="voltageLevel" required>
                            <option value="35kV/0.4kV">35kV/0.4kV</option>
                            <option value="10kV/0.4kV">10kV/0.4kV</option>
                        </select>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">变压器数量 <span class="text-danger">*</span></label>
                        <input type="number" class="form-control" name="transformerCount" min="1" max="10" required>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">投运时间 <span class="text-danger">*</span></label>
                        <input type="date" class="form-control" name="operationTime" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">负责人ID <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" name="managerId" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label class="form-label">联系方式 <span class="text-danger">*</span></label>
                    <input type="text" class="form-control" name="contact" required>
                </div>
                
                <div class="d-flex justify-content-end gap-2">
                    <a href="/SmartEnergy/substation/list" class="btn btn-secondary">取消</a>
                    <button type="submit" class="btn btn-primary">
                        <i class="bi bi-check-circle"></i> 提交
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('addSubstationForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            const formData = new FormData(e.target);
            const data = Object.fromEntries(formData);
            
            try {
                const response = await fetch('/SmartEnergy/substation/add', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body: JSON.stringify(data)
                });
                
                const result = await response.text();
                if (result === 'success') {
                    alert('添加成功！');
                    window.location.href = '/SmartEnergy/substation/list';
                } else {
                    alert('添加失败，请重试');
                }
            } catch (error) {
                console.error('Error:', error);
                alert('添加失败：' + error.message);
            }
        });
    </script>
</body>
</html>

