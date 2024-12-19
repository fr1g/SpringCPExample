package su.kami.demo.Controllers.Rest;

import com.google.gson.reflect.TypeToken;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import su.kami.demo.Models.Employee;
import su.kami.demo.Models.ResponseObject;
import su.kami.demo.Services.EmployeeService;
import su.kami.demo.Shared.SharedStatics;
import su.kami.demo.utils.ResponseHelper;

import javax.servlet.http.HttpServletRequest;

@RestController
@RequestMapping("/submit/employee")
public class EmployeeRest {

    private EmployeeService employeeService = null;

    void fix(){
        if (employeeService == null) { this.employeeService = (EmployeeService)SharedStatics.dynamicShared.services.get("EmployeeService"); }
    }

    @GetMapping("/page/{page}")
    public void changePage(@PathVariable int page, HttpServletRequest request ) {
        fix();
        var maxPage = 0;
        try {
            maxPage = employeeService.getPagination().getTableTotalPages();
            if(maxPage < page) request.getSession().setAttribute("currentPage", maxPage);
            else request.getSession().setAttribute("currentPage", page);
        } catch (Exception ex){
            ex.printStackTrace();
        }
    }

    @PostMapping("/update")
    public ResponseEntity<String> updateEmployee(@RequestBody String body) {
        fix();
        boolean exist = false;
        try {
            // # pragma disable UncheckedTransform

            Employee got = ((ResponseObject<Employee>)
                                SharedStatics.jsonHandler.fromJson(
                                        body,
                                        (new TypeToken<ResponseObject<Employee>>(){}).getType()
                                )
                            ).content;


            exist = employeeService.isExist(got.empId);
            if (exist)
                employeeService.update(got);
            else employeeService.insert(got);

            System.out.println(got.name);
        }catch (Exception ex){
            ex.printStackTrace();
            return ResponseHelper.Return(502, ex.getMessage());
        }
        return ResponseHelper.Return(200, "X@Employee " + (exist ? "updated" : "inserted") + " successfully");
    }

}
