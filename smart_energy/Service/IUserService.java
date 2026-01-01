package Demo.Service;

import Demo.Entity.User;
import java.util.List;

/**
 * 用户管理服务接口
 */
public interface IUserService {
    
    int insertUser(User user);
    User getUserById(String userId);
    User getUserByName(String name);
    List<User> getUsersByRole(String role);
    List<User> getAllUsers();
    int updateUser(User user);
    int deleteUser(String userId);
    boolean validateUser(String userId, String password);
}

