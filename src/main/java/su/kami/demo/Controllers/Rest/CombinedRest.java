package su.kami.demo.Controllers.Rest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import su.kami.demo.Services.BaseService;
import su.kami.demo.Shared.SharedStatics;

import javax.servlet.http.HttpServletRequest;

@RequestMapping("/submit/combined")
@RestController
public class CombinedRest {
    private BaseService baseService = null;

    void fix(){
        if (baseService == null) { this.baseService = (BaseService) SharedStatics.dynamicShared.services.get("BaseService"); }
    }

    @GetMapping("/page/{page}")
    public void changePage(@PathVariable int page, HttpServletRequest request ) {
        fix();
        var maxPage = 0;
        try {
            maxPage = baseService.getPagination().getTableTotalPages();
            if(maxPage < page) request.getSession().setAttribute("combined/currentPage", Integer.valueOf(maxPage));
            else request.getSession().setAttribute("combined/currentPage", page);
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }
}
