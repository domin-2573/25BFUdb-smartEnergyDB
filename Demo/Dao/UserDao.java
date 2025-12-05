package Demo.Dao;

import Demo.Entity.User;
import org.apache.ibatis.annotations.*;
import java.util.List;

/**
 * 用户DAO
 */
@Mapper
public interface UserDao {
    
    @Insert("INSERT INTO user (user_id, name, password, role) " +
            "VALUES (#{userId}, #{name}, #{password}, #{role})")
    int insertUser(User user);
    
    @Select("SELECT * FROM user WHERE user_id = #{userId}")
    User getUserById(@Param("userId") String userId);
    
    @Select("SELECT * FROM user WHERE name = #{name}")
    User getUserByName(@Param("name") String name);
    
    @Select("SELECT * FROM user WHERE role = #{role}")
    List<User> getUsersByRole(@Param("role") String role);
    
    @Select("SELECT * FROM user ORDER BY user_id")
    List<User> getAllUsers();
    
    @Update("UPDATE user SET name = #{name}, password = #{password}, role = #{role} " +
            "WHERE user_id = #{userId}")
    int updateUser(User user);
    
    @Delete("DELETE FROM user WHERE user_id = #{userId}")
    int deleteUser(@Param("userId") String userId);
}

