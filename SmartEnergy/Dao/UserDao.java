package Demo.Dao;

import Demo.Entity.User;
import org.apache.ibatis.annotations.*;
import java.util.List;

/**
 * 用户DAO
 */
@Mapper
public interface UserDao {
    
    @Insert("INSERT INTO `用户表` (`用户ID`, `姓名`, `密码`, `角色`) " +
            "VALUES (#{userId}, #{name}, #{password}, #{role})")
    int insertUser(User user);
    
    @Select("SELECT `用户ID` AS userId, `姓名` AS name, `密码` AS password, `角色` AS role, `最后登录时间` AS lastLoginTime FROM `用户表` WHERE `用户ID` = #{userId}")
    User getUserById(@Param("userId") String userId);
    
    @Select("SELECT `用户ID` AS userId, `姓名` AS name, `密码` AS password, `角色` AS role FROM `用户表` WHERE `姓名` = #{name}")
    User getUserByName(@Param("name") String name);
    
    @Select("SELECT `用户ID` AS userId, `姓名` AS name, `密码` AS password, `角色` AS role FROM `用户表` WHERE `角色` = #{role}")
    List<User> getUsersByRole(@Param("role") String role);
    
    @Select("SELECT `用户ID` AS userId, `姓名` AS name, `密码` AS password, `角色` AS role FROM `用户表` ORDER BY `用户ID`")
    List<User> getAllUsers();
    
    @Update("UPDATE `用户表` SET `姓名` = #{name}, `密码` = #{password}, `角色` = #{role} " +
            "WHERE `用户ID` = #{userId}")
    int updateUser(User user);
    
    @Delete("DELETE FROM `用户表` WHERE `用户ID` = #{userId}")
    int deleteUser(@Param("userId") String userId);
    
    @Update("UPDATE `用户表` SET `最后登录时间` = NOW() WHERE `用户ID` = #{userId}")
    int updateLastLoginTime(@Param("userId") String userId);
    
    @Update("UPDATE `用户表` SET `登录失败次数` = #{count}, `账号锁定时间` = #{lockTime} WHERE `用户ID` = #{userId}")
    int updateLoginFailure(@Param("userId") String userId, @Param("count") int count, @Param("lockTime") java.util.Date lockTime);
}

