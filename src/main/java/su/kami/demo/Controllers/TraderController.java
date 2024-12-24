package su.kami.demo.Controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/trader")
public class TraderController {
    @GetMapping
    public String base() {
        return "Pages/trader";
    }
}
