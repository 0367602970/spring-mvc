package vn.hoidanit.laptopshop;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;


@RestController
public class HelloController {
    @GetMapping("/")
    public String index() {
        return "Hello Toàn Đẹp Trai!";
    }
    
    @GetMapping("/user")
    public String userPage() {
        return "Trang chủ người dùng";
    }

    @GetMapping("/admin")
    public String adminPage() {
        return "Trang chủ admin";
    }
}

