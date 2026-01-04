<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登录 - SmartEnergy智慧能源管理系统</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            padding: 3rem;
            width: 100%;
            max-width: 450px;
            animation: slideUp 0.5s ease-out;
        }
        
        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 2rem;
        }
        
        .login-icon {
            font-size: 4rem;
            color: #667eea;
            margin-bottom: 1rem;
        }
        
        .login-title {
            font-size: 2rem;
            font-weight: bold;
            color: #1e293b;
            margin: 0;
        }
        
        .login-subtitle {
            color: #64748b;
            margin-top: 0.5rem;
        }
        
        .form-floating {
            margin-bottom: 1.5rem;
        }
        
        .form-control {
            border-radius: 10px;
            border: 2px solid #e2e8f0;
            padding: 0.75rem 1rem;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 10px;
            padding: 0.75rem;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            transition: transform 0.2s, box-shadow 0.2s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }
        
        .alert {
            border-radius: 10px;
            border: none;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <i class="bi bi-lightning-charge-fill login-icon"></i>
            <h1 class="login-title">SmartEnergy</h1>
            <p class="login-subtitle">智慧能源管理系统</p>
        </div>
        
        <div id="alertContainer"></div>
        
        <form id="loginForm">
            <div class="form-floating">
                <input type="text" class="form-control" id="userId" name="userId" placeholder="用户ID" required>
                <label for="userId"><i class="bi bi-person"></i> 用户ID</label>
            </div>
            
            <div class="form-floating">
                <input type="password" class="form-control" id="password" name="password" placeholder="密码" required>
                <label for="password"><i class="bi bi-lock"></i> 密码</label>
            </div>
            
            <button type="submit" class="btn btn-primary btn-login">
                <i class="bi bi-box-arrow-in-right"></i> 登录
            </button>
        </form>
        
        <div class="text-center mt-3">
            <small class="text-muted">
                <i class="bi bi-shield-check"></i> 安全登录 · 数据加密
            </small>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('loginForm').addEventListener('submit', async function(e) {
            e.preventDefault();
            
            const userId = document.getElementById('userId').value;
            const password = document.getElementById('password').value;
            const alertContainer = document.getElementById('alertContainer');
            
            // 清除之前的提示
            alertContainer.innerHTML = '';
            
            try {
                const formData = new URLSearchParams();
                formData.append('userId', userId);
                formData.append('password', password);
                
                const response = await fetch('/SmartEnergy/auth/login', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    },
                    body: formData
                });
                
                // 检查响应状态
                if (!response.ok) {
                    // 如果响应不是200-299，尝试读取错误信息
                    const errorText = await response.text();
                    console.error('HTTP Error:', response.status, errorText);
                    alertContainer.innerHTML = `<div class="alert alert-danger"><i class="bi bi-exclamation-triangle"></i> 服务器错误 (${response.status})，请检查控制台</div>`;
                    return;
                }
                
                // 检查响应内容类型
                const contentType = response.headers.get('content-type');
                if (!contentType || !contentType.includes('application/json')) {
                    const text = await response.text();
                    console.error('Non-JSON response:', text);
                    alertContainer.innerHTML = '<div class="alert alert-danger"><i class="bi bi-exclamation-triangle"></i> 服务器返回格式错误，请检查控制台</div>';
                    return;
                }
                
                const result = await response.json();
                
                if (result.success) {
                    // 登录成功
                    alertContainer.innerHTML = '<div class="alert alert-success"><i class="bi bi-check-circle"></i> 登录成功，正在跳转...</div>';
                    setTimeout(() => {
                        window.location.href = result.redirect || '/SmartEnergy/admin/dashboard';
                    }, 1000);
                } else {
                    // 登录失败
                    let message = result.message || '登录失败';
                    if (result.remainingAttempts !== undefined) {
                        message += ` (剩余尝试次数: ${result.remainingAttempts})`;
                    }
                    alertContainer.innerHTML = `<div class="alert alert-danger"><i class="bi bi-exclamation-triangle"></i> ${message}</div>`;
                }
            } catch (error) {
                console.error('Login error:', error);
                alertContainer.innerHTML = `<div class="alert alert-danger"><i class="bi bi-exclamation-triangle"></i> 网络错误: ${error.message}，请检查控制台</div>`;
            }
        });
    </script>
</body>
</html>
