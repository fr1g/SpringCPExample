package su.kami.demo.Services;

import su.kami.demo.DataAccess.DAO.EmployeeManage;
import su.kami.demo.DataAccess.Interfaces.DAO;
import su.kami.demo.Models.Employee;
import su.kami.demo.Shared.SharedStatics;
import su.kami.demo.utils.MyTableHelper;
import su.kami.demo.utils.QueriedPageTools.Page;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class EmployeeService implements Service<Employee> {
    private EmployeeManage employeeManage;
    private Page<Employee> pagination;

    private String[] tableHead = new String[]{
            "EMP ID", "NAME", "CONTACT", "DATE of JOIN (local datetime)", "WORKTYPE"
    };

//    private

    public EmployeeService(EmployeeManage employeeManage) {
        this.employeeManage = employeeManage;
        this.pagination = new Page<Employee>(employeeManage);
    }

    public boolean isExist(int id){
        var find = this.employeeManage.get(id);
        return (find != null && find.empId != -1);
    }

    public void update(Employee e){
        this.employeeManage.update(e);
    }

    public void insert(Employee e){
        this.employeeManage.add(e);
    }

    public String getPagedHtmlTable(int pageNumber, int pageSize, String tableClasses, String cellClasses) {
        if(pageSize == 0) pageSize = 8;
        var page = pagination;
        try{
            page.stateHasChanged();
            page.setPageSize(pageSize);
            page.gotoPage(pageNumber);
        }catch(Exception e){
            e.printStackTrace();
            return "500 Internal Server Error: " + e.toString();
        }
        return SharedStatics.publicTableHelper
                .giveHtmlTable(
                        this.tableHead,
                        null,
                        null,
                        SharedStatics.publicTableHelper.toMappedStrings(page.pageContent),
                        cellClasses,
                        null,
                        (Map.of("class", tableClasses))
                );
    }

    @Override
    public DAO<Employee> lendAgent() {
        return this.employeeManage;
    }
}
