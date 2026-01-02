<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加用户 - SmartEnergy</title>
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
                <h3>添加用户</h3>
                <form id="addUserForm">
                    <div class="mb-3">
                        <label class="form-label">用户ID</label>
                        <input type="text" class="form-control" name="userId" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">姓名</label>
                        <input type="text" class="form-control" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">密码</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">角色</label>
                        <select class="form-select" name="role" required>
                            <option value="系统管理员">系统管理员</option>
                            <option value="能源管理员">能源管理员</option>
                            <option value="运维人员">运维人员</option>
                            <option value="数据分析师">数据分析师</option>
                            <option value="企业管理层">企业管理层</option>
                            <option value="运维工单管理员">运维工单管理员</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">提交</button>
                </form>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('addUserForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            const formData = new FormData(e.target);
            const data = Object.fromEntries(formData);
            
            const response = await fetch('/SmartEnergy/user/add', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(data)
            });
            
            const result = await response.text();
            if (result === 'success') {
                alert('添加成功！');
                window.location.href = '/SmartEnergy/user/list';
            } else {
                alert('添加失败');
            }
        });
    </script>
</body>
</html>

