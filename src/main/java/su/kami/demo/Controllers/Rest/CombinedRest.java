package su.kami.demo.Controllers.Rest;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import su.kami.demo.Services.BaseService;
import su.kami.demo.Shared.SharedStatics;

@RequestMapping("/submit/combined")
@RestController
public class CombinedRest {
    private BaseService baseService = null;

    void fix(){
        if (baseService == null) { this.baseService = (BaseService) SharedStatics.dynamicShared.services.get("BaseService"); }
    }
}
