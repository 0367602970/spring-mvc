package vn.nguyentoan.laptopshop.service;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.nguyentoan.laptopshop.domain.Role;
import vn.nguyentoan.laptopshop.domain.User;
import vn.nguyentoan.laptopshop.domain.dto.RegisterDTO;
import vn.nguyentoan.laptopshop.repository.OrderRepository;
import vn.nguyentoan.laptopshop.repository.ProductReposity;
import vn.nguyentoan.laptopshop.repository.RoleRepository;
import vn.nguyentoan.laptopshop.repository.UserRepository;

@Service
public class UserService {
    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final ProductReposity productReposity;
    private final OrderRepository orderRepository;

    public UserService(UserRepository userRepository, RoleRepository roleRepository,
            ProductReposity productReposity, OrderRepository orderRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.productReposity = productReposity;
        this.orderRepository = orderRepository;
    }

    public String handleHello() {
        return "Hello from service";
    }

    public List<User> getAllUsers() {
        return this.userRepository.findAll();
    }

    public List<User> findAllUserByEmail(String email) {
        return this.userRepository.findOneByEmail(email);
    }

    public User getUserByID(long id) {
        return this.userRepository.findById(id);
    }

    public void deleteUser(long id) {
        this.userRepository.deleteById(id);
    }

    public User handleSaveUser(User user) {
        User rs = this.userRepository.save(user);
        return rs;
    }

    public Role getRoleByName(String name) {
        return this.roleRepository.findByName(name);
    }

    public User registerDTOtoUser(RegisterDTO registerDTO) {
        User user = new User();
        user.setFullName(registerDTO.getFirstName() + " " + registerDTO.getLastName());
        user.setEmail(registerDTO.getEmail());
        user.setPassword(registerDTO.getPassword());
        return user;
    }

    public boolean checkEmailExist(String email) {
        return this.userRepository.existsByEmail(email);
    }

    public User getUserByEmail(String email) {
        return this.userRepository.findByEmail(email);
    }

    public long countUsers() {
        return this.userRepository.count();
    }

    public long countProducts() {
        return this.productReposity.count();
    }

    public long countOrders() {
        return this.orderRepository.count();
    }

    public Page<User> fecthAllUsers(Pageable page) {
        return this.userRepository.findAll(page);
    }
}
