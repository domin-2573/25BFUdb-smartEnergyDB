package Demo;

import java.sql.*;

public class TestConnection {
    public static void main(String[] args) {
        System.out.println("========== 测试dev01用户连接 ==========");
        System.out.println("目标: 192.168.192.32:3306/smart_energy");
        System.out.println("测试用户: dev01");
        System.out.println("======================================");
        
        // 首先测试dev01能否连接
        testDev01Connection();
        
        // 如果dev01有smart_energy权限，就成功了
        // 如果没有，查看dev01能访问哪些数据库
    }
    
    private static void testDev01Connection() {
        String[] urls = {
            "jdbc:mysql://192.168.192.32:3306/smart_energy?useSSL=false",
            "jdbc:mysql://192.168.192.32:3306/smart_energy?useSSL=false&allowPublicKeyRetrieval=true",
            "jdbc:mysql://192.168.192.32:3306/",  // 不指定数据库
            "jdbc:mysql://192.168.192.32:3306/mysql?useSSL=false"  // mysql系统数据库
        };
        
        // 尝试不同的密码（你可能知道dev01的密码）
        String[] passwords = {
            "123456",        // 常用密码1
            "dev01",         // 常用密码2  
            "dev",           // 常用密码3
            "password",      // 常用密码4
            "admin",         // 常用密码5
            "",              // 空密码
            "Dev01@123",     // 复杂密码1
            "Dev01#2023"     // 复杂密码2
        };
        
        String user = "dev01";
        
        for (String url : urls) {
            System.out.println("\n测试连接: " + url);
            
            for (String password : passwords) {
                try {
                    Connection conn = DriverManager.getConnection(url, user, password);
                    System.out.println("  ✅ 连接成功！密码: '" + password + "'");
                    
                    // 显示权限信息
                    showConnectionInfo(conn);
                    
                    // 如果连接的是smart_energy，测试权限
                    if (url.contains("smart_energy")) {
                        testSmartEnergyAccess(conn);
                    }
                    
                    conn.close();
                    
                    // 如果成功连接到smart_energy，给出配置建议
                    if (url.contains("smart_energy")) {
                        System.out.println("\n✅✅✅ 成功！请使用以下配置：");
                        System.out.println("spring.datasource.username=" + user);
                        System.out.println("spring.datasource.password=" + password);
                        System.out.println("spring.datasource.url=" + url);
                        System.exit(0);
                    }
                    
                } catch (SQLException e) {
                    // 密码错误，继续尝试下一个
                }
            }
        }
        
        System.out.println("\n❌ dev01连接失败，需要查看dev01的权限");
        System.out.println("请在MySQL Workbench中执行：");
        System.out.println("SHOW GRANTS FOR 'dev01'@'%';");
        System.out.println("或");
        System.out.println("SHOW DATABASES;");
    }
    
    private static void showConnectionInfo(Connection conn) throws SQLException {
        DatabaseMetaData meta = conn.getMetaData();
        System.out.println("    数据库: " + meta.getDatabaseProductName());
        
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT USER(), DATABASE(), VERSION()");
        if (rs.next()) {
            System.out.println("    当前用户: " + rs.getString(1));
            System.out.println("    当前数据库: " + rs.getString(2));
            System.out.println("    MySQL版本: " + rs.getString(3));
        }
        rs.close();
        stmt.close();
    }
    
    private static void testSmartEnergyAccess(Connection conn) {
        try {
            Statement stmt = conn.createStatement();
            
            // 测试1: 查询表
            ResultSet rs = stmt.executeQuery("SHOW TABLES");
            System.out.println("    smart_energy中的表:");
            int count = 0;
            while (rs.next()) {
                System.out.println("      - " + rs.getString(1));
                count++;
            }
            System.out.println("    总计: " + count + " 张表");
            rs.close();
            
            // 测试2: 测试CRUD权限
            try {
                rs = stmt.executeQuery("SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'smart_energy'");
                if (rs.next()) {
                    System.out.println("    ✅ 有查询权限");
                }
            } catch (Exception e) {
                System.out.println("    ⚠ 权限有限: " + e.getMessage());
            }
            
            stmt.close();
            
        } catch (SQLException e) {
            System.out.println("    ❌ 无法访问smart_energy: " + e.getMessage());
        }
    }
}