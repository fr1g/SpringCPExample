package su.kami.demo.Controllers.Rest;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import su.kami.demo.Models.Employee;
import su.kami.demo.Models.ResponseObject;
import su.kami.demo.Models.Trader;
import su.kami.demo.Models.enums.ETraderType;
import su.kami.demo.Services.EmployeeService;
import su.kami.demo.Services.TraderService;
import su.kami.demo.Shared.SharedStatics;
import su.kami.demo.utils.ResponseHelper;

import javax.servlet.http.HttpServletRequest;

@RequestMapping("/submit/trader")
@RestController
public class TraderRest {
    private TraderService traderService = null;
    private EmployeeService employeeService = null;

    void fix(){
        if (traderService == null) { this.traderService = (TraderService) SharedStatics.dynamicShared.services.get("TraderService"); }
        if (employeeService == null) { this.employeeService = (EmployeeService)SharedStatics.dynamicShared.services.get("EmployeeService"); }
    }

    @GetMapping("/page/{page}")
    public void changePage(@PathVariable int page, HttpServletRequest request ) {
        fix();
        var maxPage = 0;
        try {
            maxPage = traderService.getPagination().getTableTotalPages();
            if(maxPage < page) request.getSession().setAttribute("traders/currentPage", Integer.valueOf(maxPage));
            else request.getSession().setAttribute("traders/currentPage", page);
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }

    @GetMapping("/remove/{id}")
    public void remove(@PathVariable int id, HttpServletRequest request ) {
        fix();
        var message = "";
        try {
            traderService.delete(new Trader(id));
            message = "Remove Successfully: " + id; // why da' fvck the java have no template string as c#?
        } catch (Exception ex){
            if(!ex.toString().contains("Cannot delete or update")) ex.printStackTrace();
            var isReallyExist = traderService.isExist(id);
            message = "Error occurred: " + (isReallyExist ? "@Unknown" : "@NotFound") + " @" + ex.getMessage();
            // idk
        } finally {
            request.getSession().setAttribute("_msg", message);
        }
    }

    @PostMapping("/update")
    public ResponseEntity<String> updateTrader(@RequestBody String body) {
        fix();
        boolean exist = false;
        try {
            // # pragma disable UncheckedTransform

            Trader got = ((ResponseObject<Trader>)
                    SharedStatics.jsonHandler.fromJson(
                            body,
                            (new TypeToken<ResponseObject<Trader>>(){}).getType()
                    )
            ).content; // # pragma
            /* PROCEDURE:
              1. get unfiltered json
              2. make the json parsed as unfiltered object
              3. split the unfiltered name and give values to the positions
              4. run check
              !! convention:
             */
            got = this.filtTrader(got);
            System.out.println((new Gson()).toJson(got));


            exist = traderService.isExist(got.traderID);
            if (exist){
                Trader before = traderService.get(got.traderID);
                if(got.contact.equals("~")) got.contact = before.contact;
                if(got.name.equals("~")) got.name = before.name;
                if(got.registrar.empId == -1) got.registrar = before.registrar;
                if(got.note.equals("~")) got.note = before.note;
                if(got.type == null) got.type = before.type;
                if(got.type == ETraderType.ALSO) got.type = before.type;

                traderService.update(got);
            }
            else {
                if(got.contact.equals("~") || got.name.equals("~") || got.registrar.empId == -1 || got.type == null || got.type == ETraderType.ALSO)
                    return ResponseHelper.Return(405, "E@Illegal-Data");
                else
                    traderService.insert(got);
            }

            System.out.println(got.name);
        }catch (Exception ex){
            if(!ex.toString().contains("such")) ex.printStackTrace();
            // todo this place requiring a _msg or not?
            return ResponseHelper.Return(502, ex.getMessage());
        }
        return ResponseHelper.Return(200, "X@Trader " + (exist ? "updated" : "inserted") + " successfully");
    }

    protected Trader filtTrader(Trader trader) {
        var prepare = trader.name.split("@");
        trader.registrar = (!prepare[1].equals("-1")) ? employeeService.get(Integer.parseInt(prepare[1])) : new Employee(-1);
        trader.name = prepare[0];
        if(trader.note.equals("unfiltered")) trader.note = null; // todo maybe causes problem
        return trader;
    }
}
