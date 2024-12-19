package su.kami.demo.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
//@RequestMapping("/")
public class Base {

    @GetMapping("/")
    public String home() {
        return "index"; // # pragma disable CSfuckyoujava why you cannot found the view are you a goddamnit racialist huh
    }

    @GetMapping("/error")
    public String error() {
        return "Pages/error";
    }
}
