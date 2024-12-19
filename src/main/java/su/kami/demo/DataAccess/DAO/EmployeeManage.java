package su.kami.demo.DataAccess.DAO;

import java.util.List;
import java.util.ArrayList;
import java.util.Date;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import su.kami.demo.DataAccess.Interfaces.DAO;
import su.kami.demo.Models.Employee;
import su.kami.demo.Models.enums.EEmpType;
import su.kami.demo.utils.*;

public class EmployeeManage implements DAO<Employee> {

    
    private Connection connection;

    public EmployeeManage(Connection connection){
        this.connection = connection;
    }

    public EmployeeManage(MyConn connection) {
        this.connection = connection.create();
    }

    @Override
    public Employee get(int id) {
        try {
            PreparedStatement pre = this.connection.prepareStatement("select * from employees where emp_id = ?;");
            pre.setInt(1, id);
            ResultSet rs = pre.executeQuery();
            if(rs.next()) return(
                new Employee(
                    rs.getInt(1),
                    rs.getString(2),
                    rs.getString(3),
                    (new Date(rs.getTimestamp(4).getTime())),
                    EEmpType.enumerize(rs.getInt(5)) 
                )
            );
        
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
            return null;
        }
        System.out.println("done.");
        return new Employee(-1, "notfound", "notexist", new Date(), EEmpType.enumerize(0));
    }

    @Override
    public List<Employee> get() {
        return get("");
    }

    @Override
    public List<Employee> get(String limit) {
        try {
            if(limit == null) limit = "";
            List<Employee> results = new ArrayList<Employee>();
            PreparedStatement pre = this.connection.prepareStatement("select * from employees " + limit);
            ResultSet rs = pre.executeQuery();
            while(rs.next()) results.add(
                    new Employee(
                            rs.getInt(1),
                            rs.getString(2),
                            rs.getString(3),
                            (new Date(rs.getTimestamp(4).getTime())),
                            EEmpType.enumerize(rs.getInt(5))
                    )
            );
            return results;
        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        System.out.println("done.");
        return new ArrayList<>();
    }

    @Override
    public void update(Employee t) {
        try{
            PreparedStatement pre = this.connection.prepareStatement("update employees set name = ?, contact = ?, date_join = ?, type = ? where emp_id = ?");
            pre.setString(1, t.name);
            pre.setString(2, t.contact);
            pre.setTimestamp(3, t.dateJoin == null ? new Timestamp(new Date().getTime()) : new Timestamp(t.dateJoin.getTime()));
            pre.setShort(4, t.type == null ? 6 : (short)EEmpType.tinify(t.type)); // !

            pre.setInt(5, t.empId);

            pre.executeUpdate();
        }catch(Exception ex){
            ex.printStackTrace();
        }
        System.out.println("done.");
    }

    @Override
    public void delete(Employee t) {
        try {
            // if() here need to add a logic to determine whether the item is not here.
            PreparedStatement pre = this.connection.prepareStatement("delete from employees where emp_id = ?;");
            pre.setInt(1, t.empId);

            pre.executeUpdate();

        } catch (Exception e) {
            // TODO: handle exception
            e.printStackTrace();
        }
        System.out.println("done.");
    }

    @Override
    public void add(Employee t) {
        try{
            PreparedStatement pre = this.connection.prepareStatement("insert into employees(name, contact, date_join, type)" + 
                "values(?, ?, ?, ?)"
            );
            pre.setString(1, t.name);
            pre.setString(2, t.contact);
            pre.setTimestamp(3, t.dateJoin == null ? new Timestamp(new Date().getTime()) : new Timestamp(t.dateJoin.getTime()));
            pre.setShort(4, t.type == null ? 6 : (short)EEmpType.tinify(t.type)); // !

            pre.executeUpdate();
        }catch(Exception ex){
            ex.printStackTrace();
        }
        System.out.println("done.");
    }

    @Override
    public int count(String requirement) {
        if (requirement == null || requirement.isEmpty()) requirement = "";
        else requirement = " where " + requirement;
        try {
            PreparedStatement pre = this.connection.prepareStatement("select count(*) from employees " + requirement);
            ResultSet rs = pre.executeQuery();
            if(rs.next()) return rs.getInt(1);
            else return -1;
        }catch (Exception ex){
            ex.printStackTrace();
        }
        return -1;
    }

}
