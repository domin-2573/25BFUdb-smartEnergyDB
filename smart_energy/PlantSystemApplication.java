package Demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@MapperScan("Demo.Dao")
@SpringBootApplication
public class PlantSystemApplication extends SpringBootServletInitializer {
    
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(PlantSystemApplication.class);
    }
    
    public static void main(String[] args) {
        SpringApplication.run(PlantSystemApplication.class, args);
    }
}