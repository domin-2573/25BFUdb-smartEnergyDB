package Demo.Config;

import Demo.Tool.SecurityTool;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import Demo.Interceptor.LoginInterceptor;

@Configuration
public class SecurityConfig implements WebMvcConfigurer {
    
    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/**")
                .excludePathPatterns(
                    "/login",
                    "/welcome",
                    "/auth/**",  // 排除所有认证相关的API
                    "/test/**",  // 排除测试接口
                    "/SmartEnergy/login",
                    "/SmartEnergy/welcome",
                    "/SmartEnergy/auth/**",  // 排除所有认证相关的API（带context-path）
                    "/SmartEnergy/test/**",  // 排除测试接口（带context-path）
                    "/SmartEnergy/admin/dashboard/data",
                    "/error",
                    "/static/**",
                    "/css/**",
                    "/js/**",
                    "/images/**"
                );
    }
}

