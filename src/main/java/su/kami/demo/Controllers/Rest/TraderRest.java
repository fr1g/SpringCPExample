package su.kami.demo.Controllers.Rest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import su.kami.demo.Services.TraderService;
import su.kami.demo.Shared.SharedStatics;

@RequestMapping("/submit/trader")
@RestController
public class TraderRest {
    private TraderService traderService = null;

    void fix(){
        if (traderService == null) { this.traderService = (TraderService) SharedStatics.dynamicShared.services.get("EmployeeService"); }
    }
}
