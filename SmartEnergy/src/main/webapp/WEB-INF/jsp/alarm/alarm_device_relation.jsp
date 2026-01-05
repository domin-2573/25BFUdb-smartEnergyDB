<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>告警设备关联 - SmartEnergy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body { background: #f5f7fa; }
        .card-container { background: white; border-radius: 10px; padding: 1.5rem; margin-bottom: 1.5rem; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .date-filter { background: white; border-radius: 10px; padding: 1rem; margin-bottom: 1.5rem; }
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
                <a class="nav-link" href="/SmartEnergy/alarm/manage">告警管理</a>
                <a class="nav-link" href="/SmartEnergy/alarm/statistics/page">告警统计</a>
                <a class="nav-link active" href="/SmartEnergy/alarm/device/relation/page">设备关联</a>
                <a class="nav-link" href="/SmartEnergy/auth/logout">退出</a>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <h2 class="mb-4"><i class="bi bi-hdd-network text-primary"></i> 告警设备关联分析</h2>
        
        <!-- 日期筛选 -->
        <div class="date-filter">
            <div class="row">
                <div class="col-md-3">
                    <label class="form-label">开始时间</label>
                    <input type="datetime-local" class="form-control" id="startTime" value="${param.startTime}">
                </div>
                <div class="col-md-3">
                    <label class="form-label">结束时间</label>
                    <input type="datetime-local" class="form-control" id="endTime" value="${param.endTime}">
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button class="btn btn-primary w-100" onclick="loadDeviceAnalysis()">
                        <i class="bi bi-search"></i> 查询
                    </button>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button class="btn btn-outline-secondary w-100" onclick="setLast30Days()">
                        近30天
                    </button>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button class="btn btn-outline-secondary w-100" onclick="setLast90Days()">
                        近90天
                    </button>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12">
                <div class="card-container">
                    <h5>告警设备关联分析</h5>
                    <p id="statusMessage">请选择时间范围并点击查询</p>
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>设备编号</th>
                                    <th>设备类型</th>
                                    <th>告警次数</th>
                                    <th>高等级</th>
                                    <th>中等级</th>
                                    <th>低等级</th>
                                    <th>最后告警时间</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="deviceTableBody">
                                <!-- 通过JavaScript动态加载 -->
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 设备详情Modal -->
    <div class="modal fade" id="deviceDetailModal" tabindex="-1" aria-labelledby="deviceDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="deviceDetailModalLabel">设备详情</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" id="deviceDetailContent">
                    <!-- 内容通过JavaScript动态加载 -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

<script>
    // 全局变量声明
    let deviceDetailModal = null;
    
    // 设置最近30天
    function setLast30Days() {
        const end = new Date();
        const start = new Date();
        start.setDate(start.getDate() - 30);
        
        document.getElementById('startTime').value = formatDateTimeLocal(start);
        document.getElementById('endTime').value = formatDateTimeLocal(end);
    }
    
    // 设置最近90天
    function setLast90Days() {
        const end = new Date();
        const start = new Date();
        start.setDate(start.getDate() - 90);
        
        document.getElementById('startTime').value = formatDateTimeLocal(start);
        document.getElementById('endTime').value = formatDateTimeLocal(end);
    }
    
    // 格式化日期为datetime-local格式
    function formatDateTimeLocal(date) {
        const year = date.getFullYear();
        const month = String(date.getMonth() + 1).padStart(2, '0');
        const day = String(date.getDate()).padStart(2, '0');
        const hours = String(date.getHours()).padStart(2, '0');
        const minutes = String(date.getMinutes()).padStart(2, '0');
        
        return `${year}-${month}-${day}T${hours}:${minutes}`;
    }
    
    // 加载设备关联分析
    async function loadDeviceAnalysis() {
        console.log('开始加载设备分析数据...');
        const startTime = document.getElementById('startTime').value;
        const endTime = document.getElementById('endTime').value;
        
        console.log('时间范围:', startTime, '到', endTime);
        
        if (!startTime || !endTime) {
            alert('请选择开始时间和结束时间');
            return;
        }
        
        try {
            document.getElementById('statusMessage').innerText = '加载数据中...';
            
            const url = '/SmartEnergy/alarm/device/frequentAlarms?startTime=' + encodeURIComponent(startTime) + 
                        '&endTime=' + encodeURIComponent(endTime) + '&limit=20';
            
            console.log('请求URL:', url);
            
            const response = await fetch(url);
            
            // 检查响应状态
            if (!response.ok) {
                throw new Error('网络响应不正常: ' + response.status + ' ' + response.statusText);
            }
            
            const data = await response.json();
            console.log('API返回数据:', data);
            
            // 检查数据结构
            if (!data) {
                throw new Error('API返回数据为空');
            }
            
            if (!data.data || data.data.length === 0) {
                document.getElementById('statusMessage').innerText = '没有找到相关设备数据';
                return;
            }
            
            console.log('找到', data.data.length, '条记录');
            
            const tbody = document.getElementById('deviceTableBody');
            if (!tbody) {
                console.error('找不到元素: deviceTableBody');
                return;
            }
            
            tbody.innerHTML = '';
            
            data.data.forEach(function(item) {
                const row = document.createElement('tr');
                row.className = 'device-row';
                
                // 获取设备类型（根据设备编号判断）
                let deviceType = '未知';
                if (item.device_id && typeof item.device_id === 'string') {
                    if (item.device_id.startsWith('BYQ') || item.device_id.startsWith('PDF')) {
                        deviceType = '变压器/配电房';
                    } else if (item.device_id.startsWith('NH')) {
                        deviceType = '计量设备';
                    } else if (item.device_id.startsWith('INV') || item.device_id.startsWith('COMB') || item.device_id.startsWith('GF')) {
                        deviceType = '光伏设备';
                    } else if (item.device_id.startsWith('BGD')) {
                        deviceType = '并网点';
                    }
                }
                
                // 格式化最后告警时间
                let lastAlarmTime = '-';
                if (item.last_alarm_time) {
                    try {
                        const date = new Date(item.last_alarm_time);
                        lastAlarmTime = date.toLocaleString('zh-CN');
                    } catch (e) {
                        lastAlarmTime = item.last_alarm_time;
                    }
                }
                
                // 安全地拼接HTML
                const rowHtml = [
                    '<td>' + escapeHtml(item.device_id || '') + '</td>',
                    '<td><span class="badge bg-secondary">' + escapeHtml(deviceType) + '</span></td>',
                    '<td><strong>' + (item.alarm_count || 0) + '</strong></td>',
                    '<td><span class="badge bg-danger">' + (item.high_count || 0) + '</span></td>',
                    '<td><span class="badge bg-warning">' + (item.medium_count || 0) + '</span></td>',
                    '<td><span class="badge bg-success">' + (item.low_count || 0) + '</span></td>',
                    '<td>' + escapeHtml(lastAlarmTime) + '</td>',
                    '<td>',
                    '<button class="btn btn-sm btn-outline-primary" onclick="showDeviceDetail(\'' + escapeHtml(item.device_id) + '\')">',
                    '<i class="bi bi-info-circle"></i> 详情',
                    '</button>',
                    '</td>'
                ].join('');
                
                row.innerHTML = rowHtml;
                tbody.appendChild(row);
            });
            
            document.getElementById('statusMessage').innerText = '数据加载完成，共 ' + data.data.length + ' 条记录';
            
        } catch (error) {
            console.error('加载数据失败:', error);
            document.getElementById('statusMessage').innerText = '加载数据失败: ' + error.message;
        }
    }
    
    // 显示设备详情
    async function showDeviceDetail(deviceId) {
        const startTime = document.getElementById('startTime').value;
        const endTime = document.getElementById('endTime').value;
        
        try {
            const url = '/SmartEnergy/alarm/device/detail/' + encodeURIComponent(deviceId) + 
                       '?startTime=' + encodeURIComponent(startTime) + 
                       '&endTime=' + encodeURIComponent(endTime);
            
            console.log('请求设备详情URL:', url);
            
            const response = await fetch(url);
            
            if (!response.ok) {
                throw new Error('网络响应不正常: ' + response.status);
            }
            
            const data = await response.json();
            console.log('设备详情数据:', data);
            
            const content = document.getElementById('deviceDetailContent');
            if (!content) {
                console.error('找不到元素: deviceDetailContent');
                return;
            }
            
            // 使用安全的属性访问方式
            const deviceInfo = data.deviceInfo || {};
            const alarmStats = data.alarmStats || {};
            const alarmList = data.alarmList || [];
            
            // 构建HTML内容
            let html = [];
            
            // 设备基本信息
            html.push('<div class="row">');
            html.push('<div class="col-md-6">');
            html.push('<h6>设备基本信息</h6>');
            html.push('<table class="table table-sm">');
            
            // 设备编号
            html.push('<tr>');
            html.push('<th width="30%">设备编号：</th>');
            html.push('<td>' + escapeHtml(deviceInfo.ledgerId || deviceId) + '</td>');
            html.push('</tr>');
            
            // 设备名称
            html.push('<tr>');
            html.push('<th>设备名称：</th>');
            html.push('<td>' + escapeHtml(deviceInfo.deviceName || '未知') + '</td>');
            html.push('</tr>');
            
            // 设备类型
            html.push('<tr>');
            html.push('<th>设备类型：</th>');
            html.push('<td><span class="badge bg-secondary">' + escapeHtml(deviceInfo.deviceType || '未知') + '</span></td>');
            html.push('</tr>');
            
            // 安装时间
            html.push('<tr>');
            html.push('<th>安装时间：</th>');
            html.push('<td>' + escapeHtml(formatDate(deviceInfo.installationDate)) + '</td>');
            html.push('</tr>');
            
            // 报废状态
            let scrapStatusBadgeClass = 'bg-success';
            if (deviceInfo.scrapStatus === '已报废') {
                scrapStatusBadgeClass = 'bg-danger';
            }
            html.push('<tr>');
            html.push('<th>报废状态：</th>');
            html.push('<td><span class="badge ' + scrapStatusBadgeClass + '">');
            html.push(escapeHtml(deviceInfo.scrapStatus || '正常使用'));
            html.push('</span></td>');
            html.push('</tr>');
            
            html.push('</table>');
            html.push('</div>');
            
            // 告警统计信息
            html.push('<div class="col-md-6">');
            html.push('<h6>告警统计信息</h6>');
            html.push('<div class="row">');
            
            // 总告警数
            html.push('<div class="col-6 text-center mb-3">');
            html.push('<div class="display-6 text-primary">' + (alarmStats.total_alarms || 0) + '</div>');
            html.push('<div class="text-muted">总告警数</div>');
            html.push('</div>');
            
            // 高等级告警
            html.push('<div class="col-6 text-center mb-3">');
            html.push('<div class="display-6 text-danger">' + (alarmStats.high_alarms || 0) + '</div>');
            html.push('<div class="text-muted">高等级告警</div>');
            html.push('</div>');
            
            // 中等级告警
            html.push('<div class="col-6 text-center">');
            html.push('<div class="display-6 text-warning">' + (alarmStats.medium_alarms || 0) + '</div>');
            html.push('<div class="text-muted">中等级告警</div>');
            html.push('</div>');
            
            // 低等级告警
            html.push('<div class="col-6 text-center">');
            html.push('<div class="display-6 text-success">' + (alarmStats.low_alarms || 0) + '</div>');
            html.push('<div class="text-muted">低等级告警</div>');
            html.push('</div>');
            
            html.push('</div>');
            html.push('</div>');
            html.push('</div>');
            
            html.push('<hr>');
            
            // 告警历史记录
            html.push('<h6>告警历史记录</h6>');
            html.push('<div class="table-responsive">');
            html.push('<table class="table table-sm table-hover">');
            html.push('<thead>');
            html.push('<tr>');
            html.push('<th>告警编号</th>');
            html.push('<th>告警类型</th>');
            html.push('<th>告警等级</th>');
            html.push('<th>发生时间</th>');
            html.push('<th>告警内容</th>');
            html.push('<th>处理状态</th>');
            html.push('</tr>');
            html.push('</thead>');
            html.push('<tbody>');
            
            // 告警列表
            if (alarmList.length > 0) {
                alarmList.forEach(function(alarm) {
                    html.push('<tr>');
                    html.push('<td>' + escapeHtml(alarm.alarmId || '-') + '</td>');
                    html.push('<td>' + escapeHtml(alarm.alarmType || '-') + '</td>');
                    html.push('<td><span class="badge ' + getAlarmLevelBadgeClass(alarm.alarmLevel) + '">');
                    html.push(escapeHtml(alarm.alarmLevel || '-'));
                    html.push('</span></td>');
                    html.push('<td>' + escapeHtml(formatDate(alarm.occurrenceTime)) + '</td>');
                    html.push('<td>' + escapeHtml(alarm.alarmContent || '-') + '</td>');
                    html.push('<td><span class="badge ' + getStatusBadgeClass(alarm.handleStatus) + '">');
                    html.push(escapeHtml(alarm.handleStatus || '-'));
                    html.push('</span></td>');
                    html.push('</tr>');
                });
            } else {
                html.push('<tr><td colspan="6" class="text-center">暂无告警记录</td></tr>');
            }
            
            html.push('</tbody>');
            html.push('</table>');
            html.push('</div>');
            
            content.innerHTML = html.join('');
            
            // 初始化modal
            const modalElement = document.getElementById('deviceDetailModal');
            if (modalElement) {
                deviceDetailModal = new bootstrap.Modal(modalElement);
                deviceDetailModal.show();
            } else {
                console.error('找不到modal元素');
            }
            
        } catch (error) {
            console.error('加载设备详情失败:', error);
            alert('加载设备详情失败：' + error.message);
        }
    }

    // 辅助函数
    function getAlarmLevelBadgeClass(level) {
        switch(level) {
            case '高': return 'bg-danger';
            case '中': return 'bg-warning';
            case '低': return 'bg-success';
            default: return 'bg-secondary';
        }
    }

    function getStatusBadgeClass(status) {
        switch(status) {
            case '已处理': return 'bg-success';
            case '未处理': return 'bg-danger';
            case '处理中': return 'bg-warning';
            default: return 'bg-secondary';
        }
    }

    function formatDate(dateString) {
        if (!dateString) return '-';
        try {
            const date = new Date(dateString);
            return date.toLocaleString('zh-CN');
        } catch (e) {
            return dateString;
        }
    }
    
    // HTML转义函数，防止XSS攻击
    function escapeHtml(text) {
        if (text === null || text === undefined) {
            return '';
        }
        const map = {
            '&': '&amp;',
            '<': '&lt;',
            '>': '&gt;',
            '"': '&quot;',
            "'": '&#039;'
        };
        return String(text).replace(/[&<>"']/g, function(m) { return map[m]; });
    }
    
    // 页面加载完成后初始化
    document.addEventListener('DOMContentLoaded', function() {
        console.log('设备分析页面已加载');
        
        // 检查必要元素是否存在
        const requiredElements = ['startTime', 'endTime', 'statusMessage', 'deviceTableBody', 'deviceDetailModal', 'deviceDetailContent'];
        requiredElements.forEach(function(id) {
            const element = document.getElementById(id);
            if (!element) {
                console.warn('找不到元素: ' + id);
            } else {
                console.log('找到元素: ' + id);
            }
        });
        
        // 如果没有设置时间，设置默认时间为最近7天
        const startTimeInput = document.getElementById('startTime');
        const endTimeInput = document.getElementById('endTime');
        
        if (!startTimeInput.value) {
            const end = new Date();
            const start = new Date();
            start.setDate(start.getDate() - 7);
            
            startTimeInput.value = formatDateTimeLocal(start);
            endTimeInput.value = formatDateTimeLocal(end);
        }
        
        // 页面加载时自动查询
        if (startTimeInput.value && endTimeInput.value) {
            setTimeout(() => loadDeviceAnalysis(), 100);
        }
    });
</script>
</body>
</html>