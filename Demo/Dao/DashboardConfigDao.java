package Demo.Dao;

import Demo.Entity.DashboardConfig;
import org.apache.ibatis.annotations.*;
import java.util.List;

/**
 * 大屏展示配置DAO
 */
@Mapper
public interface DashboardConfigDao {
    
    @Insert("INSERT INTO dashboard_config (config_id, display_module, refresh_frequency, " +
            "display_field1, sort_rule, permission_level) " +
            "VALUES (#{configId}, #{displayModule}, #{refreshFrequency}, " +
            "#{displayField1}, #{sortRule}, #{permissionLevel})")
    int insertDashboardConfig(DashboardConfig config);
    
    @Select("SELECT * FROM dashboard_config WHERE config_id = #{configId}")
    DashboardConfig getDashboardConfigById(@Param("configId") String configId);
    
    @Select("SELECT * FROM dashboard_config WHERE permission_level = #{permissionLevel}")
    List<DashboardConfig> getDashboardConfigsByPermissionLevel(@Param("permissionLevel") String permissionLevel);
    
    @Select("SELECT * FROM dashboard_config WHERE display_module = #{displayModule}")
    List<DashboardConfig> getDashboardConfigsByDisplayModule(@Param("displayModule") String displayModule);
    
    @Select("SELECT * FROM dashboard_config ORDER BY config_id")
    List<DashboardConfig> getAllDashboardConfigs();
    
    @Update("UPDATE dashboard_config SET display_module = #{displayModule}, " +
            "refresh_frequency = #{refreshFrequency}, display_field1 = #{displayField1}, " +
            "sort_rule = #{sortRule}, permission_level = #{permissionLevel} " +
            "WHERE config_id = #{configId}")
    int updateDashboardConfig(DashboardConfig config);
    
    @Delete("DELETE FROM dashboard_config WHERE config_id = #{configId}")
    int deleteDashboardConfig(@Param("configId") String configId);
}

