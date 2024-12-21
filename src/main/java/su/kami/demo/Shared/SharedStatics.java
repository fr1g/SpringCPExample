package su.kami.demo.Shared;

import com.google.gson.Gson;
import org.springframework.context.ApplicationContext;
import su.kami.demo.Services.BaseService;
import su.kami.demo.Services.EmployeeService;
import su.kami.demo.Services.Service;
import su.kami.demo.Services.TraderService;
import su.kami.demo.utils.MyTableHelper;
import su.kami.demo.utils.QueriedPageTools.Page;

import java.util.List;

public class SharedStatics {
    public static final String[] EmployeeTableHeads = {"EMP ID", "NAME", "CONTACT", "DATE of JOIN (local datetime)", "WORKTYPE"};

    public static DynamicShared dynamicShared;
    public static MyTableHelper<String> publicTableHelper;
    public static Gson jsonHandler;

    public static DynamicShared getServices(ApplicationContext context) {
        var dynamicShared = new DynamicShared();
        dynamicShared.services.put("BaseService", (BaseService) context.getBean("baseService", BaseService.class));
        dynamicShared.services.put("EmployeeService", (EmployeeService) context.getBean("employeeService", EmployeeService.class));
        dynamicShared.services.put("TraderService", (TraderService) context.getBean("traderService", TraderService.class));
        return dynamicShared;
    }
}
