package su.kami.demo.Controllers.Rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/submit/base")
public class BaseRest {
    @GetMapping("/clearMsg")
    public void clearMsg(HttpServletRequest request ) {
//        System.out.println("Requested to clear msg");
        request.getSession().setAttribute("_msg", null);
    }
}
