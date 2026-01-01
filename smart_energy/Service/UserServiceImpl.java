package Demo.Service;

import Demo.Dao.UserDao;
import Demo.Entity.User;
import Demo.Tool.SecurityTool;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

import static Demo.Tool.SecurityTool.encryptPassword;
import static Demo.Tool.SecurityTool.validatePassword;

/**
 * 用户管理服务实现
 */
@Service
public class UserServiceImpl implements IUserService {
    
    @Autowired
    private UserDao userDao;
    
    @Override
    public int insertUser(User user) {
        // 密码加密存储
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            String encryptedPassword = SecurityTool.encryptPassword(user.getPassword());
            user.setPassword(encryptedPassword);
        }
        return userDao.insertUser(user);
    }
    
    @Override
    public User getUserById(String userId) {
        return userDao.getUserById(userId);
    }
    
    @Override
    public User getUserByName(String name) {
        return userDao.getUserByName(name);
    }
    
    @Override
    public List<User> getUsersByRole(String role) {
        return userDao.getUsersByRole(role);
    }
    
    @Override
    public List<User> getAllUsers() {
        return userDao.getAllUsers();
    }
    
    @Override
    public int updateUser(User user) {
        // 如果更新了密码，需要加密
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            String encryptedPassword = encryptPassword(user.getPassword());
            user.setPassword(encryptedPassword);
        }
        return userDao.updateUser(user);
    }
    
    @Override
    public int deleteUser(String userId) {
        return userDao.deleteUser(userId);
    }
    
    @Override
    public boolean validateUser(String userId, String password) {
        User user = userDao.getUserById(userId);
        if (user == null) {
            return false;
        }
        return validatePassword(password, user.getPassword());
    }
}

