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
            "#", "NAME", "CONTACT", "DATE of JOIN (local datetime)", "WORKTYPE"
    };

    public Page<Employee> getPagination() {
        try {
            pagination.stateHasChanged();
        }catch (Exception e) {}
        return pagination;
    }

    public EmployeeService(EmployeeManage employeeManage) {
        this.employeeManage = employeeManage;
        this.pagination = new Page<Employee>(employeeManage);
    }

    public boolean isExist(int id){
        var find = this.employeeManage.get(id);
        return (find != null && find.empId != -1);
    }

    public Employee get(int id){ return employeeManage.get(id); }

    public void delete(Employee e){ this.employeeManage.delete(e); }

    public void update(Employee e){
        this.employeeManage.update(e);
    }

    public void insert(Employee e){
        this.employeeManage.add(e);
    }

    public String getPagedHtmlTable(int pageNumber, int pageSize, String tableClasses, String cellClasses) {
        if(pageSize == 0) pageSize = 8;
        try{
            pagination.stateHasChanged();
            pagination.setPageSize(pageSize);
            pagination.gotoPage(pageNumber);
        }catch(Exception e){
            e.printStackTrace();
            return "500-? Internal Server Error: " + e.toString();
        }
        return SharedStatics.publicTableHelper
                .giveHtmlTable(
                        this.tableHead,
                        "text-left inline-block? border-l border-r border-slate-500 px-1 font-semibold text-lg",
                        null,
                        SharedStatics.publicTableHelper.toMappedStrings(pagination.pageContent),
                        cellClasses,
                        null,
                        (Map.of("class", tableClasses)),
                        false
                );
    }

    @Override
    public DAO<Employee> lendAgent() {
        return this.employeeManage;
    }
}
