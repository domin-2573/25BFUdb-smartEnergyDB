package Demo.Dao;

import Demo.Entity.DashboardConfig;
import org.apache.ibatis.annotations.*;
import java.util.List;

/**
 * 大屏展示配置DAO
 */
@Mapper
public interface DashboardConfigDao {
    
    @Insert("INSERT INTO `大屏展示配置` (`配置编号`, `展示模块`, `数据刷新频率`, " +
            "`展示字段`, `排序规则`, `权限等级`) " +
            "VALUES (#{configId}, #{displayModule}, #{refreshFrequency}, " +
            "#{displayField1}, #{sortRule}, #{permissionLevel})")
    int insertDashboardConfig(DashboardConfig config);
    
    @Select("SELECT `配置编号` AS configId, `展示模块` AS displayModule, `数据刷新频率` AS refreshFrequency, " +
            "`展示字段` AS displayField1, `排序规则` AS sortRule, `权限等级` AS permissionLevel " +
            "FROM `大屏展示配置` WHERE `配置编号` = #{configId}")
    DashboardConfig getDashboardConfigById(@Param("configId") String configId);
    
    @Select("SELECT `配置编号` AS configId, `展示模块` AS displayModule, `数据刷新频率` AS refreshFrequency, " +
            "`展示字段` AS displayField1, `排序规则` AS sortRule, `权限等级` AS permissionLevel " +
            "FROM `大屏展示配置` WHERE `权限等级` = #{permissionLevel}")
    List<DashboardConfig> getDashboardConfigsByPermissionLevel(@Param("permissionLevel") String permissionLevel);
    
    @Select("SELECT `配置编号` AS configId, `展示模块` AS displayModule, `数据刷新频率` AS refreshFrequency, " +
            "`展示字段` AS displayField1, `排序规则` AS sortRule, `权限等级` AS permissionLevel " +
            "FROM `大屏展示配置` WHERE `展示模块` = #{displayModule}")
    List<DashboardConfig> getDashboardConfigsByDisplayModule(@Param("displayModule") String displayModule);
    
    @Select("SELECT `配置编号` AS configId, `展示模块` AS displayModule, `数据刷新频率` AS refreshFrequency, " +
            "`展示字段` AS displayField1, `排序规则` AS sortRule, `权限等级` AS permissionLevel " +
            "FROM `大屏展示配置` ORDER BY `配置编号`")
    List<DashboardConfig> getAllDashboardConfigs();
    
    @Update("UPDATE `大屏展示配置` SET `展示模块` = #{displayModule}, " +
            "`数据刷新频率` = #{refreshFrequency}, `展示字段` = #{displayField1}, " +
            "`排序规则` = #{sortRule}, `权限等级` = #{permissionLevel} " +
            "WHERE `配置编号` = #{configId}")
    int updateDashboardConfig(DashboardConfig config);
    
    @Delete("DELETE FROM `大屏展示配置` WHERE `配置编号` = #{configId}")
    int deleteDashboardConfig(@Param("configId") String configId);
}

