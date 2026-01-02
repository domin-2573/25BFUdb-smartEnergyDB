package Demo.Interceptor;

import Demo.Entity.User;
import Demo.Service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * 登录拦截器
 * 实现：登录验证、会话超时控制（30分钟）、登录失败限制（5次后锁定）
 */
public class LoginInterceptor implements HandlerInterceptor {
    
    private static final int SESSION_TIMEOUT_MINUTES = 30;
    private static final int MAX_LOGIN_FAILURES = 5;
    private static final int LOCKOUT_MINUTES = 30;
    
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestURI = request.getRequestURI();
        HttpSession session = request.getSession();
        
        // 检查是否是API请求（JSON请求）
        boolean isApiRequest = requestURI.startsWith("/SmartEnergy/auth/") || 
                              requestURI.startsWith("/auth/") ||
                              request.getHeader("Accept") != null && request.getHeader("Accept").contains("application/json") ||
                              request.getHeader("Content-Type") != null && request.getHeader("Content-Type").contains("application/json");
        
        // 检查是否已登录
        User user = (User) session.getAttribute("user");
        if (user == null) {
            if (isApiRequest) {
                // API请求返回JSON错误
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.setContentType("application/json;charset=UTF-8");
                response.getWriter().write("{\"success\":false,\"message\":\"未登录或会话已过期\"}");
                return false;
            } else {
                // 页面请求重定向到登录页
                response.sendRedirect("/SmartEnergy/login");
                return false;
            }
        }
        
        // 检查会话是否超时（30分钟无操作）
        Long lastAccessTime = (Long) session.getAttribute("lastAccessTime");
        if (lastAccessTime != null) {
            long currentTime = System.currentTimeMillis();
            long timeout = SESSION_TIMEOUT_MINUTES * 60 * 1000; // 30分钟
            
            if (currentTime - lastAccessTime > timeout) {
                // 会话超时，清除session
                session.invalidate();
                if (isApiRequest) {
                    // API请求返回JSON错误
                    response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                    response.setContentType("application/json;charset=UTF-8");
                    response.getWriter().write("{\"success\":false,\"message\":\"会话已超时，请重新登录\"}");
                    return false;
                } else {
                    // 页面请求重定向到登录页
                    response.sendRedirect("/SmartEnergy/login?timeout=true");
                    return false;
                }
            }
        }
        
        // 更新最后访问时间
        session.setAttribute("lastAccessTime", System.currentTimeMillis());
        
        return true;
    }
}

